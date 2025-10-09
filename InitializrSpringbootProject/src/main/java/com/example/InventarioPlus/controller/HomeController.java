package com.example.InventarioPlus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
    
    @GetMapping("/")
    public String home(Model model, HttpSession session) {
        // Verificar si el usuario está logueado
        String usuario = (String) session.getAttribute("usuario");
        if (usuario == null) {
            return "redirect:/login";
        }
        
        // Usuario logueado, mostrar datos en el dashboard
        model.addAttribute("title", "InventarioPlus - Dashboard");
        model.addAttribute("message", "¡Bienvenido al Sistema de Inventario!");
        model.addAttribute("description", "Gestiona tu inventario de manera eficiente");
        model.addAttribute("usuario", usuario);
        model.addAttribute("nombreCompleto", session.getAttribute("nombreCompleto"));
        model.addAttribute("rol", session.getAttribute("rol"));
        
        return "index";  // Esto buscará /WEB-INF/views/layout/index.jsp
    }
    
    @GetMapping("/home")
    public String homeAlternative(Model model, HttpSession session) {
        return home(model, session);
    }
    
    @GetMapping("/test")
    @org.springframework.web.bind.annotation.ResponseBody
    public String test() {
        return "¡Controller funcionando! Los mappings están bien.";
    }
}