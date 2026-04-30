package com.ai.facelogin.config;


import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Date;

@Slf4j
@Component //스프링컨테이너 빈등록
public class JwtUtil { // == jwtProvider, jwtManager



    // 서버만 알고 있는 비밀키 (최소 32자 이상의 랜덤 문자열 권장)
    private final SecretKey key;
    private final UserDetailsService userDetailsService;

    // 토큰 유효 시간 (예: 1시간)
    private final long EXPIRATION_TIME = 1000 * 60 * 60;


    //생성자 직접 초기화 및 주입 ( 생성자 주입방식은 초기화 타이밍이 맞지 않아 에러, env 환경의 외부값 직접 주입하여 초기화)
    public JwtUtil(@Value("${jwt.secret}") String secretKey,UserDetailsService userDetailsService){ //개발자가 직접 지정한 코드로 절대 유출금지
        this.key = Keys.hmacShaKeyFor(secretKey.getBytes());
        this.userDetailsService = userDetailsService;
        log.info("JwtUtil 초기화 성공: SecretKey 생성:{} 및 UserDetailsService 주입 완료 :{}",key,userDetailsService);
    }


    //얼굴 인증 성공 시 JWT 생성
    public String createToken(String userStrId) {
        log.info("JWT claims 토큰 검증 :{}",userStrId);

        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + EXPIRATION_TIME); // 유효기간 설정 (예: 1시간)

        return Jwts.builder()
                .subject(userStrId) // 1. 누구인지 (Payload)
                .issuedAt(now)                   // 2. 언제 만들었는지
                .expiration(expiryDate)          // 3. 언제까지 쓸 수 있는지
                .signWith(key)                   // 4. 우리 서버만 아는 비밀키로 서명 (Signature)
                .compact();                      // 5. 한 줄의 문자열로 압축!
    }

    //토큰에서 user_str_Id 추출 (검증 겸용) ==> 로그인 상태일 경우, 사용자의 데이터를 조회할 때 인증하는 역할
    public String getUserIdFromToken(String token) {
        Claims claims = Jwts.parser()
                .verifyWith(key)
                .build()
                .parseSignedClaims(token)
                .getPayload();

        log.info("JWT claims 토큰 검증 :{}",claims);
        return claims.getSubject();
    }
    
    //토큰 유효성 검사
    public boolean validateToken(String token) {
        log.info("JWT 토큰 유효성 검증 :{}",token);
        try {
            Jwts.parser().verifyWith(key).build().parseSignedClaims(token);
            return true;
        } catch (Exception e) {
            // 만료되었거나 변조된 토큰일 경우 false
            return false;
        }
    }


    //JWT필터에서 사용할 인증 객체 생성 메서드
    public Authentication getAuthentication(String token){

        log.info("jwtUtil token:----- 진입{}",token);

        //토큰에서 사용자 아이디(Subject)를 추출
        String userStrId = Jwts.parser()
                .verifyWith(key)
                .build()
                .parseSignedClaims(token)
                .getPayload()
                .getSubject();
        log.info("jwt Utils userStrId 추철: {}",userStrId);

        //DB에서 해당 유저의 상세 정보(권한 등)를 로드
        UserDetails userDetails = userDetailsService.loadUserByUsername(userStrId);
        log.info("Jwt Util getAuthentication()  userDetails :{}",userDetails);
        //해당 객체값을 가지고 시큐리티 전용 인증 토큰을 만들어 반환
        return new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities());
    }

    
    //Redis 블랙리스트에 사용할 토큰의 남은 유효시간(ms) 계산 메서드
    public long getRemainingExpiration(String token) {
        try {
            // 토큰을 파싱하여 내부 정보를 추출
            Claims claims = Jwts.parser()
                    .verifyWith(key)
                    .build()
                    .parseSignedClaims(token)
                    .getPayload();

            Date expiration = claims.getExpiration(); // 토큰에 기록된 만료 시각
            long now = new Date().getTime();          // 현재 시각

            // (만료 시각 - 현재 시각) = 남은 수명
            return Math.max(0, expiration.getTime() - now);
        } catch (Exception e) {
            log.error("남은 시간을 계산할 수 없는 토큰입니다: {}", e.getMessage());
            return 0;
        }
    }
    
}


/*
* JwtUtil 클래스 객체의 역할
*
* 1) 토큰 생성 
* 2) 토큰 비교 및 검증 : 로그인 후 요청을 보낼 때 Http 헤더에 담겨온 토큰을 해당 사용자인지 비교,검증
* 3) 토큰 정보 접근 : 검증 후 토큰 사용자에 대한 정보에 접근
* 
* JJWT 의존성 외부라이브러리 추가 필수
*
* */