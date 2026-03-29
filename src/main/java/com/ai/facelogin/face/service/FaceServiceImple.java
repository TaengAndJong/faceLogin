package com.ai.facelogin.face.service;


import com.ai.facelogin.common.exception.common.FileException;
import com.ai.facelogin.face.mapper.FaceDao;
import com.ai.facelogin.hugging.HuggingFaceClient;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Slf4j
@Service
@RequiredArgsConstructor
public class FaceServiceImple implements FaceService {

    //허깅페이스 객체 호출
    private final HuggingFaceClient huggingFaceClient;
    //faceDao
    private final FaceDao dao;

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


    @Override
    public float[] getVector(MultipartFile file) {

        log.info("faceServiceImple.getVector file 1) :{}",file);
        //MultipartFile를 bygte로 변환
        try {
            byte[] fileBytes = file.getBytes();
            log.info("faceServiceImple fileBytes 2) :{}",fileBytes);
            //허깅페이스 통신 시도 ( 이미지 바이너리 파일  -> 벡터 )
           return huggingFaceClient.getVector(fileBytes); //에러 나면 전역 핸들러가 처리
        } catch (IOException e) {
            log.error("이미지 바이트 변환 중 에러 발생: {}", e.getMessage());
            throw new RuntimeException("이미지 파일 읽기 실패"); // 커스텀 예외 상속된 예외가 Runtime예외라? 이렇게 ?
        }

    }


}

