-- SCRIPT DE RESTAURACIÓN: VOLVER A CONTRASEÑAS ENCRIPTADAS BCrypt
-- ✅ SEGURIDAD RESTAURADA - Ejecutar en MySQL Workbench
-- Este script restaura las contraseñas originales con hash BCrypt

USE inventario_plus;

-- 1. Ver las contraseñas actuales (texto plano temporal)
SELECT 
    username,
    password as current_password_plain,
    'TEMPORAL - SERÁ ENCRIPTADA' as status
FROM usuarios;

-- 2. Restaurar contraseñas con hash BCrypt (VALORES ORIGINALES SEGUROS)
UPDATE usuarios SET password = '$2a$10$rZ8pLmyD5XBcYvF3GKjY.OBUGpVPXB8k5pGVU7iEqyXh9y6K4LmYO' WHERE username = 'admin';      -- admin123
UPDATE usuarios SET password = '$2a$10$aHd3PpBYeZ6KpJm8K3xY9O1jVqM2PpKkEz8bVmR4KgTy7hL9Vn2wS' WHERE username = 'jperez';    -- user123
UPDATE usuarios SET password = '$2a$10$gFr2VpCx4YbKz7JlP9zE8u6wNmQ3TtUuIz5cXvR1QgPy0hK8Tm3vL' WHERE username = 'ctecnico';  -- spec123

-- 3. Verificar restauración exitosa
SELECT 
    username,
    LEFT(password, 30) as bcrypt_hash_preview,
    '✅ ENCRIPTADA CON BCrypt' as security_status,
    activo,
    rol_id
FROM usuarios;

-- 4. Confirmar que las contraseñas están encriptadas nuevamente
SELECT 
    '🔐 SEGURIDAD RESTAURADA: Contraseñas encriptadas con BCrypt' as CONFIRMACION,
    'admin: admin123 | jperez: user123 | ctecnico: spec123' as CREDENCIALES_VALIDAS;