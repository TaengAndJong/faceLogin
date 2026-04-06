package com.ai.facelogin.security.auth;


import org.jspecify.annotations.Nullable;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;


public class FaceAuthenticationToken extends AbstractAuthenticationToken {

    private final Object principal;
    private float[] faceVector;

    //인증 전 생성자 (String Id를 받음)
    public FaceAuthenticationToken(final Object principal, final float[] faceVector) {
        super((Collection<? extends GrantedAuthority>) null); //권한 타입 알려줘야함
        this.principal = principal; // 인스턴스 초기화 username userId
        this.faceVector = faceVector; // 인스턴스 얼굴이미지 password facevector
        setAuthenticated(false); // 미인증된 사용자라고 설정 (AbstractAuthenticationToken 내부 메서드)
    }

    //인증 후 provider가 검증을 성공하면 사용자 정보와 권한 전달할 메서드
    public FaceAuthenticationToken(Object principal,
                                   Collection<? extends GrantedAuthority> authorities){

        super(authorities); // 부모에게 권한 목록 전달하여 인증이 있는지 확인하기위함
        this.principal = principal; // userId
        this.faceVector = null; // 보안상 인증 후 벡터값 초기화 (토큰탈취되어도 벡터데이터가 없으면 진행불가)
        setAuthenticated(true); // 인증된 사용자라고 설정
    }



    @Override
    public @Nullable Object getPrincipal() {
        return principal;
    }

    @Override
    public @Nullable float[] getCredentials() {
        return faceVector;
    }


}


// 기존 스프링 시큐리트 인증토큰은 username과 passwrod 지만 
// 해당 프로젝트는 password가 얼굴 이미지 벡터 데이터이기 때문에 
// 기존 인증토큰을 상속받아 커스텀한 토큰이 필요