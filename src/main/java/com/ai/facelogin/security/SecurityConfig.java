package com.ai.facelogin.security;


import com.ai.facelogin.config.JwtAuthenticationFilter;
import com.ai.facelogin.security.handler.CustomLogoutSuccessHandler;
import com.ai.facelogin.security.provider.FaceAuthenticationProvider;
import jakarta.servlet.DispatcherType;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.logout.CookieClearingLogoutHandler;

@Slf4j
@EnableWebSecurity(debug = true) // Spring Security가 URL 매칭을 로그
@RequiredArgsConstructor
@Configuration
public class SecurityConfig {

    //시큐리티 전용 쿠키 삭제 인터페이스로 JWT 삭제처리
    CookieClearingLogoutHandler cookieHandler = new CookieClearingLogoutHandler("jwt");
    //로그아웃 성공 후 처리 핸들러  인터페이스 구현체 ( 생성자 주입 )
    private final CustomLogoutSuccessHandler logoutSuccessHandler;

    //시큐리티 매니저 빈등록
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
        return authConfig.getAuthenticationManager();
    }

    @Bean // 빈으로 등록해서 스프링 컨테이너에 등록 (IOC : 컨트롤 역전)
    public SecurityFilterChain filterChain(HttpSecurity http, FaceAuthenticationProvider faceAuthenticationProvider, JwtAuthenticationFilter jwtAuthenticationFilter, CustomLogoutSuccessHandler customLogoutSuccessHandler) throws Exception {
        log.info("security filter chain:");

        http
            .csrf(csrf -> csrf.disable())
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
            .authorizeHttpRequests(res -> res
                    .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll() //6.0 이후로는 포워딩도 허용을 해야 리다이렉트 안생김
                    .requestMatchers(
                            "/", "/error",
                            "/register",
                            "/login/**",
                            "/user/**",
                            "/otp/**",
                            "/css/**",
                            "/fonts/**",
                            "/js/**",
                            "/images/**",
                            "/WEB-INF/views/**"
                    ).permitAll() //누구나 접근 가능한 페이지
                    .requestMatchers("/mypage/**").hasAuthority("USER") //권한이 필요한 페이지
                    .anyRequest().authenticated() // 나머지는 인증만 되면 허용
            ).addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                .authenticationProvider(faceAuthenticationProvider)
                .formLogin(login -> login.loginPage("/login") // 로그인에 사용할 페이지 URL
                        .usernameParameter("userStrId") // 인증객체에서 name 값 명칭 커스텀 할 경우 설정 필요 ( 기본 username)
                        .permitAll()) // 로그인 URL 누구에게나  허용
            .logout(logout -> logout
                            .logoutUrl("/logout")// 로그아웃 처리 URL
                            .addLogoutHandler(cookieHandler) // 시큐리티 전용 쿠키삭제 인터페이스
                            .logoutSuccessHandler(customLogoutSuccessHandler) // 로그아웃 성공 후 처리 인터페이스
                            .permitAll()); // 로그아웃 URL 누구에게나  허용

        return http.build(); // 시큐리티 컨텍스트에 저장
    }


}
