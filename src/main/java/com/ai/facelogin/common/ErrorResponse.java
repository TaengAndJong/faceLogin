package com.ai.facelogin.common;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter // 캡슐화 된 인스턴스 스프링이 가져다 JSON으로 변환하려면 필요
@NoArgsConstructor //기본생성자 --> 프레임워크의 객체 생성 시 초기화에 필수
@AllArgsConstructor // 전체 인자 생성자 --> 클래스 인스턴스 초기화, new 연산자롤 exMsg 받아서 사용하려면 필요
public class ErrorResponse {
    private String exMsg;
}


//