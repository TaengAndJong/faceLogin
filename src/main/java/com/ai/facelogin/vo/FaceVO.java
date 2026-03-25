package com.ai.facelogin.vo;

import lombok.*;

import java.io.Serializable;
import java.time.LocalDateTime;

@ToString
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FaceVO implements Serializable { // Json 을 byte로 직렬화

    private Long faceId; // 기본키로 PK, 자동증가
    private Long userId; // users 테이블에서 Id 참조해 옴 ( FK )

    // 얼굴 인식 벡터 데이터 (pgvector 매핑용)
   // private float[] faceEncoding;

    //시간
    private LocalDateTime createdAt;// timestamp 타입일 경우, 초까지 작성되니까 LocalDataetime
    private LocalDateTime updatedAt;

    private String description;//설명(기타 사항 작성)

    

}
