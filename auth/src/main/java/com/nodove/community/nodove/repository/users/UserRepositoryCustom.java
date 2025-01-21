package com.nodove.community.nodove.repository.users;

import com.nodove.community.nodove.domain.users.User;

import java.util.List;

public interface UserRepositoryCustom {
    boolean updateEmailValidation(String email);

    List<User> ifEmailExistsAndActiveIsFalse(String email);
}
