package com.nodove.community.nodove.domain.users;

public enum UserCaching {
    PREFIX_USER_BLOCKED("BLOCKED_USER:"),
    PREFIX_USER_EMAIL("USER_EMAIL:"),
    PREFIX_USER_ID("USER_ID:"),
    PREFIX_USER_NICK("USER_NICK:"),
    PREFIX_USER_EMAIL_CODE("USER_EMAIL_VERIFICATION_CODE:"),
    PREFIX_USER_BLACKLIST("USER_BLACKLIST:"),
    PREFIX_USER_LOGIN_HISTORY("USER_LOGIN_HISTORY:"),
    PREFIX_USER_SEARCH_HISTORY("USER_SEARCH_HISTORY:");

    private final Object value;

    UserCaching(Object value) {
        this.value = value;
    }
}
