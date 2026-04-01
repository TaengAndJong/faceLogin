package com.ai.facelogin.users.mapper;

import com.ai.facelogin.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UsersDao {

    //사용자 데이터 추가
    int insertUser(UserVO vo);

    //사용자가 입력한 아이디 존재여부 조회
    int countByUserIdStr(String userIdStr);
    //사용자가 입력한 이메일 존재여부 조회
    int countByEmail(String email);

    //faceVector에 담아줄 userId 조회
    Long selectUserId(String email);
}
