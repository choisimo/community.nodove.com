package com.nodove.community.nodove.configuration;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.iv.RandomIvGenerator;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Value;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Map;
import java.util.Scanner;
import java.util.concurrent.ConcurrentHashMap;

public class JasyptConfigAESTest {

    @Test
    public void testEncrypt() {
        String url = "mongodb://nodove:dover1234!@suhak.nodove.com:27017/community";
        String username = "nodove";
        String password = "dover1234!";

        System.out.println("Encrypted URL: \n" + encrypt(url));
        System.out.println("Encrypted Username: \n" + encrypt(username));
        System.out.println("Encrypted Password: \n" + encrypt(password));

    }

    public String encrypt(String v){
        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();
        encryptor.setAlgorithm("PBEWithHMACSHA512AndAES_256");
        encryptor.setPassword("yATy7/9b6EPoIxE7EWFSgak2/GMYZRES1h+cyHoHbL1q9Z7YyNnAqlCP+BgGrRJChOH/teShxEux+xM60ErNtQ==");
        encryptor.setIvGenerator(new RandomIvGenerator());
        return encryptor.encrypt(v);
    }
}
