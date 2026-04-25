package com.ai.facelogin.users.service;

import com.ai.facelogin.common.exception.common.EmailException;
import com.ai.facelogin.common.exception.common.UserInfoException;
import com.ai.facelogin.config.CustomUserDetailsService;
import com.ai.facelogin.config.JwtUtil;
import com.ai.facelogin.face.mapper.FaceDao;
import com.ai.facelogin.security.auth.FaceAuthenticationToken;
import com.ai.facelogin.users.mapper.UsersDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor // 생성자 주입
public class UserServiceImple implements UserService {

    private final UsersDao usersDao;
    private final FaceDao faceDao;
    private final JwtUtil jwtUtil;

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

        //최종 권한(ROLE_USER)을 가진 인증 객체 생성 , credential 은 비밀번호인데 이미 얼굴인증은 거쳐서 빈 값으로 설정
        UsernamePasswordAuthenticationToken newAuth =
                new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities()); //ROLE_USER 로 재설정
        log.info("UserServiceImple --- OTP 추가 인증 후 토큰 재생성 : {}",newAuth);
        //스프링 시큐리티 세션에 USER_ROLE 권한 설정해주기
        SecurityContextHolder.getContext().setAuthentication(newAuth);

        //JwtUtil을 사용하여 실제 '문자열' 토큰 생성
        String finalJwtToken = jwtUtil.createToken(userDetails.getUsername());

        log.info("OTP 인증 성공 - 최종 권한 승격 및 JWT 발행 완료: {}, email:{}", finalJwtToken, email);

       return new FaceAuthenticationToken(finalJwtToken, null, true);
    }

}

/*
* 서비스를 인터페이스로 구현하는 이유
* 유지보수의 편의성, 로직이 바뀌면 구현체만 바꿔주면 됨!
* */