package com.example.InventarioPlus.controller;

import com.example.InventarioPlus.model.Usuario;
import com.example.InventarioPlus.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/database")
public class DatabaseTestController {
    
    @Autowired
    private UsuarioService usuarioService;
    
    @GetMapping("/test")
    public Map<String, Object> testDatabaseConnection() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // Obtener todos los usuarios de la base de datos
            List<Usuario> usuarios = usuarioService.obtenerTodosLosUsuarios();
            
            // Contar usuarios por rol
            Long totalAdmins = usuarioService.contarUsuariosPorRol("ADMIN");
            Long totalUsuarios = usuarioService.contarUsuariosPorRol("USUARIO");
            
            response.put("status", "SUCCESS");
            response.put("message", "Conexión a base de datos exitosa");
            response.put("totalUsuarios", usuarios.size());
            response.put("totalAdmins", totalAdmins);
            response.put("totalUsuariosRegulares", totalUsuarios);
            response.put("usuarios", usuarios);
            
        } catch (Exception e) {
            response.put("status", "ERROR");
            response.put("message", "Error al conectar con la base de datos: " + e.getMessage());
            response.put("error", e.getClass().getSimpleName());
        }
        
        return response;
    }
    
    @GetMapping("/info")
    public Map<String, Object> getDatabaseInfo() {
        Map<String, Object> info = new HashMap<>();
        info.put("database", "MySQL");
        info.put("schema", "inventario_plus");
        info.put("description", "Sistema de gestión de inventario");
        info.put("version", "1.0.0");
        return info;
    }
}