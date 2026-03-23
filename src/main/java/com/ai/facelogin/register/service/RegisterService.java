package com.ai.facelogin.register.service;

import com.ai.facelogin.register.dto.ReqRegisterDto;

public interface RegisterService {
    
    // 회원가입 데이터 등록
    void register(ReqRegisterDto dto);

}


/*
* interface  클래스 객체의 인스턴스는
* 접근제한자와 클래스 타입을 지정하지 않아도 
* public abstract로 지정됨
* 단, 구현체에는 public을 명시해야함
* */

