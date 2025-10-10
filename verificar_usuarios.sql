-- VERIFICACIÓN DIRECTA DE USUARIOS EN BASE DE DATOS
-- Ejecutar en MySQL Workbench

USE inventario_plus;

-- Ver todos los usuarios y sus datos
SELECT 
    id_usuario,
    username,
    nombre,
    apellido,
    correo_electronico,
    rol_id,
    activo,
    LEFT(password, 30) as password_hash_preview
FROM usuarios;

-- Verificar estructura de la tabla
DESCRIBE usuarios;

-- Verificar si existen los usuarios específicos
SELECT 'admin' as usuario_buscar, COUNT(*) as existe FROM usuarios WHERE username = 'admin'
UNION ALL
SELECT 'jperez' as usuario_buscar, COUNT(*) as existe FROM usuarios WHERE username = 'jperez'
UNION ALL  
SELECT 'ctecnico' as usuario_buscar, COUNT(*) as existe FROM usuarios WHERE username = 'ctecnico';