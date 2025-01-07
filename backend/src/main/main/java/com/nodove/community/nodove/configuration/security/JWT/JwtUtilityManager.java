package com.nodove.community.nodove.configuration.security.JWT;


import com.nodove.community.nodove.dto.security.TokenDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;

import java.io.IOException;
import java.util.Map;

public interface JwtUtilityManager {

    String generateReissuedAccessToken(String userId);

    TokenDto generateToken(Authentication authentication);

    UsernamePasswordAuthenticationToken getAuthentication(String token);

    boolean isTokenExpired(String token, int type);
    String getRefreshToken(HttpServletRequest request);

    // parsing token
    // type 0: access token, type 1: refresh token
    Map<String, Object> parseToken(String token, int type);

    // token 전달 시, response에 token을 담아서 전달.
    void loginResponse(HttpServletResponse response, TokenDto tokenDto, String deviceId) throws IOException;
}
