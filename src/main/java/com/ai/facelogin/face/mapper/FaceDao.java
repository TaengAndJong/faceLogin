package com.ai.facelogin.face.mapper;

import com.ai.facelogin.vo.FaceVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FaceDao {

    //사용자 얼굴이미지 데이터 추가
    int insertFace(FaceVO vo);


}
