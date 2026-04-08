package com.ai.facelogin.login;


import com.ai.facelogin.config.JwtUtil;
import com.ai.facelogin.login.dto.LoginReqDto;

import com.ai.facelogin.login.service.LoginService;
import com.ai.facelogin.security.auth.FaceAuthenticationToken;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;



@Slf4j
@RequiredArgsConstructor
@Controller
public class LoginController {

    private final LoginService loginService;
    private final AuthenticationManager authenticationManager; // 시큐리티 컨피그에 빈등록 필수!
    private final JwtUtil jwtUtil;

    @GetMapping("/login")
    public String loginPage() {
        log.info("Login Page---------------");
        return "auth/login"; // login.jsp
    }


    @PostMapping("/login/check")
    public String loginCheck(@Valid LoginReqDto dto, HttpServletResponse response) {
        log.info("Login check 페이지 : {} ",dto);

        String userStrId = dto.getUserIdStr();//사용자가 입력한 아이디
        float[] newVector = loginService.getFaceVector(dto);   //받아온 데이터 중 파일객체 이미지 전처리해서 다시 받아오기
        log.info("로그인 컨트롤러 userStrId :{}, toVector : {}", userStrId,newVector);

        // 인증 전 데이터를 커스텀 토큰 생성 및 값 저장하기 (미인증 토큰으로 )
        FaceAuthenticationToken unauthenticatedToken =
                new FaceAuthenticationToken(userStrId, newVector);

        try {
            // 시큐리티 매니저에게 인증 부탁 -> 매니저가 Provider를 호출하여 실제 인증절차를 실행
            Authentication authentication = authenticationManager.authenticate(unauthenticatedToken);

            //provider 의 인증검증이 성공이면 시큐리티 컨텍스트에 인증정보저장
            SecurityContextHolder.getContext().setAuthentication(authentication); // 로그인 상태가 됨

            // 로그인 상태가 되면 JWT 토큰 생성
            String token = jwtUtil.createToken(userStrId);
            log.info("JWT 발급 완료 ---- controller: {}", token);
            // 브라우저가 다음 요청부터 이 토큰을 자동으로 들고 오게 합니다.
            Cookie jwtCookie = new Cookie("jwt", token);
            jwtCookie.setHttpOnly(true); // 자바스크립트로 접근 불가 (보안)
            jwtCookie.setPath("/");     // 모든 경로에서 쿠키 사용 가능
            jwtCookie.setMaxAge(60 * 60); // 1시간 유지
            response.addCookie(jwtCookie); // Reponse 객체에 쿠키를 담아 클라이언트로 전달

            //마이페이지로 리다이렉트
            return "redirect:user/mypage";
        }catch (AuthenticationException e) {
            log.error("얼굴인증 시도 에러 - 컨트롤러 :{}",e.getMessage());
            return "redirect:auth/login";
        }

    }

}
