package com.nodove.community.nodove.configuration.security.JWT;

import com.nodove.community.nodove.configuration.security.constructor.PrincipalDetails;
import com.nodove.community.nodove.constants.JwtValidity;
import com.nodove.community.nodove.domain.users.User;
import com.nodove.community.nodove.domain.users.UserBlock;
import com.nodove.community.nodove.domain.users.UserRole;
import com.nodove.community.nodove.dto.security.TokenDto;
import com.nodove.community.nodove.dto.user.UserBlockDto;
import com.nodove.community.nodove.service.RedisService;
import com.nodove.community.nodove.service.UserBlockService;
import com.nodove.community.nodove.service.UserService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import java.security.Key;
import java.time.LocalDateTime;
import java.util.Collection;
import java.util.Date;
import java.util.List;

@Slf4j
@Component
public class JwtUtility {

    private final Key accessKey;
    private final Key refreshKey;
    private final UserService userService;
    private final RedisService redisService;
    private final UserBlockService userBlockService;

    public JwtUtility(
            @Value("${jwt.secret-key.access}") String accessKey,
            @Value("${jwt.secret-key.refresh}") String refreshKey,
            UserService userService, RedisService redisService, UserBlockService userBlockService
    ) {
        this.accessKey = Keys.hmacShaKeyFor(accessKey.getBytes());
        this.refreshKey = Keys.hmacShaKeyFor(refreshKey.getBytes());
        this.userService = userService;
        this.redisService = redisService;
        this.userBlockService = userBlockService;
    }

    protected String generateAccessToken(PrincipalDetails principalDetails) {
        Collection<? extends GrantedAuthority> role = principalDetails.getAuthorities();
        String userId = principalDetails.getUserId();
        String email = principalDetails.getEmail();

        return Jwts.builder()
                .setSubject("access")
                .claim("role", role.stream().map(GrantedAuthority::getAuthority).toList())
                .claim("userId", userId)
                .claim("email", email)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + JwtValidity.ACCESS_TOKEN.getValidityInSeconds()))
                .signWith(accessKey)
                .compact();
    }

    protected String generateRefreshToken(PrincipalDetails principalDetails) {
        String userId = principalDetails.getUserId();

        return Jwts.builder()
                .setSubject("refresh")
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + JwtValidity.REFRESH_TOKEN.getValidityInSeconds()))
                .claim("userId", userId)
                .signWith(refreshKey)
                .compact();
    }

    public TokenDto generateToken(Authentication authentication) {
        PrincipalDetails principalDetails = (PrincipalDetails) authentication.getPrincipal();
        return new TokenDto(
                generateAccessToken(principalDetails),
                generateRefreshToken(principalDetails)
        );
    }


    public UsernamePasswordAuthenticationToken getAuthentication(String token) {
        try {
            Jws<Claims> claims = Jwts.parserBuilder()
                    .setSigningKey(accessKey)
                    .build()
                    .parseClaimsJws(token);

            String userId = claims.getBody().get("userId", String.class);
            List<String> role = claims.getBody().get("role", List.class);
            String email = claims.getBody().get("email", String.class);

            User user = User.builder()
                    .userId(userId)
                    .email(email)
                    .userRole(UserRole.valueOf(role.get(0)))
                    .build();


            UserBlockDto userBlock = this.userBlockService.getBlockCaching(userId);

            UserBlock checkUserBlock = UserBlock.builder()
                    .unblockedAt(LocalDateTime.parse(userBlock.getUnblockedAt()))
                    .build();

            UserDetails userDetails = new PrincipalDetails(user, checkUserBlock);
            return new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
        } catch (Exception e) {
            log.error("Error while parsing token: {}", e.getMessage());
            return null;
        }
    }

}
