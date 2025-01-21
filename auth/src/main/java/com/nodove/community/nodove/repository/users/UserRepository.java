package com.nodove.community.nodove.repository.users;

import com.nodove.community.nodove.domain.users.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long>, UserRepositoryCustom {
    Optional<User> findByEmail(String email);
    Optional<User> findByUsername(String username);

    Optional<User> findByUserId(String userId);

    Optional<User> findByUserNick(String userNick);
}
