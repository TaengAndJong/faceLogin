package com.ai.facelogin.login.dto;

//시큐리티 인증객체 비교 시 사용자 정보 조회할 때 사용하는 DTO

import lombok.*;

@ToString
@Getter
@Builder // 서비스 레이어에서 VO -> DTO 변환 시 사용
@NoArgsConstructor
@AllArgsConstructor
public class UserLoginDto {

    private String userStrId;     // user_str_id
    private String userRole;      // 유저 권한 (ROLE_USER 등)
    private float[] faceEncoding; // DB에 저장된 얼굴 데이터

}
