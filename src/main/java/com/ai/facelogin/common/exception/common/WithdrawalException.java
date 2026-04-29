package com.ai.facelogin.common.exception.common;

//롬복 어노테이션 생략 시 구조

public class WithdrawalException  extends RuntimeException{

    //기본 생성자 -> 메시지 없이 예외의 의미 전달
    public WithdrawalException() {
        super();
    }

    // 메시지만 받는 생성자
    public WithdrawalException(String message) {
        super(message);
    }

    // 원인 예외(Throwable) 까지 저장하고 싶을 경우
    public WithdrawalException(String message, Throwable cause) {
        super(message, cause);
    }

}
