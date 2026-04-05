package com.ai.facelogin.users.service;

public interface UserService {
    
    // 중복아이디
    void duplicateUserIdStr(String userIdStr);
    //중복이메일
    void duplicateEmail(String email);

}


/*
* interface  클래스 객체의 인스턴스는
* 접근제한자와 클래스 타입을 지정하지 않아도 
* public abstract로 지정됨
* 단, 구현체에는 public을 명시해야함
* */

