package com.ai.facelogin.config;


import com.ai.facelogin.common.interceptor.LayoutInterceptor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Slf4j
@Configuration
public class WebConfig implements WebMvcConfigurer {

    //



    //layoutInterceptor 설정
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        log.info("webconfig ---- addInterceptors");
        registry.addInterceptor(new LayoutInterceptor())
                .addPathPatterns("/**") // 모든 경로에 적용
                .excludePathPatterns("/css/**", "/js/**", "/images/**"); // 정적 자원은 제외
    }

}
