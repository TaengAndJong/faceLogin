package com.ai.facelogin.security.handler;

import com.ai.facelogin.common.ApiResponse;
import com.ai.facelogin.common.ErrorResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.Nullable;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.stereotype.Component;
import tools.jackson.databind.ObjectMapper;

import java.io.IOException;

@Slf4j
@Component //스프링 빈 등록
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {


    private final ObjectMapper objectMapper;

    // 생성자로 멤버필드 초기화
    public CustomLogoutSuccessHandler(ObjectMapper objectMapper) {
        this.objectMapper = objectMapper;
    }

    @Override
    public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, @Nullable Authentication authentication) throws IOException, ServletException {

        try {

            //로그아웃 후 성공 결과 반환 API
            ApiResponse<Void> logoutResponse = ApiResponse.success("로그아웃 성공", null);

            //http 응답 설정
            response.setStatus(HttpServletResponse.SC_OK);
            response.setContentType("application/json;charset=UTF-8");

            //objectMapper로 객체를 JSON 문자열로 변환 후 출력
            String result = objectMapper.writeValueAsString(logoutResponse);
            response.getWriter().write(result);
        }catch (Exception e) {
            // 로그아웃 실패 시 방어코드 및 반환 로그메시지
            log.error("로그아웃 응답 생성 중 심각한 오류 발생: ", e);

            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.setContentType("application/json;charset=UTF-8");

            ApiResponse<String> logoutError = ApiResponse.fail(e.getMessage(), "/login");

            String result = objectMapper.writeValueAsString(logoutError);
            response.getWriter().write(result);
        }
        //메서드 끝
    }
    //클래스 끝
}
