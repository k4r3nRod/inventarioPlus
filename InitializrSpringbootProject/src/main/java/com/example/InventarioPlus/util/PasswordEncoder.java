package com.example.InventarioPlus.util;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * Utilidad para encriptación de contraseñas usando BCrypt
 */
public class PasswordEncoder {
    
    private static final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
    
    /**
     * Encripta una contraseña usando BCrypt
     * @param plainPassword contraseña en texto plano
     * @return contraseña encriptada
     */
    public static String encode(String plainPassword) {
        return encoder.encode(plainPassword);
    }
    
    /**
     * Verifica si una contraseña coincide con el hash
     * @param plainPassword contraseña en texto plano
     * @param hashedPassword contraseña encriptada
     * @return true si coinciden, false en caso contrario
     */
    public static boolean matches(String plainPassword, String hashedPassword) {
        return encoder.matches(plainPassword, hashedPassword);
    }
    
    /**
     * Genera contraseñas encriptadas para insertar en la base de datos
     * Método utilitario para generar los hashes
     */
    public static void main(String[] args) {
        // Contraseñas originales
        String[] passwords = {"admin123", "spec123", "user123", "client123"};
        String[] users = {"admin", "ctecnico", "jperez/mgonzalez", "lcliente"};
        
        System.out.println("=== CONTRASEÑAS ENCRIPTADAS CON BCRYPT ===");
        for (int i = 0; i < passwords.length; i++) {
            String encoded = encode(passwords[i]);
            System.out.println("Usuario: " + users[i]);
            System.out.println("Original: " + passwords[i]);
            System.out.println("BCrypt: " + encoded);
            System.out.println("---");
        }
    }
}