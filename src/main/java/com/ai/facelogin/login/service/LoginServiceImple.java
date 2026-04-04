package com.ai.facelogin.login.service;

import com.ai.facelogin.common.exception.common.FileException;
import com.ai.facelogin.face.service.FaceService;
import com.ai.facelogin.login.dto.LoginDto;
import com.ai.facelogin.users.mapper.UsersDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


@Slf4j
@RequiredArgsConstructor
@Service
public class LoginServiceImple implements LoginService {

    //허깅페이스로 이미지 전처리 요청
    private final FaceService faceService;
    private final UsersDao dao;

    @Override
    public float[] getFaceVector(LoginDto dto) {
        String userStrId = dto.getUserIdStr();
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
    public float[] getOriginVector(String userStrId) {

        if(userStrId == null || userStrId.isEmpty()) {
            log.error("얼굴이미지를 조회할 사용자 아이디가 없습니다.");
            //여기서는 무슨 예외 던지지
        }
        float[] vector = dao.selectOriginVector(userStrId);
        return vector;
    }
}
