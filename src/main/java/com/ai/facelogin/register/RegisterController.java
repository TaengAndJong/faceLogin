package com.ai.facelogin.register;

import com.ai.facelogin.register.dto.ReqRegisterDto;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@Controller
public class RegisterController {

    @GetMapping("/register")
    public String register() {
        log.info("register Page");
        return "auth/register"; // 뷰이름 맨 앞에는 / 사용 x => 공통레이아웃에 선언된 경로있음
    }

    @PostMapping("/register")
    public String registerProcess(
            @Valid @ModelAttribute ReqRegisterDto reqRegisterDto,
            Model model) {

        log.info("회원가입 요청 발생! reqRegisterDto: {}", reqRegisterDto);
        // 여기서 DB 저장 로직 수행 (Service 호출)

        //model에 담아주기

        return "redirect:/login"; // 가입 완료 후 로그인 페이지로 리다이렉트
    }

}



