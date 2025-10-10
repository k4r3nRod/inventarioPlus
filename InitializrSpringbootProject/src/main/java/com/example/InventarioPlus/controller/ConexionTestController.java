package com.example.InventarioPlus.controller;

import com.example.InventarioPlus.config.Conexion;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/conexion")
public class ConexionTestController {
    
    @Autowired
    private Conexion conexion;
    
    /**
     * Endpoint para probar la conexión a la base de datos
     * @return Map con el resultado de la prueba
     */
    @GetMapping("/test")
    public Map<String, Object> probarConexion() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            boolean conectado = conexion.probarConexion();
            
            if (conectado) {
                response.put("status", "SUCCESS");
                response.put("message", "Conexión exitosa a la base de datos");
                response.put("conectado", true);
            } else {
                response.put("status", "ERROR");
                response.put("message", "No se pudo establecer conexión");
                response.put("conectado", false);
            }
            
        } catch (Exception e) {
            response.put("status", "ERROR");
            response.put("message", "Error al probar conexión: " + e.getMessage());
            response.put("conectado", false);
        }
        
        return response;
    }
    
    /**
     * Endpoint para obtener información detallada de la conexión
     * @return Map con información de la base de datos
     */
    @GetMapping("/info")
    public Map<String, Object> obtenerInfoConexion() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            String info = conexion.obtenerInfoConexion();
            response.put("status", "SUCCESS");
            response.put("info", info);
            response.put("configuracion", Map.of(
                "url", conexion.getUrl(),
                "username", conexion.getUsername(),
                "driver", conexion.getDriverClassName()
            ));
            
        } catch (Exception e) {
            response.put("status", "ERROR");
            response.put("message", "Error al obtener información: " + e.getMessage());
        }
        
        return response;
    }
    
    /**
     * Endpoint para obtener solo la configuración básica
     * @return Map con configuración de conexión
     */
    @GetMapping("/config")
    public Map<String, Object> obtenerConfiguracion() {
        Map<String, Object> config = new HashMap<>();
        
        config.put("url", conexion.getUrl());
        config.put("username", conexion.getUsername());
        config.put("driver", conexion.getDriverClassName());
        config.put("descripcion", "Configuración de conexión a MySQL Workbench");
        
        return config;
    }
}