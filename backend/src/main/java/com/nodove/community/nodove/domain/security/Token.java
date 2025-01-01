package com.nodove.community.nodove.domain.security;

import lombok.Getter;

@Getter
public enum Token {
    ACCESS_TOKEN_HEADER("Authorization", "Bearer "),
    REFRESH_TOKEN_HEADER("Authorization", "Refresh "),
    DEVICE_ID_HEADER("Device-Id", "");

    private final String headerName;
    private final String prefix;
    private final Long ACCESS_TOKEN_EXPIRATION = 1000L * 60 * 60; // 1 hour
    private final Long REFRESH_TOKEN_EXPIRATION = 1000L * 60 * 60 * 24 * 30; // 30 days

    Token(String headerName, String prefix) {
        this.headerName = headerName;
        this.prefix = prefix;
    }

    public String createHeaderPrefix(String token) {
        return this.prefix + token;
    }
}

