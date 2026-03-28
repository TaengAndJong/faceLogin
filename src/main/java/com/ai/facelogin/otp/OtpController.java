package com.ai.facelogin.otp;


import com.ai.facelogin.common.exception.common.ApiResponse;
import com.ai.facelogin.otp.dto.OtpRequestDto;
import com.ai.facelogin.otp.service.OtpService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
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

    @PostMapping("/check-otp")
    public ResponseEntity<ApiResponse<Boolean>> checkOtpNumber(@Valid @RequestBody OtpRequestDto dto){

        log.info("otp 인증번호 확인 객체 --------:{}",dto);
        otpService.compareOtpCode(dto); //Redis 비교할 email과 사용자가 입력한 otp코드

        return ResponseEntity.ok(ApiResponse.success("이메일 인증완료",true));
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