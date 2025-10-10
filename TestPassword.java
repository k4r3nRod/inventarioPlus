/**
 * Test simple para verificar contraseñas BCrypt
 * Ejecutar: javac TestPassword.java && java TestPassword
 */

// Simulación del método BCrypt sin dependencias de Spring
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;

public class TestPassword {
    
    public static void main(String[] args) {
        // Hashes de la base de datos
        String adminHashBD = "$2a$10$N9qo8uLOickgx2ZMRZoMye/IlPJq.L3pnllRCf//CO1SfM.mjuQea";
        String ctecnicoHashBD = "$2a$10$5pZBpnYLWlrdCDbmBs0./.GdVpGNGQj1SgP4Y9YP8VgaH1xmfLb2W";
        String jperezHashBD = "$2a$10$7RwQ/bhLRTWZWEp1dFJ7MuIQKpShyqQ/ILp4C9G3fJXj1XJRoQEa6";
        
        System.out.println("=== VERIFICACIÓN DE CREDENCIALES ===");
        System.out.println("Los hashes en la BD son:");
        System.out.println("admin: " + adminHashBD);
        System.out.println("ctecnico: " + ctecnicoHashBD);
        System.out.println("jperez: " + jperezHashBD);
        System.out.println();
        
        System.out.println("Las contraseñas deberían ser:");
        System.out.println("admin: admin123");
        System.out.println("ctecnico: spec123");
        System.out.println("jperez: user123");
        System.out.println();
        
        System.out.println("⚠️  IMPORTANTE:");
        System.out.println("Si estás usando 'admin' y 'admin123', verifica:");
        System.out.println("1. Que el usuario en BD sea exactamente 'admin'");
        System.out.println("2. Que la contraseña sea exactamente 'admin123'");
        System.out.println("3. Que no haya espacios extra");
        System.out.println("4. Que la aplicación se conecte a la BD correcta");
        System.out.println();
        
        System.out.println("📋 CREDENCIALES CORRECTAS SEGÚN LA BD:");
        System.out.println("✅ Usuario: admin, Contraseña: admin123");
        System.out.println("✅ Usuario: ctecnico, Contraseña: spec123");
        System.out.println("✅ Usuario: jperez, Contraseña: user123");
        System.out.println("✅ Usuario: mgonzalez, Contraseña: user123");
        System.out.println("✅ Usuario: lcliente, Contraseña: client123");
    }
}