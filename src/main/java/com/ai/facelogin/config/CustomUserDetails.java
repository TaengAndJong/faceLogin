package com.ai.facelogin.config;

import com.ai.facelogin.vo.UserVO;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.Nullable;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.time.LocalDateTime;
import java.util.Collection;
import java.util.List;

@ToString
@Slf4j
public class CustomUserDetails implements UserDetails {

    private final UserVO user;

    public CustomUserDetails(UserVO user) {
        this.user = user; // 직접 생성자 주입, user 객체 초기화
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        log.info("CustomUserDetials:{}",user.getUserRole());
        return List.of(new SimpleGrantedAuthority(user.getUserRole()));

    }

    @Override
    public @Nullable String getPassword() { //Nullable null 가능 -> 비밀번호 대신 얼굴벡터 사용중
        //벡터이미지를 비밀번호로 사용중이기 때문에 해당 메서드는 정의 x
        return "";
    }

    //아이디 ( 시큐리티 표준 기본 정의 메서드)
    @Override
    public String getUsername() {
        return user.getUserStrId();
    }
    
    //이하 추가 항목들
    
    //userId (테이블 자동생성)
    public Long getUserId() {
        return user.getUserId();
    }

    //jsp 에서 사용할 userStrId
    public String getUserStrId() {
        return user.getUserStrId();
    }

    //이메일
    public String getEmail() {
        return user.getEmail();
    }

    //jsp용 role
    public String getUserRole() {
        if(user.getUserRole() == null){ return "일반회원";}
        String result = "USER".equals(user.getUserRole()) ? "일반회원":"관리자";
        return result; // "USER" 또는 "ROLE_USER" 반환
    }

    // 가입 상태
    public String getStatus(){
        return user.getStatus();
    }

    // 개인정보 동의 상태
    public Boolean getAgreeStatus() {
        return user.getAgreeState();
    }

    //개인정보 동의 한글 반환
    public String getAgreeStatusString(){

        if(user.getAgreeState() == null ) return "미동의"; // null 예외 방지
        String result = user.getAgreeState()? "동의":"미동의";

        return result;
    }

    //아이디 생성일 (가입 시간)
    public LocalDateTime getCreatedAt(){
        return user.getCreatedAt();
    }
    //정보수정일 또는 탈퇴일
    public LocalDateTime getUpdatedAt(){
        return user.getUpdatedAt();
    }


}
