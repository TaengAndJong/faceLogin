package com.ai.facelogin.otp.service;

import com.ai.facelogin.common.exception.register.EmailException;
import com.ai.facelogin.face.mapper.FaceDao;
import com.ai.facelogin.users.mapper.UsersDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.time.Duration;

@Slf4j
@Service
@RequiredArgsConstructor // 생성자 주입
public class OtpServiceImple implements OtpService {

    //SMTP 사용할 때 필요한 객체
    private final JavaMailSender mailSender;
    //Redis 연동 객체
    private final StringRedisTemplate redis;

    @Override
    public void sendOtpCodeEmail(String email) { // null, 빈값 검증 생략( DTO에 @Valid로 검증)
        //이메일로 전송할 6자리 난수 생성
        String otpCode = String.valueOf((int)(Math.random() * 899999) + 100000);
        //Redis 에 서버가 생성한 인증코드 임시 저장
        redis.opsForValue().set(
                "OTP:" + email,
                otpCode,
                Duration.ofMinutes(3) // 3분 뒤 자동 삭제 (TTL 설정)
        );
        log.info("Redis 저장 완료 - 이메일: {}, 코드: {}", email, otpCode);

        //메일로 발송
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("[서비스명] 회원가입 인증번호입니다.");
            message.setText("인증번호는 [" + otpCode + "] 입니다.\n3분 이내에 입력해주세요.");

            mailSender.send(message);
            log.info("메일 발송 성공 - To: {}", email);
        } catch (Exception e) {
            log.error("메일 발송 실패: {}", e.getMessage());
            // 기존에 만드신 EmailException을 여기서 던집니다.
            throw new EmailException("인증 이메일 발송에 실패했습니다.");
        }

    }
}

/*
* 서비스를 인터페이스로 구현하는 이유
* 유지보수의 편의성, 로직이 바뀌면 구현체만 바꿔주면 됨!
* */