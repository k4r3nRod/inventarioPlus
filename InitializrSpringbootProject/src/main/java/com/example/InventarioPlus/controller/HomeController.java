package com.example.InventarioPlus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    
    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("title", "InventarioPlus");
        model.addAttribute("message", "¡Bienvenido al Sistema de Inventario!");
        model.addAttribute("description", "Gestiona tu inventario de manera eficiente");
        return "index";  // Esto buscará /WEB-INF/views/layout/index.jsp
    }
    
    @GetMapping("/home")
    public String homeAlternative(Model model) {
        return home(model);
    }
    
    @GetMapping("/test")
    @org.springframework.web.bind.annotation.ResponseBody
    public String test() {
        return "¡Controller funcionando! Los mappings están bien.";
    }
}