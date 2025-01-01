package com.nodove.community.nodove.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nodove.community.nodove.domain.users.UserCaching;
import com.nodove.community.nodove.dto.user.UserBlockDto;
import jakarta.transaction.Transactional;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import java.beans.Transient;
import java.time.Duration;
import java.util.concurrent.TimeUnit;

@Service
public class RedisService {

    RedisTemplate<String, String> redisTemplate = new RedisTemplate<>();
    private final ObjectMapper objectMapper = new ObjectMapper();


    /* Blocking User */


    private String generateRedisBlockedKey(String userId) {
        return UserCaching.PREFIX_USER_BLOCKED + userId;
    }


    @Transactional
    public void setBlockCaching(UserBlockDto userBlockDto) {
        String redisKey = generateRedisBlockedKey(userBlockDto.getUser());

        try {
            // DTO를 JSON 문자열로 변환
            String value = objectMapper.writeValueAsString(userBlockDto);

            // Redis에 저장 (TTL 적용)
            redisTemplate.opsForValue().set(redisKey, value, userBlockDto.getDuration(), TimeUnit.MINUTES);
        } catch (JsonProcessingException e) {
            // 로그 및 사용자 정의 예외 처리
            throw new RuntimeException("Failed to serialize UserBlockDto for userId: " + userBlockDto.getUser(), e);
        }
    }

    @Transactional
    public UserBlockDto getBlockCaching(String userId) {
        String redisKey = generateRedisBlockedKey(userId);

        // Redis에서 조회
        String value = redisTemplate.opsForValue().get(redisKey);

        try {
            // JSON 문자열을 DTO로 변환
            return objectMapper.readValue(value, UserBlockDto.class);
        } catch (JsonProcessingException e) {
            // 로그 및 사용자 정의 예외 처리
            throw new RuntimeException("Failed to deserialize UserBlockDto for userId: " + userId, e);
        }
    }


    public void deleteBlockCaching(String userId) {
        String redisKey = generateRedisBlockedKey(userId);

        // Redis에서 삭제
        redisTemplate.delete(redisKey);
    }

    public boolean isBlocked(String userId) {
        String redisKey = generateRedisBlockedKey(userId);

        // Redis에서 조회
        return redisTemplate.hasKey(redisKey);
    }

    /* Blocking User */



}
