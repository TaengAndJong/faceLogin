package com.ai.facelogin.common.exception.common;

/* 아이디, 비밀번호 관련 예외처리*/

public class UserInfoException extends RuntimeException {

    public UserInfoException(String message) {
        super(message);
    }

}
