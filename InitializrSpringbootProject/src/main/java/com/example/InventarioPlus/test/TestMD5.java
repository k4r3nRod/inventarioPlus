package com.example.InventarioPlus.test;

import com.example.InventarioPlus.model.Usuario;

/**
 * Programa de prueba para verificar la encriptación MD5
 * Según documento ENCRIPTACION_CONTRASEÑAS.txt
 */
public class TestMD5 {
    
    public static void main(String[] args) {
        System.out.println("=======================================");
        System.out.println("    PRUEBA DE ENCRIPTACIÓN MD5");
        System.out.println("  Según ENCRIPTACION_CONTRASEÑAS.txt");
        System.out.println("=======================================");
        
        // Probar las contraseñas del sistema
        String[] passwords = {"admin123", "user123", "spec123"};
        String[] usuarios = {"admin", "jperez", "ctecnico"};
        
        for (int i = 0; i < passwords.length; i++) {
            String original = passwords[i];
            String encrypted = Usuario.encriptarMD5(original);
            
            System.out.println("Usuario: " + usuarios[i]);
            System.out.println("Contraseña original: " + original);
            System.out.println("Hash MD5 generado:   " + encrypted);
            System.out.println("Longitud del hash:   " + encrypted.length() + " caracteres");
            System.out.println("¿Es válido MD5?:     " + (encrypted.length() == 32 ? "✅ SÍ" : "❌ NO"));
            System.out.println("---------------------------------------");
        }
        
        // Verificar que el mismo texto produce el mismo hash
        System.out.println("PRUEBA DE CONSISTENCIA:");
        String test = "MiClave123";
        String hash1 = Usuario.encriptarMD5(test);
        String hash2 = Usuario.encriptarMD5(test);
        System.out.println("Texto: " + test);
        System.out.println("Hash 1: " + hash1);
        System.out.println("Hash 2: " + hash2);
        System.out.println("¿Son iguales?: " + (hash1.equals(hash2) ? "✅ SÍ" : "❌ NO"));
        
        System.out.println("=======================================");
        System.out.println("    FLUJO DE ENCRIPTACIÓN COMPLETO");
        System.out.println("=======================================");
        System.out.println("1. Usuario ingresa: 'admin123'");
        System.out.println("2. Sistema llama: Usuario.encriptarMD5('admin123')");
        System.out.println("3. Se genera hash: '" + Usuario.encriptarMD5("admin123") + "'");
        System.out.println("4. Se guarda en BD: Hash de 32 caracteres");
        System.out.println("5. Para login: Se compara hash guardado con hash de password ingresado");
    }
}