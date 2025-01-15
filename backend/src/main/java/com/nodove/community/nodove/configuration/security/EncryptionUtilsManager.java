package com.nodove.community.nodove.configuration.security;

public interface EncryptionUtilsManager {

    String getValidSecretKey();

    String encrypt(String data) throws Exception;

    String decrypt(String encryptedData) throws Exception;
}
