package com.ai.facelogin.mypage;


import com.ai.facelogin.config.CustomUserDetails;
import com.ai.facelogin.config.JwtUtil;
import com.ai.facelogin.users.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Slf4j
@RequestMapping("/mypage")
@RequiredArgsConstructor
@Controller
public class MypageController {

    private final UserService userService;
    private final JwtUtil jwtUtil;

    @GetMapping()
    public String getMypage(@AuthenticationPrincipal CustomUserDetails userDetails, Model model) {

        //String userId = jwtUtil.getUserIdFromToken(token);
        //@AuthenticationPrincipal 은 비로그인 시 null값 들어옴
        if (userDetails == null) {
            log.error("인증 안됨 : 토큰만료, 비로그인 상태, 로그인 페이지로 리다이렉트");
            return "redirect:/auth/login";
        }

        //@AutheticationPrincipal을 사용하면 파라미터에 값 주입 전, 자동형변환이 되어 바로 값을 꺼내 사용가능
        //객체 통째로 클라이언트로 보내기
        model.addAttribute("userDetails", userDetails);

        log.info("마이페이지 model ------:{}", model);
        return "user/mypage"; //layoutinterCeptor 통해서 user/mypage.jsp로 이동
    }

}
