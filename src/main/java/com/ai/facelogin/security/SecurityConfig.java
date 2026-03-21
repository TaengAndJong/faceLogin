package com.ai.facelogin.security;


import jakarta.servlet.DispatcherType;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Slf4j
@EnableWebSecurity(debug = true) // Spring Security가 URL 매칭을 로그
@RequiredArgsConstructor
@Configuration
public class SecurityConfig {

    @Bean // 빈으로 등록해서 스프링 컨테이너에 등록 (IOC : 컨트롤 역전)
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        log.info("security filter chain:");
        http
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(res -> res
                    .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll() //6.0 이후로는 포워딩도 허용을 해야 리다이렉트 안생김
                    .requestMatchers(
                            "/", "/error",
                            "/login",
                            "/register",
                            "/css/**",
                            "/js/**",
                            "/images/**",
                            "/WEB-INF/views/**"
                    ).permitAll()
                    .anyRequest().authenticated()
            )
            .formLogin(form -> form
                    .loginPage("/login") // 화면 보여주는 주소 (get)
                    .loginProcessingUrl("/login-auth") //얼굴 데이터 보내는 주소 (POST)
                    .usernameParameter("username") //UsernamePasswordAuthenticationFilter가 감시 -> provider를 거쳐 인증성공객체 반환
                    .passwordParameter("faceImage")
                    .defaultSuccessUrl("/mypage") // 성공 시 마이페이지로 이동
                    .permitAll()
            )
            .logout(logout ->
                    logout.logoutUrl("/logout")            // 로그아웃을 요청할 주소 (기본값은 /logout)
                            .logoutSuccessUrl("/login")      // 로그아웃 성공 시 이동할 주소
                            .invalidateHttpSession(true)     // 서버 세션을 무효화 (중요!)
                            .deleteCookies("JSESSIONID")     // 자동 로그인 쿠키 등이 있다면 삭제
                            .permitAll());

        return http.build(); // 시큐리티 컨텍스트에 저장
    }


}
