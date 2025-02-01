package nodove.com.community.configuration

import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import org.springframework.web.cors.CorsConfiguration
import org.springframework.web.cors.CorsConfigurationSource
import org.springframework.web.cors.UrlBasedCorsConfigurationSource

@Configuration
class CorsConfig {

    @Bean
    fun corsConfigurationSource(): CorsConfigurationSource {
        val source = UrlBasedCorsConfigurationSource()
        val config = CorsConfiguration()

        config.allowCredentials = true
        config.allowedOriginPatterns = listOf("http://localhost:*", "https://*.nodove.com")
        config.allowedHeaders = listOf("Content-Type", "Authorization", "provider")
        config.allowedMethods = listOf("GET", "POST", "OPTIONS", "PATCH", "DELETE", "UPDATE")
        source.registerCorsConfiguration("/**", config)
        return source
    }
}