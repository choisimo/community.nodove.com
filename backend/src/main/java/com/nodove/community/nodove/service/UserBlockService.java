package com.nodove.community.nodove.service;

import com.nodove.community.nodove.domain.users.User;
import com.nodove.community.nodove.domain.users.UserBlock;
import com.nodove.community.nodove.dto.user.UserBlockDto;
import com.nodove.community.nodove.repository.users.UserBlockRepository;
import com.nodove.community.nodove.repository.users.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserBlockService implements UserBlockServiceManager{

    private final RedisService redisService;
    private final UserBlockRepository userBlockRepository;
    private final UserRepository userRepository;

    public void setBlockCaching(UserBlockDto userBlockDto) {
        redisService.setBlockCaching(userBlockDto);
    }

    @Transactional
    @Override
    public UserBlockDto getBlockCaching(String userId) {
        // 1. Redis 캐싱 확인
        UserBlockDto cachedBlock = redisService.getBlockCaching(userId);
        if (cachedBlock != null) {
            return cachedBlock;
        }

        // 2. 데이터베이스 조회
        User user = userRepository.findByUserId(userId).orElseThrow(() -> new RuntimeException("User not found for userId: " + userId));
        if (user == null) {
            throw new RuntimeException("User not found for userId: " + userId);
        }

        UserBlock userBlock = userBlockRepository.findByUser(user);
        if (userBlock == null) {
            return null;
        }

        // 3. DTO 생성
        UserBlockDto userBlockDto = UserBlockDto.builder()
                .user(userBlock.getUser().toString())
                .isBlocked(userBlock.checkIsBlocked())
                .blockedAt(userBlock.getBlockedAt().toString())
                .reason(userBlock.getReason())
                .blockedBy(userBlock.getBlockedBy().toString())
                .unblockedAt(userBlock.getUnblockedAt() != null ? userBlock.getUnblockedAt().toString() : null)
                .Duration(userBlock.Duration())
                .build();

        // 4. 캐싱 저장
        setBlockCaching(userBlockDto);

        return userBlockDto;
    }

}
