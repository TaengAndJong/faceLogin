package com.ai.facelogin.users;


import com.ai.facelogin.common.ApiResponse;
import com.ai.facelogin.common.exception.common.WithdrawalException;
import com.ai.facelogin.otp.service.OtpService;
import com.ai.facelogin.users.dto.EmailCheckDto;
import com.ai.facelogin.users.service.UserService;
import jakarta.validation.Valid;
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
        public ResponseEntity<ApiResponse<Boolean>> checkingUserStrId(@RequestParam String userStrId) {

            //아이디 중복검사, 중복일 경우 전역 예외처리로
            userService.duplicateUserStrId(userStrId);

            return ResponseEntity.ok(
                    ApiResponse.success("사용가능한 아이디입니다.", true)
            );
        }

        @PostMapping("/check-email")
        public ResponseEntity<ApiResponse<Boolean>> emailCheck(@Valid @RequestBody EmailCheckDto dto){

            log.info("EmailCheckDto-----: {}", dto);
            // otpType에 따라 이메일 중복검증 실행여부 분기
            if("REGISTER".equals(dto.getOtpType())){ // 요다 조건문
                //이메일 중복검증 실행(중복 시, 전역 예외처리 핸들러에서 예외처리)
                userService.duplicateEmail(dto.getEmail());
            }

            //인증코드 생성 및 메일발송 (실패 시, 전역 예외처리 핸들러에서 예외처리)
            otpService.sendOtpCodeEmail(dto.getEmail());
            // 예외 미발생 시 200, true 반환 ==> 공통 반환 API 만들어서 수정하기
           return ResponseEntity.ok(
                    ApiResponse.success("인증번호가 발송되었습니다. 메일함을 확인해주세요.", true)
            );
        }

        @PostMapping("/withdraw")
        public ResponseEntity<ApiResponse<?>> withDrawalUser(
                @RequestHeader("Authorization") String token, // 쿠키나 헤더에서 넘어온 JWT
                @RequestParam("userStrId") String userStrId){

            log.info("회원탈퇴 JWT token :{}",token);
            log.info("회원탈퇴 요구 사용자 아이디 :{}",userStrId);

            if (userStrId == null || userStrId.isBlank()) {
                // 전역 핸들러가 잡을 수 있도록 예외를 던집니다!
                throw new WithdrawalException("탈퇴할 사용자 아이디가 누락되었습니다.");
            }

            //회원탈퇴 비즈니스 로직 (DB 상태 변경 및 벡터 삭제)
            userService.withdrawnUser(userStrId);

            //Redis에 블랙리스트 등록 ( 토큰 무효화 )
            //tokenService.addToBlacklist(token);

            return   ResponseEntity.ok(
                    ApiResponse.success("탈퇴 성공", true)
            );
        }

//controller end
}


/*
* 아이디 중복검증과 , 이메일중복 검증과 이메일발송인증코드 인증의 API 메서드 구현 차이
* 
* */