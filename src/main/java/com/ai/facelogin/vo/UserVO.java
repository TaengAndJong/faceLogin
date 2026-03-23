package com.ai.facelogin.vo;

import lombok.*;


@ToString //컴파일 시점에 객체 내부의 필드 값을 문자열로 나열하도록 재정의(Override) [기계어 -> 인간어]
@Getter // MyBatis나 로직에서 값을 꺼내기 위해 필요
@Builder // 서비스 레이어에서 DTO -> VO 변환 시 사용
@AllArgsConstructor // @Builder가 내부적으로 사용 (모든 필드 생성자)
@NoArgsConstructor // MyBatis가 DB 결과를 객체로 만들 때 필요 (기본 생성자)
public class UserVO {
    private String username;
    private String email;
    // 얼굴 인식 벡터 데이터 (pgvector 매핑용)
    private float[] faceVector;
}


/*
* VO는 순수한 자바 객체(POJO)이거나 DB 라이브러리(MyBatis 등)와 연결되는 객체
* DTO와 같이 사용하는 경우, 순수하게 데이터만 디비로 전달
* 기타 검증이나 setter 필요 없음 (불변객체의 성질 유지)
* */