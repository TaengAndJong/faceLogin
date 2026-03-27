package com.ai.facelogin.common.exception.common;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter // getter가 있어야 Jasckson이 필드를 읽을 수 있음
@Builder //빌더로 값 설정
@NoArgsConstructor //기본생성자 초기화 (파라미터 없음)
@AllArgsConstructor // 모든 생성자 초기화 (파라미터 있음)
public class ApiResponse<T> { // 클래스 옆에 <T>를 붙여 "이 클래스는 제네릭을 쓴다"고 선언

    private boolean success;
    private String message;
    private T data; // 위에서 선언한 T 타입을 필드타입으로 사용 (Boolean이 될 수도, Dto가 될 수도 있음)

    //성공 응답을 만드는 정적 메서드 ( static 메서드는 객체 생성 안해도 호출해서 사용가능 )
    public static <T> ApiResponse<T> success(String message, T data) {
        return ApiResponse.<T>builder() // 빌더에게도 T 타입을 알려줌
                .success(true)
                .message(message)
                .data(data)
                .build();
    }

}

/*
* @Builder 어노테이션은 디자인패턴을 자동으로 만들어주는 어노테이션
* */
