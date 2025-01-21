package com.nodove.community.nodove.dto.security;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class Redis_Refresh_Token {

    private String userId;
    private String provider;
    private String deviceId;
}
