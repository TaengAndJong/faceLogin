package com.ai.facelogin.login.dto;


import com.ai.facelogin.security.auth.FaceAuthenticationToken;
import lombok.Builder;
import lombok.Getter;


@Getter
@Builder
public class LoginRespDto {

   private final FaceAuthenticationToken tokenResponse; // 로그인 추가인증 성공 시 반환되는 최종응답결과
   private final String redirectUrl; // 로그인 성공 후 리다이렉트 경로

}
