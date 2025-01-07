package com.nodove.community.nodove.repository.users;

import com.nodove.community.nodove.domain.users.User;
import com.nodove.community.nodove.domain.users.UserBlock;
import com.nodove.community.nodove.dto.user.UserBlockDto;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserBlockRepository extends JpaRepository<UserBlock, Long> {
    Optional<UserBlock> findActiveBlockByUserId(Long userId);

    UserBlock findByUser(User user);
}
