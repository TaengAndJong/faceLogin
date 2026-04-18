package com.ai.facelogin.login.service;

import com.ai.facelogin.common.exception.common.FileException;
import com.ai.facelogin.face.service.FaceService;
import com.ai.facelogin.login.dto.LoginReqDto;
import com.ai.facelogin.login.dto.UserLoginDto;
import com.ai.facelogin.users.mapper.UsersDao;
import com.ai.facelogin.vo.UserVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


@Slf4j
@RequiredArgsConstructor
@Service
public class LoginServiceImple implements LoginService {

    //허깅페이스로 이미지 전처리 요청
    private final FaceService faceService;
    private final UsersDao userDao;

    @Override
    public float[] getFaceVector(LoginReqDto dto) {
        String userStrId = dto.getUserStrId();
        MultipartFile file = dto.getFaceEncoding();

        // 파일 빈객체 2차 방어코드
        if(file == null || file.isEmpty()) {
            log.error("Login Service ---- 얼굴 이미지 파일이 누락되었거나 비어있습니다. 사용자아이디 :{}",userStrId);
            throw new FileException("얼굴이미지가 없습니다");}

        //파일객체가 있다면 허깅페이스로 이미지 전처리 시도하기
        float [] vector = faceService.getFileToVector(file);
        log.info("로그인 서비스 반환받은 vetor  : {}",vector.length);
        //전처리된 이미지 반환
        return vector;
    }


    @Override
    public UserLoginDto getOriginUserInfo(String userStrId){
    
        if(userStrId == null || userStrId.isEmpty()) { //파라미터 빈값 , null 검증
            log.error("사용자정보 조회할 아이디가 없습니다.");
            //없으면
            throw new IllegalArgumentException("조회할 아이디가 비어있습니다.");
        }

        // 인자 있으면  데이터베이스 조회
        UserVO userVo =  userDao.selectUserLoginInfo(userStrId);
        //조회 결과 없을 시 예외 발생
        if (userVo == null) {
            log.error("존재하지 않는 사용자 아이디: {}", userStrId);
            throw new UsernameNotFoundException("해당 아이디의 사용자를 찾을 수 없습니다: " + userStrId);
        }

        // 얼굴 데이터 존재 여부 검증 (1:1 관계 데이터 누락 방지) -> 디비에서 실수로 지워졌을 경우의 상황에 대해서
        if (userVo.getFaceVO() == null || userVo.getFaceVO().getFaceEncoding() == null) {
            log.error("얼굴 데이터가 등록되지 않은 사용자: {}", userStrId);
            throw new IllegalStateException("등록된 얼굴 정보가 없습니다.");
        }

        //UserVO를  UserLoginDto로 변경 ( 필요한 데이터만 담아주기)
        UserLoginDto result  = UserLoginDto.builder()
                .userStrId(userVo.getUserStrId())
                .userRole(userVo.getUserRole())
                .faceEncoding(userVo.getFaceVO().getFaceEncoding())
                .build();
        // 결과반환
        return result;
    }

    @Override
    public boolean compareToVector(String userStrId, float[] newVector) {
        log.info("compareToVector  서비스 진입");
        //사용자 아이디와, 새로 인식되어 들어온 벡터 데이터 베이스로 전달하여 해당사용자의 얼굴 이미지 비교
        Double distance = userDao.authenticateFace(userStrId, newVector); //래퍼클래스 사용 null 체크
        log.info("distance---------------- 벡터 비교 : {}",distance);
        //얼굴 데이터가 없는 경우 (NULL 체크)
        if (distance == null) {
            throw new BadCredentialsException("얼굴 벡터이미지 찾을 수 없음");
        }

        //얼굴 데이터가 있는 경우 (거리 비교)
        if (distance < 0.35) {
            log.info("얼굴비교 인증 성공");
            return true; // 성공!
        } else {
            log.info("얼굴비교 인증 실패");
            return false; // 실패 (타인 혹은 인식 불량)
        }

    }

}
