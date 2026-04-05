package com.ai.facelogin.otp.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class OtpReqDto {

    @NotBlank(message = "이메일은 필수입니다.")
    private String email;

    @Size(min = 6, max = 6, message = "인증번호는 6자리여야 합니다.")
    private String otpCode;

}
