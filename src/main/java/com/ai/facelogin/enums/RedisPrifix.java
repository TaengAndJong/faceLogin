package com.ai.facelogin.enums;

public enum RedisPrifix {
    REGISTER("RegisterOTP"),
    LOGIN("LoginOTP");

    private final String redisPrifix;
    
    //Enum 클래스 객체 한글 초기화 생성자
     RedisPrifix(String redisPrifix) {
        this.redisPrifix = redisPrifix;
    }
    
    //접두사 반환
    public String getRedisPrifixName() {
        return redisPrifix;
    }
}

// 직접 작성 안하려면 @Getter, @RequiredArgsConstructor 어노테이션 사용
