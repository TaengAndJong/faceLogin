package com.ai.facelogin.otp;


import com.ai.facelogin.common.ApiResponse;
import com.ai.facelogin.enums.RedisPrifix;
import com.ai.facelogin.login.dto.LoginRespDto;
import com.ai.facelogin.otp.dto.OtpReqDto;
import com.ai.facelogin.otp.service.OtpService;
import com.ai.facelogin.security.auth.FaceAuthenticationToken;
import com.ai.facelogin.users.service.UserService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import jakarta.validation.groups.Default;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.SmartValidator;
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
    private final SmartValidator validator; // 스프링 Bean에 등록된 재사용 가능한 객체

    @PostMapping("/check-otp")
    public ResponseEntity<ApiResponse<?>> checkOtpNumber(
            @RequestBody OtpReqDto dto, // DTO 전부 받아 수동 검증
            HttpServletResponse response,
            BindingResult bindingResult // 일회용이라서 메서드 주입으로 객체를 주입 
            ) throws BindException {

        log.info("otp 인증번호 검증 확인 객체 --------:{}",dto);
        //SmartValidator로 동적 검증 실행
        Class<?> group = "LOGIN".equals(dto.getOtpType())
                ? OtpReqDto.OnLogin.class // 로그인이면 @Valid 로그인 인터페이스 그룹 사용
                : OtpReqDto.OnRegister.class;


        // 기본 필드와 선택 그룹 검사 (  그룹 선택 시, 기본그룹을 필수로 명시해줘야 제외 안됨)
        validator.validate(dto, bindingResult, Default.class, group);

        //입력값 검증 에러 처리
        if (bindingResult.hasErrors()) { //
            // 입력값이 비었거나 형식이 틀린 경우 전역핸들러로 던짐
            throw new BindException(bindingResult); //  해당 @Valid 메시지를 전달
        }

        log.info("검증 통과 후 로직 실행: {}", dto);
        // 로그인 추가인증과 회원가입 분기처리
        if("REGISTER".equals(dto.getOtpType())){ //요다 조건문
            log.info("회원가입 인증번호 코드 비교 실행");
            otpService.compareOtpCode(dto, RedisPrifix.REGISTER.getRedisPrifixName()); //Redis 비교할 email과 사용자가 입력한 otp코드
            return ResponseEntity.ok(ApiResponse.success("이메일 인증완료", true));
        }

        if("LOGIN".equals(dto.getOtpType())){
            log.info("로그인 인증번호 코드 비교 실행");
            otpService.compareOtpCode(dto, RedisPrifix.LOGIN.getRedisPrifixName()); //Redis 비교할 email과 사용자가 입력한 otp코드
            // 로그인 실행 로직 추가
            //권한변경 및 JWT 토큰 재생성
            FaceAuthenticationToken tokenResponse = userService.changeAuthorityAndJwtToken(dto);
            log.info("otpController 토큰 재발급 응답  :{}",tokenResponse);

            //JWT 쿠키 수동설정 필요
            String token = (String) tokenResponse.getPrincipal(); //jwt 문자열 추출
            Cookie jwtCookie = new Cookie("jwt", token);
            jwtCookie.setHttpOnly(true); // 자바스크립트로 접근 불가 (보안)
            jwtCookie.setPath("/");     // 모든 경로에서 쿠키 사용 가능
            jwtCookie.setMaxAge(60 * 60); // 1시간 유지
            response.addCookie(jwtCookie);

            LoginRespDto result = LoginRespDto.builder()
                    .tokenResponse(tokenResponse)
                    .redirectUrl("/mypage")
                    .build();
            

            return ResponseEntity.ok(ApiResponse.success("otp 추가인증 및 로그인 성공",result));
        }
        // 두 경우를 제외하고 전역으로 예외 던지기 ( 인증예외 )
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