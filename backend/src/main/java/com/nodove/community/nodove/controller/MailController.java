package com.nodove.community.nodove.controller;

import com.nodove.community.nodove.dto.response.ResponseStatusManager;
import com.nodove.community.nodove.service.SmtpServiceManager;
import com.nodove.community.nodove.service.UserServiceManager;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class MailController {

    private final ResponseStatusManager responseStatus;
    private final SmtpServiceManager smtpServiceManager;
    private final UserServiceManager userServiceManager;

    @PostMapping("/join/email/check")
    public ResponseEntity<?> checkEmailCodeValidation(HttpServletResponse response,
                                                      @RequestParam("email") String email,
                                                      @RequestParam("code") String encryptedCode) {
        if (email == null || encryptedCode == null) {
            return ResponseEntity.badRequest().body(
                    responseStatus.error(response,
                            "error",
                            "EMAIL_CODE_NOT_FOUND",
                            "EMAIL_CODE_NOT_FOUND")
            );
        }

        if (!smtpServiceManager.checkEmailCodeValidation(email, encryptedCode)) {
            return ResponseEntity.badRequest().body(
                    responseStatus.error(response,
                            "error",
                            "EMAIL_CODE_VALIDATION_FAILED",
                            "EMAIL_CODE_VALIDATION_FAILED")
            );
        }

        if (!userServiceManager.updateEmailValidation(email)) {
            return ResponseEntity.badRequest().body(
                    responseStatus.error(response,
                            "error",
                            "EMAIL_CODE_VALIDATION_FAILED",
                            "EMAIL_CODE_VALIDATION_FAILED")
            );
        }

        return ResponseEntity.ok().body(
                responseStatus.success(response,
                        "success",
                        "EMAIL_CODE_VALIDATION_SUCCESS",
                        "EMAIL_CODE_VALIDATION_SUCCESS")
        );
    }
}
