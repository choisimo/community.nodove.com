package com.nodove.community.nodove.service;

import com.nodove.community.nodove.dto.user.UserBlockDto;
import jakarta.transaction.Transactional;

public interface UserBlockServiceManager {
    @Transactional
    UserBlockDto getBlockCaching(String userId);
}
