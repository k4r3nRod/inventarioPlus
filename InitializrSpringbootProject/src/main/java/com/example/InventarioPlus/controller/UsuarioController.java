package com.example.InventarioPlus.controller;

import com.example.InventarioPlus.model.Usuario;
import com.example.InventarioPlus.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {
    
    @Autowired
    private UsuarioService usuarioService;
    
    // ==========================================
    // ENDPOINTS DE CONSULTA
    // ==========================================
    
    /**
     * Obtener todos los usuarios activos
     */
    @GetMapping
    public ResponseEntity<List<Usuario>> obtenerTodosLosUsuarios() {
        List<Usuario> usuarios = usuarioService.obtenerTodosLosUsuarios();
        return ResponseEntity.ok(usuarios);
    }
    
    /**
     * Obtener usuario por ID
     */
    @GetMapping("/{id}")
    public ResponseEntity<Usuario> obtenerUsuarioPorId(@PathVariable Long id) {
        Usuario usuario = usuarioService.obtenerUsuarioPorId(id);
        if (usuario != null) {
            return ResponseEntity.ok(usuario);
        }
        return ResponseEntity.notFound().build();
    }
    
    /**
     * Buscar usuarios por rol
     */
    @GetMapping("/rol/{rol}")
    public ResponseEntity<List<Usuario>> obtenerUsuariosPorRol(@PathVariable String rol) {
        List<Usuario> usuarios = usuarioService.obtenerUsuariosPorRol(rol.toUpperCase());
        return ResponseEntity.ok(usuarios);
    }
    
    /**
     * Buscar usuarios por término (nombre o apellido)
     */
    @GetMapping("/buscar")
    public ResponseEntity<List<Usuario>> buscarUsuarios(@RequestParam String termino) {
        List<Usuario> usuarios = usuarioService.buscarUsuarios(termino);
        return ResponseEntity.ok(usuarios);
    }
    
    /**
     * Obtener estadísticas de usuarios
     */
    @GetMapping("/estadisticas")
    public ResponseEntity<Map<String, Object>> obtenerEstadisticas() {
        Map<String, Object> estadisticas = usuarioService.obtenerEstadisticas();
        return ResponseEntity.ok(estadisticas);
    }
    
    // ==========================================
    // ENDPOINTS DE MODIFICACIÓN
    // ==========================================
    
    /**
     * Crear nuevo usuario
     */
    @PostMapping
    public ResponseEntity<Map<String, Object>> crearUsuario(@RequestBody UsuarioRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // Validar campos requeridos
            if (request.getNombre() == null || request.getApellido() == null || 
                request.getCorreo() == null || request.getUsername() == null || 
                request.getPassword() == null || request.getRol() == null) {
                response.put("success", false);
                response.put("message", "Todos los campos son requeridos");
                return ResponseEntity.badRequest().body(response);
            }
            
            // Verificar disponibilidad
            if (!usuarioService.isUsernameDisponible(request.getUsername())) {
                response.put("success", false);
                response.put("message", "El username ya está en uso");
                return ResponseEntity.badRequest().body(response);
            }
            
            if (!usuarioService.isEmailDisponible(request.getCorreo())) {
                response.put("success", false);
                response.put("message", "El correo electrónico ya está en uso");
                return ResponseEntity.badRequest().body(response);
            }
            
            // Crear usuario
            boolean creado = usuarioService.agregarUsuario(
                request.getNombre(),
                request.getApellido(),
                request.getCorreo(),
                request.getUsername(),
                request.getPassword(),
                request.getRol().toUpperCase()
            );
            
            if (creado) {
                response.put("success", true);
                response.put("message", "Usuario creado exitosamente");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "Error al crear el usuario");
                return ResponseEntity.internalServerError().body(response);
            }
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error interno del servidor: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    /**
     * Actualizar usuario
     */
    @PutMapping("/{id}")
    public ResponseEntity<Map<String, Object>> actualizarUsuario(@PathVariable Long id, @RequestBody UsuarioRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            Usuario usuarioExistente = usuarioService.obtenerUsuarioPorId(id);
            if (usuarioExistente == null) {
                response.put("success", false);
                response.put("message", "Usuario no encontrado");
                return ResponseEntity.status(404).body(response);
            }
            
            // Actualizar campos
            usuarioExistente.setNombre(request.getNombre());
            usuarioExistente.setApellido(request.getApellido());
            usuarioExistente.setCorreo(request.getCorreo());
            usuarioExistente.setTelefono(request.getTelefono());
            usuarioExistente.setRol(request.getRol().toUpperCase());
            
            // Si se proporciona nueva contraseña
            if (request.getPassword() != null && !request.getPassword().isEmpty()) {
                usuarioExistente.setPassword(request.getPassword());
            }
            
            Usuario usuarioActualizado = usuarioService.actualizarUsuario(usuarioExistente);
            
            if (usuarioActualizado != null) {
                response.put("success", true);
                response.put("message", "Usuario actualizado exitosamente");
                response.put("usuario", usuarioActualizado);
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "Error al actualizar el usuario");
                return ResponseEntity.internalServerError().body(response);
            }
            
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Error interno del servidor: " + e.getMessage());
            return ResponseEntity.internalServerError().body(response);
        }
    }
    
    /**
     * Eliminar usuario (desactivar)
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<Map<String, Object>> eliminarUsuario(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        
        boolean eliminado = usuarioService.eliminarUsuario(id);
        
        if (eliminado) {
            response.put("success", true);
            response.put("message", "Usuario eliminado exitosamente");
            return ResponseEntity.ok(response);
        } else {
            response.put("success", false);
            response.put("message", "Usuario no encontrado");
            return ResponseEntity.status(404).body(response);
        }
    }
    
    // ==========================================
    // CLASE INTERNA PARA REQUESTS
    // ==========================================
    
    public static class UsuarioRequest {
        private String nombre;
        private String apellido;
        private String correo;
        private String telefono;
        private String username;
        private String password;
        private String rol;
        
        // Getters y Setters
        public String getNombre() { return nombre; }
        public void setNombre(String nombre) { this.nombre = nombre; }
        
        public String getApellido() { return apellido; }
        public void setApellido(String apellido) { this.apellido = apellido; }
        
        public String getCorreo() { return correo; }
        public void setCorreo(String correo) { this.correo = correo; }
        
        public String getTelefono() { return telefono; }
        public void setTelefono(String telefono) { this.telefono = telefono; }
        
        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
        
        public String getRol() { return rol; }
        public void setRol(String rol) { this.rol = rol; }
    }
}