package com.ai.facelogin.users.mapper;

import com.ai.facelogin.login.dto.UserLoginDto;
import com.ai.facelogin.vo.UserVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface UsersDao {

    //사용자 데이터 추가
    int insertUser(UserVO vo);

    //사용자가 입력한 아이디 존재여부 조회
    int countByUserStrId(String userStrId);
    //사용자가 입력한 이메일 존재여부 조회
    int countByEmail(String email);

    //사용자의 이메일 조회
    String selectUserEmail(String userStrId);

    //faceVector에 담아줄 userId 조회
    Long selectUserId(String email);
    
    //해당 사용자의 회원가입시 디비에 저장된 사용자전체정보 조회
    UserVO selectUserLoginInfo(@Param("userStrId") String userStrId);

    // 이미지 벡터 비교
    Double authenticateFace(@Param("userStrId") String userStrId,
                             @Param("newVector")  float[] newVector);

    //회원탈퇴 : 회원가입 상태 업데이트
    int updateUserStatus(String userStrId);
    
    //회원탈퇴 : 얼굴벡터 데이터 영구삭제
    int deleteUserVectorImage(String userStrId);
}
