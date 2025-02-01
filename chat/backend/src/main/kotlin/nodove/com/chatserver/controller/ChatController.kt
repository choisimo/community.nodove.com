package nodove.com.chatserver.controller

import nodove.com.chatserver.dto.Message
import nodove.com.chatserver.repository.MessageRepository
import org.slf4j.LoggerFactory
import org.springframework.messaging.handler.annotation.MessageMapping
import org.springframework.messaging.handler.annotation.Payload
import org.springframework.messaging.handler.annotation.SendTo
import org.springframework.messaging.simp.SimpMessagingTemplate
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class ChatController(private val messageRepository: MessageRepository, private val messageTemplate: SimpMessagingTemplate) {

    private val log = LoggerFactory.getLogger(ChatController::class.java)

    @MessageMapping("/chat.sendMessage/{receiver}")
    /**
     * or using
     * @SendTo("/topic/messages/{receiver}")
     * */

    fun sendMessage(@Payload message: Message): Message {
        log.info("Message sent: $message")
        messageTemplate.convertAndSend("/topic/messages", message);
        messageRepository.save(message)
        return message
    }


    @MessageMapping("/chat.addUser")
    @GetMapping("/messages")
    fun messages(): List<Message> {
        return messageRepository.findAllByOrderByTimestampAsc()
    }


}