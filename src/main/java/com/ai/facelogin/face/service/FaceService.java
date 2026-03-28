package com.ai.facelogin.face.service;

import org.springframework.web.multipart.MultipartFile;

public interface FaceService {

    //파일객체 검증
    void validateFaceImage(MultipartFile file);
}
