package com.example.InventarioPlus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {
    
    // Método removido para evitar conflicto con DashboardController
    // La ruta "/" ahora está manejada por DashboardController
    
    @GetMapping("/home")
    public String homeAlternative(Model model, HttpSession session) {
        // Redirigir al dashboard si el usuario está logueado
        if (session.getAttribute("usuario") != null) {
            return "redirect:/dashboard";
        }
        return "redirect:/login";
    }
    
    @GetMapping("/test")
    @org.springframework.web.bind.annotation.ResponseBody
    public String test() {
        return "¡Controller funcionando! Los mappings están bien.";
    }
}