package com.nodove.community.nodove.dto.response;

import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class ResponseStatus implements ResponseStatusManager{

    @Override
    public String success(HttpServletResponse response, String status, String message, String code) {
        if (!response.isCommitted()){
            return ApiResponseDto.builder()
                    .status(status)
                    .code(code)
                    .data(message == null ? "no data" : message)
                    .build()
                    .toString();
        }
        return null;
    }

    @Override
    public String error(HttpServletResponse response, String status, String message, String code) {
        if (!response.isCommitted()){
            return ApiResponseDto.builder()
                    .status(status)
                    .code(code)
                    .data(message == null ? "no data" : message)
                    .build()
                    .toString();
        }
        return null;
    }

}
