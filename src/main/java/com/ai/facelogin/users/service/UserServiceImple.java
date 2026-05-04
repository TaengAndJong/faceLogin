package com.ai.facelogin.users.service;

import com.ai.facelogin.common.exception.common.EmailException;
import com.ai.facelogin.common.exception.common.UserInfoException;
import com.ai.facelogin.common.exception.common.WithdrawalException;
import com.ai.facelogin.config.CustomUserDetailsService;
import com.ai.facelogin.config.JwtUtil;
import com.ai.facelogin.face.mapper.FaceDao;
import com.ai.facelogin.otp.dto.OtpReqDto;
import com.ai.facelogin.security.auth.FaceAuthenticationToken;
import com.ai.facelogin.users.mapper.UsersDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor // 생성자 주입
public class UserServiceImple implements UserService {

    private final UsersDao usersDao;
    private final JwtUtil jwtUtil;

    private final UserDetailsService customUserDetailsService;

    //사용자아이디 중복체크 ( 참,거짓 반환 )
    @Override
    public void duplicateUserStrId(String userStrId) {
        log.info("중복 아이디 userStrId:{}",userStrId);

        int isduplicatedId = usersDao.countByUserStrId(userStrId);
        if(isduplicatedId > 0) { //아이디 중복
             //글로벌 예외 핸들러로 던지기
            throw new UserInfoException("이미 사용 중이거나 탈퇴 처리가 완료된 아이디입니다. 다른 아이디를 사용해 주세요.");
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
    public FaceAuthenticationToken changeAuthorityAndJwtToken(OtpReqDto dto) {

        //0.email 파라미터로 userStrId 조회해오기
        String userStrId =dto.getUserStrId();
        String email = dto.getEmail();
        log.info("권한 변경 및 토큰 재발급  userStrId:{}, email:  {}", userStrId, email);

        // 1. DB에서 유저 정보 로드 (UserDetailsService 활용)
        // JwtUtil에 이미 주입된 userDetailsService를 사용하거나 직접 조회
        UserDetails userDetails = customUserDetailsService.loadUserByUsername(userStrId);

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

    @Transactional
    @Override
    public void withdrawnUser(String userStrId) {
        
        //파라밑터 NPE 방어 코드
        if (userStrId == null || userStrId.isBlank()) {
            throw new WithdrawalException("잘못된 접근입니다. 아이디가 없습니다.");
        }

        int  userWithdrawalStatus =usersDao.updateUserStatus(userStrId);
        //사용자  탈퇴 처리 실패 예외
        if( userWithdrawalStatus == 0) {
            log.error("탈퇴 업데이트 실패 - 존재하지 않거나 이미 탈퇴된 ID: {}", userStrId);
            throw new WithdrawalException("사용자 회원탈퇴 실패 [ 존재하지 않거나 이미 탈퇴된 계정] ");
        }
        //사용자 탈퇴 성공 후 사용자의 벡터 이미지 삭제
        usersDao.deleteUserVectorImage(userStrId);
        log.info("회원 탈퇴 완료 및 벡터 이미지 삭제: {}", userStrId);
    }

}

/*
* 서비스를 인터페이스로 구현하는 이유
* 유지보수의 편의성, 로직이 바뀌면 구현체만 바꿔주면 됨!
* */