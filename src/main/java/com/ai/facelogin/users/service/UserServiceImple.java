package com.ai.facelogin.users.service;

import com.ai.facelogin.face.mapper.FaceDao;
import com.ai.facelogin.register.dto.ReqRegisterDto;
import com.ai.facelogin.users.mapper.UsersDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@RequiredArgsConstructor // 생성자 주입
public class UserServiceImple implements UserService {

    private final UsersDao usersDao;
    private final FaceDao faceDao;
    
    //사용자아이디 중복체크 ( 참,거짓 반환 )
    @Override
    public boolean duplicateUserIdStr(String userIdStr) {
        log.info("중복 아이디 userIdStr:{}",userIdStr);

        int isduplicatedId = usersDao.countByUserIdStr(userIdStr);
        if(isduplicatedId > 0) {
            return true; // 중복
        }
        return false; // 안 중복
    }

    //이메일 중복체크 ( 참,거짓 반환 )
    @Override
    public boolean duplicateEmail(String email) {
        log.info("중복 email:{}",email);
        return false;
    }
}

/*
* 서비스를 인터페이스로 구현하는 이유
* 유지보수의 편의성, 로직이 바뀌면 구현체만 바꿔주면 됨!
* */