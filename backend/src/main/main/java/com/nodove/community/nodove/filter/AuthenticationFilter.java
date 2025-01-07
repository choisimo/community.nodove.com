package com.nodove.community.nodove.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nodove.community.nodove.configuration.security.JWT.JwtUtilityManager;
import com.nodove.community.nodove.configuration.security.constructor.PrincipalDetails;
import com.nodove.community.nodove.dto.response.ApiResponseDto;
import com.nodove.community.nodove.dto.security.Redis_Refresh_Token;
import com.nodove.community.nodove.dto.security.TokenDto;
import com.nodove.community.nodove.dto.user.UserLoginRequest;
import com.nodove.community.nodove.service.RedisServiceManager;
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
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@Slf4j
public class AuthenticationFilter extends UsernamePasswordAuthenticationFilter {

    private final AuthenticationManager authenticationManager;
    private final JwtUtilityManager jwtUtility;
    private final ObjectMapper objectMapper;
    private final RedisServiceManager redisService;
    private final UserService userService;

    public AuthenticationFilter(AuthenticationManager authenticationManager, JwtUtilityManager jwtUtility, ObjectMapper objectMapper, RedisServiceManager redisService, UserService userService) {
        super.setFilterProcessesUrl("/auth/login");
        this.authenticationManager = authenticationManager;
        this.jwtUtility = jwtUtility;
        this.objectMapper = objectMapper;
        this.redisService = redisService;
        this.userService = userService;
    }

    private final Map<String, String> requestCache = new ConcurrentHashMap<>();

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {

        log.info("Attempting authentication");

        try {
            UserLoginRequest userLoginRequest = objectMapper.readValue(request.getInputStream(), UserLoginRequest.class);
            requestCache.put("requestBody", objectMapper.writeValueAsString(userLoginRequest));
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
        String requestLogin = requestCache.get("requestBody");
        UserLoginRequest userLoginRequest = objectMapper.readValue(requestLogin, UserLoginRequest.class);

        PrincipalDetails principalDetails = (PrincipalDetails) authentication.getPrincipal();
        if (!principalDetails.isEnabled()) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, ApiResponseDto.builder()
                    .status("error")
                    .message("User is not enabled -> check email verification")
                    .code("USER_DISABLED")
                    .build().toString());
            return;
        }

        this.userService.saveLoginHistory(userLoginRequest, request);
        TokenDto token = jwtUtility.generateToken(authentication);

        String deviceId = UUID.randomUUID().toString();

        Redis_Refresh_Token redis_refresh_token = Redis_Refresh_Token.builder()
                .provider("LOCAL")
                .userId(principalDetails.getUserId())
                .deviceId(deviceId)
                .build();
        this.redisService.saveRefreshToken(redis_refresh_token, token.getRefreshToken());

        jwtUtility.loginResponse(response, token, deviceId);
    }
}
