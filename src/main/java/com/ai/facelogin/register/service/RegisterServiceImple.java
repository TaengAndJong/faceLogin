package com.ai.facelogin.register.service;

import com.ai.facelogin.face.mapper.FaceDao;
import com.ai.facelogin.register.dto.ReqRegisterDto;

import com.ai.facelogin.users.mapper.UsersDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor // 생성자 주입
public class RegisterServiceImple implements RegisterService {

    private final UsersDao usersDao;
    private final FaceDao faceDao;
    
    @Transactional // users 테이블과 facevector 테이블에 순차적으로 각각 insert 해야하기때문에
    @Override
    public void register(ReqRegisterDto dto){ // dto 객체 빈값||null 검증은 컨트롤러에서 @valid가 실행

        // 1차 중복검증 마친 후의 2차 재검증
        //아이디 중복체크
        //이메일 중복체크
        //이메일 실제 사용 인증코드 ()
        //얼굴 데이터 float[] 로 변경
        // dto -> vo로 빌드
        //db에 insert
        
    };





}

/*
* 서비스를 인터페이스로 구현하는 이유
* 유지보수의 편의성, 로직이 바뀌면 구현체만 바꿔주면 됨!
* */