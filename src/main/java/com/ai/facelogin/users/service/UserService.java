package com.ai.facelogin.users.service;

import com.ai.facelogin.otp.dto.OtpReqDto;
import com.ai.facelogin.security.auth.FaceAuthenticationToken;

public interface UserService {
    
    // 중복아이디
    void duplicateUserStrId(String userStrId);
    //중복이메일
    void duplicateEmail(String email);

    //추가인증 성공 후 사용자 권한 및 토큰 재발급 메서드
    FaceAuthenticationToken changeAuthorityAndJwtToken(OtpReqDto dto);

}


/*
* interface  클래스 객체의 인스턴스는
* 접근제한자와 클래스 타입을 지정하지 않아도 
* public abstract로 지정됨
* 단, 구현체에는 public을 명시해야함
* */

