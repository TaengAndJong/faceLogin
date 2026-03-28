package com.ai.facelogin.face.service;


import com.ai.facelogin.common.exception.common.FileException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@Service
@RequiredArgsConstructor
public class FaceServiceImple implements FaceService {

    @Override
    public void validateFaceImage(MultipartFile file) {
        // 1. MIME 타입 체크 (가장 확실한 방법)
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            throw new FileException("이미지 파일만 업로드 가능합니다.");
        }

        // 2. 파일 크기 체크 (예: 5MB 제한)
        long maxSize = 5 * 1024 * 1024; // 5MB
        if (file.getSize() > maxSize) {
            throw new FileException("파일 크기는 5MB를 초과할 수 없습니다.");
        }

        // 3. 확장자 체크
        String fileName = file.getOriginalFilename();
        if (fileName == null || !fileName.toLowerCase().matches(".*\\.(jpg|jpeg|png)$")) {
            throw new FileException("지원하지 않는 파일 형식입니다. (jpg, png만 가능)");
        }
    }





}

