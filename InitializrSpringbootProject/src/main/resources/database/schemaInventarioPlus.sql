-- =========================================
-- ESQUEMA DE BASE DE DATOS: inventario_plus
-- Compatible con MySQL Workbench
-- ENCRIPTACIÓN MD5 según ENCRIPTACION_CONTRASEÑAS.txt
-- =========================================

-- PASO 1: Eliminar base de datos existente y recrear desde cero
DROP DATABASE IF EXISTS inventario_plus;
CREATE DATABASE inventario_plus CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE inventario_plus;

-- PASO 2: Crear tabla Roles PRIMERO (para las foreign keys)
CREATE TABLE Roles (
    id_rol BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- PASO 3: Insertar roles básicos
INSERT INTO Roles (nombre_rol, descripcion) VALUES 
('ADMINISTRADOR', 'Administrador del sistema con acceso completo'),
('ESPECIALISTA', 'Especialista técnico para inspecciones y mantenimiento'),
('USUARIO', 'Usuario regular con acceso limitado'),
('CLIENTE', 'Cliente externo que solicita préstamos de equipos');

-- PASO 4: Crear tabla Usuarios con encriptación MD5
CREATE TABLE usuarios (
    id_usuario BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,  -- Para hash MD5 (32 caracteres)
    rol_id BIGINT NOT NULL DEFAULT 3,   -- 1=ADMIN, 2=ESPECIALISTA, 3=USUARIO
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (rol_id) REFERENCES Roles(id_rol)
);

-- Tabla Equipos
CREATE TABLE Equipos (
    id_equipo BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(100),
    modelo VARCHAR(100),
    numero_serial VARCHAR(100) UNIQUE,
    estado VARCHAR(50),
    ubicacion VARCHAR(100),
    requiere_inspeccion VARCHAR(10),
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla Prestamos
CREATE TABLE Prestamos (
    id_prestamo BIGINT PRIMARY KEY AUTO_INCREMENT,
    fecha_prestamo DATETIME NOT NULL,
    fecha_devolucion_estimada DATETIME,
    fecha_devolucion_real DATETIME,
    id_usuario BIGINT,
    id_equipo BIGINT,
    estado_prestamo VARCHAR(50),
    condicion_al_prestar TEXT,
    condicion_al_devolver TEXT,
    observaciones TEXT,
    inspeccion_requerida VARCHAR(10),
    inspeccion_realizada VARCHAR(10),
    especialista_asignado_id BIGINT,
    fecha_inspeccion_programada DATETIME,
    estado_inspeccion VARCHAR(50),
    observaciones_inspeccion TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_equipo) REFERENCES Equipos(id_equipo),
    FOREIGN KEY (especialista_asignado_id) REFERENCES usuarios(id_usuario)
);

-- Tabla Devoluciones
CREATE TABLE Devoluciones (
    id_devolucion BIGINT PRIMARY KEY AUTO_INCREMENT,
    id_prestamo BIGINT,
    fecha_registro_devolucion DATETIME,
    fecha_devolucion_real DATETIME,
    condicion_al_devolver TEXT,
    observaciones TEXT,
    solicitar_inspeccion VARCHAR(10),
    especialista_asignado_id BIGINT,
    fecha_inspeccion_programada DATETIME,
    inspeccion_realizada VARCHAR(10),
    estado_inspeccion VARCHAR(50),
    creado_por BIGINT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_prestamo) REFERENCES Prestamos(id_prestamo),
    FOREIGN KEY (especialista_asignado_id) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (creado_por) REFERENCES usuarios(id_usuario)
);

-- Tabla Inspecciones
CREATE TABLE Inspecciones (
    id_inspeccion BIGINT PRIMARY KEY AUTO_INCREMENT,
    id_devolucion BIGINT,
    id_prestamo BIGINT,
    especialista_id BIGINT,
    fecha_inspeccion DATETIME,
    resultado TEXT,
    observaciones TEXT,
    creado_por BIGINT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_devolucion) REFERENCES Devoluciones(id_devolucion),
    FOREIGN KEY (id_prestamo) REFERENCES Prestamos(id_prestamo),
    FOREIGN KEY (especialista_id) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (creado_por) REFERENCES usuarios(id_usuario)
);

-- =========================================
-- PASO 5: INSERTAR USUARIOS CON ENCRIPTACIÓN MD5
-- Según documento ENCRIPTACION_CONTRASEÑAS.txt
-- =========================================

-- Hashes MD5 generados con Usuario.encriptarMD5():
-- admin123 -> 0192023a7bbd73250516f069df18b500
-- user123  -> 6ad14ba9986e3615423dfca256d04e3f
-- spec123  -> 5f35dc7f50c58d67c94f87d99de5b26e
-- demo123  -> 62cc2d8b4bf2d8728120d052163a77df
-- test123  -> cc03e747a6afbbcbf8be7668acfebee5
-- guest123 -> fcf41657f02f88137a1bcf068a32c0a3

INSERT INTO usuarios (nombre, apellido, correo_electronico, username, password, rol_id, activo) VALUES
('Administrador', 'del Sistema', 'admin@inventarioplus.com', 'admin', '0192023a7bbd73250516f069df18b500', 1, TRUE),
('Juan', 'Pérez', 'juan.perez@inventarioplus.com', 'jperez', '6ad14ba9986e3615423dfca256d04e3f', 3, TRUE),
('Carlos', 'Técnico', 'carlos.tecnico@inventarioplus.com', 'ctecnico', '5f35dc7f50c58d67c94f87d99de5b26e', 2, TRUE),
('Usuario', 'Demo', 'demo@inventarioplus.com', 'demo', '62cc2d8b4bf2d8728120d052163a77df', 3, TRUE),
('Usuario', 'Test', 'test@inventarioplus.com', 'test', 'cc03e747a6afbbcbf8be7668acfebee5', 3, TRUE),
('Usuario', 'Invitado', 'guest@inventarioplus.com', 'guest', 'fcf41657f02f88137a1bcf068a32c0a3', 3, TRUE),
('Especialista', 'Principal', 'especialista@inventarioplus.com', 'especialista', '6ad14ba9986e3615423dfca256d04e3f', 2, TRUE),
('Super', 'Admin', 'superadmin@inventarioplus.com', 'superadmin', '0192023a7bbd73250516f069df18b500', 1, TRUE);

-- =========================================
-- PASO 6: VERIFICACIÓN DE USUARIOS CREADOS
-- =========================================

-- Ver todos los usuarios con encriptación MD5
SELECT 
    '✅ USUARIOS CREADOS CON ENCRIPTACIÓN MD5' as TITULO,
    '' as SEPARADOR;

SELECT 
    username,
    nombre,
    apellido,
    password as hash_md5,
    LENGTH(password) as hash_length,
    rol_id,
    CASE rol_id 
        WHEN 1 THEN 'ADMINISTRADOR'
        WHEN 2 THEN 'ESPECIALISTA' 
        WHEN 3 THEN 'USUARIO'
        WHEN 4 THEN 'CLIENTE'
    END as rol_nombre,
    activo
FROM usuarios
ORDER BY rol_id, username;

-- Credenciales de acceso
SELECT 
    '🔐 CREDENCIALES DE ACCESO' as TITULO,
    '' as SEPARADOR;

SELECT 
    username as USUARIO,
    CASE username
        WHEN 'admin' THEN 'admin123'
        WHEN 'jperez' THEN 'user123'
        WHEN 'ctecnico' THEN 'spec123'
        WHEN 'demo' THEN 'demo123'
        WHEN 'test' THEN 'test123'
        WHEN 'guest' THEN 'guest123'
        WHEN 'especialista' THEN 'user123'
        WHEN 'superadmin' THEN 'admin123'
    END as PASSWORD,
    CASE rol_id 
        WHEN 1 THEN '👑 ADMINISTRADOR'
        WHEN 2 THEN '🔧 ESPECIALISTA' 
        WHEN 3 THEN '👤 USUARIO'
        WHEN 4 THEN '👥 CLIENTE'
    END as ROL
FROM usuarios
ORDER BY rol_id, username;

-- Resumen final
SELECT 
    '📊 RESUMEN DE CREACIÓN' as TITULO,
    COUNT(*) as TOTAL_USUARIOS,
    SUM(CASE WHEN rol_id = 1 THEN 1 ELSE 0 END) as ADMINISTRADORES,
    SUM(CASE WHEN rol_id = 2 THEN 1 ELSE 0 END) as ESPECIALISTAS,
    SUM(CASE WHEN rol_id = 3 THEN 1 ELSE 0 END) as USUARIOS,
    SUM(CASE WHEN LENGTH(password) = 32 THEN 1 ELSE 0 END) as CON_MD5_VALIDO
FROM usuarios;

dsadasd