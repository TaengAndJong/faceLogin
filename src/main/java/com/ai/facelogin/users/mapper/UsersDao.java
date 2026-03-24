package com.ai.facelogin.users.mapper;

import com.ai.facelogin.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UsersDao {

    //사용자 데이터 추가
    int insertUser(UserVO vo);

    //사용자가 입력한 아이디 중복 체크
    int duplicateUser(String useIdStr);
}
