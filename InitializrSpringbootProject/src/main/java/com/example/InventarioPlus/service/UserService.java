package com.example.InventarioPlus.service;

import com.example.InventarioPlus.model.User;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class UserService {
    
    // Base de datos simulada en memoria (en producción sería JPA/Database)
    private final Map<String, User> usuarios = new HashMap<>();
    
    // Constructor - Inicializar usuarios de prueba
    public UserService() {
        inicializarUsuarios();
    }
    
    private void inicializarUsuarios() {
        usuarios.put("admin", new User("admin", "admin123", "Administrador del Sistema", "admin@inventarioplus.com", "ADMIN"));
        usuarios.put("usuario", new User("usuario", "user123", "Usuario Empleado", "usuario@inventarioplus.com", "USUARIO"));
        usuarios.put("karen", new User("karen", "karen123", "Karen Rodriguez", "karen@inventarioplus.com", "ADMIN"));
    }
    
    // Validar credenciales
    public boolean validarCredenciales(String username, String password) {
        User user = usuarios.get(username);
        return user != null && user.getPassword().equals(password) && user.isActivo();
    }
    
    // Obtener usuario por username
    public User obtenerUsuario(String username) {
        return usuarios.get(username);
    }
    
    // Verificar si es administrador
    public boolean esAdministrador(String username) {
        User user = usuarios.get(username);
        return user != null && user.isAdmin();
    }
    
    // Obtener todos los usuarios (para administración)
    public Map<String, User> obtenerTodosLosUsuarios() {
        return new HashMap<>(usuarios);
    }
    
    // Agregar nuevo usuario
    public boolean agregarUsuario(User user) {
        if (!usuarios.containsKey(user.getUsername())) {
            usuarios.put(user.getUsername(), user);
            return true;
        }
        return false;
    }
    
    // Actualizar usuario
    public boolean actualizarUsuario(String username, User user) {
        if (usuarios.containsKey(username)) {
            usuarios.put(username, user);
            return true;
        }
        return false;
    }
    
    // Eliminar usuario
    public boolean eliminarUsuario(String username) {
        return usuarios.remove(username) != null;
    }
}