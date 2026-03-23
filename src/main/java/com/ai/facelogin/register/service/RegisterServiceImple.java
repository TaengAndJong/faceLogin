package com.ai.facelogin.register.service;

import com.ai.facelogin.register.dto.ReqRegisterDto;
import com.ai.facelogin.register.mapper.RegisterDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor // 생성자 주입
public class RegisterServiceImple implements RegisterService {

    public final RegisterDao registerDao;

    @Override
    public void register(ReqRegisterDto dto){ // dto 객체 빈값||null 검증은 컨트롤러에서 @valid가 실행

        // 아이디 중복검증
        // 이메일 중복검증
        // 얼굴 이미지 검증?

        //dto 를 vo로 변경

        //db에 insert
        
    };

}

/*
* 서비스를 인터페이스로 구현하는 이유
* 유지보수의 편의성, 로직이 바뀌면 구현체만 바꿔주면 됨!
* */