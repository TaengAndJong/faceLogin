package com.ai.facelogin.common.exception.common;



public class FileException extends RuntimeException {

    //기본 생성자
    public FileException() {
        super();
    }

    //메시지 받을 생성자
    public FileException(String message) {
        super(message);
    }

}
