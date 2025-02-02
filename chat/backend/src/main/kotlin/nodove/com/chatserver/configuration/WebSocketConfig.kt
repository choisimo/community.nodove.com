package nodove.com.chatserver.configuration

import org.springframework.context.annotation.Configuration
import org.springframework.messaging.simp.config.MessageBrokerRegistry
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker
import org.springframework.web.socket.config.annotation.StompEndpointRegistry
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer

@Configuration
@EnableWebSocketMessageBroker
class WebSocketConfig : WebSocketMessageBrokerConfigurer {

    override fun registerStompEndpoints(registry: StompEndpointRegistry) {
        registry.addEndpoint("/chat").setAllowedOrigins("*").withSockJS()
    }

    override fun configureMessageBroker(registry: MessageBrokerRegistry) {
        // 클라이언트에서 메시지를 보낼 endpoint 를 설정
        registry.setApplicationDestinationPrefixes("/app")
        // 클라이언트 구독 요청을 처리할 때 메시지를 전달할 endpoint 설정
        registry.enableSimpleBroker("/topic")
    }
}
