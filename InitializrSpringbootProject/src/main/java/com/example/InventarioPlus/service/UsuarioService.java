package com.example.InventarioPlus.service;

import com.example.InventarioPlus.model.Usuario;
import com.example.InventarioPlus.repository.UsuarioRepository;
import com.example.InventarioPlus.util.PasswordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.util.List;
import java.util.Optional;

@Service
public class UsuarioService {
    
    @Autowired
    private UsuarioRepository usuarioRepository;
    
    @PostConstruct
    public void initializeUsers() {
        // Crear usuarios de prueba si no existen en la base de datos (comentado porque ya están en la BD)
        /*
        if (!usuarioRepository.existsByUsername("admin")) {
            Usuario admin = new Usuario("Administrador", "del Sistema", "admin@inventarioplus.com", 
                                      "admin", PasswordEncoder.encode("admin123"), 1); // 1 = ADMINISTRADOR
            usuarioRepository.save(admin);
            System.out.println("✅ Usuario admin creado en la base de datos");
        }
        
        if (!usuarioRepository.existsByUsername("usuario")) {
            Usuario usuario = new Usuario("Usuario", "Empleado", "usuario@inventarioplus.com", 
                                        "usuario", PasswordEncoder.encode("user123"), 3); // 3 = USUARIO
            usuarioRepository.save(usuario);
            System.out.println("✅ Usuario empleado creado en la base de datos");
        }
        
        if (!usuarioRepository.existsByUsername("karen")) {
            Usuario karen = new Usuario("Karen", "Rodriguez", "karen@inventarioplus.com", 
                                      "karen", PasswordEncoder.encode("karen123"), 3); // 3 = USUARIO
            usuarioRepository.save(karen);
            System.out.println("✅ Usuario Karen creado en la base de datos");
        }
        */
        System.out.println("✅ Los usuarios ya están configurados en la base de datos");
    }
    
    // ==========================================
    // MÉTODOS DE AUTENTICACIÓN
    // ==========================================
    
    /**
     * Validar credenciales usando BCrypt
     */
    public boolean validarCredenciales(String username, String password) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findByUsername(username);
        if (usuarioOpt.isPresent()) {
            Usuario usuario = usuarioOpt.get();
            return usuario.getActivo() && PasswordEncoder.matches(password, usuario.getPassword());
        }
        return false;
    }
    
    /**
     * Obtener usuario por username
     */
    public Usuario obtenerUsuarioPorUsername(String username) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findByUsername(username);
        return usuarioOpt.orElse(null);
    }
    
    /**
     * Verificar si es administrador
     */
    public boolean esAdministrador(String username) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findByUsername(username);
        return usuarioOpt.isPresent() && usuarioOpt.get().isAdmin();
    }
    
    // ==========================================
    // MÉTODOS CRUD
    // ==========================================
    
    /**
     * Obtener todos los usuarios activos
     */
    public List<Usuario> obtenerTodosLosUsuarios() {
        return usuarioRepository.findByActivo(true);
    }
    
    /**
     * Obtener usuario por ID
     */
    public Usuario obtenerUsuarioPorId(Long id) {
        return usuarioRepository.findById(id).orElse(null);
    }
    
    /**
     * Guardar usuario
     */
    public Usuario guardarUsuario(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }
    
    /**
     * Agregar nuevo usuario (encripta la contraseña automáticamente)
     */
    public boolean agregarUsuario(String nombre, String apellido, String correo, 
                                String username, String password, String rol) {
        if (!usuarioRepository.existsByUsername(username) && 
            !usuarioRepository.existsByCorreo(correo)) {
            Integer rolId = convertirRolStringAId(rol);
            Usuario usuario = new Usuario(nombre, apellido, correo, username, PasswordEncoder.encode(password), rolId);
            usuarioRepository.save(usuario);
            return true;
        }
        return false;
    }
    
    /**
     * Convertir rol de String a Integer
     */
    private Integer convertirRolStringAId(String rol) {
        if (rol == null) return 3; // Default: USUARIO
        switch (rol.toUpperCase()) {
            case "ADMIN":
            case "ADMINISTRADOR":
                return 1;
            case "ESPECIALISTA":
            case "TECNICO":
                return 2;
            case "USUARIO":
                return 3;
            case "CLIENTE":
                return 4;
            default:
                return 3; // Default: USUARIO
        }
    }
    
    /**
     * Actualizar usuario
     */
    public Usuario actualizarUsuario(Usuario usuario) {
        if (usuario.getId() != null && usuarioRepository.existsById(usuario.getId())) {
            return usuarioRepository.save(usuario);
        }
        return null;
    }
    
    /**
     * Eliminar usuario (desactivar)
     */
    public boolean eliminarUsuario(Long id) {
        Optional<Usuario> usuarioOpt = usuarioRepository.findById(id);
        if (usuarioOpt.isPresent()) {
            Usuario usuario = usuarioOpt.get();
            usuario.setActivo(false);
            usuarioRepository.save(usuario);
            return true;
        }
        return false;
    }
    
    // ==========================================
    // MÉTODOS DE BÚSQUEDA
    // ==========================================
    
    /**
     * Buscar usuarios por rol
     */
    public List<Usuario> obtenerUsuariosPorRol(String rol) {
        Integer rolId = convertirRolStringAId(rol);
        return usuarioRepository.findByActivoAndRol(true, rolId);
    }
    
    /**
     * Contar usuarios por rol
     */
    public Long contarUsuariosPorRol(String rol) {
        Integer rolId = convertirRolStringAId(rol);
        return usuarioRepository.contarUsuariosPorRol(rolId);
    }
    
    /**
     * Buscar usuarios por nombre o apellido
     */
    public List<Usuario> buscarUsuarios(String termino) {
        return usuarioRepository.buscarPorNombreOApellido(termino);
    }
    
    /**
     * Buscar por correo electrónico
     */
    public Usuario obtenerUsuarioPorEmail(String email) {
        return usuarioRepository.findByCorreo(email).orElse(null);
    }
    
    /**
     * Verificar disponibilidad de username
     */
    public boolean isUsernameDisponible(String username) {
        return !usuarioRepository.existsByUsername(username);
    }
    
    /**
     * Verificar disponibilidad de email
     */
    public boolean isEmailDisponible(String email) {
        return !usuarioRepository.existsByCorreo(email);
    }
    
    // ==========================================
    // MÉTODOS DE ESTADÍSTICAS
    // ==========================================
    
    /**
     * Obtener estadísticas de usuarios
     */
    public java.util.Map<String, Object> obtenerEstadisticas() {
        java.util.Map<String, Object> stats = new java.util.HashMap<>();
        stats.put("totalUsuarios", usuarioRepository.count());
        stats.put("usuariosActivos", usuarioRepository.findByActivo(true).size());
        stats.put("administradores", contarUsuariosPorRol("ADMIN"));
        stats.put("usuariosRegulares", contarUsuariosPorRol("USUARIO"));
        return stats;
    }
}