package com.example.InventarioPlus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class DashboardController {
    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        // Verificar si el usuario está logueado
        if (session.getAttribute("usuario") == null) {
            return "redirect:/login";
        }
        
        // Agregar información del usuario al modelo
        model.addAttribute("usuario", session.getAttribute("usuario"));
        model.addAttribute("nombreCompleto", session.getAttribute("nombreCompleto"));
        model.addAttribute("rol", session.getAttribute("rol"));
        model.addAttribute("usuarioCompleto", session.getAttribute("usuarioCompleto"));
        
        // Retornar la vista del dashboard
        return "dashboard-content";
    }
    
    @GetMapping("/")
    public String home(HttpSession session) {
        // Si el usuario está logueado, redirigir al dashboard
        if (session.getAttribute("usuario") != null) {
            return "redirect:/dashboard";
        }
        // Si no está logueado, redirigir al login
        return "redirect:/login";
    }
}