package com.nodove.community.nodove.service;

import jakarta.transaction.Transactional;
import org.springframework.http.ResponseEntity;

public interface SmtpServiceManager {
    @Transactional
    void sendJoinMail(String email);

    ResponseEntity<?> resendJoinMail(String email);

    @Transactional
    boolean checkJoinEmailCode(String email, String code);

    void MailSender(String email, String title, String content);

    boolean checkEmailCodeValidation(String email, String encryptedCode);
}
