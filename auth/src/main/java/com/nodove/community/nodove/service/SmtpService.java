package com.nodove.community.nodove.service;

import com.nodove.community.nodove.domain.users.UserCaching;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class SmtpService implements SmtpServiceManager{

    private final RedisServiceManager redisService;
    private final JavaMailSender mailSender;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void sendJoinMail(String email) {
        try {
            String rand = UUID.randomUUID().toString().replace("-", "");

            String title = "community.nodove.com 회원 가입 인증 코드 이메일 입니다.";
            String content = "<!DOCTYPE html>\n"
                    + "<html lang='ko'>\n"
                    + "<head>\n"
                    + "    <meta charset='UTF-8'>\n"
                    + "    <title>회원 가입 인증</title>\n"
                    + "</head>\n"
                    + "<body>\n"
                    + "    <div style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>\n"
                    + "        <h2>안녕하세요. community.nodove.com 입니다.</h2>\n"
                    + "        <p>아래의 인증 코드를 입력하여 회원 가입을 완료해주세요.</p>\n"
                    + "        <p style='font-size: 18px; font-weight: bold;'>인증 코드: <span style='color: #007BFF;'>" + rand + "</span></p>\n"
                    + "        <p>또는 아래의 링크를 클릭하여 인증을 완료해주세요:</p>\n"
                    + "        <a href='https://auth.nodove.com/join/email/check?email=" + email + "&code=" + rand + "' "
                    + "           style='display: inline-block; padding: 10px 20px; background-color: #007BFF; color: #fff; text-decoration: none; border-radius: 5px;'>\n"
                    + "            인증 링크</a>\n"
                    + "        <p>감사합니다.<br>community.nodove.com 드림</p>\n"
                    + "    </div>\n"
                    + "</body>\n"
                    + "</html>";
            String encodedRand = passwordEncoder.encode(rand);
            redisService.saveEmailCode(UserCaching.PREFIX_USER_EMAIL + email, encodedRand);
            log.info("Email code saved for email={}", email);
            MailSender(email, title, content);
        } catch (Exception e) {
            log.error("Failed to send join mail for email={}", email, e);
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
    public boolean checkEmailCodeValidation(String email, String rawCode) {
        try {
            String encodedCode = redisService.getEmailCode(UserCaching.PREFIX_USER_EMAIL + email);
            if (encodedCode == null || rawCode == null || rawCode.isEmpty() || encodedCode.isEmpty()) {
                return false;
            }
            return passwordEncoder.matches(rawCode, encodedCode);
        } catch (Exception e) {
            log.error("Failed to check email code validation for email={}", email, e);
            return false;
        }
    }

}
