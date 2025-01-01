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

    @Value("${spring.datasource.url}") String mariadb_url;
    @Value("${spring.datasource.username}") String mariadb_username;
    @Value("${spring.datasource.password}") String mariadb_password;
    @Value("${spring.data.mongodb.uri}") String mongodb_uri;

    @Value("${mailsender.host}") String smtp_host;
    @Value("${mailsender.port}") String smtp_port;
    @Value("${mailsender.username}") String smtp_username;
    @Value("${mailsender.password}") String smtp_password;

    @Value("${Jasypt.config.password}") String value_pass;

    @BeforeEach
    void setUp() {
        System.out.println("mariadb_url : " + mariadb_url);
        System.out.println("mariadb_username : " + mariadb_username);
        System.out.println("mariadb_password : " + mariadb_password);
        System.out.println("mongodb_uri : " + mongodb_uri);
        System.out.println("smtp_host : " + smtp_host);
        System.out.println("smtp_port : " + smtp_port);
        System.out.println("smtp_username : " + smtp_username);
        System.out.println("smtp_password : " + smtp_password);
    }

    @Test
    void StringEncryptor() {
        System.out.println("mariadb_url : " + jasyptEncryptor(mariadb_url));
        System.out.println("mariadb_username : " + jasyptEncryptor(mariadb_username));
        System.out.println("mariadb_password : " + jasyptEncryptor(mariadb_password));
        System.out.println("mongodb_uri : " + jasyptEncryptor(mongodb_uri));
        System.out.println("smtp_host : " + jasyptEncryptor(smtp_host));
        System.out.println("smtp_port : " + jasyptEncryptor(smtp_port));
        System.out.println("smtp_username : " + jasyptEncryptor(smtp_username));
        System.out.println("smtp_password : " + jasyptEncryptor(smtp_password));
    }

    public String jasyptEncryptor(String text) {
        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        encryptor.setAlgorithm("PBEWithHMACSHA512AndAES_256");
        encryptor.setPassword(value_pass);
        encryptor.setIvGenerator(new RandomIvGenerator());
        return encryptor.encrypt(text);
    }
}
