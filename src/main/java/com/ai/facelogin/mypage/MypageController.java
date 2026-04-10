package com.ai.facelogin.mypage;


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

    @GetMapping()
    public String getMypage(Authentication authentication, Model model) {

        //현재 로그인 중인 사용자 ID(pricipal)
        if(authentication == null){
            return "redirect:/login"; // 인증 정보없으면 로그인 페이지로
        }

        String userId = authentication.getName();

        model.addAttribute("userId", userId);

        return "user/mypage"; //layoutinterCeptor 통해서 user/mypage.jsp로 이동
    }

}
