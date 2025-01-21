package com.nodove.community.nodove.domain.users;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.ZoneOffset;

@Entity
@Table(name = "user_block")
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class UserBlock {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "blocked_by")
    private User blockedBy;

    @Column(name = "reason", nullable = false)
    private String reason; // block reason

    @Column(name = "blocked_at", nullable = false)
    private LocalDateTime blockedAt;

    @Column(name = "unblocked_at", nullable = true)
    private LocalDateTime unblockedAt;


    public Boolean checkIsBlocked() {
        return unblockedAt == null || LocalDateTime.now().isBefore(unblockedAt);
    }

    public Long Duration() {
        return unblockedAt.toEpochSecond(ZoneOffset.UTC) - blockedAt.toEpochSecond(ZoneOffset.UTC);
    }
}
