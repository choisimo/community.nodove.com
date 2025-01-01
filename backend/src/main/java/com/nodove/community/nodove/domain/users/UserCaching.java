package com.nodove.community.nodove.domain.users;

public enum UserCaching {
    PREFIX_USER_BLOCKED("BLOCKED_USER:");

    private final Object value;

    UserCaching(Object value) {
        this.value = value;
    }
}
