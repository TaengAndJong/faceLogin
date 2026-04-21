package com.ai.facelogin.login;


import com.ai.facelogin.common.ApiResponse;
import com.ai.facelogin.config.JwtUtil;
import com.ai.facelogin.login.dto.LoginReqDto;

import com.ai.facelogin.login.service.LoginService;
import com.ai.facelogin.otp.service.OtpService;
import com.ai.facelogin.security.auth.FaceAuthenticationToken;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;


@Slf4j
@RequiredArgsConstructor
@Controller
public class LoginController {

    private final OtpService otpService;
    private final LoginService loginService;
    private final AuthenticationManager authenticationManager; // 시큐리티 컨피그에 빈등록 필수!
    private final JwtUtil jwtUtil;

    @GetMapping("/login")
    public String loginPage(Authentication auth) {

        //인증객체 생성되었고  사용자인증이 되었고 익명의 사용자가 아니라면
        if (auth != null && auth.isAuthenticated() &&
            !(auth instanceof AnonymousAuthenticationToken) //
        ) {
                log.info("auth 로그인한 사용자 로그인 컨트롤러 :{}",auth);
                log.info("인증된 사용자의 로그인 페이지 접근 시 /mypage로 리다이렉트");
                return "redirect:/mypage";
            }
        //인증된 사용자가 아니라면 로그인 페이지 접근 가능
        return "auth/login"; // login.jsp
    }


    @ResponseBody
    @PostMapping("/login/check")
    public ResponseEntity<ApiResponse<String>> loginCheck(@Valid LoginReqDto dto, HttpServletResponse response) throws IOException {
        log.info("Login check 페이지 : {} ", dto);

        // 변환 전 이미지 복사해서 저장
        if (dto.getFaceEncoding() != null && !dto.getFaceEncoding().isEmpty()) {
            File testDir = new File("C:/Users/k/Desktop/test");
            if (!testDir.exists()) testDir.mkdirs();

            String fileName = "login_" + System.currentTimeMillis() + ".jpg";
            File targetFile = new File(testDir, fileName);

            //transferTo 대신 InputStream을 열어서 복사 (원본이미지 저장 후에 데이터유지)
            try (InputStream is = dto.getFaceEncoding().getInputStream()) {
                java.nio.file.Files.copy(is, targetFile.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
            }

            log.info("검증용 이미지 복사 완료 (원본 보존됨): {}", fileName);
        }


        String userStrId = dto.getUserStrId();//사용자가 입력한 아이디
        float[] newVector = loginService.getFaceVector(dto);   //받아온 데이터 중 파일객체 이미지 전처리해서 다시 받아오기
        log.info("로그인 컨트롤러 userStrId :{}, toVector : {}", userStrId, newVector);

        // 인증 전 데이터를 커스텀 토큰 생성 및 값 저장하기 (미인증 토큰으로 )
        FaceAuthenticationToken unauthenticatedToken =
                new FaceAuthenticationToken(userStrId, newVector);
        log.info("로그인 컨트롤러 토큰생성완료  :{}", unauthenticatedToken);


        log.info("로그인 컨트롤러 인증 시작 ");
        // 시큐리티 매니저에게 인증 부탁 -> 매니저가 Provider를 호출하여 실제 인증절차를 실행
        Authentication authentication = authenticationManager.authenticate(unauthenticatedToken);
        log.info("로그인 컨트롤러 실제 인증절차 완료  :{}", authentication);

        //provider의 인증결과 토큰 반환되면 시큐리티 컨텍스트에 인증정보저장 ( 2가지 상태 저장 됨 : 인증성공과 임시인증)
        SecurityContextHolder.getContext().setAuthentication(authentication); // 로그인 상태가 됨
        log.info("로그인 컨트롤러 프로바이더에서 반환된 인증상태를 컨텍스트에 저장 ");

        //임시인증 분기처리 로직추가
        if(authentication instanceof FaceAuthenticationToken faceAuthToken) {
            log.info("authentication instanceof faceAuthToken:{}",faceAuthToken);

            if(faceAuthToken.isPreAuthStatus()) { // 임시인증상태 (명시적 조건분기)
                //사용자의 이메일로 otp 전송 및 마스킹된 이메일 정보 반환 받음
               String userEmail= otpService.sendOtpLoginEmail(userStrId);
                log.info("추가인증 OTP 코드 보내고 마스킹된 이메일값 반환 받음 : {}",userEmail);
                //클라이언트에게 OTP 코드 이메일 발송 응답 반환과 OTP 생성 및 발송
                return ResponseEntity.ok(ApiResponse.requiredAuth("이메일 추가인증", userEmail));
            }

           if(faceAuthToken.isAuthenticated()) { // 인증성공상태(명시적 조건분기)
               // 로그인 상태가 되면 JWT 토큰 생성
               String token = jwtUtil.createToken(userStrId);
               log.info("로그인 컨트롤러 JWT 발급 완료: {}", token);
               // 브라우저가 다음 요청부터 이 토큰을 자동으로 들고 오게 합니다.
               Cookie jwtCookie = new Cookie("jwt", token);
               jwtCookie.setHttpOnly(true); // 자바스크립트로 접근 불가 (보안)
               jwtCookie.setPath("/");     // 모든 경로에서 쿠키 사용 가능
               jwtCookie.setMaxAge(60 * 60); // 1시간 유지
               response.addCookie(jwtCookie); // Reponse 객체에 쿠키를 담아 클라이언트로 전달

               //공통 APIresponse에 담아서 반환하기
               return ResponseEntity.ok(ApiResponse.success("로그인 성공", "/mypage"));
           }

        }// 추가인증, 인증성공 조건분기 끝

        // 위의 조건에 걸리지 않은 나머지 문제 처리 
        log.error("정의되지 않은 인증 상태 발생: {}", authentication);
        throw new BadCredentialsException("유효하지 않은 인증 상태입니다."); //전역으로 던지기

    }//loginCheck end

}//class end