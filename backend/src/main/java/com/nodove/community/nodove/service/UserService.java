package com.nodove.community.nodove.service;

import com.nodove.community.nodove.domain.users.User;
import com.nodove.community.nodove.repository.users.UserRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    @Transactional
    public User findByUserId(String userId) {
        return userRepository.findByUserId(userId).orElseThrow(() -> new IllegalArgumentException("해당 사용자가 없습니다."));
    }

}
