package com.ai.facelogin.common.exception;

import com.ai.facelogin.common.exception.common.DuplicationExcep;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ui.Model;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {


    //기본검증 실패 시 예외처리 (컨트롤러 진입 직전 발생)
    @ExceptionHandler(value = MethodArgumentNotValidException.class)
    public String validException(MethodArgumentNotValidException ex, HttpServletRequest request, Model model){
        log.info("공통예외 - @valide 기본검증실패 예외처리 핸들러");
        
        // 에러 결과 메시지 가져오기
        String exMsg = ex.getBindingResult().getAllErrors().get(0).getDefaultMessage();
        //JSP 에서 사용할 수 있게 Model 에 담기
        model.addAttribute("exMsg", exMsg);
        //(선택)  사용자가 입력했던 데이터 다시 반환할 경우, 모델에 같이 담기
        model.addAttribute("dto", ex.getBindingResult().getTarget());
        log.info("Model ---- 예외처리 결과 반환 모델: {}",model);

        //Referer ( Http header )
        String referer = request.getHeader("Referer");
        log.info("referer ---- httpHeader로 사용자가 요청을 보낸 이전 페이지 URL : {}",model);
        if (referer != null) {
            String viewPath = resultViewPathFromReferer(referer);
            return viewPath;
        }

        return "error/default";
    }

    //비즈니스 중복 검증 예외 (비즈니스로직에서 DB 데이터 충돌 발생)
    @ExceptionHandler(value = DuplicationExcep.class)
    public String validDuplication(DuplicationExcep ex, HttpServletRequest request,Model model){
        log.info("공통예외 - @valide 중복실패 예외처리 핸들러");
        //작성해 둔 중복커스텀 예외객체를 통해 데이터 받기 ( 예외코드나 메시지 등)
        log.info("errorMessage :{},errorCode:{}",ex.getMessage(),ex.getErrCode());
        // JSP 반환을 위해 Model에 담기
        model.addAttribute("exMsg", ex.getMessage());
        model.addAttribute("exCode", ex.getErrCode());

        //Referer ( Http header )
        String referer = request.getHeader("Referer");
        log.info("referer ---- httpHeader로 사용자가 요청을 보낸 이전 페이지 URL : {}",model);
        if (referer != null) {
            String viewPath = resultViewPathFromReferer(referer);
            return viewPath;
        }

        return "error/default";
    }


    private String resultViewPathFromReferer(String referer) {

        String viewPath = referer.substring(referer.indexOf("/", 8) + 1);
        log.info("가공된 ViewPath :{}",viewPath);
        return viewPath;
    }



}


/*
* 공통예외 처리 핸들러 
* try-catch구문을 자주쓰면 코드가 지저분해지는 것을 방지하고 
* 공통으로 예외를 모아서 처리하기위해 구현하는 클래스로 
* 스프링의 @RestControllerAdvice를 사용
*
*
*
*
*
* */