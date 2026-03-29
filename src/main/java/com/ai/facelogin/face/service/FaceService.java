package com.ai.facelogin.face.service;

import org.springframework.web.multipart.MultipartFile;


public interface FaceService {

    //파일객체 검증
    void validateFaceImage(MultipartFile file);
    
    //File 객체 이미지를  허깅페이스 모델을 통해 float[] (실수 배열)인 벡터로 변환하여 반환받는 로직 수행 메서드
    float[] getVector(MultipartFile file);
    
}
