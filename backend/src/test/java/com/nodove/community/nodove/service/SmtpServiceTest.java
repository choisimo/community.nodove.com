package com.nodove.community.nodove.service;

import com.nodove.community.nodove.configuration.security.EncryptionUtils;
import com.nodove.community.nodove.domain.users.UserCaching;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class SmtpServiceTest {

    @Autowired
    private RedisServiceManager redisService;
    @Autowired
    private JavaMailSender mailSender;
    @Autowired
    private EncryptionUtils encryptionUtils;

    @Test
    void sendJoinMail() {
        String email = "nodove@naver.com";
        try {
            String rand = UUID.randomUUID().toString().replace("-", "");

            String title = "community.nodove.com 회원 가입 인증 코드 이메일 입니다.";
            String content = "안녕하세요. community.nodove.com 입니다.\n"
                    + "아래의 인증 코드를 입력하여 회원 가입을 완료해주세요.\n"
                    + "인증 코드 : " + rand + "\n" +
                    "또는 아래의 링크를 클릭하여 인증을 완료해주세요.\n"
                    + "링크 : https://auth.nodove.com/join/email/check?email=" + email + "&code=" + encryptionUtils.encrypt(rand) + "\n";

            this.redisService.saveEmailCode(UserCaching.PREFIX_USER_EMAIL + email, encryptionUtils.encrypt(rand));
            this.mailSender(email, title, content);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    void checkJoinEmailCode() {
    }

    @Test
    void mailSender(String email, String title, String content) {
        try {
            MimeMessageHelper message = new MimeMessageHelper(mailSender.createMimeMessage(), true, "UTF-8");
            message.setTo(email);
            message.setSubject(title);
            message.setText(content, true);
            message.setFrom("no-reply@nodove.com");
            mailSender.send(message.getMimeMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}