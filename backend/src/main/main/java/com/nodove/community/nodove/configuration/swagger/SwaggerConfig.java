package com.nodove.community.nodove.configuration.swagger;

import io.swagger.v3.oas.models.Components;
import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import io.swagger.v3.oas.models.security.SecurityRequirement;
import io.swagger.v3.oas.models.security.SecurityScheme;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SwaggerConfig {

    @Value("${springdoc.info.title}")
    private String appTitle;

    @Value("${springdoc.info.version}")
    private String appVersion;

    @Value("${springdoc.info.description}")
    private String appDescription;

    @Value("${springdoc.info.contact.name}")
    private String appContactName;

    @Value("${springdoc.info.contact.url}")
    private String appContactUrl;

    @Value("${springdoc.info.contact.email}")
    private String appContactEmail;



    @Bean
    public OpenAPI customOpenAPI() {
        // Bearer Token 인증
        final String bearerAuthScheme = "bearerAuth";
        SecurityScheme bearerScheme = new SecurityScheme()
                .name(bearerAuthScheme)
                .type(SecurityScheme.Type.HTTP)
                .scheme("bearer")
                .bearerFormat("JWT");

        // Cookie 인증
        final String cookieAuthScheme = "cookieAuth";
        SecurityScheme cookieScheme = new SecurityScheme()
                .type(SecurityScheme.Type.APIKEY)
                .in(SecurityScheme.In.COOKIE)
                .name("refreshToken"); // 쿠키 이름과 일치해야 함

        return new OpenAPI()
                .addSecurityItem(new SecurityRequirement()
                        .addList(bearerAuthScheme) // Bearer 인증
                        .addList(cookieAuthScheme)) // Cookie 인증 추가
                .components(new Components()
                        .addSecuritySchemes(bearerAuthScheme, bearerScheme)
                        .addSecuritySchemes(cookieAuthScheme, cookieScheme))
                .info(new
                        Info()
                        .title(this.appTitle)
                        .version(this.appVersion)
                        .description(this.appDescription)
                        .contact(new io.swagger.v3.oas.models.info.Contact()
                                .name(this.appContactName)
                                .url(this.appContactUrl)
                                .email(this.appContactEmail))
                );
    }

}
