package com.nodove.community.nodove.service;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
class RedisServiceTest {

    @Autowired
    RedisTemplate<String, String> redisTemplate;

    @Test
    void setUp() {
        System.out.println("setUp");
        this.redisTemplate.opsForValue().set("test", "test");
        assertEquals("test", this.redisTemplate.opsForValue().get("test"));
    }
}