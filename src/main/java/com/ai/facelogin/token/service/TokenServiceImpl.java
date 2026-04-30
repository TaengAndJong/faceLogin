package com.ai.facelogin.token.service;


import com.ai.facelogin.config.JwtUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.concurrent.TimeUnit;

@Slf4j
@Service
@RequiredArgsConstructor // 생성자 주입
public class TokenServiceImpl implements TokenService {

    //Redis 연동 객체
    private final StringRedisTemplate redis;
    private final JwtUtil jwtUtil;

    @Override
    public void addToBlacklist(String token) {

        String jwt = resolveToken(token);// 접두사를 제거한 토큰 추출
        
        long expiration = jwtUtil.getRemainingExpiration(token); // 남은 유효시간

        if( expiration > 0 ) { // 유효시간이 남아있다면
            //Redis 저장 (Key: 토큰, Value: "logout", 만료시간 설정) : 설정한 시간이 지나면 Redis에서 자동으로 삭제
            redis.opsForValue().set(
                    jwt,
                    "logout",
                    expiration,
                    TimeUnit.MILLISECONDS
            );
        } // end
        log.info("블랙리스트 등록 완료: {} (남은 시간: {}ms)", jwt.substring(0, 10) + "...", expiration);
 }// addToBlacklist end


    @Override
    public boolean isBlacklisted(String token) {
        String jwt = resolveToken(token);
      //  return Boolean.TRUE.equals(redisTemplate.hasKey(jwt));
        return false;
    }

    //JWT 접두사 제거 메서드
    private String resolveToken(String token) {
        log.info("TokenService ---- resolveToken : {}",token);
        if (token != null && token.startsWith("Bearer ")) {
            return token.substring(7);
        }
        return token;
    }

}


