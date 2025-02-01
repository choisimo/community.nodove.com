package nodove.com.chatserver.repository

import nodove.com.chatserver.dto.Message
import org.springframework.data.mongodb.repository.MongoRepository

interface MessageRepository : MongoRepository<Message, String>{
    fun findAllByOrderByTimestampAsc() : List<Message>
}