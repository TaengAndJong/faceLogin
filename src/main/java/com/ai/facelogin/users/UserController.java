package com.ai.facelogin.users;


import com.ai.facelogin.otp.service.OtpService;
import com.ai.facelogin.users.dto.EmailCheckDto;
import com.ai.facelogin.users.service.UserService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RequestMapping("/user")
@RequiredArgsConstructor // 생성자 주입
@Validated //단일 파라미터에 bean valid 적용
@Controller
public class UserController {

        //주입받을 서비스 객체
        private final UserService userService;
        //otp 서비스 객체
        private final OtpService otpService;

        @GetMapping("/check-id")
        @ResponseBody//응답 데이터를 JSON 형식으로 보내기 위해 필요함
        public boolean checkingUserIdStr(
                @NotBlank(message = "아이디를 입력해주세요.")
                @Size(min = 4, max = 20, message = "아이디는 4~20자여야 합니다.")
                @Pattern(regexp = "^[a-zA-Z0-9]+$", message = "아이디는 영문과 숫자만 가능합니다.")
                @RequestParam String userIdStr) {
                
            log.info("아이디 중복 체크 진입: {} ", userIdStr);
            boolean result = userService.duplicateUserIdStr(userIdStr);
            log.info("아이디 중복 체크 결과반환: {} ", result);

            return  result;
        }

        @PostMapping("/check-email")
        public ResponseEntity<Boolean> emailCheck(@Valid @RequestBody EmailCheckDto dto){

            //이메일 중복검증 실행(중복 시, 전역 예외처리 핸들러에서 예외처리)
            userService.duplicateEmail(dto.getEmail());
            
            //인증코드 생성 및 메일발송 (실패 시, 전역 예외처리 핸들러에서 예외처리)
            otpService.sendOtpCodeEmail(dto.getEmail());

            // 예외 미발생 시 200, true 반환 ==> 공통 반환 API 만들어서 수정하기
            return ResponseEntity.ok(true);
        }


//controller end
}


/*
* 아이디 중복검증과 , 이메일중복 검증과 이메일발송인증코드 인증의 API 메서드 구현 차이
* 
* */