package com.ai.facelogin.register;

import com.ai.facelogin.register.dto.RegisterReqDto;
import com.ai.facelogin.register.service.RegisterService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;


@Slf4j
@Controller
@RequiredArgsConstructor //final 필드 생성자주입
public class RegisterController {

    //객체주입 잊지말자 -- null point 발생함
   private final RegisterService registerService;
   
    @GetMapping("/register")
    public String register() {
        log.info("register Page");
        return "auth/register"; // 뷰이름 맨 앞에는 / 사용 x => 공통레이아웃에 선언된 경로있음
    }

    @PostMapping("/register")
    public String registerProcess(@Valid RegisterReqDto dto) throws IOException {

        log.info("회원가입 요청 발생! reqRegisterDto: {}", dto);
        // 🎯 [1단계] 변환 전 이미지 복사해서 저장
        if (dto.getFaceEncoding() != null && !dto.getFaceEncoding().isEmpty()) {
            File testDir = new File("C:/Users/k/Desktop/test");
            if (!testDir.exists()) testDir.mkdirs();

            String fileName = "login_" + System.currentTimeMillis() + ".jpg";
            File targetFile = new File(testDir, fileName);

            // 🎯 핵심: transferTo 대신 InputStream을 열어서 복사합니다.
            try (InputStream is = dto.getFaceEncoding().getInputStream()) {
                java.nio.file.Files.copy(is, targetFile.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
            }

            log.info("검증용 이미지 복사 완료 (원본 보존됨): {}", fileName);
        }

        // 여기서 DB 저장 로직 수행 (Service 호출)
        registerService.register(dto);

        //model에 담아주기

        return "redirect:/login"; // 가입 완료 후 로그인 페이지로 리다이렉트
    }

}



