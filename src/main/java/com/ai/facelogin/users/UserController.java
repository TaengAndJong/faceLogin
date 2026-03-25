package com.ai.facelogin.users;


import com.ai.facelogin.users.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Slf4j
@RequestMapping("/user")
@RequiredArgsConstructor // 생성자 주입
@Controller
public class UserController {

        //주입받을 서비스 객체
        private final UserService userService;

        @GetMapping("/checkId")
        @ResponseBody//응답 데이터를 JSON 형식으로 보내기 위해 필요함
        public boolean checkingUserIdStr(@RequestParam String userIdStr) {
                
            log.info("회원가입 아이디 중복 체크 진입: {} ", userIdStr);

            return  userService.duplicateUserIdStr(userIdStr);
        }

}
