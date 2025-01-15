package com.nodove.community.nodove.service;

import com.nodove.community.nodove.configuration.security.EncryptionUtils;
import com.nodove.community.nodove.domain.users.UserCaching;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class SmtpService implements SmtpServiceManager{

    private final RedisServiceManager redisService;
    private final JavaMailSender mailSender;
    private final EncryptionUtils encryptionUtils;

    @Override
    public void sendJoinMail(String email) {
        try {
            String rand = UUID.randomUUID().toString().replace("-", "");

            String title = "community.nodove.com 회원 가입 인증 코드 이메일 입니다.";
            String content = "안녕하세요. community.nodove.com 입니다.\n"
                    + "아래의 인증 코드를 입력하여 회원 가입을 완료해주세요.\n"
                    + "인증 코드 : " + rand + "\n" +
                    "또는 아래의 링크를 클릭하여 인증을 완료해주세요.\n"
                    + "링크 : https://auth.nodove.com/join/email/check?email=" + email + "&code=" + encryptionUtils.encrypt(rand) + "\n";
            redisService.saveEmailCode(UserCaching.PREFIX_USER_EMAIL + email, rand);
            log.info("Email code saved for email={}", email);
            MailSender(email, title, content);
        } catch (Exception e) {
            log.error("Failed to send join mail for email={}", email, e);
        }
    }

    @Override
    public ResponseEntity<?> resendJoinMail(String email) {
        try {
            String rand = UUID.randomUUID().toString().replace("-", "");

            String title = "community.nodove.com 회원 가입 인증 코드 이메일 입니다.";
            String content = "안녕하세요. community.nodove.com 입니다.\n"
                    + "아래의 인증 코드를 입력하여 회원 가입을 완료해주세요.\n"
                    + "인증 코드 : " + rand + "\n" +
                    "또는 아래의 링크를 클릭하여 인증을 완료해주세요.\n"
                    + "링크 : https://auth.nodove.com/join/email/check?email=" + email + "&code=" + encryptionUtils.encrypt(rand) + "\n";
            redisService.saveEmailCode(UserCaching.PREFIX_USER_EMAIL + email, rand);
            log.info("Email code saved for email={}", email);
            MailSender(email, title, content);
            return ResponseEntity.ok().build();
        } catch (Exception e) {
            log.error("Failed to resend join mail for email={}", email, e);
            return ResponseEntity.badRequest().build();
        }
    }

    @Override
    public boolean checkJoinEmailCode(String email, String code) {
        try {
            String savedCode = redisService.getEmailCode(UserCaching.PREFIX_USER_EMAIL + email);
            if (savedCode == null) {
                return false;
            }
            return (savedCode).equals(code);
        } catch (Exception e) {
            log.error("Failed to check join email code for email={}", email, e);
            return false;
        }
    }


    @Override
    public void MailSender(String email, String title, String content) {
        try {
            MimeMessageHelper message = new MimeMessageHelper(mailSender.createMimeMessage(), true, "UTF-8");
            message.setTo(email);
            message.setSubject(title);
            message.setText(content, true);
            mailSender.send(message.getMimeMessage());
        } catch (Exception e) {
            log.error("Failed to send mail for email={}", email, e);
        }
    }

    @Override
    public boolean checkEmailCodeValidation(String email, String encryptedCode) {
        try {
            String savedCode = redisService.getEmailCode(UserCaching.PREFIX_USER_EMAIL + email);
            if (savedCode == null) {
                return false;
            }

            return savedCode.equals(encryptionUtils.decrypt(encryptedCode));
        } catch (Exception e) {
            log.error("Failed to check email code validation for email={}", email, e);
            return false;
        }
    }

}
