package com.ai.facelogin.otp.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.*;
import jakarta.validation.groups.Default;

@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OtpReqDto {

    // 스프링 @Validated 구분할 마커 인터페이스 그룹 생성(기본 그룹 상속)
    public interface OnLogin extends Default{}// 로그인 시 검증할 그룹
    public interface OnRegister extends Default {}

    @NotBlank(message = "이메일은 필수입니다." )
    private String email;

    @NotBlank(message = "아이디는 필수입니다.", groups = OnLogin.class) // 로그인 추가인증일 때만 검증
    private String userStrId;

    @NotBlank // null, "", " " 모두 차단
    @Size(min = 6, max = 6, message = "인증번호는 6자리여야 합니다.")
    @Pattern(regexp = "^[0-9]+$", message = "인증번호는 숫자만 입력 가능합니다.")
    private String otpCode;

    @NotBlank(message = "인증 타입은 필수입니다.")
    private String otpType;

}

