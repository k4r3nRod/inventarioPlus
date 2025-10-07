-- Crear la base de datos
CREATE DATABASE InventarioPlus;
USE InventarioPlus;

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
    rol_id INT,
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
