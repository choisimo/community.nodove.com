package nodove.com.chatserver.dto

data class RoomDto(
    val host : String,
    val guest : List<String>,
    val roomName : String,
    val roomType : RoomType,
    val roomStatus : RoomStatus,
    val roomPassword : String
)
