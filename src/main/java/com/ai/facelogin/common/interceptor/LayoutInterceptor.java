package com.ai.facelogin.common.interceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


@Slf4j
public class LayoutInterceptor implements HandlerInterceptor {

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) throws Exception {

        if (modelAndView != null && modelAndView.hasView()) {
            String viewName = modelAndView.getViewName();

            // 1. 이미 레이아웃이거나, 리다이렉트(redirect:)인 경우는 제외합니다.
            if (!viewName.startsWith("common/") && !viewName.startsWith("redirect:")) {

                // 2. 원래 컨트롤러가 가려고 했던 경로를 'contentPage'에 담습니다.
                // (확장자 .jsp는 include 시점에 붙이거나 여기서 붙여줍니다)
                modelAndView.addObject("contentPage", viewName + ".jsp");

                // 3. 실제 브라우저에 뿌릴 최종 뷰를 '레이아웃'으로 강제 변경합니다.
                modelAndView.setViewName("common/layout");
            }
        }//if end
        log.info("layoutInterceptor postHandle handler:{}",handler);
        log.info("layoutInterceptor postHandle modelAndView:{}",modelAndView);
    }//method end


    //class end
}
