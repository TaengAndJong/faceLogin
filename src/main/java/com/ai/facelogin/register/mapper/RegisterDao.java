package com.ai.facelogin.register.mapper;

import com.ai.facelogin.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface RegisterDao {

    //회원가입 데이터 추가
    int insert(UserVO record);

}
