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
    /**
     * Jasypt password
     * */
    @Value("${Jasypt.config.password}") private String value_pass;

    /**
     * redis properties
     */
    @Value("${spring.data.redis.host}") private String host;
    @Value("${spring.data.redis.port}") private int port;
    @Value("${spring.data.redis.password}") private String password;

    /**
     * mail properties
     * */
    @Value("${spring.mail.host}") private String mail_host;
    @Value("${spring.mail.port}") private int mail_port;
    @Value("${spring.mail.username}") private String mail_username;
    @Value("${spring.mail.password}") private String mail_password;

    @BeforeEach
    void print_origin_values() {
        System.out.println("host: " + host);
        System.out.println("port: " + port);
        System.out.println("password: " + password);

        System.out.println("mail_host: " + mail_host);
        System.out.println("mail_port: " + mail_port);
        System.out.println("mail_username: " + mail_username);
        System.out.println("mail_password: " + mail_password);
    }

    @Test
    void StringEncryptor() {
        String encrypted_host = jasyptEncryptor(host);
        String encrypted_port = jasyptEncryptor(String.valueOf(port));
        String encrypted_password = jasyptEncryptor(password);
        System.out.println("encrypted_host: " + encrypted_host);
        System.out.println("encrypted_port: " + encrypted_port);
        System.out.println("encrypted_password: " + encrypted_password);

        String encrypted_mail_host = jasyptEncryptor(mail_host);
        String encrypted_mail_port = jasyptEncryptor(String.valueOf(mail_port));
        String encrypted_mail_username = jasyptEncryptor(mail_username);
        String encrypted_mail_password = jasyptEncryptor(mail_password);

        System.out.println("encrypted_mail_host: " + encrypted_mail_host);
        System.out.println("encrypted_mail_port: " + encrypted_mail_port);
        System.out.println("encrypted_mail_username: " + encrypted_mail_username);
        System.out.println("encrypted_mail_password: " + encrypted_mail_password);
    }

    public String jasyptEncryptor(String text) {
        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        encryptor.setAlgorithm("PBEWithHMACSHA512AndAES_256");
        encryptor.setPassword(this.value_pass);
        encryptor.setIvGenerator(new RandomIvGenerator());
        return encryptor.encrypt(text);
    }
}
