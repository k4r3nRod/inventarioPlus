package com.example.InventarioPlus.model;

public class User {
    private String username;
    private String password;
    private String nombreCompleto;
    private String email;
    private String rol;
    private boolean activo;
    
    // Constructores
    public User() {}
    
    public User(String username, String password, String nombreCompleto, String email, String rol) {
        this.username = username;
        this.password = password;
        this.nombreCompleto = nombreCompleto;
        this.email = email;
        this.rol = rol;
        this.activo = true;
    }
    
    // Getters y Setters
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
    
    public String getNombreCompleto() {
        return nombreCompleto;
    }
    
    public void setNombreCompleto(String nombreCompleto) {
        this.nombreCompleto = nombreCompleto;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getRol() {
        return rol;
    }
    
    public void setRol(String rol) {
        this.rol = rol;
    }
    
    public boolean isActivo() {
        return activo;
    }
    
    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    
    // Métodos auxiliares
    public boolean isAdmin() {
        return "ADMIN".equalsIgnoreCase(this.rol);
    }
    
    public boolean isUsuario() {
        return "USUARIO".equalsIgnoreCase(this.rol);
    }
    
    @Override
    public String toString() {
        return "User{" +
                "username='" + username + '\'' +
                ", nombreCompleto='" + nombreCompleto + '\'' +
                ", email='" + email + '\'' +
                ", rol='" + rol + '\'' +
                ", activo=" + activo +
                '}';
    }
}