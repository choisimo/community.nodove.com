package com.nodove.community.nodove.configuration;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.iv.RandomIvGenerator;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;


@SpringBootTest
public class JasyptConfigAESTest {

    @Value("${Jasypt.config.password}") String value_pass;
    @Value("${spring.datasource.url}") String value_url;
    @Value("${spring.datasource.username}") String value_username;
    @Value("${spring.datasource.password}") String value_password;
    @Value("${spring.data.mongodb.uri}") String value_mongodb_uri;
    @BeforeEach
    void setUp() {
        System.out.println("value_pass : " + value_pass);
        System.out.println("value_url : " + value_url);
        System.out.println("value_username : " + value_username);
        System.out.println("value_password : " + value_password);
    }

    @Test
    void StringEncryptor() {
        System.out.println("jasyptEncryptor(value_url) : " + jasyptEncryptor(value_url));
        System.out.println("jasyptEncryptor(value_username) : " + jasyptEncryptor(value_username));
        System.out.println("jasyptEncryptor(value_password) : " + jasyptEncryptor(value_password));
        System.out.println("jasyptEncryptor(value_mongodb_uri) : " + jasyptEncryptor(value_mongodb_uri));
    }

    public String jasyptEncryptor(String text) {
        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        encryptor.setAlgorithm("PBEWithHMACSHA512AndAES_256");
        encryptor.setPassword(value_pass);
        encryptor.setIvGenerator(new RandomIvGenerator());
        return encryptor.encrypt(text);
    }
}
