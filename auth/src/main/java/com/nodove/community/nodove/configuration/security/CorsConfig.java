package com.nodove.community.nodove.configuration.security;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;


@Configuration
public class CorsConfig{

    @Bean
    @Primary
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration corsConfiguration = new CorsConfiguration();
/*        corsConfiguration.setAllowedOrigins(List.of(
                "http://localhost:3000",
                "http://localhost:8080",
                "http://localhost:12324"
        ));*/
        corsConfiguration.addAllowedOriginPattern("http://localhost:*");
        corsConfiguration.addAllowedOriginPattern("https://*.nodove.com");
        corsConfiguration.setAllowedMethods(Arrays.asList("GET", "POST", "OPTIONS", "PATCH", "DELETE", "UPDATE"));
        corsConfiguration.setAllowedHeaders(Arrays.asList("Content-Type", "Authorization", "X-Requested-With", "X-XSRF-TOKEN"));
        corsConfiguration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", corsConfiguration);
        return source;
    }
}
