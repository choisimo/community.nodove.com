package nodove.com.chatserver.configuration

import io.swagger.v3.oas.models.Components
import io.swagger.v3.oas.models.OpenAPI
import io.swagger.v3.oas.models.info.Contact
import io.swagger.v3.oas.models.info.Info
import io.swagger.v3.oas.models.security.SecurityRequirement
import io.swagger.v3.oas.models.security.SecurityScheme
import org.springframework.beans.factory.annotation.Value
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration

@Configuration
class SwaggerConfig {

    @Value("\${springdoc.info.title}")
    private val appTitle: String? = null

    @Value("\${springdoc.info.version}")
    private val appVersion: String? = null

    @Value("\${springdoc.info.description}")
    private val appDescription: String? = null

    @Value("\${springdoc.info.contact.name}")
    private val appContactName: String? = null

    @Value("\${springdoc.info.contact.url}")
    private val appContactUrl: String? = null

    @Value("\${springdoc.info.contact.email}")
    private val appContactEmail: String? = null


    @Bean
    fun customOpenAPI(): OpenAPI {
        // Bearer Token 인증
        val bearerAuthScheme = "bearerAuth"
        val bearerScheme: SecurityScheme = SecurityScheme()
            .name(bearerAuthScheme)
            .type(SecurityScheme.Type.HTTP)
            .scheme("bearer")
            .bearerFormat("JWT")

        // Cookie 인증
        val cookieAuthScheme = "cookieAuth"
        val cookieScheme: SecurityScheme = SecurityScheme()
            .type(SecurityScheme.Type.APIKEY)
            .`in`(SecurityScheme.In.COOKIE)
            .name("refreshToken") // 쿠키 이름과 일치해야 함

        return OpenAPI()
            .addSecurityItem(
                SecurityRequirement()
                    .addList(bearerAuthScheme) // Bearer 인증
                    .addList(cookieAuthScheme)
            ) // Cookie 인증 추가
            .components(
                Components()
                    .addSecuritySchemes(bearerAuthScheme, bearerScheme)
                    .addSecuritySchemes(cookieAuthScheme, cookieScheme)
            )
            .info(
                Info()
                    .title(this.appTitle)
                    .version(this.appVersion)
                    .description(this.appDescription)
                    .contact(
                        Contact()
                            .name(this.appContactName)
                            .url(this.appContactUrl)
                            .email(this.appContactEmail)
                    )
            )
    }
}
