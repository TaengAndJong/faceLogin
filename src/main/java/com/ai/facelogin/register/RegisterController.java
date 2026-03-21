package com.ai.facelogin.register;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Slf4j
@Controller
public class RegisterController {

    @GetMapping("/register")
    public String register() {
        log.info("register Page");
        return "auth/register"; // 뷰이름 맨 앞에는 / 사용 x => 공통레이아웃에 선언된 경로있음
    }
}
