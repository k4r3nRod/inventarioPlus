package com.example.InventarioPlus.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "usuarios")
public class Usuario {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_usuario")
    private Long id;
    
    private String nombre;
    private String apellido;
    
    @Column(name = "correo_electronico")
    private String correo;
    
    private String telefono;
    private String username;
    private String password;
    
    @Column(name = "rol_id")
    private Integer rol;
    
    private Boolean activo = true;
    
    @Column(name = "fecha_creacion")
    private LocalDateTime fechaCreacion;
    
    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualizacion;
    
    @PrePersist
    protected void onCreate() {
        fechaCreacion = LocalDateTime.now();
        fechaActualizacion = LocalDateTime.now();
    }
    
    @PreUpdate
    protected void onUpdate() {
        fechaActualizacion = LocalDateTime.now();
    }
    
    // Constructor vacío (obligatorio para JPA)
    public Usuario() {}
    
    // Constructor con parámetros
    public Usuario(String nombre, String apellido, String correo, 
                   String username, String password, Integer rol) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.correo = correo;
        this.username = username;
        this.password = password;
        this.rol = rol;
        this.activo = true;
    }
    
    // Getters y Setters
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public String getNombre() {
        return nombre;
    }
    
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public String getApellido() {
        return apellido;
    }
    
    public void setApellido(String apellido) {
        this.apellido = apellido;
    }
    
    public String getCorreo() {
        return correo;
    }
    
    public void setCorreo(String correo) {
        this.correo = correo;
    }
    
    public String getTelefono() {
        return telefono;
    }
    
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    
    public Integer getRol() {
        return rol;
    }
    
    public void setRol(Integer rol) {
        this.rol = rol;
    }
    
    public Boolean getActivo() {
        return activo;
    }
    
    public void setActivo(Boolean activo) {
        this.activo = activo;
    }
    
    public LocalDateTime getFechaCreacion() {
        return fechaCreacion;
    }
    
    public void setFechaCreacion(LocalDateTime fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
    
    public LocalDateTime getFechaActualizacion() {
        return fechaActualizacion;
    }
    
    public void setFechaActualizacion(LocalDateTime fechaActualizacion) {
        this.fechaActualizacion = fechaActualizacion;
    }
    
    // Métodos auxiliares
    public String getNombreCompleto() {
        return nombre + " " + apellido;
    }
    
    public boolean isAdmin() {
        return rol != null && rol == 1; // 1 = ADMINISTRADOR
    }
    
    public boolean isUsuario() {
        return rol != null && rol == 3; // 3 = USUARIO
    }
    
    public boolean isEspecialista() {
        return rol != null && rol == 2; // 2 = ESPECIALISTA
    }
    
    public boolean isCliente() {
        return rol != null && rol == 4; // 4 = CLIENTE
    }
    
    public String getRolNombre() {
        if (rol == null) return "DESCONOCIDO";
        switch (rol) {
            case 1: return "ADMINISTRADOR";
            case 2: return "ESPECIALISTA";
            case 3: return "USUARIO";
            case 4: return "CLIENTE";
            default: return "DESCONOCIDO";
        }
    }
    
    @Override
    public String toString() {
        return "Usuario{" +
                "id=" + id +
                ", nombre='" + nombre + '\'' +
                ", apellido='" + apellido + '\'' +
                ", username='" + username + '\'' +
                ", rol='" + rol + '\'' +
                ", activo=" + activo +
                '}';
    }
}