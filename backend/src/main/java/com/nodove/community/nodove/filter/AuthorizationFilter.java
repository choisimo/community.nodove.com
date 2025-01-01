package com.nodove.community.nodove.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nodove.community.nodove.configuration.security.JWT.JwtUtility;
import com.nodove.community.nodove.service.RedisService;
import com.nodove.community.nodove.service.UserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.filter.OncePerRequestFilter;

@Slf4j
public class AuthorizationFilter extends OncePerRequestFilter {

    private final JwtUtility jwtUtility;
    private final ObjectMapper objectMapper;
    private final RedisService redisService;
    private final UserService userService;


    public AuthorizationFilter(JwtUtility jwtUtility, ObjectMapper objectMapper, RedisService redisService, UserService userService) {
        this.jwtUtility = jwtUtility;
        this.objectMapper = objectMapper;
        this.redisService = redisService;
        this.userService = userService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        log.info("AuthorizationFilter");
        filterChain.doFilter(request, response);
    }
}
