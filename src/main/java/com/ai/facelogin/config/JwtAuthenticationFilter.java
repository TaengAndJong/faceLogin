package com.ai.facelogin.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final  JwtUtil jwtUtil;


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        log.info("doFIlterInternal -- JwtAuthenticationFilter 진입");

        //request Header 에서 '인증 키' 값 꺼내기
        String bearerToken = request.getHeader("Authorization");
        String token = null;
        log.info("bearerToken :{} " ,bearerToken);

        //Bearer 로 시작하는 지 확인 후 순수 토큰 문자열 추출
        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            token = bearerToken.substring(7);
            log.info("token :{} " ,token);
        }

        // 리다이렉트시 header에서 토큰을 찾지 못하고, 쿠키에서 찾아야함(브라우저 리다이렉트용)
        if(token == null && request.getCookies() !=null){ //header에 토큰이 없고, 쿠키가 값이 잇으면
            log.info("리다이렉트 시 쿠키조회 " , request.getCookies());
            for(Cookie cookie : request.getCookies()){
                if("jwt".equals(cookie.getName())){ // 브라우저에 저장된 쿠키에 토큰명이라면 (jwt 사용중)
                    token = cookie.getValue(); // 쿠키 값 토큰에 할당
                    log.info("리다이렉트 시 token :{} " ,token);
                    break;//  for 종료
                }
            }
        }

     
        //토큰 읽고, JwtUtil을 통해 인증 시도
        if (token != null && jwtUtil.validateToken(token)) {
            log.info("jwt 토큰 검증 시도 진입");
            
            // 4. 토큰에서 유저 정보를 꺼내서 '인증 객체(Authentication)'를 생성.
            Authentication auth = jwtUtil.getAuthentication(token);
            log.info("jwt jwtUtil.getAuthentication(token) :{}",auth);
            //이번 요청 동안만 이 유저를 "인증됨" 상태로 유지
            SecurityContextHolder.getContext().setAuthentication(auth);
        }
        
        // jwtutil 인증이 끝나면 다음 필터로 넘겨줌
        filterChain.doFilter(request, response);

    }//filterend

}//class end
