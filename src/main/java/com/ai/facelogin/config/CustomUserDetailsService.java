package com.ai.facelogin.config;

import com.ai.facelogin.users.mapper.UsersDao;
import com.ai.facelogin.vo.UserVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;


@Slf4j
@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    //사용자 정보에 접근하기 위해 사용자정보 DAO 불러오기
    private final UsersDao userdao;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        log.info("UserDetailsService--loadUserByUsername : {} ",username);
        String userStrId = username;
        //디비에서 사용자 정보조회
        UserVO user = userdao.selectUserLoginInfo(userStrId);
        if(user == null){
            throw new UsernameNotFoundException("사용자 정보를 찾을 수 없음:{}"+ userStrId);
        }

        //시큐리티가 이해할 수 있는 UserDetails 객체로 변환하여 반환
        UserDetails userDetails = org.springframework.security.core.userdetails.User.builder()
                .username(user.getUserIdStr()) //로그인 시 사용하는 로그인 아이디
                .password("") // JWT 사용하면  비워두기
                .authorities(user.getUserRole()) //접두사가 없어도 "USER"라고 입력하면 자동응로 시큐리티가 바꿔인식
                .build();
        
        //roles() 와 authorities() 구별 필요
        
        log.info("UserDetailsService--userDetails : {} ",userDetails);
        //최종반환 데이터타입은 UserService 
        return userDetails;
    }
}

// 시큐리티가 직접 정보를 찾을 수 없어서 개발자에가 디비에서 사용자 정보를 조회해오라고 시킴
// 시큐리티의 UserDetailsService 인터페이스를 구현해 loadUserByUsername 메서드를 오버로딩하여 
// 결과를 시큐리티에게 알려줌 ( 유저의 모든 정보 == 인증,인가(권한여부)에 필요한 최소한의 정보들)