package com.ai.facelogin.login.service;

import com.ai.facelogin.login.dto.LoginReqDto;
import com.ai.facelogin.login.dto.UserLoginDto;

public interface LoginService {

    // 이미지 전처리해서 가져 올 메서드
    float[] getFaceVector(LoginReqDto dto);

    //데이터베이스에 저장 된 사용자 정보 가져올 메서드
    UserLoginDto getOriginUserInfo(String userStrId);

    //얼굴이미지 검증 벡터 비교 메서드
    boolean compareToVector(float[] originVector,float[] newVector);

}

//인터페이스는 자동으로 public abstract 처리됨