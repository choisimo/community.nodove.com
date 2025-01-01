package com.nodove.community.nodove.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nodove.community.nodove.configuration.security.JWT.JwtUtility;
import com.nodove.community.nodove.dto.security.TokenDto;
import com.nodove.community.nodove.dto.user.UserLoginRequest;
import com.nodove.community.nodove.service.RedisService;
import com.nodove.community.nodove.service.UserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import java.io.IOException;

@Slf4j
public class AuthenticationFilter extends UsernamePasswordAuthenticationFilter {

    private final AuthenticationManager authenticationManager;
    private final JwtUtility jwtUtility;
    private final ObjectMapper objectMapper;
    private final RedisService redisService;
    private final UserService userService;

    public AuthenticationFilter(AuthenticationManager authenticationManager, JwtUtility jwtUtility, ObjectMapper objectMapper, RedisService redisService, UserService userService) {
        this.authenticationManager = authenticationManager;
        this.jwtUtility = jwtUtility;
        this.objectMapper = objectMapper;
        this.redisService = redisService;
        this.userService = userService;
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {

        log.info("Attempting authentication");

        try {
            UserLoginRequest userLoginRequest = objectMapper.readValue(request.getInputStream(), UserLoginRequest.class);
            UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(userLoginRequest.getEmail(), userLoginRequest.getPassword());
            return authenticationManager.authenticate(authenticationToken);
        } catch (Exception e) {
            log.error("Error occurred while attempting authentication: {}", e.getMessage());
            throw new RuntimeException(e);
        }
    }


    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain, Authentication authentication) throws IOException {
        log.info("Authentication successful");
        TokenDto token = jwtUtility.generateToken(authentication);
    }
}
