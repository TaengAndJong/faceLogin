package com.ai.facelogin.login;


import com.ai.facelogin.face.service.FaceService;
import com.ai.facelogin.login.dto.LoginDto;
import com.ai.facelogin.login.service.LoginService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;


@Slf4j
@RequiredArgsConstructor
@Controller
public class LoginController {

    private final LoginService loginService;

    @GetMapping("/login")
    public String loginPage() {
        log.info("Login Page---------------");
        return "auth/login"; // login.jsp
    }


    @PostMapping("/login-check")
    public LoginDto loginCheck(@Valid LoginDto dto) {
        log.info("Login check 페이지 : {} ",dto);

        //받아온 데이터 중 파일객체 이미지 전처리해서 다시 받아오기 
        float[] newVector = loginService.getFaceVector(dto);
        log.info("로그인 컨트롤러 toVector : {}" ,newVector);
        // 기존 데이터베이스에 저장되어있는 원본이미지데이터 조회해오기
        float[] originVector = loginService.getOriginVector(dto.getUserIdStr());


        //시큐리티 인증객체에게 인증 비교할 두 데이터 넘겨주기

        return  null; // 로그인 성공여부에 따른 응답 반환이 필요함?
    }

}
