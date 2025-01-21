package com.nodove.community.nodove.dto.user;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserBlockDto {

    private Long id;
    private String user;
    private String blockedBy;
    private String blockedAt;
    private String unblockedAt;
    private String reason;
    private boolean isBlocked;
    private Long Duration;
}
