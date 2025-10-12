# 📚 DOCUMENTACIÓN TÉCNICA - INVENTARIO PLUS

## 📋 **INFORMACIÓN DEL PROYECTO**

- **Nombre:** InventarioPlus
- **Versión:** 0.0.1-SNAPSHOT
- **Framework:** Spring Boot 3.5.6
- **Java:** 17
- **Base de datos:** MySQL
- **Empaquetado:** WAR
- **Arquitectura:** MVC (Model-View-Controller)
- **Autenticación:** MD5 Hash
- **Frontend:** JSP + Bootstrap + JavaScript

---

## 🎯 **PROPÓSITO DEL SISTEMA**

InventarioPlus es un sistema de gestión de inventario diseñado para:
- **Controlar préstamos** de equipos
- **Gestionar usuarios** con diferentes roles
- **Autenticar** accesos con encriptación MD5
- **Administrar** equipos e inspecciones
- **Generar reportes** de actividad

---

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

### **Capas del Sistema:**

1. **Capa de Presentación:** JSP + CSS + JavaScript
2. **Capa de Control:** Spring Controllers
3. **Capa de Negocio:** Services
4. **Capa de Datos:** Repositories + JPA
5. **Capa de Persistencia:** MySQL Database

---

## 📁 **ESTRUCTURA DEL PROYECTO**

```
InventarioPlus/
├── src/
│   ├── main/
│   │   ├── java/com/example/InventarioPlus/
│   │   │   ├── InventarioPlusApplication.java      # 🚀 Aplicación principal
│   │   │   ├── config/                             # ⚙️ Configuración
│   │   │   │   ├── AuthInterceptor.java           # 🔒 Interceptor de seguridad
│   │   │   │   └── WebConfig.java                 # 🌐 Configuración MVC
│   │   │   ├── controller/                        # 🎮 Controladores
│   │   │   │   ├── DashboardController.java       # 📊 Panel principal
│   │   │   │   ├── HomeController.java            # 🏠 Página inicio
│   │   │   │   ├── LoginController.java           # 🔐 Autenticación
│   │   │   │   └── UsuarioController.java         # 👥 API usuarios
│   │   │   ├── model/                             # 📊 Modelos de datos
│   │   │   │   └── Usuario.java                   # 👤 Entidad usuario
│   │   │   ├── repository/                        # 🗃️ Acceso a datos
│   │   │   │   └── UsuarioRepository.java         # 📚 Repositorio usuarios
│   │   │   └── service/                           # ⚙️ Lógica de negocio
│   │   │       └── UsuarioService.java            # 🔧 Servicio usuarios
│   │   ├── resources/
│   │   │   ├── application.properties             # ⚙️ Configuración app
│   │   │   └── database/
│   │   │       └── schemaInventarioPlus.sql       # 🗄️ Schema DB
│   │   └── webapp/
│   │       ├── assets/                            # 🎨 Recursos estáticos
│   │       │   ├── css/                          # 🎨 Estilos
│   │       │   │   ├── estilosLayout.css
│   │       │   │   └── login.css
│   │       │   └── js/                           # ⚡ Scripts
│   │       │       └── layout.js
│   │       └── WEB-INF/views/layout/             # 🖼️ Vistas JSP
│   │           ├── dashboard-content.jsp          # 📊 Panel
│   │           └── login-standalone.jsp           # 🔐 Login
│   └── test/                                      # 🧪 Pruebas
├── target/                                        # 📦 Archivos compilados
├── pom.xml                                        # 📋 Configuración Maven
└── README.md                                      # 📖 Documentación básica
```

---

## 🔧 **COMPONENTES PRINCIPALES**

### **1. APLICACIÓN PRINCIPAL**

#### **`InventarioPlusApplication.java`**
```java
@SpringBootApplication
public class InventarioPlusApplication {
    public static void main(String[] args) {
        SpringApplication.run(InventarioPlusApplication.class, args);
    }
}
```

**📋 Responsabilidades:**
- Punto de entrada de la aplicación
- Inicialización automática de Spring Boot
- Auto-configuración de componentes
- Escaneo de anotaciones

---

### **2. CONFIGURACIÓN**

#### **`WebConfig.java`**
```java
@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {
    // Configuración de JSP y recursos
}
```

**📋 Responsabilidades:**
- Configuración de resolución de vistas JSP
- Registro de interceptores de seguridad
- Configuración de recursos estáticos
- Habilitación de Spring MVC

#### **`AuthInterceptor.java`**
```java
@Component
public class AuthInterceptor implements HandlerInterceptor {
    // Control de acceso y sesiones
}
```

**📋 Responsabilidades:**
- Interceptación de peticiones HTTP
- Validación de sesiones de usuario
- Redirección a login para páginas protegidas
- Control de acceso basado en roles

---

### **3. CONTROLADORES**

#### **`LoginController.java`**
```java
@Controller
public class LoginController {
    @GetMapping("/login")      // Muestra formulario
    @PostMapping("/login")     // Procesa login
    @PostMapping("/logout")    // Cierra sesión
}
```

**📋 Responsabilidades:**
- Presentación del formulario de login
- Validación de credenciales MD5
- Creación y gestión de sesiones
- Manejo de errores de autenticación

#### **`DashboardController.java`**
```java
@Controller
public class DashboardController {
    @GetMapping("/dashboard")  // Panel principal
}
```

**📋 Responsabilidades:**
- Carga del panel principal del usuario
- Presentación de información de sesión
- Acceso a funcionalidades del sistema
- Control de acceso por roles

#### **`HomeController.java`**
```java
@Controller
public class HomeController {
    @GetMapping("/")          // Página inicio
}
```

**📋 Responsabilidades:**
- Manejo de la página de inicio
- Redirección automática según estado de sesión
- Punto de entrada de la aplicación web

#### **`UsuarioController.java`**
```java
@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {
    @GetMapping            // Lista usuarios
    @PostMapping           // Crea usuario
    @PutMapping("/{id}")   // Actualiza usuario
    @DeleteMapping("/{id}") // Elimina usuario
}
```

**📋 Responsabilidades:**
- API REST para gestión de usuarios
- Operaciones CRUD completas
- Respuestas en formato JSON
- Validación de datos de entrada

---

### **4. MODELO DE DATOS**

#### **`Usuario.java`**
```java
@Entity
@Table(name = "usuarios")
public class Usuario {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_usuario;
    
    @Column(nullable = false, unique = true)
    private String username;
    
    @Column(nullable = false)
    private String password; // MD5 Hash
    
    // Métodos de encriptación MD5
    public static String encriptarMD5(String password) { ... }
}
```

**📋 Responsabilidades:**
- Representación de la entidad usuario en BD
- Mapeo objeto-relacional con JPA
- Encriptación MD5 de contraseñas
- Validaciones de datos
- Getters y Setters

**📊 Campos principales:**
- `id_usuario`: Identificador único (BIGINT)
- `nombre`, `apellido`: Datos personales
- `correo_electronico`: Email único
- `username`: Usuario único para login
- `password`: Hash MD5 de la contraseña
- `rol_id`: Referencia al rol del usuario
- `activo`: Estado del usuario (Boolean)
- `fecha_creacion`, `fecha_actualizacion`: Timestamps

---

### **5. REPOSITORIOS**

#### **`UsuarioRepository.java`**
```java
@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    Usuario findByUsername(String username);
    Usuario findByUsernameAndPassword(String username, String password);
    boolean existsByUsername(String username);
    boolean existsByCorreoElectronico(String email);
}
```

**📋 Responsabilidades:**
- Interfaz de acceso a datos de usuarios
- Métodos de consulta personalizados
- Operaciones CRUD automáticas de Spring Data
- Consultas por username y credenciales

---

### **6. SERVICIOS**

#### **`UsuarioService.java`**
```java
@Service
public class UsuarioService {
    public Usuario validarCredenciales(String username, String password) { ... }
    public Usuario agregarUsuario(Usuario usuario) { ... }
    public List<Usuario> obtenerTodosLosUsuarios() { ... }
    public Usuario obtenerUsuarioPorId(Long id) { ... }
}
```

**📋 Responsabilidades:**
- Lógica de negocio de usuarios
- Validación de credenciales con MD5
- Gestión completa de usuarios
- Reglas de negocio del sistema
- Intermediario entre controladores y repositorios

---

## 🔐 **SISTEMA DE AUTENTICACIÓN**

### **Proceso de Autenticación MD5:**

1. **Usuario ingresa credenciales** → Formulario login
2. **Password se encripta a MD5** → Cliente/Servidor
3. **Se compara con BD** → Hash almacenado
4. **Si coincide** → Sesión creada
5. **Redirección** → Dashboard

### **Algoritmo MD5 Implementado:**
```java
public static String encriptarMD5(String password) {
    try {
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] hashBytes = md.digest(password.getBytes("UTF-8"));
        StringBuilder sb = new StringBuilder();
        for (byte b : hashBytes) {
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    } catch (Exception e) {
        throw new RuntimeException("Error al encriptar password: " + e.getMessage());
    }
}
```

---

## 🗄️ **BASE DE DATOS**

### **Esquema Principal:**

#### **Tabla `usuarios`:**
```sql
CREATE TABLE usuarios (
    id_usuario BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,  -- Hash MD5 (32 caracteres)
    rol_id BIGINT NOT NULL DEFAULT 3,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (rol_id) REFERENCES Roles(id_rol)
);
```

#### **Tabla `Roles`:**
```sql
CREATE TABLE Roles (
    id_rol BIGINT PRIMARY KEY AUTO_INCREMENT,
    nombre_rol VARCHAR(100) NOT NULL,
    descripcion TEXT
);
```

### **Usuarios de Prueba Incluidos:**
| Usuario | Contraseña | Hash MD5 | Rol |
|---------|------------|----------|-----|
| `admin` | `admin123` | `0192023a7bbd73250516f069df18b500` | ADMINISTRADOR |
| `jperez` | `user123` | `6ad14ba9986e3615423dfca256d04e3f` | USUARIO |
| `ctecnico` | `spec123` | `5f35dc7f50c58d67c94f87d99de5b26e` | ESPECIALISTA |
| `demo` | `demo123` | `62cc2d8b4bf2d8728120d052163a77df` | USUARIO |

---

## 🎨 **FRONTEND**

### **Tecnologías Utilizadas:**
- **JSP** (JavaServer Pages)
- **Bootstrap 5.1.3** (Framework CSS)
- **FontAwesome 6.0.0** (Iconografía)
- **JavaScript Vanilla** (Validaciones)

### **Vistas Principales:**

#### **`login-standalone.jsp`**
- **Funcionalidad:** Formulario de autenticación
- **Características:**
  - Validación en tiempo real
  - Diseño responsive
  - Manejo de errores visuales
  - Encriptación MD5 en cliente

#### **`dashboard-content.jsp`**
- **Funcionalidad:** Panel principal del usuario
- **Características:**
  - Información de sesión
  - Menú de navegación
  - Controles de usuario
  - Logout funcional

### **Archivos CSS:**
- **`login.css`:** Estilos específicos del login
- **`estilosLayout.css`:** Estilos generales del sistema

### **JavaScript:**
- **`layout.js`:** Validaciones y funcionalidad interactiva

---

## ⚙️ **CONFIGURACIÓN**

### **`application.properties`**
```properties
# Configuración del servidor
server.port=8080

# Configuración de la base de datos MySQL
spring.datasource.url=jdbc:mysql://localhost:3306/inventario_plus?useSSL=false&serverTimezone=UTC
spring.datasource.username=root
spring.datasource.password=admin
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# Configuración de JPA/Hibernate
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.format_sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQLDialect

# Configuración de JSP
spring.mvc.view.prefix=/WEB-INF/views/layout/
spring.mvc.view.suffix=.jsp

# Configuración de DevTools
spring.devtools.restart.enabled=true
spring.devtools.livereload.enabled=true
```

### **`pom.xml` - Dependencias Principales:**
```xml
<dependencies>
    <!-- Spring Boot Starters -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
    
    <!-- Base de datos -->
    <dependency>
        <groupId>com.mysql</groupId>
        <artifactId>mysql-connector-j</artifactId>
        <scope>runtime</scope>
    </dependency>
    
    <!-- JSP Support -->
    <dependency>
        <groupId>org.apache.tomcat.embed</groupId>
        <artifactId>tomcat-embed-jasper</artifactId>
    </dependency>
    <dependency>
        <groupId>org.glassfish.web</groupId>
        <artifactId>jakarta.servlet.jsp.jstl</artifactId>
    </dependency>
    
    <!-- Development Tools -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-devtools</artifactId>
        <scope>runtime</scope>
        <optional>true</optional>
    </dependency>
</dependencies>
```

---

## 🔄 **FLUJO DE TRABAJO**

### **1. Inicio de Aplicación:**
```
InventarioPlusApplication.main()
    ↓
Spring Boot Auto-Configuration
    ↓
Escaneo de componentes (@Controller, @Service, @Repository)
    ↓
Configuración de DataSource y JPA
    ↓
Inicialización de Tomcat en puerto 8080
    ↓
Aplicación lista para recibir peticiones
```

### **2. Proceso de Login:**
```
Usuario accede a "/"
    ↓
HomeController → Verifica sesión
    ↓
Sin sesión → Redirect to "/login"
    ↓
LoginController.mostrarLogin() → login-standalone.jsp
    ↓
Usuario submite formulario
    ↓
LoginController.procesarLogin()
    ↓
UsuarioService.validarCredenciales()
    ↓
UsuarioRepository.findByUsernameAndPassword()
    ↓
Consulta MySQL con hash MD5
    ↓
Si válido → Crear sesión → Redirect "/dashboard"
    ↓
DashboardController.mostrarDashboard() → dashboard-content.jsp
```

### **3. Protección de Rutas:**
```
Petición HTTP a cualquier URL
    ↓
AuthInterceptor.preHandle()
    ↓
¿Ruta protegida? (no es /login, /css, /js)
    ↓
¿Existe sesión de usuario?
    ↓
No → Redirect "/login"
Sí → Continuar procesamiento
```

---

## 🛡️ **SEGURIDAD**

### **Medidas Implementadas:**

1. **Encriptación MD5:** Todas las contraseñas se almacenan hasheadas
2. **Control de Sesiones:** AuthInterceptor valida acceso a rutas protegidas
3. **Validación de Entrada:** Validaciones tanto en frontend como backend
4. **Rutas Protegidas:** Solo usuarios autenticados acceden al dashboard
5. **Logout Seguro:** Destrucción completa de sesiones

### **Consideraciones de Seguridad:**
- **MD5 es legacy:** Para producción considerar BCrypt o Argon2
- **HTTPS recomendado:** Para transmisión segura de credenciales
- **Validación CSRF:** Implementar para formularios críticos
- **Rate Limiting:** Limitar intentos de login por IP

---

## 🚀 **INSTALACIÓN Y EJECUCIÓN**

### **Prerrequisitos:**
- Java 17 o superior
- Maven 3.6+
- MySQL 8.0+
- IDE (IntelliJ IDEA, Eclipse, VSCode)

### **Pasos de Instalación:**

1. **Clonar el repositorio:**
```bash
git clone https://github.com/k4r3nRod/inventarioPlus.git
cd inventarioPlus/InitializrSpringbootProject
```

2. **Configurar base de datos:**
```sql
-- Ejecutar en MySQL Workbench
SOURCE src/main/resources/database/schemaInventarioPlus.sql;
```

3. **Configurar conexión:** 
   - Editar `application.properties`
   - Ajustar credenciales MySQL

4. **Compilar y ejecutar:**
```bash
mvn clean install
mvn spring-boot:run
```

5. **Acceder a la aplicación:**
   - URL: http://localhost:8080
   - Login: admin / admin123

---

## 🧪 **TESTING**

### **Pruebas Incluidas:**
- **`InventarioPlusApplicationTests.java`:** Test básico de contexto Spring

### **URLs de Testing:**
- **Health Check:** http://localhost:8080/actuator/health
- **API Usuarios:** http://localhost:8080/api/usuarios
- **Login directo:** http://localhost:8080/login

---

## 📈 **FUTURAS MEJORAS**

### **Funcionalidades Pendientes:**
1. **Gestión de Equipos:** CRUD completo de equipos
2. **Sistema de Préstamos:** Registro y control de préstamos
3. **Módulo de Inspecciones:** Inspecciones técnicas post-devolución
4. **Reportes:** Dashboard con estadísticas y reportes
5. **API REST completa:** Endpoints para integración externa

### **Mejoras Técnicas:**
1. **Migración a BCrypt:** Mejorar seguridad de passwords
2. **JWT Authentication:** Para APIs REST
3. **Documentación Swagger:** Auto-documentación de APIs
4. **Testing completo:** Unit tests y integration tests
5. **Docker:** Containerización de la aplicación

---

## 👥 **ROLES DEL SISTEMA**

### **Roles Definidos:**

1. **ADMINISTRADOR (id: 1)**
   - Acceso completo al sistema
   - Gestión de usuarios y roles
   - Configuración del sistema

2. **ESPECIALISTA (id: 2)**
   - Gestión de equipos e inspecciones
   - Aprobación de préstamos especiales
   - Reportes técnicos

3. **USUARIO (id: 3)**
   - Solicitud de préstamos
   - Consulta de historial propio
   - Funciones básicas

4. **CLIENTE (id: 4)**
   - Acceso limitado para clientes externos
   - Solo consulta de préstamos propios

---

## 🔍 **TROUBLESHOOTING**

### **Problemas Comunes:**

#### **Error de Conexión MySQL:**
```
Caused by: com.mysql.cj.jdbc.exceptions.CommunicationsException
```
**Solución:** Verificar que MySQL esté ejecutándose y credenciales correctas

#### **Puerto 8080 en uso:**
```
Web server failed to start. Port 8080 was already in use.
```
**Solución:** 
```bash
netstat -ano | findstr :8080
Stop-Process -Id [PID] -Force
```

#### **JSP no encontrada:**
```
HTTP Status 404 – Not Found
```
**Solución:** Verificar configuración de ViewResolver en WebConfig.java

---

## 📞 **SOPORTE Y CONTACTO**

- **Repositorio:** https://github.com/k4r3nRod/inventarioPlus
- **Rama actual:** karen_dev
- **Versión:** 0.0.1-SNAPSHOT
- **Última actualización:** 11 de octubre de 2025

---

## 📄 **LICENCIA**

Este proyecto está desarrollado como parte de un sistema de gestión de inventario.
Para uso educativo y empresarial.

---

**📝 Documentación generada automáticamente el 11 de octubre de 2025**