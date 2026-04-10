package com.ai.facelogin.hugging;

import com.ai.facelogin.common.exception.common.HuggingFaceException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.util.Collections;
import java.util.List;
import java.util.Map;


@Slf4j
@Component
@RequiredArgsConstructor
public class HuggingFaceClient {

    private final HuggingFaceConfig config; // 생성자 주입
    private final RestTemplate restTemplate;// 컨피그에 작성한 허깅페이스 설정 객체 주입
    
    
    //허깅페이스 APi로 요청을 보내 실수 배열 데이터로 받아오는 메서드 -> face서비스에서 사용
    public float[] getVector(MultipartFile file) {

        try{
            log.info(" faceServiceImple HuggingFaceClient 진입 3) 허깅클라이언트 클래스 ");
            //헤더 설정 ( 토큰 필요 )
            HttpHeaders headers = new HttpHeaders();
            // Config 객체에서 토큰과 URL을 가져오기
            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON)); //Accept 헤더를 JSON으로 명시 ( 컨텐츠 타입 중복 에러 방지)
            headers.setBearerAuth(config.getToken()); // "Bearer " 문자열 안 붙여도 알아서 붙여줌 (허깅페이스 연결토큰)

            //fastAPI 사용시 , upload 파일을 사용하기 때문에 file 객체로 보내줘야함

            //바디에 이미지 데이터 담아주기
            // 바디 구성은 .getResource()가 핵심이며, 파일명과 데이터를 모두 가지고있어서 파이썬에서 선호
            MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
            body.add("file", file.getResource());

            log.info("허깅페이스 헤더 정보 :{} ",headers);
            log.info("허깅페이스 헤더 config.getApiUrl() 정보 :{} ",config.getApiUrl());
            log.info("허깅페이스 body 정보 :{} ",body);

            //요청 엔티티 생성
            HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);
            //허깅스페이스 API 호출
            ResponseEntity<Map> response = restTemplate.postForEntity(config.getApiUrl(), requestEntity, Map.class);

            log.info("허깅페이스 requestEntity 정보 :{} ",requestEntity);
            log.info("허깅페이스 모델 반환 response 정보 :{} ",response);
            log.info("허깅페이스 응답 상태 코드: {}", response.getStatusCode());
            log.info("허깅페이스 전체 응답 내용: {}", response.getBody());

            //  response.getBody() 사전 검증, null인 경우
            if (response.getBody() == null) {
                log.error("HuggingFace 응답 사고: 응답 body가 null");
                //예외 던지기
                throw new HuggingFaceException("서버로부터 응답 데이터 못 받음.");
            }

            // 2단계: 상자는 왔는데, 안에 에러 쪽지가 들어있는 경우
            if (response.getBody().containsKey("error")) {
                String errorDetail = body.get("error").toString();
                log.error("HuggingFace 모델 인식 실패: {}", errorDetail);
                //예외 던지기
                throw new HuggingFaceException("얼굴 인식 실패: " + errorDetail);
            }


            // 결과데이터  벡터로 변환 ( 허깅스페이스 파이썬 서버에서 건네주는타입 확인 필요)
            // 결과(List)를 float[]로 변환해서 반환
            List<Double> vectorList = (List<Double>) response.getBody().get("vector"); //데이터 손실방지 Double 타입으로 가져옴
            log.info("허깅페이스 vectorList : {}",vectorList);

            if (vectorList == null || vectorList.isEmpty()){
                throw new HuggingFaceException("모델 응답에 vector 데이터 누락");
            }

            float[] result = new float[vectorList.size()]; // 다시 float로 형변환
            log.info("허깅페이스  result 객체생성: {}", result);

            for (int i = 0; i < vectorList.size(); i++) {
                result[i] = vectorList.get(i).floatValue();
            }
            log.info("허깅페이스  result 데이터 담긴 결과: {}", result);
            return result;

        }catch (HttpClientErrorException.Unauthorized e) {
            //토큰 오류  401 에러
            throw new HuggingFaceException("허깅페이스 토큰 오류", HttpStatus.UNAUTHORIZED);
        
        } catch (HttpServerErrorException e) {
           //모델 로딩 중 503 에러
            if (e.getStatusCode() == HttpStatus.SERVICE_UNAVAILABLE) {
                throw new HuggingFaceException("모델 로딩 중", HttpStatus.SERVICE_UNAVAILABLE);
            }
           //서버 에러 (기타 500 관련 에러)
            throw new HuggingFaceException("AI 서버 에러 발생", HttpStatus.INTERNAL_SERVER_ERROR);
        
        } catch (Exception e) { //checked 예외와 예측불가능 상황대비용(runtime예외에서 각각 처리하기 힘들기 때문에 포괄적으로 처리 및 시큐어코딩 가이드의 정보 노출 방지)
            log.error("HuggingFace Client Error 메시지: {}, 원인: ", e.getMessage(), e);
            // 그 외 모든 예외 ( 네트워크 타임아웃, dns 오류, JSON파싱 오류 등
            throw new HuggingFaceException("AI 통신 중 알 수 없는 에러", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

}


/*
 * 실제 API 호출 담당
 * 허깅페이스 서버에 사진을 던지고 벡터(숫자 배열 float[ ])를 받아오는 핵심 파일
 * FaceServiceImpl(서비스 구현체)에서 이 클래스를 주입받아 사용
 * 추후에 Optional로 커스텀해보기
 * */