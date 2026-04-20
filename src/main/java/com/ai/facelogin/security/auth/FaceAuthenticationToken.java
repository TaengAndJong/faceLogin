package com.ai.facelogin.security.auth;


import com.ai.facelogin.enums.UserRole;
import org.jspecify.annotations.Nullable;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;


public class FaceAuthenticationToken extends AbstractAuthenticationToken {

    private final Object principal;
    private float[] faceVector;
    private final boolean preAuthStatus; //임시인증 상태 분기에 사용

    //인증 전 생성자 (String Id를 받음)
    public FaceAuthenticationToken(final Object principal, final float[] faceVector) {
        super((Collection<? extends GrantedAuthority>) null); //권한 타입 알려줘야함
        this.principal = principal; // 인스턴스 초기화 username userStrId
        this.faceVector = faceVector; // 인스턴스 얼굴이미지 password facevector
        this.preAuthStatus = false; // 직접 초기화
        setAuthenticated(false); // 미인증된 사용자라고 설정 (AbstractAuthenticationToken 내부 메서드)
    }

    //인증 후 provider가 검증을 성공하면 사용자 정보와 권한 전달할 메서드
    public FaceAuthenticationToken(Object principal,
                                   Collection<? extends GrantedAuthority> authorities){

        super(authorities); // 부모에게 권한 목록 전달하여 인증이 있는지 확인하기위함 => 인증 왜 확인?
        this.principal = principal; // userStrId
        this.faceVector = null; // 보안상 인증 후 벡터값 초기화 (토큰탈취되어도 벡터데이터가 없으면 진행불가)
        this.preAuthStatus = false; //직접 초기화
        setAuthenticated(true); // 인증된 사용자라고 설정
    }
    
    //추가인증을 진행하기 위해 임시 권한 할당 전달할 메서드
    public FaceAuthenticationToken(Object principal,
                                   Collection<? extends GrantedAuthority> authorities,
                                   boolean preAuthStatus) { // 인증상태 구분을 위해 파라미터 추가 (오버로딩)
        super(authorities); //
        this.principal = principal; //userStrId
        this.faceVector = null;
        this.preAuthStatus = preAuthStatus; // 임시인증상태
        setAuthenticated(false); // false로 설정해야 시큐리티가 '인증 진행 중'으로 인식
    }

    @Override
    public @Nullable Object getPrincipal() {
        return principal;
    }

    @Override
    public @Nullable float[] getCredentials() {
        return faceVector;
    }

    // 컨트롤러에서 바로 꺼내 쓸수 있게 임시 인증 상태값 반환 getter
    public boolean isPreAuthStatus() {
        return this.preAuthStatus;
    }
}


// 기존 스프링 시큐리트 인증토큰은 username과 passwrod 지만 
// 해당 프로젝트는 password가 얼굴 이미지 벡터 데이터이기 때문에 
// 기존 인증토큰을 상속받아 커스텀한 토큰이 필요