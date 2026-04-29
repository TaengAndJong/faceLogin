package com.ai.facelogin.token.service;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor // 생성자 주입
public class TokenServiceImpl implements TokenService {

    //Redis 연동 객체
    private final StringRedisTemplate redis;

    @Override
    public void addToBlacklist(String token) {



    }

    @Override
    public boolean isBlacklisted(String token) {
        return false;
    }


}


