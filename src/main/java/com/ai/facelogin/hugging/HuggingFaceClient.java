package com.ai.facelogin.hugging;

import com.ai.facelogin.common.exception.common.HuggingFaceException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;


@Slf4j
@Component
@RequiredArgsConstructor
public class HuggingFaceClient {

    private final HuggingFaceConfig config; // 생성자 주입
    private final RestTemplate restTemplate;// 컨피그에 작성한 허깅페이스 설정 객체 주입
    
    
    //허깅페이스 APi로 요청을 보내 실수 배열 데이터로 받아오는 메서드 -> face서비스에서 사용
    public float[] getVector(byte[] imageBytes) {

        try{
            log.info(" faceServiceImple HuggingFaceClient 진입 3)");
            //헤더 설정 ( 토큰 필요 )
            HttpHeaders headers = new HttpHeaders();
            // Config 객체에서 토큰과 URL을 가져오기
            headers.setBearerAuth(config.getToken()); // "Bearer " 문자열 안 붙여도 알아서 붙여줌 (허깅페이스 연결토큰)
            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);  //바이너리 타입의 이미지 파일 전송용

            //바디에 이미지 데이터 담아주기
            HttpEntity<byte[]> requestEntity = new HttpEntity<>(imageBytes, headers);

            log.info("허깅페이스 헤더 정보 :{} ",headers);
            //허깅페이스 API 호출 (결과를 float 배열로 받음) , http 요청은 post  ( postForObject )
            return restTemplate.postForObject(config.getApiUrl(), requestEntity, float[].class);

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
 * */