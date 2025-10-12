# 📦 InventarioPlus - Sistema de Gestión de Inventario

Sistema completo de gestión de inventario desarrollado con **Spring Boot 3.5.6**, diseñado para administrar préstamos de equipos, control de usuarios y autenticación segura con **encriptación MD5**.

## 🚀 **CARACTERÍSTICAS PRINCIPALES**

- ✅ **Sistema de Autenticación MD5**: Login seguro con contraseñas hasheadas
- ✅ **Gestión Completa de Usuarios**: CRUD con roles y permisos
- ✅ **Control de Sesiones**: Interceptores de seguridad automáticos
- ✅ **API REST**: Endpoints completos para integración
- ✅ **Interfaz Responsiva**: JSP + Bootstrap + JavaScript
- ✅ **Base de Datos Optimizada**: MySQL con esquema completo
- ✅ **Arquitectura MVC**: Separación clara de responsabilidades

## 🛠️ **STACK TECNOLÓGICO**

| Componente | Tecnología | Versión |
|------------|------------|---------|
| **Backend** | Spring Boot | 3.5.6 |
| **Java** | OpenJDK | 17 |
| **Base de datos** | MySQL | 8.0+ |
| **ORM** | Spring Data JPA | 3.5.6 |
| **Frontend** | JSP + Bootstrap | 5.1.3 |
| **Build Tool** | Maven | 3.9+ |
| **Seguridad** | MD5 Hash + Sessions | Custom |
| **Servidor** | Tomcat Embedded | 10.1.46 |

## 📋 **PRERREQUISITOS**

- ☑️ **Java JDK 17** o superior
- ☑️ **MySQL 8.0+** con usuario y contraseña
- ☑️ **Maven 3.9+** para compilación
- ☑️ **IDE** recomendado (IntelliJ IDEA, VSCode, Eclipse)
- ☑️ **Git** para control de versiones

## 🔧 **INSTALACIÓN Y CONFIGURACIÓN**

### **1. Configurar Base de Datos MySQL**

#### **Opción A: Ejecutar Schema Completo**
```sql
-- En MySQL Workbench
SOURCE src/main/resources/database/schemaInventarioPlus.sql;
```

#### **Opción B: Configuración Manual**
```sql
-- 1. Crear base de datos
CREATE DATABASE inventario_plus CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. Usar base de datos
USE inventario_plus;

-- 3. Ejecutar el schema completo (incluye datos de prueba)
```

### **2. Configurar Credenciales**
Editar `src/main/resources/application.properties`:

```properties
# Configuración de Base de Datos MySQL
spring.datasource.url=jdbc:mysql://localhost:3306/inventario_plus?useSSL=false&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=TU_PASSWORD_MYSQL

# Configuración del Servidor
server.port=8080

# Configuración JPA/Hibernate
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

### **3. Compilar y Ejecutar**
```bash
# Compilar proyecto
mvn clean compile

# Ejecutar aplicación
mvn spring-boot:run
```

### **4. Acceder a la Aplicación**
🌐 **URL:** http://localhost:8080

## 👤 **USUARIOS DE PRUEBA INCLUIDOS**

| Usuario | Contraseña | Hash MD5 | Rol |
|---------|------------|----------|-----|
| `admin` | `admin123` | `0192023a7bbd73250516f069df18b500` | **ADMINISTRADOR** |
| `jperez` | `user123` | `6ad14ba9986e3615423dfca256d04e3f` | **USUARIO** |
| `ctecnico` | `spec123` | `5f35dc7f50c58d67c94f87d99de5b26e` | **ESPECIALISTA** |
| `demo` | `demo123` | `62cc2d8b4bf2d8728120d052163a77df` | **USUARIO** |
| `test` | `test123` | `cc03e747a6afbbcbf8be7668acfebee5` | **USUARIO** |
| `guest` | `guest123` | `fcf41657f02f88137a1bcf068a32c0a3` | **USUARIO** |
| `especialista` | `user123` | `6ad14ba9986e3615423dfca256d04e3f` | **ESPECIALISTA** |
| `superadmin` | `admin123` | `0192023a7bbd73250516f069df18b500` | **ADMINISTRADOR** |

## 📁 **ESTRUCTURA DEL PROYECTO LIMPIO**

```
InventarioPlus/
├── 📝 DOCUMENTACION_COMPLETA.md          # Documentación técnica completa
├── 📝 DOCUMENTACION_CLASES.md            # Documentación detallada de clases
├── 📝 README.md                          # Este archivo
├── 📝 README_CREACION_BD.md              # Guía de creación de BD
├── 🗄️ verificar_creacion_bd.sql          # Script de verificación
│
└── InitializrSpringbootProject/          # 🚀 Proyecto Spring Boot
    ├── 📄 pom.xml                        # Configuración Maven
    ├── 📄 application.properties         # Configuración app
    │
    ├── src/main/java/com/example/InventarioPlus/
    │   ├── 🚀 InventarioPlusApplication.java    # App principal
    │   │
    │   ├── 📁 config/
    │   │   ├── 🔒 AuthInterceptor.java         # Seguridad sesiones
    │   │   └── ⚙️ WebConfig.java               # Configuración MVC
    │   │
    │   ├── 📁 controller/
    │   │   ├── 🏠 HomeController.java          # Página inicio
    │   │   ├── 🔐 LoginController.java         # Autenticación
    │   │   ├── 📊 DashboardController.java     # Panel principal
    │   │   └── 👥 UsuarioController.java       # API REST usuarios
    │   │
    │   ├── 📁 model/
    │   │   └── 👤 Usuario.java                 # Entidad usuario + MD5
    │   │
    │   ├── 📁 repository/
    │   │   └── 🗃️ UsuarioRepository.java       # Acceso a datos
    │   │
    │   └── 📁 service/
    │       └── ⚙️ UsuarioService.java          # Lógica de negocio
    │
    ├── src/main/resources/
    │   ├── 📄 application.properties           # Configuración
    │   └── 📁 database/
    │       └── 🗄️ schemaInventarioPlus.sql     # Schema completo BD
    │
    └── src/main/webapp/
        ├── 📁 assets/
        │   ├── 📁 css/
        │   │   ├── 🎨 login.css               # Estilos login
        │   │   └── 🎨 estilosLayout.css       # Estilos generales
        │   └── 📁 js/
        │       └── ⚡ layout.js                # Scripts interactivos
        │
        └── 📁 WEB-INF/views/layout/
            ├── 🔐 login-standalone.jsp         # Vista login
            └── 📊 dashboard-content.jsp        # Vista panel
```

## 🏗️ **ARQUITECTURA DEL SISTEMA**

### **Patrón MVC Implementado:**

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│     MODELO      │    │      VISTA      │    │   CONTROLADOR   │
│                 │    │                 │    │                 │
│  Usuario.java   │◄──►│  *.jsp files    │◄──►│ *Controller.java│
│  Repository     │    │  CSS/JS files   │    │                 │
│  Service        │    │                 │    │                 │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### **Flujo de Autenticación:**

```
🌐 Usuario accede → HomeController → ¿Sesión existe?
                                        ↙        ↘
                                      Sí         No
                                      ↓          ↓
                               Dashboard    Login Form
                                            ↓
                              LoginController.procesarLogin()
                                            ↓
                              UsuarioService.validarCredenciales()
                                            ↓
                                    Encriptar MD5
                                            ↓
                              UsuarioRepository.findByUsernameAndPassword()
                                            ↓
                                   Consulta MySQL
                                      ↙        ↘
                                   Válido   Inválido
                                     ↓         ↓
                              Crear Sesión  Mostrar Error
                                     ↓
                             Redirect Dashboard
```

## 🔐 **SISTEMA DE SEGURIDAD**

### **Encriptación MD5:**
```java
public static String encriptarMD5(String password) {
    MessageDigest md = MessageDigest.getInstance("MD5");
    byte[] hashBytes = md.digest(password.getBytes("UTF-8"));
    StringBuilder sb = new StringBuilder();
    for (byte b : hashBytes) {
        sb.append(String.format("%02x", b));
    }
    return sb.toString(); // 32 caracteres hexadecimales
}
```

### **Protección de Rutas:**
- ✅ **Rutas Públicas:** `/login`, `/assets/**`, `/css/**`, `/js/**`
- 🔒 **Rutas Protegidas:** `/dashboard`, `/api/**` (requieren sesión)
- 🛡️ **Interceptor:** `AuthInterceptor` valida cada petición HTTP

## 📊 **BASE DE DATOS**

### **Schema Principal:**
- 🗂️ **usuarios**: Datos de usuarios con hash MD5
- 🗂️ **Roles**: Definición de roles del sistema
- 🗂️ **Equipos**: Catálogo de equipos (preparado para futuro)
- 🗂️ **Prestamos**: Sistema de préstamos (preparado para futuro)
- 🗂️ **Devoluciones**: Control de devoluciones (preparado para futuro)
- 🗂️ **Inspecciones**: Inspecciones técnicas (preparado para futuro)

### **Roles del Sistema:**
1. **ADMINISTRADOR (1)**: Acceso completo al sistema
2. **ESPECIALISTA (2)**: Gestión técnica y inspecciones
3. **USUARIO (3)**: Funciones básicas del sistema
4. **CLIENTE (4)**: Acceso limitado para externos

## 🌐 **API REST ENDPOINTS**

| Método | Endpoint | Descripción | Auth |
|--------|----------|-------------|------|
| `GET` | `/` | Página inicio | ❌ |
| `GET` | `/login` | Formulario login | ❌ |
| `POST` | `/login` | Procesar login | ❌ |
| `POST` | `/logout` | Cerrar sesión | ✅ |
| `GET` | `/dashboard` | Panel principal | ✅ |
| `GET` | `/api/usuarios` | Listar usuarios | ✅ |
| `GET` | `/api/usuarios/{id}` | Usuario por ID | ✅ |
| `POST` | `/api/usuarios` | Crear usuario | ✅ |
| `PUT` | `/api/usuarios/{id}` | Actualizar usuario | ✅ |
| `DELETE` | `/api/usuarios/{id}` | Eliminar usuario | ✅ |

## 🧪 **TESTING Y VALIDACIÓN**

### **URLs de Testing:**
```bash
# Health Check básico
curl http://localhost:8080/

# API de usuarios (requiere sesión)
curl -X GET http://localhost:8080/api/usuarios \
  -H "Cookie: JSESSIONID=YOUR_SESSION_ID"

# Test de login
curl -X POST http://localhost:8080/login \
  -d "username=admin&password=admin123"
```

### **Verificación de Base de Datos:**
```bash
# Ejecutar script de verificación
mysql -u root -p inventario_plus < verificar_creacion_bd.sql
```

## 🚀 **FUNCIONALIDADES ACTUALES**

### ✅ **Implementado y Funcional:**
- 🔐 **Sistema de Login MD5** completo
- 👥 **Gestión de Usuarios** (CRUD completo)
- 🛡️ **Control de Sesiones** automático
- 📊 **Panel Dashboard** funcional
- 🌐 **API REST** para usuarios
- 🎨 **Interfaz responsiva** con validaciones JavaScript
- 🗄️ **Base de datos** optimizada y documentada

### 🔄 **Preparado para Implementar:**
- 📦 **Gestión de Equipos** (esquema creado)
- 📋 **Sistema de Préstamos** (tablas preparadas)
- 🔍 **Módulo de Inspecciones** (estructura lista)
- 📊 **Reportes y Estadísticas** (base implementada)
- 🔔 **Sistema de Notificaciones** (arquitectura preparada)

## 📈 **ROADMAP FUTURO**

### **Fase 1 - Gestión de Equipos**
- [ ] CRUD completo de equipos
- [ ] Categorización y clasificación
- [ ] Control de stock y ubicación
- [ ] Carga masiva de equipos

### **Fase 2 - Sistema de Préstamos**
- [ ] Solicitud y aprobación de préstamos
- [ ] Control de fechas y devoluciones
- [ ] Historial completo de movimientos
- [ ] Notificaciones automáticas

### **Fase 3 - Inspecciones y Mantenimiento**
- [ ] Programación de inspecciones
- [ ] Registro de resultados técnicos
- [ ] Generación de reportes PDF
- [ ] Control de especialistas

### **Fase 4 - Mejoras Técnicas**
- [ ] Migración de MD5 a BCrypt
- [ ] Implementación de JWT
- [ ] API documentada con Swagger
- [ ] Testing automatizado completo
- [ ] Dockerización

## 🔧 **TROUBLESHOOTING**

### **Error: Puerto 8080 en uso**
```bash
# Windows
netstat -ano | findstr :8080
Stop-Process -Id [PID] -Force

# Linux/Mac
lsof -ti:8080 | xargs kill -9
```

### **Error: Conexión MySQL**
```bash
# Verificar servicio MySQL
# Windows: services.msc → MySQL80
# Linux: sudo systemctl status mysql

# Verificar credenciales en application.properties
```

### **Error: JSP no encontrada**
- Verificar configuración en `WebConfig.java`
- Confirmar estructura de directorios en `webapp/`

## 🤝 **CONTRIBUIR**

1. **Fork** el repositorio
2. **Crear rama** para funcionalidad: `git checkout -b feature/NuevaFuncionalidad`
3. **Commit** cambios: `git commit -m 'Agregar nueva funcionalidad'`
4. **Push** a la rama: `git push origin feature/NuevaFuncionalidad`
5. **Crear Pull Request**

## 📄 **DOCUMENTACIÓN ADICIONAL**

- 📚 **[Documentación Completa](DOCUMENTACION_COMPLETA.md)**: Guía técnica detallada
- 🏗️ **[Documentación de Clases](DOCUMENTACION_CLASES.md)**: Análisis de arquitectura
- 🗄️ **[Guía de Base de Datos](README_CREACION_BD.md)**: Setup de MySQL

## 📞 **CONTACTO Y SOPORTE**

- **Repositorio:** https://github.com/k4r3nRod/inventarioPlus
- **Rama Actual:** `karen_dev`
- **Versión:** 0.0.1-SNAPSHOT
- **Licencia:** MIT

## 📝 **CHANGELOG**

### **v0.0.1-SNAPSHOT** - 11 de octubre de 2025
- ✅ Implementación completa de autenticación MD5
- ✅ Sistema de usuarios con roles
- ✅ API REST funcional
- ✅ Interfaz web responsiva
- ✅ Base de datos optimizada
- ✅ Documentación completa
- ✅ Proyecto limpio y optimizado

---

**🚀 ¡Listo para usar y expandir!** - *Sistema completo de gestión de inventario con Spring Boot*