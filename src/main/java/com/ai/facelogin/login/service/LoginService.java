package com.ai.facelogin.login.service;

import com.ai.facelogin.login.dto.LoginDto;
import org.springframework.web.multipart.MultipartFile;

public interface LoginService {

    // 이미지 전처리해서 가져 올 메서드
    float[] getFaceVector(LoginDto dto);

    //데이터베이스에 저장된 원본 얼굴이미지 조회
    float[] getOriginVector(String userStrId);

}

//인터페이스는 자동으로 public abstract 처리됨