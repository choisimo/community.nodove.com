package com.nodove.community.nodove.service;

import com.nodove.community.nodove.domain.users.User;
import com.nodove.community.nodove.dto.user.UserLoginRequest;
import com.nodove.community.nodove.dto.user.UserRegisterDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;
import org.springframework.http.ResponseEntity;

public interface UserServiceManager {

    @Transactional
    public User findByUserId(String userId);

    @Transactional
    public void saveLoginHistory(UserLoginRequest userLoginRequest, HttpServletRequest request);

    @Transactional
    public ResponseEntity<?> registerUser(UserRegisterDto userRegisterDto);

    @Transactional
    public ResponseEntity<?> refreshAccessToken(HttpServletRequest request, HttpServletResponse response);

    boolean updateEmailValidation(String email);
}
