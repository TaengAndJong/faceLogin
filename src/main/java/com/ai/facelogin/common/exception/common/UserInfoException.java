package com.ai.facelogin.common.exception.common;

/* 아이디, 비밀번호 관련 예외처리*/

public class UserInfoException extends RuntimeException {

    //기본 생성자
    public UserInfoException() {
        super();
    }

    //메시지 받는 생성자
    public UserInfoException(String message) {
        super(message);
    }

}
