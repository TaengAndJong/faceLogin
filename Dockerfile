#운영서버에서 사용할 때 작성필요 개발환경에서 필요 x
# Dockerfile의 목적 : 스프링부트의 JAR 파일을 어떻게 실행할지


#프론트 ,백엔드 빌드는 서버사양이 넉넉할때 사용
# 로컬 빌드 시, 로컬에서 서버로 전송항 jar 만 복사

# 2단계: 실행 이미지
# 빌드 단계 없이 실행 환경(JRE)만 바로 사용.
FROM eclipse-temurin:17-jre
#컨테이너 내부에서 작업할 폴더로  다른 명칭도 사용가능
WORKDIR /java-app

# gradle 일 경우 서버의 결과물이 빌드되는 경로
COPY build/libs/*.jar app.jar

#도커 컴포즈에서 사용하는 컨테이너 포트로 컨테이너 내부에서만 사용하는 포트(외부접근 불가)
EXPOSE 8081
#컨테이너 실행 시 반드시 실행되는 명령
ENTRYPOINT ["java", "-jar", "java-app.jar"]


