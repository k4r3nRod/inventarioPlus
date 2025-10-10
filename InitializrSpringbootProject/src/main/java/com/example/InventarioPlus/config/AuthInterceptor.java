package com.example.InventarioPlus.config;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class AuthInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, 
                           Object handler) throws Exception {
        
        String requestURI = request.getRequestURI();
        
        // Rutas que no requieren autenticación
        if (requestURI.equals("/login") || 
            requestURI.equals("/") ||
            requestURI.startsWith("/assets/") ||
            requestURI.startsWith("/webjars/") ||
            requestURI.startsWith("/css/") ||
            requestURI.startsWith("/js/") ||
            requestURI.startsWith("/images/") ||
            requestURI.startsWith("/api/") ||
            requestURI.equals("/logout")) {
            return true;
        }
        
        // Verificar si el usuario está autenticado
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuario") != null) {
            return true;
        }
        
        // Si no está autenticado, redirigir al login
        response.sendRedirect("/login");
        return false;
    }
}