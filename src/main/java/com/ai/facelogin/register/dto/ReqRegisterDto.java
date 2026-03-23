package com.ai.facelogin.register.dto;


import jakarta.validation.constraints.*;
import lombok.*;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
@NoArgsConstructor //스프링 바인딩용
@AllArgsConstructor // 전체 필드 주입용
public class ReqRegisterDto {

    @NotBlank(message = "이름은 필수 입력 값입니다.")
    @Size(min = 4, max = 20)
    @Pattern(
            regexp = "^[a-zA-Z0-9]+$",
            message = "아이디는 영문과 숫자만 가능합니다."
    )
    private String username; // 사용자 아이디

    @NotBlank(message = "이메일은 필수 입력 값입니다.")
    @Email(message = "이메일 형식이 올바르지 않습니다.")
    @Pattern(
            regexp = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$",
            message = "이메일 형식이 올바르지 않습니다."
    )
    private String email; // 이메일

    @NotNull(message = "이미지는 필수입니다.")
//    @FileSize(max = 5MB) //커스텀 어노테이션 생성 및 정의 필요 또는 스프링설정 옵션에서 제한
    private MultipartFile faceImage; // 벡터 이미지
}


/*
*
*
*
*
* */

/*
*
* */