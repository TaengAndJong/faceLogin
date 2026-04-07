package com.ai.facelogin.config;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final  JwtUtil jwtUtil;


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {

        //request Header 에서 '인증 키' 값 꺼내기
        String bearerToken = request.getHeader("Authorization");
        String token = null;

        //Bearer 로 시작하는 지 확인 후 순수 토큰 문자열 추출
        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            token = bearerToken.substring(7);
        }

        //토큰 읽고, JwtUtil을 통해 인증 시도
        if (token != null && jwtUtil.validateToken(token)) {
            // 4. 토큰에서 유저 정보를 꺼내서 '인증 객체(Authentication)'를 생성.
            Authentication auth = jwtUtil.getAuthentication(token);

            //이번 요청 동안만 이 유저를 "인증됨" 상태로 유지
            SecurityContextHolder.getContext().setAuthentication(auth);
        }
        
        // jwtutil 인증이 끝나면 다음 필터로 넘겨줌
        filterChain.doFilter(request, response);

    }//filterend

}//class end
