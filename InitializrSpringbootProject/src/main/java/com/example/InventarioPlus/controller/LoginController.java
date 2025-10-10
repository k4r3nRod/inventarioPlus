package com.example.InventarioPlus.controller;

import com.example.InventarioPlus.model.User;
import com.example.InventarioPlus.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {
    
    @Autowired
    private UserService userService;
    
    @GetMapping("/login")
    public String showLoginForm(Model model, HttpSession session) {
        // Si ya está autenticado, redirigir al home
        if (session.getAttribute("usuario") != null) {
            return "redirect:/";
        }
        
        return "login-standalone";
    }
    
    @PostMapping("/login")
    public String processLogin(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            Model model,
            HttpSession session) {
        
        if (userService.validarCredenciales(username, password)) {
            User usuario = userService.obtenerUsuario(username);
            
            // Crear sesión con información completa del usuario
            session.setAttribute("usuario", usuario.getUsername());
            session.setAttribute("nombreCompleto", usuario.getNombreCompleto());
            session.setAttribute("rol", usuario.getRol());
            session.setAttribute("usuarioCompleto", usuario);
            
            // Redirigir al dashboard
            return "redirect:/";
        } else {
            // Error de credenciales
            model.addAttribute("error", "Usuario o contraseña incorrectos");
            return "login-standalone";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login?logout=true";
    }

}