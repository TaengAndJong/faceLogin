package com.ai.facelogin.security;


import com.ai.facelogin.config.JwtAuthenticationFilter;
import com.ai.facelogin.security.handler.CustomLogoutSuccessHandler;
import com.ai.facelogin.security.provider.FaceAuthenticationProvider;
import jakarta.servlet.DispatcherType;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.security.autoconfigure.web.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
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
    private final CustomLogoutSuccessHandler customLogoutSuccessHandler;
    //얼굴 인증 처리 provider
    private final FaceAuthenticationProvider faceAuthenticationProvider;
    //jwt 인증 필터
    private final JwtAuthenticationFilter jwtAuthenticationFilter;

    //시큐리티 매니저 빈등록
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
        return authConfig.getAuthenticationManager();
    }


    //정적 리소스 설정 (보안 필터링 제외)
    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring()
                // 스프링 부트가 제공하는 기본 정적 리소스 위치를 모두 보안검사 무시
                .requestMatchers(PathRequest.toStaticResources().atCommonLocations())
                // 추가로 보안검사 무시하고 싶은 특정 경로들 (파비콘, 에러페이지 등)
                .requestMatchers("/favicon.ico", "/resources/**", "/error");

    }

    @Bean // 빈으로 등록해서 스프링 컨테이너에 등록 (IOC : 컨트롤 역전)
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        log.info("security filter chain:");

        http
            .csrf(csrf -> csrf.disable())
                .sessionManagement(session -> session
                        .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                )
                .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                .authenticationProvider(faceAuthenticationProvider)
                .authorizeHttpRequests(res -> res
                        .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll() //6.0 이후로는 포워딩도 허용을 해야 리다이렉트 안생김
                        .requestMatchers( // 나머지 공통 리소스 허용
                                "/",
                                "/register",
                                "/login/**",
                                "/user/**",
                                "/otp/**",
                                "/WEB-INF/views/**"//내부 포워딩용으로 경로 추가
                        ).permitAll()
                        .requestMatchers("/mypage/**").hasAuthority("USER") //권한이 필요한 페이지
                        .anyRequest().authenticated() // 나머지는 인증(로그인)만 되면 허용
                )
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
