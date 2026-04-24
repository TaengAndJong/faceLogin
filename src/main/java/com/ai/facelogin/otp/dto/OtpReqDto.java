package com.ai.facelogin.otp.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.*;

@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OtpReqDto {

    @NotBlank(message = "이메일은 필수입니다.")
    private String email;

    @NotBlank // null, "", " " 모두 차단
    @Size(min = 6, max = 6, message = "인증번호는 6자리여야 합니다.")
    @Pattern(regexp = "^[0-9]+$", message = "인증번호는 숫자만 입력 가능합니다.")
    private String otpCode;

    @NotBlank(message = "인증 타입은 필수입니다.")
    private String otpType;
}
