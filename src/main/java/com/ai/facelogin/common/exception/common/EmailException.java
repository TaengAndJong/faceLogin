package com.ai.facelogin.common.exception.common;

/* 이메일 인증 관련 예외처리*/

public class EmailException extends RuntimeException {

    //기본 생성자
    public EmailException() {
        super();
    }

    //메시지 받을 생성자
    public EmailException(String message) {
        super(message);
    }

}
