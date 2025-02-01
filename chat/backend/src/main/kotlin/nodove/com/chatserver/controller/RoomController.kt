package nodove.com.chatserver.controller

import nodove.com.chatserver.dto.RoomDto
import org.springframework.http.ResponseEntity
import org.springframework.security.core.annotation.AuthenticationPrincipal
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api")
class RoomController {

    @PostMapping("/room")
    fun createRoomAndNotify(@RequestBody roomDto : RoomDto) : ResponseEntity<Any> {
        return ResponseEntity.ok().build()
    }
}