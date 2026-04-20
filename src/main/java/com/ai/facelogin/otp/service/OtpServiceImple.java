package com.ai.facelogin.otp.service;

import com.ai.facelogin.common.exception.common.EmailException;
import com.ai.facelogin.enums.RedisPrifix;
import com.ai.facelogin.otp.dto.OtpReqDto;
import com.ai.facelogin.users.mapper.UsersDao;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.SecureRandom;
import java.time.Duration;

@Slf4j
@Service
@Transactional(readOnly = true) // 연쇄 디비작업이 없어서 기본값으로 설정
@RequiredArgsConstructor // 생성자 주입
public class OtpServiceImple implements OtpService {

    //SMTP 사용할 때 필요한 객체
    private final JavaMailSender mailSender;
    //Redis 연동 객체
    private final StringRedisTemplate redis;
    //사용자 정보 조회
    private final UsersDao usersDao;

    //시큐어랜덤 : 자바 기본 라이브러리리서 주입 안되며, 주입하려면 빈으로 등록해줘야함
    private final SecureRandom secureRandom = new SecureRandom(); 

    @Override
    public void sendOtpCodeEmail(String email) { // null, 빈값 검증 생략( DTO에 @Valid로 검증)

        log.info("회원가입 이메일 OTP 번호 전송 :{}", email);
        if(email == null ){ log.error("이메일 값 없음"); return; }
        //난수 생성
        String otpCode= createAndSaveOtp(email, RedisPrifix.REGISTER.getRedisPrifixName());
        log.info("Redis 저장 완료 - 이메일: {}, 코드: {}", email, otpCode);
        //실제발송 로직 공통분리
        sendActualEmail(email,otpCode);
    }

    @Override
    public void sendOtpLoginEmail(String userStrId) {

        log.info("추가인증 이메일OTP 번호 전송 ---:{}", userStrId);
        if(userStrId == null ){log.error("이메일 조회할 사용자 아이디 값 없음"); return;}

        //사용자 이메일 조회해오기
        String email =usersDao.selectUserEmail(userStrId);
        //이메일 한 번 더 검증 (누락 방지 및 사용자정보 조회확인)
        if (email == null || email.isBlank()) {
            log.warn("등록되지 않은 사용자 아이디 접근: {}", userStrId); 
            throw new EmailException("인증번호 발송에 실패했습니다. 정보를 확인해주세요.");
        }

        //난수생성
        String otpCode= createAndSaveOtp(email,RedisPrifix.LOGIN.getRedisPrifixName());
        log.info("Redis 저장 완료 - 이메일: {}, 코드: {}", email, otpCode);
        //실제발송 로직 공통분리
        sendActualEmail(email,otpCode);
    }


    @Override
    public void compareOtpCode(OtpReqDto dto,String redisPrix) {
        log.info("OtpRequestDto -- 서비스 구현체 :{} redisPrix :{} ",dto,redisPrix);
        //Redis 저장한 키로 명칭 동일하게 맞추기
        String key = "OTP:"+ redisPrix + dto.getEmail();
        String saveOtpCode = redis.opsForValue().get(key); //Redis에서 이메일을 키로 저장된 코드 가져오기
        log.info("OTP  saveOtpCode 값 확인: {}, key:{}", saveOtpCode,key);
        //저장된 코드가 없거나 , 인증번호가 동일하지 않을 때
        if (saveOtpCode == null) {
            //만료되었거나 보낸 적이 없는 경우 (경고 수준)
            log.warn("OTP 검증 실패: Redis에 값이 없음. saveOtpCode: {}, key:{}", saveOtpCode,key);
            throw new EmailException("인증번호가 유효하지 않습니다."); //보안 고려 동일한 메시지로 출력(외부에서 파악 못하게)
        }

        if (!saveOtpCode.equals(dto.getOtpCode())) {
            //번호가 틀린 경우 (사용자 실수이므로 warn 또는 info)
            log.warn("OTP 불일치: 입력값={}, 저장값={}", dto.getOtpCode(), saveOtpCode);
            throw new EmailException("인증번호가 유효하지 않습니다.");
        }
        //인증번호 데이터를 삭제하여 재사용 방지
        redis.delete(key);
        //인증 성공 여부를 10분간 기록 (증명서 발급) = 회원가입 완료 전까지 성공여부 살려두기
        redis.opsForValue().set(
                "AUTH_COMPLETE:" + dto.getEmail(),
                "TRUE",
                Duration.ofMinutes(10)
        );

    }

    
    //이메일 인증코드 동일검증 통과 확인 메서드
    @Override
    public boolean isVerificationCompleted(String email) {
        // 가입 시점에 이 키가 있는지 확인
        return "TRUE".equals(redis.opsForValue().get("AUTH_COMPLETE:" + email));
    }

    // OTP 생성 메서드
    private String createAndSaveOtp(String email, String redisPrix) {
        // 6자리 난수 생성
        String otpCode = String.format("%06d", secureRandom.nextInt(1000000));

        // Redis 저장 (키 형식과 만료 시간 관리)
        //Redis 에 서버가 생성한 인증코드 임시 저장 ,키명은 redis에서 조회할 때돋 동일하게 사용
        String redisKey = "OTP:" + redisPrix + email;
        redis.opsForValue().set(redisKey, otpCode, Duration.ofMinutes(3));

        log.info("OTP 생성 및 Redis 저장 완료: {} -> {}", email, otpCode);
        return otpCode; //otpCode 반환
    }

    // 실제 이메일전송메서드
    private void sendActualEmail(String email, String otpCode) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(email);
            message.setSubject("[서비스명] 인증번호 안내");
            message.setText("인증번호는 [" + otpCode + "] 입니다.\n3분 이내에 입력해주세요.");
            mailSender.send(message);
        } catch (Exception e) {
            log.error("메일 발송 실패: {}", e.getMessage());
            // 기존에 만든 EmailException 예외 던지기
            throw new EmailException("인증 이메일 발송에 실패했습니다.");
        }
    }

}

/*
*
* 서비스를 인터페이스로 구현하는 이유
* 유지보수의 편의성, 로직이 바뀌면 구현체만 바꿔주면 됨!
*
* */