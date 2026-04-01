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
    public float[] getFileToVector(MultipartFile file) {     //MultipartFile를 그대로 전달
        log.info("faceServiceImple.getVector file 1) 파일객체 파라미터 :{}",file);
        // 허깅페이스에서 넘어온 데이터에서 순순 vector 데이터만 뽑아서 반환해 줘야 함
       
        return huggingFaceClient.getVector(file); // 파이썬 서버에서 파일객체를 벡터[숫자배열]로 변환해서 데이터 반환
    }


}

