package com.ai.facelogin.otp;


import com.ai.facelogin.common.exception.common.ApiResponse;
import com.ai.facelogin.otp.dto.OtpRequestDto;
import com.ai.facelogin.otp.service.OtpService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/otp")
public class OtpController {

    private final OtpService otpService;

    @PostMapping("/check-otp")
    public ResponseEntity<ApiResponse<Boolean>> checkOtpNumber(OtpRequestDto dto){

        log.info("checkOtpNumber--------:{}",dto);


        return ResponseEntity.ok(ApiResponse.success("이메일 인증완료",true));
    }

}
