package com.example.InventarioPlus.service;

import com.example.InventarioPlus.entity.Usuario;
import com.example.InventarioPlus.repository.UsuarioRepository;
import com.example.InventarioPlus.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.util.List;
import java.util.Optional;

@Service
public class UserService {
    
    @Autowired
    private UsuarioRepository usuarioRepository;
    
    @PostConstruct
    public void initializeUsers() {
        // Crear usuarios de prueba si no existen en la base de datos
        if (!usuarioRepository.existsByUsername("admin")) {
            Usuario admin = new Usuario("Administrador", "del Sistema", "admin@inventarioplus.com", 
                                      "admin", "admin123", "ADMIN");
            usuarioRepository.save(admin);
        }
        
        if (!usuarioRepository.existsByUsername("usuario")) {
            Usuario usuario = new Usuario("Usuario", "Empleado", "usuario@inventarioplus.com", 
                                        "usuario", "user123", "USUARIO");
            usuarioRepository.save(usuario);
        }
        
        if (!usuarioRepository.existsByUsername("karen")) {
            Usuario karen = new Usuario("Karen", "Rodriguez", "karen@inventarioplus.com", 
                                      "karen", "karen123", "USUARIO");
            usuarioRepository.save(karen);
        }
    }
    
    // Validar credenciales contra la base de datos
    public boolean validarCredenciales(String username, String password) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findByUsernameAndPassword(username, password);
        return usuarioOpt.isPresent() && usuarioOpt.get().getActivo();
    }
    
    // Obtener usuario por username y convertir a modelo User para compatibilidad
    public User obtenerUsuario(String username) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findByUsername(username);
        if (usuarioOpt.isPresent()) {
            Usuario usuario = usuarioOpt.get();
            return new User(usuario.getUsername(), usuario.getPassword(), 
                          usuario.getNombreCompleto(), usuario.getCorreoElectronico(), 
                          usuario.getRol());
        }
        return null;
    }
    
    // Verificar si es administrador
    public boolean esAdministrador(String username) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findByUsername(username);
        return usuarioOpt.isPresent() && usuarioOpt.get().isAdmin();
    }
    
    // Obtener todos los usuarios activos
    public List<Usuario> obtenerTodosLosUsuarios() {
        return usuarioRepository.findByActivo(true);
    }
    
    // Agregar nuevo usuario
    public boolean agregarUsuario(String nombre, String apellido, String correo, 
                                String username, String password, String rol) {
        if (!usuarioRepository.existsByUsername(username) && 
            !usuarioRepository.existsByCorreoElectronico(correo)) {
            Usuario usuario = new Usuario(nombre, apellido, correo, username, password, rol);
            usuarioRepository.save(usuario);
            return true;
        }
        return false;
    }
    
    // Buscar usuarios por rol
    public List<Usuario> obtenerUsuariosPorRol(String rol) {
        return usuarioRepository.findByActivoAndRol(true, rol);
    }
    
    // Contar usuarios por rol
    public Long contarUsuariosPorRol(String rol) {
        return usuarioRepository.contarUsuariosPorRol(rol);
    }
    
    // Buscar usuarios por nombre o apellido
    public List<Usuario> buscarUsuarios(String termino) {
        return usuarioRepository.buscarPorNombreOApellido(termino);
    }
}