package com.nodove.community.nodove.configuration.security;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.nodove.community.nodove.configuration.security.JWT.JwtUtility;
import com.nodove.community.nodove.configuration.security.constructor.PrincipalDetails;
import com.nodove.community.nodove.configuration.security.constructor.PrincipalDetailsService;
import com.nodove.community.nodove.filter.AuthenticationFilter;
import com.nodove.community.nodove.filter.AuthorizationFilter;
import com.nodove.community.nodove.service.RedisService;
import com.nodove.community.nodove.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfigurationSource;

@Slf4j
@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final PrincipalDetailsService principalDetailsService;
    private JwtUtility jwtUtility;
    private final RedisService redisService;
    private final UserService userService;

    private final AuthenticationConfiguration authenticationConfiguration;
    private final CorsConfigurationSource corsConfigurationSource;

    @Bean
    public AuthenticationManager authenticationManager() throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.cors(cors -> cors.configurationSource(corsConfigurationSource));
        http.formLogin(AbstractHttpConfigurer::disable);
        http.csrf(AbstractHttpConfigurer::disable);
        http.httpBasic(AbstractHttpConfigurer::disable);
        http.sessionManagement(management->management.sessionCreationPolicy(SessionCreationPolicy.STATELESS));
        http.addFilterBefore(new AuthorizationFilter(jwtUtility, ObjectMapper(), redisService, userService), UsernamePasswordAuthenticationFilter.class);
        http.addFilterAt(new AuthenticationFilter(authenticationManager(), jwtUtility, ObjectMapper(), redisService, userService), UsernamePasswordAuthenticationFilter.class);

        http.authorizeHttpRequests((authorize) -> {
                    authorize.requestMatchers(PathRequest.toStaticResources().atCommonLocations()).permitAll();
                    authorize.requestMatchers("/api/private").hasAnyAuthority("ADMIN", "ROLE_ADMIN");
            authorize.requestMatchers("/api/protected").hasAnyAuthority("USER", "ROLE_USER", "ADMIN", "ROLE_ADMIN");
            authorize.requestMatchers("/api/public").permitAll();
            authorize.anyRequest().permitAll();
            });
        return http.build();
    }


    @Bean
    public ObjectMapper ObjectMapper() {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.registerModule(new JavaTimeModule());
        return objectMapper;
    }
}
