package com.example.InventarioPlus.debug;

import com.example.InventarioPlus.util.PasswordEncoder;

public class PasswordTester {
    public static void main(String[] args) {
        // Contraseñas de la base de datos (los hashes)
        String adminHash = "$2a$10$N9qo8uLOickgx2ZMRZoMye/IlPJq.L3pnllRCf//CO1SfM.mjuQea";
        String ctecnicoHash = "$2a$10$5pZBpnYLWlrdCDbmBs0./.GdVpGNGQj1SgP4Y9YP8VgaH1xmfLb2W";
        String jperezHash = "$2a$10$7RwQ/bhLRTWZWEp1dFJ7MuIQKpShyqQ/ILp4C9G3fJXj1XJRoQEa6";
        
        // Contraseñas originales
        String adminPass = "admin123";
        String ctecnicoPass = "spec123";
        String jperezPass = "user123";
        
        System.out.println("=== VERIFICACIÓN DE CONTRASEÑAS BCrypt ===");
        
        // Probar admin
        boolean adminMatch = PasswordEncoder.matches(adminPass, adminHash);
        System.out.println("admin / admin123 -> " + adminMatch);
        
        // Probar ctecnico
        boolean ctecnicoMatch = PasswordEncoder.matches(ctecnicoPass, ctecnicoHash);
        System.out.println("ctecnico / spec123 -> " + ctecnicoMatch);
        
        // Probar jperez
        boolean jperezMatch = PasswordEncoder.matches(jperezPass, jperezHash);
        System.out.println("jperez / user123 -> " + jperezMatch);
        
        System.out.println("===============================================");
        
        // Generar nuevos hashes para verificar
        System.out.println("Generando nuevos hashes:");
        System.out.println("admin123 -> " + PasswordEncoder.encode("admin123"));
        System.out.println("spec123 -> " + PasswordEncoder.encode("spec123"));
        System.out.println("user123 -> " + PasswordEncoder.encode("user123"));
    }
}