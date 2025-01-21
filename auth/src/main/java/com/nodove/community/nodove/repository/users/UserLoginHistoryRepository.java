package com.nodove.community.nodove.repository.users;

import com.nodove.community.nodove.domain.users.UserLoginHistory;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserLoginHistoryRepository extends JpaRepository<UserLoginHistory, Long> {
}
