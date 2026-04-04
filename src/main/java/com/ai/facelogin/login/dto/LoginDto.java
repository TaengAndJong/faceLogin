package com.ai.facelogin.login.dto;


import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class LoginDto {

    @NotBlank(message = "이름은 필수 입력 값입니다.")
    @Size(min = 4, max = 20)
    @Pattern(
            regexp = "^[a-zA-Z0-9]+$",
            message = "아이디는 영문과 숫자만 가능합니다."
    )
    private String userIdStr;

    @NotNull(message = "이미지는 필수입니다.")
    private MultipartFile faceEncoding; // 파일 객체

}
