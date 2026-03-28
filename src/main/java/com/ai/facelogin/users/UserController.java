package com.ai.facelogin.users;


import com.ai.facelogin.common.exception.common.ApiResponse;
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
        public ResponseEntity<ApiResponse<Boolean>> checkingUserIdStr(@RequestParam String userIdStr) {

            //아이디 중복검사, 중복일 경우 전역 예외처리로
            userService.duplicateUserIdStr(userIdStr);

            return ResponseEntity.ok(
                    ApiResponse.success("사용가능한 아이디입니다.", true)
            );
        }

        @PostMapping("/check-email")
        public ResponseEntity<ApiResponse<Boolean>> emailCheck(@Valid @RequestBody EmailCheckDto dto){

            //이메일 중복검증 실행(중복 시, 전역 예외처리 핸들러에서 예외처리)
            userService.duplicateEmail(dto.getEmail());
            
            //인증코드 생성 및 메일발송 (실패 시, 전역 예외처리 핸들러에서 예외처리)
            otpService.sendOtpCodeEmail(dto.getEmail());

            // 예외 미발생 시 200, true 반환 ==> 공통 반환 API 만들어서 수정하기
           return ResponseEntity.ok(
                    ApiResponse.success("인증번호가 발송되었습니다. 메일함을 확인해주세요.", true)
            );
        }


//controller end
}


/*
* 아이디 중복검증과 , 이메일중복 검증과 이메일발송인증코드 인증의 API 메서드 구현 차이
* 
* */