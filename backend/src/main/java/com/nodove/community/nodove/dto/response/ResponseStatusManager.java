package com.nodove.community.nodove.dto.response;

import jakarta.servlet.http.HttpServletResponse;

public interface ResponseStatusManager {

    String success(HttpServletResponse response, String status, String message, String code);

    String error(HttpServletResponse response, String status, String message, String code);
}
