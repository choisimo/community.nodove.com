package nodove.com.community.filter

import jakarta.servlet.FilterChain
import jakarta.servlet.http.HttpServletRequest
import jakarta.servlet.http.HttpServletResponse
import org.springframework.web.filter.OncePerRequestFilter

class RequestFilter : OncePerRequestFilter() {
    override fun doFilterInternal (request : HttpServletRequest, response: HttpServletResponse, filterChain: FilterChain) {
        val token: String? = request.getHeader("Authorization")

        if ((token != null) && !(token.startsWith("Bearer"))) {
            filterChain.doFilter(request, response)
            return
        }


    }
}