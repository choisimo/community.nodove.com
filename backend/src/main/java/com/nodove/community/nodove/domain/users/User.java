package com.nodove.community.nodove.domain.users;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "user")
@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @Builder.Default
    @Column(name = "user_id", nullable = false, unique = true)
    private String userId = String.valueOf(System.currentTimeMillis());

    @Email
    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "user_name", nullable = true)
    private String username;

    @Column(name = "user_nick", nullable = false)
    private String userNick;

    @Column(name = "user_role", nullable = false)
    private UserRole userRole;

    @Column(name = "is_active", nullable = false)
    private Boolean isActive = false;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at", nullable = false)
    private LocalDateTime updatedAt;

    @Column(name = "deleted_at", nullable = true)
    private LocalDateTime deletedAt;

/*  // todo : userBlockList 양방향 매핑.. 추 후 추가 -> 캐싱 적용 목적 (UserBlock)
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UserBlock> userBlockList = new ArrayList<>();
*/

    @PrePersist
    protected void onCreate() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
        this.userRole = UserRole.ROLE_USER;
    }

    @PreUpdate
    protected void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    @OnDelete(action = OnDeleteAction.CASCADE)
    protected void onDelete() {
        this.deletedAt = LocalDateTime.now();
    }
}
