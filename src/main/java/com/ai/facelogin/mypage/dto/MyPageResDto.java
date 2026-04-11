package com.ai.facelogin.mypage.dto;


import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class MyPageResDto {

    private String userId;// 데이터이스 자동생성 아이디
    private String userIdStr; // 사용자 아이디
    private String userName; // 사용자명
    private String email;//사용 이메일
    private String status; // 가입상태
}
