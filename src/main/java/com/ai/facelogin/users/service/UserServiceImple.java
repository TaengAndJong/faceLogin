package com.ai.facelogin.users.service;

import com.ai.facelogin.common.exception.common.EmailException;
import com.ai.facelogin.common.exception.common.UserInfoException;
import com.ai.facelogin.config.CustomUserDetailsService;
import com.ai.facelogin.face.mapper.FaceDao;
import com.ai.facelogin.security.auth.FaceAuthenticationToken;
import com.ai.facelogin.users.mapper.UsersDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor // 생성자 주입
public class UserServiceImple implements UserService {

    private final UsersDao usersDao;
    private final FaceDao faceDao;

    CustomUserDetailsService userDetailsService;

    //사용자아이디 중복체크 ( 참,거짓 반환 )
    @Override
    public void duplicateUserStrId(String userStrId) {
        log.info("중복 아이디 userStrId:{}",userStrId);

        int isduplicatedId = usersDao.countByUserStrId(userStrId);
        if(isduplicatedId > 0) { //아이디 중복
             //글로벌 예외 핸들러로 던지기
            throw new UserInfoException("사용 중인 아이디입니다.");
        }

    }

    //이메일 중복체크 ( 참,거짓 반환 )
    @Override
    public void duplicateEmail(String email) {
        log.info("중복 email:{}",email);
        int isduplicatedEmail = usersDao.countByEmail(email);
        if(isduplicatedEmail > 0) { // 이메일 중복
            //글로벌 예외 핸들러로 던지기
            throw new EmailException("사용 중인 이메일입니다.");
        }
    }

    //권한 변경 및 JWT 토큰 발급
    @Override
    public FaceAuthenticationToken changeAuthorityAndJwtToken(String email) {

        // 1. DB에서 유저 정보 로드 (UserDetailsService 활용)
        // JwtUtil에 이미 주입된 userDetailsService를 사용하거나 직접 조회

        UserDetails userDetails = userDetailsService.loadUserByUsername(email);

        return null;
    }
}

/*
* 서비스를 인터페이스로 구현하는 이유
* 유지보수의 편의성, 로직이 바뀌면 구현체만 바꿔주면 됨!
* */