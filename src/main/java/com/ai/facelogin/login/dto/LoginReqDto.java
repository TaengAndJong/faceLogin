package com.ai.facelogin.login.dto;


import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;



//로그인 시 컨트롤러에 정보를 전달해주는 DTO
@ToString
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class LoginReqDto {

    @NotBlank(message = "이름은 필수 입력 값입니다.")
    @Size(min = 4, max = 20)
    @Pattern(
            regexp = "^[a-zA-Z0-9]+$",
            message = "아이디는 영문과 숫자만 가능합니다."
    )
    private String userStrId;

    @NotNull(message = "이미지는 필수입니다.")
    private MultipartFile faceEncoding; // 파일 객체

}
