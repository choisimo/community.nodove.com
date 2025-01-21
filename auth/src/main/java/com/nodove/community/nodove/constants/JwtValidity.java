package com.nodove.community.nodove.constants;
import lombok.Getter;

@Getter
public enum JwtValidity {
    ACCESS_TOKEN(30 * 60 * 1000L),   // 30분 (밀리초)
    REFRESH_TOKEN(7 * 24 * 60 * 60 * 1000L); // 7일 (밀리초)

    private final long validityInMillis;

    JwtValidity(long validityInMillis) {
        this.validityInMillis = validityInMillis;
    }

    public long getValidityInSeconds() {
        return validityInMillis / 1000;
    }
}

