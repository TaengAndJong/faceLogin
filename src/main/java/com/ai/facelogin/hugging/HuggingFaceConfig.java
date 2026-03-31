package com.ai.facelogin.hugging;

import lombok.Getter;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
@ConfigurationProperties(prefix = "huggingface") // yml의 huggingface 접두어를 찾습니다.
@Getter
@Setter
public class HuggingFaceConfig {

    @Value("${huggingface.api.url}") //스프링 옵션 파일에 선언된 값들
    private String apiUrl;
    @Value("${huggingface.token}")
    private String token;

    
    // 스프링 옵션에 작성한 값을 자바 객체로 매핑
    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }

}


/*
* API 키, URL 설정 관리
* */