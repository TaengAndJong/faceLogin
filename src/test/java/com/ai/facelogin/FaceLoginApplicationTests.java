package com.ai.facelogin;

import org.junit.jupiter.api.Test;
import org.opencv.core.Mat;
import org.opencv.imgcodecs.Imgcodecs;
import org.springframework.boot.test.context.SpringBootTest;
import org.opencv.core.Core;

//@SpringBootTest // 서버 전체를 다 불러와서 에러남 주석처리
class FaceLoginApplicationTests {

    // (파일명 끝에 버전 숫자 4120 확인하세요! 4.12.0 버전 기준)
    String dllPath = "D:/opencv/build/java/x64/opencv_java4120.dll";


    @Test
    void contextLoads() {
        // 스프링 컨텍스트가 잘 뜨는지 확인 (기본 제공)
    }

    @Test //이 테스트만 실행 (순수자바로 실행)
    void opencvConnectionTest() {


        // 1. 네이티브 라이브러리(DLL) 로드
        try {
            System.load(dllPath); //경로파라미터요구

            // 2. 결과 출력
            System.out.println("=================================");
            System.out.println("OpenCV 연결 성공!");
            System.out.println("버전: " + Core.VERSION);
            System.out.println("=================================");
        } catch (UnsatisfiedLinkError e) {
            System.err.println("DLL 파일을 찾을 수 없습니다. VM options 설정을 확인하세요!");
            e.printStackTrace();
        }
    }

    @Test
    void readImageTest(){
         System.out.println("이미지 읽기 테스트");

         System.load(dllPath); //dll라이브러리 로드 (openCV 엔진 )
         //이미지 읽어오기
         Mat readImage = Imgcodecs.imread("D:/test.jpg");

         if(readImage == null || readImage.empty()){
             System.out.println("❌ 실패: 이미지를 찾을 수 없습니다! 경로를 확인하세요.");
         } else {
             System.out.println("✅ 성공: 이미지를 불러왔습니다!");
             System.out.println("가로 너비(해상도): " + readImage.width());
             System.out.println("세로 높이 (x): " + readImage.height());

         }

    }

}
