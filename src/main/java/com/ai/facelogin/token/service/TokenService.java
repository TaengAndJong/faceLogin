package com.ai.facelogin.token.service;

import org.springframework.stereotype.Service;


public interface TokenService {

    /**
     * 토큰을 블랙리스트(Redis)에 등록하여 무효화
     * @param token 블랙리스트에 올릴 AccessToken (발급되었던 Jason Web Token)
     */
    void addToBlacklist(String token); //Radis 블랙리스트에 담는 메서드
    boolean isBlacklisted(String token);// 결과 확인 메서드

}
