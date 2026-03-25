package com.ai.facelogin.common.exception;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.ConstraintViolationException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {


    //기본검증 실패 시 예외처리 (객체 파라미터(DTO) 검증용, 컨트롤러 진입 직전 발생)
    @ExceptionHandler(value = MethodArgumentNotValidException.class)
    @ResponseBody // 데이터 반환 선언
    public ResponseEntity<String> validException(MethodArgumentNotValidException ex, HttpServletRequest request){
        log.info("공통예외 - @valide DTO 기본검증실패 예외처리 핸들러");
        // BindingResult로 에러 결과 메시지 가져오기
        String exMsg = ex.getBindingResult().getAllErrors().get(0).getDefaultMessage();
        
        //axios로 상태코드와 응답메시지 반환
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(exMsg);

    }



    //@Validated 검증 실패 시 예외처리 핸들러 ( 단일파라미터용 )
    @ExceptionHandler(ConstraintViolationException.class)
    @ResponseBody //데이터 반환용 어노테이션 선언
    public ResponseEntity<String> failedValidated(ConstraintViolationException ex) {
        log.info("공통예외 - @Validated 예외처리 핸들러");
        // 에러 결과 메시지 가져오기
        String exMsg =ex.getConstraintViolations().iterator().next().getMessage();
        //axios로 상태코드와 응답메시지 반환
       return  ResponseEntity.status(HttpStatus.BAD_REQUEST).body(exMsg);
    }



    //예외 발생시 "/" 루트 경로로 우회 시키는 메서드
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