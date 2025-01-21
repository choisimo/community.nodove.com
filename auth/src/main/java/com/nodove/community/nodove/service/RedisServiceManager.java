package com.nodove.community.nodove.service;

import com.nodove.community.nodove.dto.security.Redis_Refresh_Token;
import com.nodove.community.nodove.dto.user.UserBlockDto;
import jakarta.transaction.Transactional;

public interface RedisServiceManager {

    @Transactional
    void setBlockCaching(UserBlockDto userBlockDto);

    @Transactional
    UserBlockDto getBlockCaching(String userId);

    @Transactional
    void deleteBlockCaching(String userId);

    @Transactional
    boolean isBlocked(String userId);

    // Save Refresh Token
    @Transactional
    void saveRefreshToken(Redis_Refresh_Token redisRefreshToken, String refreshToken);

    // Get Refresh Token
    @Transactional
    String getRefreshToken(Redis_Refresh_Token redisRefreshToken);

    // Delete Refresh Token
    @Transactional
    void deleteRefreshToken(Redis_Refresh_Token redisRefreshToken);

    @Transactional
    boolean UserEmailExists(String email);

    @Transactional
    boolean UserIdExists(String userId);

    @Transactional
    boolean UserNickExists(String userNick);

    @Transactional
    void saveUserNick(String userNick);

    @Transactional
    void saveUserEmail(String email);

    @Transactional
    void saveUserId(String userId);

    @Transactional
    String getEmailCode(String email);

    @Transactional
    void saveEmailCode(String email, String code);
}
