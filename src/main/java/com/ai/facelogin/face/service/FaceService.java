package com.ai.facelogin.face.service;

import org.springframework.web.multipart.MultipartFile;


public interface FaceService {

    //파일객체 검증
    void validateFaceImage(MultipartFile file);

    //허깅페이스 클라이언트로 파일객체전달 및 벡터변환 이미지 데이터 반환 받아오는 메서드
    float[] getFileToVector(MultipartFile file);
    
}
