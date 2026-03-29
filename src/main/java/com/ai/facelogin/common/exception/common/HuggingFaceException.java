package com.ai.facelogin.common.exception.common;


import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor // 생성자 주입
public class HuggingFaceException extends RuntimeException {

     private final HttpStatus status; // 통신 에러 상태

    public HuggingFaceException( String message, HttpStatus status) {
        super(message); // 부모한테 상속받음
        this.status = status; // 해당 클래스 클래스멤버 변수 초기화
    }

}

/*
*
*
*
* */