-- SCRIPT PARA CAMBIAR A ENCRIPTACIÓN MD5
-- Según documento ENCRIPTACION_CONTRASEÑAS.txt
-- Ejecutar en MySQL Workbench

USE inventario_plus;

-- 1. Ver contraseñas actuales (BCrypt)
SELECT 
    username,
    LEFT(password, 30) as current_bcrypt_hash,
    'BCrypt - SERÁ CAMBIADO A MD5' as status
FROM usuarios;

-- 2. Calcular los hashes MD5 de las contraseñas originales (GENERADOS CON TestMD5.java)
-- admin123 -> MD5: 0192023a7bbd73250516f069df18b500
-- user123  -> MD5: 6ad14ba9986e3615423dfca256d04e3f  
-- spec123  -> MD5: 5f35dc7f50c58d67c94f87d99de5b26e

-- 3. Actualizar contraseñas con hash MD5 (según documento ENCRIPTACION_CONTRASEÑAS.txt)
UPDATE usuarios SET password = '0192023a7bbd73250516f069df18b500' WHERE username = 'admin';      -- admin123
UPDATE usuarios SET password = '6ad14ba9986e3615423dfca256d04e3f' WHERE username = 'jperez';    -- user123
UPDATE usuarios SET password = '5f35dc7f50c58d67c94f87d99de5b26e' WHERE username = 'ctecnico';  -- spec123

-- 4. Verificar cambios a MD5
SELECT 
    username,
    password as md5_hash,
    LENGTH(password) as hash_length,
    '✅ MD5 IMPLEMENTADO' as encryption_type,
    activo,
    rol_id
FROM usuarios;

-- 5. Validación de los hashes MD5 generados
SELECT 
    '🔧 ENCRIPTACIÓN CAMBIADA A MD5 SEGÚN DOCUMENTO' as CONFIRMACION,
    'admin: admin123 | jperez: user123 | ctecnico: spec123' as CREDENCIALES_VALIDAS,
    'Hash MD5 de 32 caracteres hexadecimales' as FORMATO_HASH;

-- 6. Verificar que los hashes son exactamente de 32 caracteres (MD5)
SELECT 
    username,
    password,
    LENGTH(password) as longitud,
    CASE 
        WHEN LENGTH(password) = 32 THEN '✅ MD5 Válido'
        ELSE '❌ No es MD5'
    END as validacion_md5
FROM usuarios;