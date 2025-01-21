package com.nodove.community.nodove.domain.users;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Data
@Table(name = "user_login_history")
@Builder
public class UserLoginHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "login_time")
    private LocalDateTime loginTime;

    @Column(name = "ip_address", nullable = true)
    private String ipAddress;

    @Column(name = "device", nullable = true)
    private String device;

    @Column(name = "is_success", nullable = false)
    private Boolean isSuccess;
}
