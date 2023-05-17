package com.svalero.filters;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedIn = (session != null && session.getAttribute("username") != null);

        if (isLoggedIn || isPublicPage(httpRequest)) {
            chain.doFilter(request, response);
        } else {
            httpResponse.sendRedirect("login.jsp");
        }
    }

    private boolean isPublicPage(HttpServletRequest request) {
        String requestURI = request.getRequestURI();
        return requestURI.endsWith("login.jsp") || requestURI.endsWith("login");
    }
}
