package com.nodove.community.nodove.filter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nodove.community.nodove.configuration.security.JWT.JwtUtility;
import com.nodove.community.nodove.domain.security.Token;
import com.nodove.community.nodove.dto.response.ApiResponseDto;
import com.nodove.community.nodove.service.RedisService;
import com.nodove.community.nodove.service.UserService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

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
        try {
            log.info("AuthorizationFilter");

            String authorizationHeader = request.getHeader("Authorization");

            if (authorizationHeader == null || !authorizationHeader.startsWith("Bearer ")) {
                log.error("Authorization header is missing or invalid");
                filterChain.doFilter(request, response);
                return;
            }

            String token = authorizationHeader.substring(7);
            String refreshToken;

            if (jwtUtility.isTokenExpired(token, 0)) {
                refreshToken = checkRefreshTokenForReissue(request, response, token);
                if (refreshToken == null) return;

                if (jwtUtility.isTokenExpired(refreshToken, 1)) {
                    log.error("Refresh Token is expired");
                    handleErrorResponse(response, HttpServletResponse.SC_UNAUTHORIZED, "Refresh Token is expired");
                    return;
                }

                token = reissueToken(refreshToken);
                response.setStatus(HttpServletResponse.SC_ACCEPTED);
                handleSuccessResponse(response, HttpServletResponse.SC_ACCEPTED, "Access Token reissued successfully", token);
            }

            Authentication authentication = jwtUtility.getAuthentication(token);
            if (authentication == null) {
                log.error("Unauthorized: Token is invalid");
                handleErrorResponse(response, HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
                return;
            }

            SecurityContextHolder.getContext().setAuthentication(authentication);
        } catch (Exception e) {
            log.error("Error occurred in AuthorizationFilter: {}", e.getMessage());
            handleErrorResponse(response, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Internal Server Error");
        }

        filterChain.doFilter(request, response);
    }

    private String checkRefreshTokenForReissue(HttpServletRequest request, HttpServletResponse response, String token) throws IOException {
        String refreshToken = jwtUtility.getRefreshToken(request);
        if (refreshToken == null || jwtUtility.isTokenExpired(refreshToken, 1)) {
            log.error("Refresh Token is invalid or expired.");
            if (!response.isCommitted()) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write(objectMapper.writeValueAsString(
                        ApiResponseDto.builder()
                                .status("error")
                                .message("Refresh Token is invalid or expired. Please log in again.")
                                .code("TOKEN_EXPIRED")
                                .build()
                ));
            }
        }
        return refreshToken;
    }

    private String reissueToken(String refreshToken) {
        String userId = jwtUtility.parseToken(refreshToken, 1).get("userId").toString();
        return jwtUtility.generateReissuedAccessToken(userId);
    }

    private void handleErrorResponse(HttpServletResponse response, int status, String message) throws IOException {
        if (!response.isCommitted()) {
            response.setStatus(status);
            response.setContentType("application/json");
            response.getWriter().write(objectMapper.writeValueAsString(
                    ApiResponseDto.builder()
                            .status("error")
                            .message(message)
                            .code(String.valueOf(status))
                            .build()
            ));
        }
    }

    private void handleSuccessResponse(HttpServletResponse response, int status, String message, String token) throws IOException {
        if (!response.isCommitted()) {
            response.setStatus(status);
            response.setContentType("application/json");
            response.setHeader(Token.ACCESS_TOKEN_HEADER.getHeaderName(), Token.ACCESS_TOKEN_HEADER.createHeaderPrefix(token));
            response.getWriter().write(objectMapper.writeValueAsString(
                    ApiResponseDto.builder()
                            .status("success")
                            .message(message)
                            .code("TOKEN_REISSUED")
                            .build()
            ));
        }
    }
}

