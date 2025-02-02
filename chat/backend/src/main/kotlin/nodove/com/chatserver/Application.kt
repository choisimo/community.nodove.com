package nodove.com.chatserver

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration
import org.springframework.boot.runApplication

@SpringBootApplication
class ChatServerApplication

fun main(args: Array<String>) {
    runApplication<ChatServerApplication>(*args)
    {
        println("Hello, world!");
        println("This is a Kotlin project with Gradle Kotlin DSL.")
    }
}
