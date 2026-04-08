package com.ai.facelogin.security;


import com.ai.facelogin.config.JwtAuthenticationFilter;
import com.ai.facelogin.security.provider.FaceAuthenticationProvider;
import jakarta.servlet.DispatcherType;
import jakarta.servlet.Filter;
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

@Slf4j
@EnableWebSecurity(debug = true) // Spring Security가 URL 매칭을 로그
@RequiredArgsConstructor
@Configuration
public class SecurityConfig {


    //시큐리티 매니저 빈등록
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authConfig) throws Exception {
        return authConfig.getAuthenticationManager();
    }

    @Bean // 빈으로 등록해서 스프링 컨테이너에 등록 (IOC : 컨트롤 역전)
    public SecurityFilterChain filterChain(HttpSecurity http, FaceAuthenticationProvider faceAuthenticationProvider, JwtAuthenticationFilter jwtAuthenticationFilter) throws Exception {
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
                            "/login/**",
                            "/register",
                            "/user/**",
                            "/otp/**",
                            "/css/**",
                            "/js/**",
                            "/images/**",
                            "/WEB-INF/views/**"
                    ).permitAll()
                    .anyRequest().authenticated()
            ).addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class)
                .authenticationProvider(faceAuthenticationProvider)
            .logout(logout ->
                    logout.logoutUrl("/logout")            // 로그아웃을 요청할 주소 (기본값은 /logout)
                            .logoutSuccessUrl("/login") // 로그아웃 성공 시 이동할 주소
                            .deleteCookies("jwt") // 저장된 jwt 토큰 삭제
                            .invalidateHttpSession(true) // 남아있는 세션 무효화
                            .permitAll());

        return http.build(); // 시큐리티 컨텍스트에 저장
    }


}
