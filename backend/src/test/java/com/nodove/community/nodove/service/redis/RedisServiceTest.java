package com.nodove.community.nodove.service.redis;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nodove.community.nodove.domain.users.UserCaching;
import com.nodove.community.nodove.dto.user.UserBlockDto;
import org.junit.jupiter.api.Test;
import org.springframework.data.redis.core.RedisTemplate;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class RedisServiceTest {

    RedisTemplate<String, String> redisTemplate;
    ObjectMapper objectMapper = new ObjectMapper();
    @Test
    public void testGetBlockCaching() {
        String userId = "12345";
        String redisKey = UserCaching.PREFIX_USER_BLOCKED + userId;

        String value = redisTemplate.opsForValue().get(redisKey);
        assertNotNull(value);

        UserBlockDto dto = null;
        try {
            dto = objectMapper.readValue(value, UserBlockDto.class);
        } catch (JsonProcessingException e) {
            throw new RuntimeException(e);
        }
        assertEquals(userId, dto.getUserId());
    }

}
