package nodove.com.chatserver.configuration

import nodove.com.chatserver.filter.RequestFilter
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.security.authentication.AuthenticationManager
import org.springframework.security.config.Customizer
import org.springframework.security.config.annotation.web.builders.HttpSecurity
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity
import org.springframework.security.config.annotation.web.configurers.*
import org.springframework.security.config.annotation.web.configurers.AuthorizeHttpRequestsConfigurer.AuthorizationManagerRequestMatcherRegistry
import org.springframework.security.config.http.SessionCreationPolicy
import org.springframework.security.core.Authentication
import org.springframework.security.web.SecurityFilterChain
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter
import org.springframework.web.cors.CorsConfigurationSource

@Configuration
@EnableWebSecurity
class SecurityConfig {

    @Bean
    fun AuthenticationManager() : AuthenticationManager {
        return AuthenticationManager { authentication : Authentication -> authentication}
    }

    @Bean
    @Throws(Exception::class)
    fun securityFilterChain(http: HttpSecurity, corsConfigurationSource: CorsConfigurationSource): SecurityFilterChain {
        http
            .cors { obj : CorsConfigurer<HttpSecurity> -> obj.configurationSource(corsConfigurationSource) }
            .formLogin { obj: FormLoginConfigurer<HttpSecurity> -> obj.disable() }
            .csrf { obj: CsrfConfigurer<HttpSecurity> -> obj.disable() }
            .httpBasic { obj: HttpBasicConfigurer<HttpSecurity> -> obj.disable() }
            .sessionManagement { management: SessionManagementConfigurer<HttpSecurity?> ->
                management.sessionCreationPolicy(
                    SessionCreationPolicy.STATELESS
                )
            }
            .addFilterBefore(RequestFilter(), UsernamePasswordAuthenticationFilter::class.java)
            .authorizeHttpRequests { request ->
                request
                    .anyRequest().permitAll()
            } // 모든 요청에 대해 인증 없이 접근 가능
            return http.build()
    }
}
