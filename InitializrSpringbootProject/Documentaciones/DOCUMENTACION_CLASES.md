# 📋 DOCUMENTACIÓN DE CLASES - INVENTARIO PLUS

## 🏗️ **ARQUITECTURA DE CLASES**

```
📦 com.example.InventarioPlus
├── 🚀 InventarioPlusApplication.java          # Punto de entrada
├── 📁 config/
│   ├── 🔒 AuthInterceptor.java               # Seguridad y sesiones
│   └── ⚙️ WebConfig.java                     # Configuración MVC
├── 📁 controller/
│   ├── 🏠 HomeController.java                # Página inicio
│   ├── 🔐 LoginController.java               # Autenticación
│   ├── 📊 DashboardController.java           # Panel principal
│   └── 👥 UsuarioController.java             # API REST usuarios
├── 📁 model/
│   └── 👤 Usuario.java                       # Entidad de datos
├── 📁 repository/
│   └── 🗃️ UsuarioRepository.java             # Acceso a datos
└── 📁 service/
    └── ⚙️ UsuarioService.java                # Lógica de negocio
```

---

## 🚀 **CLASE PRINCIPAL**

### **`InventarioPlusApplication.java`**

```java
package com.example.InventarioPlus;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class InventarioPlusApplication {
    public static void main(String[] args) {
        SpringApplication.run(InventarioPlusApplication.class, args);
    }
}
```

#### **📋 Análisis Detallado:**

**🎯 Propósito:**
- **Bootstrapping** de la aplicación Spring Boot
- **Auto-configuración** de todos los componentes
- **Punto de entrada único** del sistema

**🏷️ Anotaciones:**
- `@SpringBootApplication`: Combina `@Configuration`, `@EnableAutoConfiguration`, `@ComponentScan`

**⚙️ Funcionalidades:**
- Escaneo automático de componentes en el package `com.example.InventarioPlus`
- Configuración automática de DataSource, JPA, MVC, etc.
- Inicialización de servidor Tomcat embebido

**🔄 Flujo de Ejecución:**
1. JVM ejecuta `main()`
2. `SpringApplication.run()` inicia el contexto Spring
3. Auto-configuración basada en classpath y properties
4. Inicialización de beans y dependencias
5. Servidor web listo en puerto 8080

---

## ⚙️ **CONFIGURACIÓN**

### **`WebConfig.java`**

```java
package com.example.InventarioPlus.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@EnableWebMvc
public class WebConfig implements WebMvcConfigurer {
    
    @Autowired
    private AuthInterceptor authInterceptor;
    
    @Override
    public void configureViewResolvers(ViewResolverRegistry registry) {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/layout/");
        resolver.setSuffix(".jsp");
        registry.viewResolver(resolver);
    }
    
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/assets/**")
                .addResourceLocations("/assets/");
    }
    
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(authInterceptor);
    }
}
```

#### **📋 Análisis Detallado:**

**🎯 Propósito:**
- **Configuración personalizada** de Spring MVC
- **Resolución de vistas JSP**
- **Registro de interceptores** de seguridad
- **Mapeo de recursos estáticos**

**🏷️ Anotaciones:**
- `@Configuration`: Indica clase de configuración
- `@EnableWebMvc`: Habilita configuración avanzada de MVC
- `@Autowired`: Inyección de dependencias

**⚙️ Métodos Importantes:**

1. **`configureViewResolvers()`:**
   - Configura prefijo: `/WEB-INF/views/layout/`
   - Configura sufijo: `.jsp`
   - Resultado: `login` → `/WEB-INF/views/layout/login.jsp`

2. **`addResourceHandlers()`:**
   - Mapea `/assets/**` → `/assets/` físico
   - Permite acceso a CSS, JS, imágenes
   - Ejemplo: `/assets/css/login.css`

3. **`addInterceptors()`:**
   - Registra `AuthInterceptor` globalmente
   - Se ejecuta antes de cada petición HTTP
   - Control de acceso automático

**🔗 Dependencias:**
- `AuthInterceptor`: Inyectado para control de sesiones
- Spring MVC: Framework base para configuración

---

### **`AuthInterceptor.java`**

```java
package com.example.InventarioPlus.config;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class AuthInterceptor implements HandlerInterceptor {
    
    @Override
    public boolean preHandle(HttpServletRequest request, 
                           HttpServletResponse response, 
                           Object handler) throws Exception {
        
        String requestURI = request.getRequestURI();
        
        // Permitir acceso a recursos estáticos y login
        if (requestURI.startsWith("/assets/") || 
            requestURI.equals("/login") || 
            requestURI.equals("/") ||
            requestURI.startsWith("/css/") ||
            requestURI.startsWith("/js/")) {
            return true;
        }
        
        // Verificar sesión para rutas protegidas
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuario") != null) {
            return true; // Usuario autenticado
        }
        
        // Redirigir a login si no está autenticado
        response.sendRedirect("/login");
        return false;
    }
}
```

#### **📋 Análisis Detallado:**

**🎯 Propósito:**
- **Control de acceso** a rutas protegidas
- **Validación de sesiones** de usuario
- **Redirección automática** a login

**🏷️ Anotaciones:**
- `@Component`: Registra como bean de Spring
- `HandlerInterceptor`: Interface para interceptar peticiones

**⚙️ Lógica de Seguridad:**

1. **Rutas Públicas:**
   - `/assets/**`: Recursos estáticos
   - `/login`: Página de login
   - `/`: Página de inicio
   - `/css/**`, `/js/**`: Archivos de estilo y scripts

2. **Rutas Protegidas:**
   - `/dashboard`: Panel principal
   - `/api/**`: APIs REST
   - Cualquier otra ruta no pública

3. **Validación de Sesión:**
   - Obtiene sesión HTTP actual
   - Verifica existencia del atributo `usuario`
   - Si no existe → Redirect a `/login`
   - Si existe → Permite continuar

**🔄 Flujo de Ejecución:**
```
Petición HTTP → AuthInterceptor.preHandle()
                      ↓
              ¿Es ruta pública?
                   ↙        ↘
                 Sí         No
                 ↓          ↓
            Permitir   ¿Hay sesión?
                        ↙        ↘
                      Sí         No
                      ↓          ↓
                 Permitir   Redirect /login
```

---

## 🎮 **CONTROLADORES**

### **`HomeController.java`**

```java
package com.example.InventarioPlus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import jakarta.servlet.http.HttpSession;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(HttpSession session) {
        // Si ya hay sesión activa, ir al dashboard
        if (session.getAttribute("usuario") != null) {
            return "redirect:/dashboard";
        }
        // Si no hay sesión, ir al login
        return "redirect:/login";
    }
}
```

#### **📋 Análisis Detallado:**

**🎯 Propósito:**
- **Punto de entrada** de la aplicación web
- **Router inteligente** basado en estado de sesión
- **Redirección automática** a la página apropiada

**🏷️ Anotaciones:**
- `@Controller`: Marca como controlador MVC
- `@GetMapping("/")`: Maneja peticiones GET a la raíz

**⚙️ Lógica de Redirección:**
1. Recibe petición a "/"
2. Verifica existencia de sesión
3. Con sesión → `/dashboard`
4. Sin sesión → `/login`

**📊 Parámetros:**
- `HttpSession session`: Sesión HTTP actual

**🔄 Casos de Uso:**
- Usuario accede por primera vez → Login
- Usuario con sesión activa → Dashboard
- Usuario después de logout → Login

---

### **`LoginController.java`**

```java
package com.example.InventarioPlus.controller;

import com.example.InventarioPlus.model.Usuario;
import com.example.InventarioPlus.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;

@Controller
public class LoginController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/login")
    public String mostrarLogin(HttpSession session) {
        // Si ya está logueado, redirigir al dashboard
        if (session.getAttribute("usuario") != null) {
            return "redirect:/dashboard";
        }
        return "login-standalone";
    }

    @PostMapping("/login")
    public String procesarLogin(@RequestParam String username,
                              @RequestParam String password,
                              HttpSession session,
                              Model model) {
        try {
            // Encriptar password con MD5
            String passwordMD5 = Usuario.encriptarMD5(password);
            
            // Validar credenciales
            Usuario usuario = usuarioService.validarCredenciales(username, passwordMD5);
            
            if (usuario != null) {
                // Login exitoso - crear sesión
                session.setAttribute("usuario", usuario);
                session.setAttribute("nombreUsuario", usuario.getNombre());
                session.setAttribute("rolUsuario", usuario.getRol_id());
                return "redirect:/dashboard";
            } else {
                // Credenciales inválidas
                model.addAttribute("error", "Usuario o contraseña incorrectos");
                return "login-standalone";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Error en el sistema: " + e.getMessage());
            return "login-standalone";
        }
    }

    @PostMapping("/logout")
    public String logout(HttpSession session) {
        // Destruir sesión completamente
        session.invalidate();
        return "redirect:/login?logout=true";
    }
}
```

#### **📋 Análisis Detallado:**

**🎯 Propósito:**
- **Gestión completa de autenticación**
- **Procesamiento de formularios de login**
- **Gestión de sesiones de usuario**
- **Control de logout seguro**

**🏷️ Anotaciones:**
- `@Controller`: Controlador MVC
- `@Autowired`: Inyección de UsuarioService
- `@GetMapping("/login")`: Muestra formulario
- `@PostMapping("/login")`: Procesa login
- `@PostMapping("/logout")`: Cierra sesión

**⚙️ Métodos Principales:**

1. **`mostrarLogin()`:**
   - Verifica si ya hay sesión activa
   - Con sesión → Dashboard
   - Sin sesión → Formulario login

2. **`procesarLogin()`:**
   - Recibe username y password
   - Encripta password con MD5
   - Valida contra base de datos
   - Crea sesión si es válido
   - Muestra error si no es válido

3. **`logout()`:**
   - Invalida sesión completamente
   - Redirige a login con confirmación

**📊 Parámetros de Login:**
- `username`: Nombre de usuario
- `password`: Contraseña en texto plano
- `session`: Sesión HTTP para crear/destruir
- `model`: Para pasar datos a la vista

**🔐 Proceso de Autenticación:**
```
1. Usuario envía formulario
2. Password → MD5 hash
3. Consulta BD con username + hash
4. Si válido → Crear sesión
5. Sesión contiene:
   - usuario: Objeto Usuario completo
   - nombreUsuario: Nombre para mostrar
   - rolUsuario: ID del rol para permisos
```

**⚠️ Manejo de Errores:**
- Credenciales incorrectas
- Errores de sistema
- Usuario inactivo
- Problemas de conexión BD

---

### **`DashboardController.java`**

```java
package com.example.InventarioPlus.controller;

import com.example.InventarioPlus.model.Usuario;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import jakarta.servlet.http.HttpSession;

@Controller
public class DashboardController {

    @GetMapping("/dashboard")
    public String mostrarDashboard(HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        
        if (usuario != null) {
            // Pasar información del usuario a la vista
            model.addAttribute("usuario", usuario);
            model.addAttribute("nombreCompleto", 
                usuario.getNombre() + " " + usuario.getApellido());
            model.addAttribute("rolNombre", obtenerNombreRol(usuario.getRol_id()));
            
            return "dashboard-content";
        }
        
        // Si no hay sesión, redirigir al login
        return "redirect:/login";
    }
    
    private String obtenerNombreRol(Long rolId) {
        switch (rolId.intValue()) {
            case 1: return "ADMINISTRADOR";
            case 2: return "ESPECIALISTA";
            case 3: return "USUARIO";
            case 4: return "CLIENTE";
            default: return "DESCONOCIDO";
        }
    }
}
```

#### **📋 Análisis Detallado:**

**🎯 Propósito:**
- **Panel principal** del usuario autenticado
- **Presentación de información** de sesión
- **Base para navegación** del sistema
- **Control de acceso** por roles

**🏷️ Anotaciones:**
- `@Controller`: Controlador MVC
- `@GetMapping("/dashboard")`: Maneja GET a dashboard

**⚙️ Funcionalidades:**

1. **Validación de Sesión:**
   - Obtiene usuario de la sesión
   - Si no existe → Redirect login
   - Si existe → Muestra dashboard

2. **Preparación de Datos:**
   - `usuario`: Objeto completo del usuario
   - `nombreCompleto`: Concatenación nombre + apellido
   - `rolNombre`: Nombre legible del rol

3. **Control de Roles:**
   - Mapea ID numérico a nombre descriptivo
   - Base para futura implementación de permisos

**📊 Datos Enviados a Vista:**
```java
Model {
    "usuario": Usuario object,
    "nombreCompleto": "Juan Pérez",
    "rolNombre": "ADMINISTRADOR"
}
```

**🔄 Flujo de Renderizado:**
```
GET /dashboard → DashboardController
                       ↓
                Verificar sesión
                       ↓
              Preparar datos del usuario
                       ↓
              Enviar a dashboard-content.jsp
```

---

### **`UsuarioController.java`**

```java
package com.example.InventarioPlus.controller;

import com.example.InventarioPlus.model.Usuario;
import com.example.InventarioPlus.service.UsuarioService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/usuarios")
public class UsuarioController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping
    public ResponseEntity<List<Usuario>> obtenerTodosLosUsuarios() {
        List<Usuario> usuarios = usuarioService.obtenerTodosLosUsuarios();
        return ResponseEntity.ok(usuarios);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Usuario> obtenerUsuarioPorId(@PathVariable Long id) {
        Usuario usuario = usuarioService.obtenerUsuarioPorId(id);
        if (usuario != null) {
            return ResponseEntity.ok(usuario);
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping
    public ResponseEntity<String> crearUsuario(@RequestBody UsuarioRequest request) {
        try {
            Usuario usuario = new Usuario();
            usuario.setNombre(request.getNombre());
            usuario.setApellido(request.getApellido());
            usuario.setCorreo_electronico(request.getCorreo_electronico());
            usuario.setTelefono(request.getTelefono());
            usuario.setUsername(request.getUsername());
            usuario.setPassword(Usuario.encriptarMD5(request.getPassword()));
            usuario.setRol_id(request.getRol_id());
            usuario.setActivo(true);

            Usuario usuarioGuardado = usuarioService.agregarUsuario(usuario);
            return ResponseEntity.ok("Usuario creado exitosamente con ID: " + 
                usuarioGuardado.getId_usuario());
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                .body("Error al crear usuario: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<String> actualizarUsuario(@PathVariable Long id, 
                                                   @RequestBody UsuarioRequest request) {
        try {
            Usuario usuarioExistente = usuarioService.obtenerUsuarioPorId(id);
            if (usuarioExistente == null) {
                return ResponseEntity.notFound().build();
            }

            // Actualizar campos
            usuarioExistente.setNombre(request.getNombre());
            usuarioExistente.setApellido(request.getApellido());
            usuarioExistente.setCorreo_electronico(request.getCorreo_electronico());
            usuarioExistente.setTelefono(request.getTelefono());
            
            // Solo actualizar password si se proporciona
            if (request.getPassword() != null && !request.getPassword().isEmpty()) {
                usuarioExistente.setPassword(Usuario.encriptarMD5(request.getPassword()));
            }

            Usuario usuarioActualizado = usuarioService.agregarUsuario(usuarioExistente);
            return ResponseEntity.ok("Usuario actualizado exitosamente");
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                .body("Error al actualizar usuario: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> eliminarUsuario(@PathVariable Long id) {
        try {
            Usuario usuario = usuarioService.obtenerUsuarioPorId(id);
            if (usuario == null) {
                return ResponseEntity.notFound().build();
            }

            // Soft delete - marcar como inactivo
            usuario.setActivo(false);
            usuarioService.agregarUsuario(usuario);
            
            return ResponseEntity.ok("Usuario desactivado exitosamente");
        } catch (Exception e) {
            return ResponseEntity.badRequest()
                .body("Error al eliminar usuario: " + e.getMessage());
        }
    }

    // Clase interna para requests
    public static class UsuarioRequest {
        private String nombre;
        private String apellido;
        private String correo_electronico;
        private String telefono;
        private String username;
        private String password;
        private Long rol_id;

        // Getters y Setters
        // ... (código completo con todos los getters/setters)
    }
}
```

#### **📋 Análisis Detallado:**

**🎯 Propósito:**
- **API REST completa** para gestión de usuarios
- **Operaciones CRUD** (Create, Read, Update, Delete)
- **Respuestas JSON** para integración con frontend
- **Validación y manejo de errores**

**🏷️ Anotaciones:**
- `@RestController`: Controlador que retorna JSON
- `@RequestMapping("/api/usuarios")`: Base path para API
- `@GetMapping`, `@PostMapping`, etc.: Mapeo HTTP methods
- `@PathVariable`: Variables de URL
- `@RequestBody`: Cuerpo de petición JSON

**⚙️ Endpoints Disponibles:**

1. **GET /api/usuarios**
   - Lista todos los usuarios
   - Respuesta: Array JSON de usuarios

2. **GET /api/usuarios/{id}**
   - Obtiene usuario específico por ID
   - Respuesta: Objeto JSON del usuario

3. **POST /api/usuarios**
   - Crea nuevo usuario
   - Body: JSON con datos del usuario
   - Encripta password automáticamente

4. **PUT /api/usuarios/{id}**
   - Actualiza usuario existente
   - Preserva password si no se envía nuevo

5. **DELETE /api/usuarios/{id}**
   - Soft delete (marca como inactivo)
   - No elimina físicamente el registro

**📊 Estructura UsuarioRequest:**
```json
{
    "nombre": "Juan",
    "apellido": "Pérez",
    "correo_electronico": "juan@ejemplo.com",
    "telefono": "555-1234",
    "username": "jperez",
    "password": "password123",
    "rol_id": 3
}
```

**🔐 Seguridad:**
- Encriptación automática de passwords
- Validación de existencia antes de operaciones
- Soft delete para preservar integridad referencial

**⚠️ Manejo de Errores:**
- 404 Not Found: Usuario no existe
- 400 Bad Request: Error en datos o procesamiento
- 200 OK: Operación exitosa

---

## 📊 **MODELO DE DATOS**

### **`Usuario.java`**

```java
package com.example.InventarioPlus.model;

import jakarta.persistence.*;
import java.security.MessageDigest;
import java.time.LocalDateTime;

@Entity
@Table(name = "usuarios")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id_usuario;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(nullable = false, length = 100)
    private String apellido;

    @Column(nullable = false, unique = true, length = 150)
    private String correo_electronico;

    @Column(length = 20)
    private String telefono;

    @Column(nullable = false, unique = true, length = 50)
    private String username;

    @Column(nullable = false, length = 255)
    private String password; // Hash MD5

    @Column(nullable = false)
    private Long rol_id = 3L; // Default: USUARIO

    @Column(nullable = false)
    private Boolean activo = true;

    @Column(name = "fecha_creacion", updatable = false)
    private LocalDateTime fechaCreacion;

    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualizacion;

    // Constructor vacío requerido por JPA
    public Usuario() {}

    // Constructor completo
    public Usuario(String nombre, String apellido, String correo_electronico, 
                   String username, String password, Long rol_id) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.correo_electronico = correo_electronico;
        this.username = username;
        this.password = password;
        this.rol_id = rol_id;
        this.activo = true;
    }

    // Método de encriptación MD5
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

    // Métodos de ciclo de vida JPA
    @PrePersist
    protected void onCreate() {
        fechaCreacion = LocalDateTime.now();
        fechaActualizacion = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        fechaActualizacion = LocalDateTime.now();
    }

    // Getters y Setters completos
    public Long getId_usuario() { return id_usuario; }
    public void setId_usuario(Long id_usuario) { this.id_usuario = id_usuario; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getApellido() { return apellido; }
    public void setApellido(String apellido) { this.apellido = apellido; }

    // ... (todos los getters/setters)

    @Override
    public String toString() {
        return "Usuario{" +
                "id_usuario=" + id_usuario +
                ", nombre='" + nombre + '\'' +
                ", apellido='" + apellido + '\'' +
                ", username='" + username + '\'' +
                ", rol_id=" + rol_id +
                ", activo=" + activo +
                '}';
    }
}
```

#### **📋 Análisis Detallado:**

**🎯 Propósito:**
- **Entidad principal** del sistema de usuarios
- **Mapeo objeto-relacional** con JPA
- **Encriptación MD5** integrada
- **Auditoría automática** de fechas

**🏷️ Anotaciones JPA:**

- `@Entity`: Marca como entidad de base de datos
- `@Table(name = "usuarios")`: Especifica nombre de tabla
- `@Id`: Campo clave primaria
- `@GeneratedValue`: Auto-increment de ID
- `@Column`: Configuración de columnas
- `@PrePersist`, `@PreUpdate`: Callbacks de ciclo de vida

**📊 Campos Principales:**

1. **Identificación:**
   - `id_usuario`: BIGINT AUTO_INCREMENT
   - `username`: VARCHAR(50) UNIQUE
   - `correo_electronico`: VARCHAR(150) UNIQUE

2. **Datos Personales:**
   - `nombre`: VARCHAR(100) NOT NULL
   - `apellido`: VARCHAR(100) NOT NULL
   - `telefono`: VARCHAR(20) NULL

3. **Seguridad:**
   - `password`: VARCHAR(255) - Hash MD5
   - `rol_id`: BIGINT - Referencia a roles
   - `activo`: BOOLEAN - Estado del usuario

4. **Auditoría:**
   - `fechaCreacion`: DATETIME - Creación automática
   - `fechaActualizacion`: DATETIME - Actualización automática

**🔐 Método de Encriptación:**

```java
public static String encriptarMD5(String password) {
    // 1. Obtener instancia MessageDigest MD5
    // 2. Convertir password a bytes UTF-8
    // 3. Generar hash MD5
    // 4. Convertir a hexadecimal
    // 5. Retornar string de 32 caracteres
}
```

**⏰ Ciclo de Vida:**
- `@PrePersist`: Se ejecuta antes de INSERT
- `@PreUpdate`: Se ejecuta antes de UPDATE
- Timestamps automáticos sin intervención manual

**🔄 Constructores:**
1. **Vacío:** Requerido por JPA para reflection
2. **Completo:** Para creación programática de usuarios

---

## 🗃️ **REPOSITORIO**

### **`UsuarioRepository.java`**

```java
package com.example.InventarioPlus.repository;

import com.example.InventarioPlus.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {
    
    // Método de consulta derivado
    Usuario findByUsername(String username);
    
    // Método para validación de credenciales
    Usuario findByUsernameAndPassword(String username, String password);
    
    // Verificación de existencia
    boolean existsByUsername(String username);
    boolean existsByCorreoElectronico(String correoElectronico);
    
    // Consulta personalizada con @Query
    @Query("SELECT u FROM Usuario u WHERE u.activo = true")
    List<Usuario> findUsuariosActivos();
    
    // Consulta nativa SQL
    @Query(value = "SELECT COUNT(*) FROM usuarios WHERE rol_id = :rolId", 
           nativeQuery = true)
    long contarUsuariosPorRol(@Param("rolId") Long rolId);
    
    // Consulta por múltiples campos
    List<Usuario> findByActivoAndRol_id(Boolean activo, Long rolId);
}
```

#### **📋 Análisis Detallado:**

**🎯 Propósito:**
- **Interfaz de acceso a datos** para Usuario
- **Abstracción de operaciones SQL**
- **Consultas automáticas y personalizadas**
- **Integración con Spring Data JPA**

**🏷️ Anotaciones:**
- `@Repository`: Marca como componente de repositorio
- `@Query`: Define consultas personalizadas
- `@Param`: Mapea parámetros de consulta

**⚙️ Métodos Heredados de JpaRepository:**

```java
// CRUD básico automático:
Usuario save(Usuario usuario);              // INSERT/UPDATE
Optional<Usuario> findById(Long id);        // SELECT por ID
List<Usuario> findAll();                    // SELECT todos
void deleteById(Long id);                   // DELETE por ID
long count();                               // COUNT total
boolean existsById(Long id);                // EXISTS por ID
```

**🔍 Consultas Derivadas:**

Spring Data genera SQL automáticamente basado en nombres de métodos:

```java
findByUsername(String username)
// → SELECT * FROM usuarios WHERE username = ?

existsByUsername(String username)  
// → SELECT COUNT(*) > 0 FROM usuarios WHERE username = ?

findByActivoAndRol_id(Boolean activo, Long rolId)
// → SELECT * FROM usuarios WHERE activo = ? AND rol_id = ?
```

**📝 Consultas Personalizadas:**

1. **JPQL (Java Persistence Query Language):**
```java
@Query("SELECT u FROM Usuario u WHERE u.activo = true")
// Consulta orientada a objetos usando entidades
```

2. **SQL Nativo:**
```java
@Query(value = "SELECT COUNT(*) FROM usuarios WHERE rol_id = :rolId", 
       nativeQuery = true)
// SQL directo contra la base de datos
```

**🔗 Integración con Service:**
```java
@Service
public class UsuarioService {
    @Autowired
    private UsuarioRepository usuarioRepository;
    
    public Usuario validarCredenciales(String username, String password) {
        return usuarioRepository.findByUsernameAndPassword(username, password);
    }
}
```

---

## ⚙️ **SERVICIO**

### **`UsuarioService.java`**

```java
package com.example.InventarioPlus.service;

import com.example.InventarioPlus.model.Usuario;
import com.example.InventarioPlus.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.util.List;
import java.util.Optional;

@Service
public class UsuarioService {
    
    @Autowired
    private UsuarioRepository usuarioRepository;
    
    /**
     * Inicialización de usuarios por defecto
     * Se ejecuta después de la construcción del bean
     */
    @PostConstruct
    public void initializeUsers() {
        System.out.println("✅ Los usuarios ya están configurados en la base de datos");
        // Comentado porque los usuarios se crean desde el schema SQL
        /*
        if (!usuarioRepository.existsByUsername("admin")) {
            Usuario admin = new Usuario("Administrador", "del Sistema", 
                "admin@inventarioplus.com", "admin", 
                Usuario.encriptarMD5("admin123"), 1L);
            usuarioRepository.save(admin);
        }
        */
    }
    
    /**
     * Valida las credenciales de un usuario
     * @param username Nombre de usuario
     * @param passwordMD5 Contraseña ya encriptada en MD5
     * @return Usuario si las credenciales son válidas, null en caso contrario
     */
    public Usuario validarCredenciales(String username, String passwordMD5) {
        try {
            Usuario usuario = usuarioRepository.findByUsernameAndPassword(username, passwordMD5);
            
            // Verificar que el usuario esté activo
            if (usuario != null && usuario.getActivo()) {
                System.out.println("✅ Login exitoso para usuario: " + username);
                return usuario;
            } else if (usuario != null && !usuario.getActivo()) {
                System.out.println("⚠️ Usuario inactivo: " + username);
                return null;
            } else {
                System.out.println("❌ Credenciales incorrectas para: " + username);
                return null;
            }
        } catch (Exception e) {
            System.err.println("❌ Error al validar credenciales: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Agrega un nuevo usuario al sistema
     * @param usuario Usuario a agregar
     * @return Usuario guardado
     */
    public Usuario agregarUsuario(Usuario usuario) {
        try {
            // Validar datos requeridos
            if (usuario.getUsername() == null || usuario.getUsername().trim().isEmpty()) {
                throw new IllegalArgumentException("El username es requerido");
            }
            
            if (usuario.getPassword() == null || usuario.getPassword().trim().isEmpty()) {
                throw new IllegalArgumentException("La contraseña es requerida");
            }
            
            // Verificar unicidad de username
            if (usuario.getId_usuario() == null && 
                usuarioRepository.existsByUsername(usuario.getUsername())) {
                throw new IllegalArgumentException("El username ya existe: " + usuario.getUsername());
            }
            
            // Verificar unicidad de email
            if (usuario.getId_usuario() == null && 
                usuarioRepository.existsByCorreoElectronico(usuario.getCorreo_electronico())) {
                throw new IllegalArgumentException("El email ya existe: " + usuario.getCorreo_electronico());
            }
            
            // Establecer valores por defecto
            if (usuario.getRol_id() == null) {
                usuario.setRol_id(3L); // Usuario por defecto
            }
            
            if (usuario.getActivo() == null) {
                usuario.setActivo(true);
            }
            
            Usuario usuarioGuardado = usuarioRepository.save(usuario);
            System.out.println("✅ Usuario guardado: " + usuarioGuardado.getUsername());
            return usuarioGuardado;
            
        } catch (Exception e) {
            System.err.println("❌ Error al agregar usuario: " + e.getMessage());
            throw e;
        }
    }
    
    /**
     * Obtiene todos los usuarios del sistema
     * @return Lista de todos los usuarios
     */
    public List<Usuario> obtenerTodosLosUsuarios() {
        return usuarioRepository.findAll();
    }
    
    /**
     * Obtiene un usuario por su ID
     * @param id ID del usuario
     * @return Usuario encontrado o null si no existe
     */
    public Usuario obtenerUsuarioPorId(Long id) {
        Optional<Usuario> usuario = usuarioRepository.findById(id);
        return usuario.orElse(null);
    }
    
    /**
     * Obtiene un usuario por su username
     * @param username Nombre de usuario
     * @return Usuario encontrado o null si no existe
     */
    public Usuario obtenerUsuarioPorUsername(String username) {
        return usuarioRepository.findByUsername(username);
    }
    
    /**
     * Verifica si existe un username
     * @param username Username a verificar
     * @return true si existe, false en caso contrario
     */
    public boolean existeUsername(String username) {
        return usuarioRepository.existsByUsername(username);
    }
    
    /**
     * Desactiva un usuario (soft delete)
     * @param id ID del usuario a desactivar
     * @return true si se desactivó correctamente
     */
    public boolean desactivarUsuario(Long id) {
        try {
            Usuario usuario = obtenerUsuarioPorId(id);
            if (usuario != null) {
                usuario.setActivo(false);
                usuarioRepository.save(usuario);
                System.out.println("✅ Usuario desactivado: " + usuario.getUsername());
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("❌ Error al desactivar usuario: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Activa un usuario
     * @param id ID del usuario a activar
     * @return true si se activó correctamente
     */
    public boolean activarUsuario(Long id) {
        try {
            Usuario usuario = obtenerUsuarioPorId(id);
            if (usuario != null) {
                usuario.setActivo(true);
                usuarioRepository.save(usuario);
                System.out.println("✅ Usuario activado: " + usuario.getUsername());
                return true;
            }
            return false;
        } catch (Exception e) {
            System.err.println("❌ Error al activar usuario: " + e.getMessage());
            return false;
        }
    }
}
```

#### **📋 Análisis Detallado:**

**🎯 Propósito:**
- **Capa de lógica de negocio** para usuarios
- **Validación de reglas de negocio**
- **Intermediario** entre controladores y repositorio
- **Manejo de errores** y logging

**🏷️ Anotaciones:**
- `@Service`: Marca como servicio de Spring
- `@Autowired`: Inyección de dependencias
- `@PostConstruct`: Inicialización después de construcción

**⚙️ Métodos Principales:**

1. **Autenticación:**
   - `validarCredenciales()`: Login con MD5
   - Verifica usuario activo
   - Logging de intentos

2. **CRUD de Usuarios:**
   - `agregarUsuario()`: Crear/actualizar con validaciones
   - `obtenerTodosLosUsuarios()`: Listar todos
   - `obtenerUsuarioPorId()`: Buscar por ID
   - `obtenerUsuarioPorUsername()`: Buscar por username

3. **Gestión de Estado:**
   - `desactivarUsuario()`: Soft delete
   - `activarUsuario()`: Reactivar usuario
   - `existeUsername()`: Verificar existencia

**🔍 Validaciones Implementadas:**

1. **Datos Requeridos:**
   - Username no vacío
   - Password no vacío

2. **Unicidad:**
   - Username único en sistema
   - Email único en sistema

3. **Valores por Defecto:**
   - rol_id = 3 (Usuario)
   - activo = true

4. **Estado de Usuario:**
   - Solo usuarios activos pueden hacer login
   - Mensajes informativos en logs

**🔐 Proceso de Login:**
```
1. Recibir username + passwordMD5
2. Consultar BD: findByUsernameAndPassword()
3. Verificar usuario != null
4. Verificar usuario.activo == true
5. Log resultado (exitoso/fallido)
6. Retornar Usuario o null
```

**⚠️ Manejo de Errores:**
- Captura de excepciones en cada método
- Logging detallado de errores y éxitos
- Mensajes descriptivos para debugging
- Propagación controlada de excepciones

**📊 Logging Implementado:**
- ✅ Operaciones exitosas
- ❌ Errores y fallos
- ⚠️ Advertencias (usuario inactivo)
- 📝 Información de debug

---

## 📝 **RESUMEN DE ARQUITECTURA**

### **🔄 Flujo de Datos Completo:**

```
🌐 HTTP Request
    ↓
🔒 AuthInterceptor → Validar sesión
    ↓
🎮 Controller → Recibir petición
    ↓
⚙️ Service → Lógica de negocio
    ↓
🗃️ Repository → Acceso a datos
    ↓
🗄️ MySQL Database
    ↓
📊 JPA/Hibernate → Mapeo ORM
    ↓
⚙️ Service → Procesar resultado
    ↓
🎮 Controller → Preparar respuesta
    ↓
🖼️ JSP View / JSON Response
    ↓
🌐 HTTP Response
```

### **📦 Dependencias entre Clases:**

```
InventarioPlusApplication
    ↓
WebConfig → AuthInterceptor
    ↓
Controllers → Services → Repository → Entity
    ↓
LoginController → UsuarioService → UsuarioRepository → Usuario
DashboardController → (usa sesión)
HomeController → (redirecciona)
UsuarioController → UsuarioService → UsuarioRepository → Usuario
```

### **🎯 Responsabilidades por Capa:**

1. **Presentación (Controllers):**
   - Recibir peticiones HTTP
   - Validar parámetros de entrada
   - Llamar servicios apropiados
   - Formatear respuestas

2. **Negocio (Services):**
   - Implementar reglas de negocio
   - Validar datos
   - Coordinar operaciones
   - Manejar transacciones

3. **Datos (Repository + Entity):**
   - Mapeo objeto-relacional
   - Consultas a base de datos
   - Persistencia de entidades
   - Integridad referencial

4. **Configuración (Config):**
   - Configuración de frameworks
   - Interceptores de seguridad
   - Resolución de vistas
   - Manejo de recursos

Esta arquitectura asegura **separación de responsabilidades**, **mantenibilidad**, **escalabilidad** y **testabilidad** del código.

---

**📅 Documentación generada el 11 de octubre de 2025**
**🔧 Proyecto: InventarioPlus v0.0.1-SNAPSHOT**