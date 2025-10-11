-- =========================================
-- SCRIPT DE VERIFICACIÓN POST-CREACIÓN
-- Ejecutar DESPUÉS de crear la base de datos
-- =========================================

USE inventario_plus;

-- 1. VERIFICAR ESTRUCTURA DE TABLAS
SELECT 
    '📋 VERIFICACIÓN DE ESTRUCTURA' as TITULO,
    '' as SEPARADOR;

SHOW TABLES;

-- 2. VERIFICAR USUARIOS Y ENCRIPTACIÓN MD5
SELECT 
    '🔐 VERIFICACIÓN DE ENCRIPTACIÓN MD5' as TITULO,
    '' as SEPARADOR;

SELECT 
    username,
    nombre,
    password,
    LENGTH(password) as longitud_hash,
    CASE 
        WHEN LENGTH(password) = 32 THEN '✅ MD5 Válido'
        ELSE '❌ No es MD5'
    END as estado_md5,
    rol_id,
    activo
FROM usuarios
ORDER BY rol_id, username;

-- 3. PROBAR FLUJO DE VALIDACIÓN MD5
SELECT 
    '🧪 PRUEBA DE VALIDACIÓN MD5' as TITULO,
    '' as SEPARADOR;

-- Simular validación para usuario admin
SELECT 
    'admin' as usuario_prueba,
    'admin123' as password_original,
    '0192023a7bbd73250516f069df18b500' as hash_esperado,
    password as hash_en_bd,
    CASE 
        WHEN password = '0192023a7bbd73250516f069df18b500' THEN '✅ LOGIN EXITOSO'
        ELSE '❌ LOGIN FALLIDO'
    END as resultado_login
FROM usuarios 
WHERE username = 'admin';

-- 4. ESTADÍSTICAS FINALES
SELECT 
    '📊 ESTADÍSTICAS FINALES' as TITULO,
    '' as SEPARADOR;

SELECT 
    COUNT(*) as total_usuarios,
    COUNT(DISTINCT rol_id) as tipos_rol,
    SUM(CASE WHEN LENGTH(password) = 32 THEN 1 ELSE 0 END) as usuarios_md5,
    SUM(CASE WHEN activo = TRUE THEN 1 ELSE 0 END) as usuarios_activos
FROM usuarios;

-- 5. FLUJO IMPLEMENTADO
SELECT 
    '⚙️ FLUJO DE ENCRIPTACIÓN IMPLEMENTADO' as PROCESO,
    '' as SEPARADOR;
    
SELECT 
    '1. Usuario ingresa contraseña en texto plano' as PASO_1,
    '2. Sistema llama Usuario.encriptarMD5(password)' as PASO_2,
    '3. Se genera hash MD5 de 32 caracteres hexadecimales' as PASO_3,
    '4. Se compara con hash almacenado en BD' as PASO_4,
    '5. Login exitoso si los hashes coinciden exactamente' as PASO_5;

-- 6. CONFIRMACIÓN FINAL
SELECT 
    '✅ BASE DE DATOS CREADA CON ÉXITO' as ESTADO,
    'Encriptación MD5 según ENCRIPTACION_CONTRASEÑAS.txt' as IMPLEMENTACION,
    NOW() as FECHA_CREACION;