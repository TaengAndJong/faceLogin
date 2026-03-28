package com.ai.facelogin.otp.service;

import com.ai.facelogin.otp.dto.OtpRequestDto;

public interface OtpService {
    // 이메일 인증코드 전송
    void sendOtpCodeEmail(String email);

    //전송 된 인증코드 비교 검증
    void compareOtpCode(OtpRequestDto dto);

    // Redis 인증 성공여부 (회원가입 시
    boolean isVerificationCompleted(String email);
}


/*
* interface  클래스 객체의 인스턴스는
* 접근제한자와 클래스 타입을 지정하지 않아도 
* public abstract로 지정됨
* 단, 구현체에는 public을 명시해야함
* */

