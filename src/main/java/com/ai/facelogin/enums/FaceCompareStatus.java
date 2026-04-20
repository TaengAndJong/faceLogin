package com.ai.facelogin.enums;


import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum FaceCompareStatus {

    SUCCESS,        // 즉시 통과 (0.32 이하)
    OTP_REQUIRED,   // 추가 인증 필요 (0.33 ~ 0.35)
    FAIL            // 인증 실패 (0.35 초과)

}
