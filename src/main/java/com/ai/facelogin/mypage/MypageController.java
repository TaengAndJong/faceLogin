package com.ai.facelogin.mypage;


import com.ai.facelogin.config.JwtUtil;
import com.ai.facelogin.users.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
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
    public String getMypage(Authentication authentication, Model model) {

        //String userId = jwtUtil.getUserIdFromToken(token);
        //현재 로그인 중인 사용자 ID(pricipal)
        if(authentication == null || !authentication.isAuthenticated()){
            return "redirect:/auth/login"; // 인증정보 없으면 로그인페이지로 리다이렉션
        }

        String userId = authentication.getName();

         log.info("마이페이지 userId ------:{}", userId);
        model.addAttribute("userId", userId);

        return "user/mypage"; //layoutinterCeptor 통해서 user/mypage.jsp로 이동
    }

}
