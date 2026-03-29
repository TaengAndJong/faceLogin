package com.ai.facelogin.register.service;

import com.ai.facelogin.common.exception.common.EmailException;
import com.ai.facelogin.common.exception.common.UserInfoException;
import com.ai.facelogin.face.mapper.FaceDao;
import com.ai.facelogin.face.service.FaceService;
import com.ai.facelogin.otp.service.OtpService;
import com.ai.facelogin.register.dto.ReqRegisterDto;

import com.ai.facelogin.users.mapper.UsersDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor // 생성자 주입
public class RegisterServiceImple implements RegisterService {

    private final UsersDao usersDao;
    private final FaceDao faceDao;
    private final OtpService otpService; //service 주입
    private final FaceService faceService;
    
    @Transactional // users 테이블과 facevector 테이블에 순차적으로 각각 insert 해야하기때문에
    @Override
    public void register(ReqRegisterDto dto){ // dto 객체 빈값||null 검증은 컨트롤러에서 @valid가 실행


        log.info("RegisterService-----:{}",dto);
        // 1차 중복검증 마친 후의 2차 재검증

        //아이디 중복체크
        if(usersDao.countByUserIdStr(dto.getUserIdStr())> 0){
            // 아이디 중복예외 던지기
            throw new UserInfoException("중복된 아이디입니다.");

        }
        //이메일 중복체크
        if(usersDao.countByEmail(dto.getEmail())> 0){
            //이메일 중복예외 던지기
            throw new EmailException("중복된 이메일입니다.");
        }
        //이메일 인증코드 검증 확인
        if(!otpService.isVerificationCompleted(dto.getEmail())){
            //이메일 인증 실패 예외던지기
            throw new EmailException("인증되지 않은 이메일입니다.");
        }
        //파일 객체 ( @valid를 통해 빈 값 검증 외에 확장자, 파일사이즈 제한,MIME 타입 검증), 2차 검증
        //발생한 예외는 공통예외처리 핸들러로 전달
        faceService.validateFaceImage(dto.getFaceEncoding());
        //예외가 발생하지 않으면 얼굴이미지 파일 객체 float[] 형태로 변경
        float[] vectorImage =  faceService.getVector(dto.getFaceEncoding());
        log.info("RegisterService vectorImage:{}",vectorImage);


        // dto -> vo로 빌드


        //db에 insert
        
    };





}

/*
* 서비스를 인터페이스로 구현하는 이유
* 유지보수의 편의성, 로직이 바뀌면 구현체만 바꿔주면 됨!
* */