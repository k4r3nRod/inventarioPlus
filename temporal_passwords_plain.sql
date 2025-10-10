-- SCRIPT TEMPORAL: CAMBIAR CONTRASEÑAS A TEXTO PLANO PARA PRUEBAS
-- ⚠️  SOLO PARA DESARROLLO/TESTING - NO USAR EN PRODUCCIÓN
-- Ejecutar en MySQL Workbench

USE inventario_plus;

-- 1. Ver las contraseñas actuales (encriptadas)
SELECT 
    username,
    LEFT(password, 50) as current_password_hash
FROM usuarios;

-- 2. Actualizar contraseñas a texto plano TEMPORALMENTE para pruebas
UPDATE usuarios SET password = 'admin123' WHERE username = 'admin';
UPDATE usuarios SET password = 'user123' WHERE username = 'jperez';
UPDATE usuarios SET password = 'spec123' WHERE username = 'ctecnico';

-- 3. Verificar cambios
SELECT 
    username,
    password as plain_password,
    activo,
    rol_id
FROM usuarios;

-- 4. Mensaje de recordatorio
SELECT '⚠️  RECORDATORIO: ESTAS SON CONTRASEÑAS TEMPORALES EN TEXTO PLANO' as IMPORTANTE;
SELECT '🔧 Para volver a BCrypt, ejecutar el script de restauración después de las pruebas' as NOTA;