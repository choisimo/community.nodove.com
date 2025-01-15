package com.nodove.community.nodove.configuration.security;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

import java.util.Base64;

@Service
public class EncryptionUtils implements EncryptionUtilsManager {

    @Value("${encryptionUtil-secret-key}")
    private String SECRET_KEY;

    @Override
    public String getValidSecretKey() {
        int length = SECRET_KEY.length();
        if (length > 16) {
            return SECRET_KEY.substring(0, 16);  // 16바이트로 자르기
        } else if (length < 16) {
            // 16바이트 미만이면 부족한 부분을 '0'으로 패딩
            return String.format("%-16s", SECRET_KEY).replace(' ', '0');
        } else {
            return SECRET_KEY;  // 이미 16바이트면 그대로 반환
        }
    }

    @Override
    public String encrypt(String data) throws Exception {
        String validKey = getValidSecretKey();
        SecretKeySpec secretKey = new SecretKeySpec(validKey.getBytes(), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        byte[] encryptedData = cipher.doFinal(data.getBytes());
        return Base64.getEncoder().encodeToString(encryptedData); // Base64로 인코딩하여 반환
    }

    @Override
    public String decrypt(String encryptedData) throws Exception {
        String validKey = getValidSecretKey();
        SecretKeySpec secretKey = new SecretKeySpec(validKey.getBytes(), "AES");
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] decodedData = Base64.getDecoder().decode(encryptedData);
        byte[] decryptedData = cipher.doFinal(decodedData);
        return new String(decryptedData);
    }
}

