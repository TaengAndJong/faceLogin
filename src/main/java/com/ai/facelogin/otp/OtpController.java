package com.ai.facelogin.otp;


import com.ai.facelogin.common.ApiResponse;
import com.ai.facelogin.enums.RedisPrifix;
import com.ai.facelogin.otp.dto.OtpReqDto;
import com.ai.facelogin.otp.service.OtpService;
import com.ai.facelogin.security.auth.FaceAuthenticationToken;
import com.ai.facelogin.users.service.UserService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/otp")
public class OtpController {

    private final OtpService otpService;
    private final UserService userService;

    @PostMapping("/check-otp")
    public ResponseEntity<ApiResponse<?>> checkOtpNumber(@Valid @RequestBody OtpReqDto dto){

        log.info("otp 인증번호 검증 확인 객체 --------:{}",dto);

        if("REGISTER".equals(dto.getOtpType())){
            log.info("회원가입 인증번호 코드 비교 실행");
            otpService.compareOtpCode(dto, RedisPrifix.REGISTER.getRedisPrifixName()); //Redis 비교할 email과 사용자가 입력한 otp코드
            return ResponseEntity.ok(ApiResponse.success("이메일 인증완료", true));
        }

        //여기서 추가인증 분기처리해야하지 않나 ?
        if("LOGIN".equals(dto.getOtpType())){
            log.info("로그인 인증번호 코드 비교 실행");
            otpService.compareOtpCode(dto, RedisPrifix.LOGIN.getRedisPrifixName()); //Redis 비교할 email과 사용자가 입력한 otp코드
            // 로그인 실행 로직 추가
            FaceAuthenticationToken tokenResponse = userService.changeAuthorityAndJwtToken(dto.getEmail());
            return ResponseEntity.ok(ApiResponse.success("otp 추가인증 및 로그인 성공",tokenResponse));
        }
        // 두 경우를 제외하고 전역으로 예외 던지기
        throw new BadCredentialsException("유효하지 않은 인증 타입이거나 잘못된 접근입니다.");
    }

}

/*
* @Model 과 @RequestBody
*
* @Model은 SSR(서버사이드렌더링)과 관련되며,
* HTML 구조를 다시 렌더링 할 때, 데이터를 담아주는 객체
*
* @RequestBody는 Model과 달리 HTML을 다시 렌더링 하지 않고
* 브라우저로부터 데이터를 받아올 때 JSON 형식으로 받아 올 수 있게 함
* (비동기로 화면 안 바꾸고 데이터만 확인)
* */