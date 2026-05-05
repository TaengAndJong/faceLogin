package com.ai.facelogin.config;

import com.ai.facelogin.users.mapper.UsersDao;
import com.ai.facelogin.vo.UserVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.User;
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
    public UserDetails loadUserByUsername(String userStrId) throws UsernameNotFoundException {
        log.info("UserDetailsService--loadUserByUsername : {} ",userStrId);

        //디비에서 사용자 정보조회
        UserVO user = userdao.selectUserLoginInfo(userStrId);
        if(user == null){
            throw new UsernameNotFoundException("사용자 정보를 찾을 수 없음:{}"+ userStrId);
        }


        //시큐리티가 이해할 수 있는 UserDetails 객체로 변환하여 반환 ( 직접 커스텀한 UserDetails 가 있다면 객체 생성)
        UserDetails customUserDetails = new CustomUserDetails(user); // 조회해온 정보를 생성자에 주입


        log.info("UserDetailsService--userDetails : {} ",customUserDetails);
        //최종반환 데이터타입은 UserService 
        return customUserDetails;
    }
}

// 시큐리티가 직접 정보를 찾을 수 없어서 개발자에가 디비에서 사용자 정보를 조회해오라고 시킴
// 시큐리티의 UserDetailsService 인터페이스를 구현해 loadUserByUsername 메서드를 오버로딩하여 
// 결과를 시큐리티에게 알려줌 ( 유저의 모든 정보 == 인증,인가(권한여부)에 필요한 최소한의 정보들)