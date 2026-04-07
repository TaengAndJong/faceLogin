package com.ai.facelogin.security.provider;


import com.ai.facelogin.login.dto.UserLoginDto;
import com.ai.facelogin.login.service.LoginService;
import com.ai.facelogin.security.auth.FaceAuthenticationToken;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.Nullable;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class FaceAuthenticationProvider implements AuthenticationProvider {


    //DB에 저장된 기존회원의 얼굴벡터와 새 벡터가져올 서비스객체
    private final LoginService loginService;

    //인증이 이루어지는 메서드
    @Override
    public @Nullable Authentication authenticate(Authentication authentication) throws AuthenticationException {
        // 컨트롤러에서 받아온 미인증 토큰 (principal, facevector)
        FaceAuthenticationToken receivedToken = (FaceAuthenticationToken) authentication;  

        //principal과 fecevector 각각 변수에 담기
        String userStrId = receivedToken.getPrincipal().toString(); // 다운캐스팅 아니면 그냥 문자열로바꿔도됨 ?
        float[] newVector = receivedToken.getCredentials();
        
        //새로 들어온 데이터와 비교할 기존 데이터 조회
        UserLoginDto userData = loginService.getOriginUserInfo(userStrId);
        log.info("시큐리티 프로바이더 ----- 기존 userData 조회:{}",userData);

        //기존 사용자 정보 조회 검증
        if(userData == null){ // 여기 예외처리 다음과 같이하는 이유 정리하기
            throw new UsernameNotFoundException("존재하지 않는 사용자입니다.");
        }

        // 얼굴 벡터 대조 ( LoginService에 로직 설계 필요)
        boolean isMatched = loginService.compareToVector(userStrId,newVector);

        if(!isMatched){ // 비교한 벡터가 일치하지 않음 , 인증실패
            throw new BadCredentialsException("얼굴 인증에 실패하였습니다.");
        }
        //얼굴비교 검증 성공하면
        //인증된 권한 목록
        List<GrantedAuthority> authorityList
                = Collections.singletonList(new SimpleGrantedAuthority(userData.getUserRole()));
        log.info("프로바이터 권한 목록 :{}",authorityList);

        //인증이 완료된 사용자 정보를 담은 인증토큰 생성
        FaceAuthenticationToken successAuthentication
                = new FaceAuthenticationToken(userStrId,authorityList);
        log.info("프로바이터 인증 완료된 새로운 토큰생성 :{}",successAuthentication);
        //인증이 완료된 인증토큰 반환
        return successAuthentication;
    }

    // FaceAuthenticationToken 관련 메서드만 처리
    @Override
    public boolean supports(Class<?> authentication) {
        return FaceAuthenticationToken.class.isAssignableFrom(authentication);
    }
}

// 시큐리티 인증 필터 중 실제로 인증 데이터를 비교,검증하여
// 실제 인증여부를 판단하는 인터페이스