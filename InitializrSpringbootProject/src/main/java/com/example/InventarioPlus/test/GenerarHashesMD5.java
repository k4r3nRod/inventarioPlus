package com.example.InventarioPlus.test;

import com.example.InventarioPlus.model.Usuario;

/**
 * Generador de hashes MD5 para usuarios de ejemplo
 * Según documento ENCRIPTACION_CONTRASEÑAS.txt
 */
public class GenerarHashesMD5 {
    
    public static void main(String[] args) {
        System.out.println("=========================================");
        System.out.println("  GENERADOR DE HASHES MD5 PARA USUARIOS");
        System.out.println("  Según ENCRIPTACION_CONTRASEÑAS.txt");
        System.out.println("=========================================");
        
        // Contraseñas existentes
        System.out.println("USUARIOS EXISTENTES:");
        generarHash("admin123", "admin");
        generarHash("user123", "jperez");
        generarHash("spec123", "ctecnico");
        
        System.out.println("\nUSUARIOS DE EJEMPLO ADICIONALES:");
        generarHash("demo123", "demo");
        generarHash("test123", "test");
        generarHash("guest123", "guest");
        generarHash("user123", "especialista");  // Reutilizando user123
        generarHash("admin123", "superadmin");   // Reutilizando admin123
        
        System.out.println("\n=========================================");
        System.out.println("SCRIPT SQL GENERADO:");
        System.out.println("=========================================");
        
        System.out.println("-- Usuarios existentes");
        System.out.println("UPDATE usuarios SET password = '" + Usuario.encriptarMD5("admin123") + "' WHERE username = 'admin';");
        System.out.println("UPDATE usuarios SET password = '" + Usuario.encriptarMD5("user123") + "' WHERE username = 'jperez';");
        System.out.println("UPDATE usuarios SET password = '" + Usuario.encriptarMD5("spec123") + "' WHERE username = 'ctecnico';");
        
        System.out.println("\n-- Usuarios nuevos (INSERT)");
        System.out.println("('Usuario', 'Demo', 'demo@inventarioplus.com', 'demo', '" + Usuario.encriptarMD5("demo123") + "', 3, TRUE),");
        System.out.println("('Usuario', 'Test', 'test@inventarioplus.com', 'test', '" + Usuario.encriptarMD5("test123") + "', 3, TRUE),");
        System.out.println("('Usuario', 'Invitado', 'guest@inventarioplus.com', 'guest', '" + Usuario.encriptarMD5("guest123") + "', 3, TRUE);");
        
        System.out.println("\n=========================================");
        System.out.println("TODAS LAS CREDENCIALES:");
        System.out.println("=========================================");
        String[][] credenciales = {
            {"admin", "admin123", "ADMINISTRADOR"},
            {"jperez", "user123", "USUARIO"},
            {"ctecnico", "spec123", "ESPECIALISTA"},
            {"demo", "demo123", "USUARIO"},
            {"test", "test123", "USUARIO"},
            {"guest", "guest123", "USUARIO"},
            {"especialista", "user123", "ESPECIALISTA"},
            {"superadmin", "admin123", "ADMINISTRADOR"}
        };
        
        for (String[] cred : credenciales) {
            System.out.printf("%-12s | %-10s | %-32s | %s%n", 
                cred[0], cred[1], Usuario.encriptarMD5(cred[1]), cred[2]);
        }
        
        System.out.println("\n✅ Todos los hashes generados correctamente");
        System.out.println("📝 Usar estos hashes en los scripts SQL");
    }
    
    private static void generarHash(String password, String username) {
        String hash = Usuario.encriptarMD5(password);
        System.out.printf("%-12s: %-10s -> %s%n", username, password, hash);
    }
}