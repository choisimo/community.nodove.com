package com.nodove.community.nodove.controller;

import com.nodove.community.nodove.configuration.security.constructor.PrincipalDetails;
import com.nodove.community.nodove.dto.response.ApiResponseDto;
import com.nodove.community.nodove.dto.user.UserLoginRequest;
import com.nodove.community.nodove.dto.user.UserRegisterDto;
import com.nodove.community.nodove.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    // 회원가입
    @Operation(summary = "회원가입", description = "회원가입을 진행합니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "회원가입 성공"),
            @ApiResponse(responseCode = "400", description = "회원가입 실패"),
            @ApiResponse(responseCode = "500", description = "서버 오류")
    })
    @PostMapping("/auth/register")
    public ResponseEntity<?> registerUser(
            @RequestBody(required = true) UserRegisterDto userRegisterDto) {
        log.info("회원 가입을 진행합니다. email = {}", userRegisterDto.getEmail());
        return this.userService.registerUser(userRegisterDto);
    }

    @Operation(summary = "로그인", description = "로그인을 진행합니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "로그인 성공"),
            @ApiResponse(responseCode = "400", description = "로그인 실패"),
            @ApiResponse(responseCode = "500", description = "서버 오류")
    })
    @PostMapping("/auth/login")
    public ResponseEntity<?> loginUser(
            @RequestBody(required = true) UserLoginRequest UserLoginRequest) {
        // filter 에서 처리
        return ResponseEntity.ok().body(ApiResponseDto.<Void>builder()
                .status("success")
                .message("로그인 성공")
                .code("LOGIN_SUCCESS")
                .build());
    }

    @Operation(summary = "토큰 갱신", description = "토큰을 갱신합니다.")
    @ApiResponses(value = {
            @ApiResponse(responseCode = "200", description = "토큰 갱신 성공"),
            @ApiResponse(responseCode = "400", description = "토큰 갱신 실패"),
            @ApiResponse(responseCode = "500", description = "서버 오류")
    })
    @PostMapping("/auth/refresh")
    public ResponseEntity<?> refreshAccessToken(HttpServletRequest request, HttpServletResponse response, @AuthenticationPrincipal PrincipalDetails principalDetails) {
        return this.userService.refreshAccessToken(request, response);
    }


    @PutMapping("/auth/logout")
    public ResponseEntity<?> logoutUser(HttpServletRequest request, HttpServletResponse response) {
        return this.userService.logoutUser(request, response);
    }

}