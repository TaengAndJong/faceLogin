package com.ai.facelogin.common.exception.common;


import lombok.Getter;

@Getter //생성자는 데이터를 저장하는 용도이며 캡슐화 상태로,getter를 통해 접근해야함
public class DuplicationExcep extends RuntimeException{

    //캡슐화와 값 초기화와 고정을 위해 private, final 필요
    private final String errCode;
    
    public DuplicationExcep(String errCode, String message) {
        super(message);
        this.errCode = errCode; // 생성된 필드는 반드시 초기화 필요
    }

}
