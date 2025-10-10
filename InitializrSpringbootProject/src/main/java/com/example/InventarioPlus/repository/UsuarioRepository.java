package com.example.InventarioPlus.repository;

import com.example.InventarioPlus.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    
    // Buscar usuario por username
    Optional<Usuario> findByUsername(String username);
    
    // Buscar usuario por email
    Optional<Usuario> findByCorreo(String correo);
    
    // Buscar usuario por username y password (para login)
    Optional<Usuario> findByUsernameAndPassword(String username, String password);
    
    // Buscar usuarios activos
    List<Usuario> findByActivo(Boolean activo);
    
    // Buscar usuarios por rol
    List<Usuario> findByRol(Integer rol);
    
    // Buscar usuarios activos por rol
    List<Usuario> findByActivoAndRol(Boolean activo, Integer rol);
    
    // Verificar si existe username
    boolean existsByUsername(String username);
    
    // Verificar si existe email
    boolean existsByCorreo(String correo);
    
    // Búsqueda por nombre o apellido (LIKE)
    @Query("SELECT u FROM Usuario u WHERE u.activo = true AND " +
           "(LOWER(u.nombre) LIKE LOWER(CONCAT('%', :termino, '%')) OR " +
           "LOWER(u.apellido) LIKE LOWER(CONCAT('%', :termino, '%')))")
    List<Usuario> buscarPorNombreOApellido(@Param("termino") String termino);
    
    // Contar usuarios por rol
    @Query("SELECT COUNT(u) FROM Usuario u WHERE u.activo = true AND u.rol = :rol")
    Long contarUsuariosPorRol(@Param("rol") Integer rol);
}