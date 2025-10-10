-- =========================================
-- ESQUEMA DE BASE DE DATOS: inventario_plus
-- Compatible con MySQL Workbench
-- =========================================

-- Crear la base de datos (ejecutar solo si no existe)
CREATE DATABASE IF NOT EXISTS inventario_plus
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE inventario_plus;

-- Tabla Roles
CREATE TABLE Roles (
    id_rol INT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- Tabla Usuarios
CREATE TABLE Usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    rol_id INT,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (rol_id) REFERENCES Roles(id_rol)
);

-- Tabla Equipos
CREATE TABLE Equipos (
    id_equipo INT PRIMARY KEY AUTO_INCREMENT,
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
    id_prestamo INT PRIMARY KEY AUTO_INCREMENT,
    fecha_prestamo DATETIME NOT NULL,
    fecha_devolucion_estimada DATETIME,
    fecha_devolucion_real DATETIME,
    id_usuario INT,
    id_equipo INT,
    estado_prestamo VARCHAR(50),
    condicion_al_prestar TEXT,
    condicion_al_devolver TEXT,
    observaciones TEXT,
    inspeccion_requerida VARCHAR(10),
    inspeccion_realizada VARCHAR(10),
    especialista_asignado_id INT,
    fecha_inspeccion_programada DATETIME,
    estado_inspeccion VARCHAR(50),
    observaciones_inspeccion TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_equipo) REFERENCES Equipos(id_equipo),
    FOREIGN KEY (especialista_asignado_id) REFERENCES Usuarios(id_usuario)
);

-- Tabla Devoluciones
CREATE TABLE Devoluciones (
    id_devolucion INT PRIMARY KEY AUTO_INCREMENT,
    id_prestamo INT,
    fecha_registro_devolucion DATETIME,
    fecha_devolucion_real DATETIME,
    condicion_al_devolver TEXT,
    observaciones TEXT,
    solicitar_inspeccion VARCHAR(10),
    especialista_asignado_id INT,
    fecha_inspeccion_programada DATETIME,
    inspeccion_realizada VARCHAR(10),
    estado_inspeccion VARCHAR(50),
    creado_por INT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_prestamo) REFERENCES Prestamos(id_prestamo),
    FOREIGN KEY (especialista_asignado_id) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (creado_por) REFERENCES Usuarios(id_usuario)
);

-- Tabla Inspecciones
CREATE TABLE Inspecciones (
    id_inspeccion INT PRIMARY KEY AUTO_INCREMENT,
    id_devolucion INT,
    id_prestamo INT,
    especialista_id INT,
    fecha_inspeccion DATETIME,
    resultado TEXT,
    observaciones TEXT,
    creado_por INT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_devolucion) REFERENCES Devoluciones(id_devolucion),
    FOREIGN KEY (id_prestamo) REFERENCES Prestamos(id_prestamo),
    FOREIGN KEY (especialista_id) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (creado_por) REFERENCES Usuarios(id_usuario)
);

-- =========================================
-- DATOS DE EJEMPLO
-- =========================================

-- Insertar roles de ejemplo
INSERT INTO Roles (nombre_rol, descripcion) VALUES 
('ADMINISTRADOR', 'Administrador del sistema con acceso completo'),
('ESPECIALISTA', 'Especialista técnico para inspecciones y mantenimiento'),
('USUARIO', 'Usuario regular con acceso limitado'),
('CLIENTE', 'Cliente externo que solicita préstamos de equipos');

-- Insertar usuarios de ejemplo (con nuevos campos)
INSERT INTO Usuarios (nombre, apellido, correo_electronico, telefono, username, password, rol_id, activo) VALUES 
('Admin', 'Sistema', 'admin@inventarioplus.com', '555-0001', 'admin', 'admin123', 1, TRUE),
('Carlos', 'Técnico', 'carlos.tecnico@empresa.com', '555-0002', 'ctecnico', 'spec123', 2, TRUE),
('Juan', 'Pérez', 'juan.perez@empresa.com', '555-0003', 'jperez', 'user123', 3, TRUE),
('María', 'González', 'maria.gonzalez@empresa.com', '555-0004', 'mgonzalez', 'user123', 3, TRUE),
('Luis', 'Cliente', 'luis.cliente@externo.com', '555-0005', 'lcliente', 'client123', 4, TRUE);
