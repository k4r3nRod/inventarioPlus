# 📋 **CAMBIOS FUNCIONALES - InventarioPlus**

**Fecha:** 7 de octubre de 2025  
**Autor:** Asistente de desarrollo  
**Proyecto:** InventarioPlus - Sistema de Inventario  
**Versión:** 0.0.1-SNAPSHOT  

---

## 🎯 **OBJETIVO**
Convertir la aplicación Spring Boot de JAR a WAR con soporte completo para JSP y JSTL, compatible con Spring Boot 3.x y Jakarta EE.

---

## 🔧 **CAMBIOS REALIZADOS**

### **1. 📦 CONFIGURACIÓN DEL PROYECTO (pom.xml)**

#### **1.1 Cambio de packaging**
```xml
<!-- ANTES -->
<groupId>com.example</groupId>
<artifactId>InventarioPlus</artifactId>
<version>0.0.1-SNAPSHOT</version>
<name>InventarioPlus</name>

<!-- DESPUÉS -->
<groupId>com.example</groupId>
<artifactId>InventarioPlus</artifactId>
<version>0.0.1-SNAPSHOT</version>
<packaging>war</packaging>
<name>InventarioPlus</name>
```

#### **1.2 Actualización de dependencias JSP y JSTL**
```xml
<!-- ANTES (NO FUNCIONABA) -->
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>jstl</artifactId>
    <version>1.2</version>
</dependency>

<!-- DESPUÉS (FUNCIONA) -->
<dependency>
    <groupId>org.glassfish.web</groupId>
    <artifactId>jakarta.servlet.jsp.jstl</artifactId>
</dependency>
<dependency>
    <groupId>jakarta.servlet.jsp.jstl</groupId>
    <artifactId>jakarta.servlet.jsp.jstl-api</artifactId>
</dependency>
```

#### **1.3 Agregado soporte para Tomcat WAR**
```xml
<!-- NUEVO -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-tomcat</artifactId>
    <scope>provided</scope>
</dependency>
```

---

### **2. ☕ CLASE PRINCIPAL (InventarioPlusApplication.java)**

```java
// ANTES
package com.example.InventarioPlus;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class InventarioPlusApplication {
    public static void main(String[] args) {
        SpringApplication.run(InventarioPlusApplication.class, args);
    }
}

// DESPUÉS
package com.example.InventarioPlus;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class InventarioPlusApplication extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(InventarioPlusApplication.class, args);
    }
}
```

---

### **3. ⚙️ CONFIGURACIÓN DE VISTAS (WebConfig.java)**

**Archivo creado:** `src/main/java/com/example/InventarioPlus/config/WebConfig.java`

```java
package com.example.InventarioPlus.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Bean
    public InternalResourceViewResolver jspViewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/WEB-INF/views/layout/");
        resolver.setSuffix(".jsp");
        resolver.setViewClass(JstlView.class);
        resolver.setOrder(1);
        return resolver;
    }
}
```

---

### **4. 📄 CONFIGURACIÓN DE PROPIEDADES (application.properties)**

```properties
# CONFIGURACIÓN EXISTENTE
spring.application.name=InventarioPlus
server.port=8080

# CONFIGURACIÓN DE MYSQL
spring.datasource.url=jdbc:mysql://localhost:3306/InventarioPlus?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=root

# CONFIGURACIÓN DE JPA/HIBERNATE
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.database-platform=org.hibernate.dialect.MySQL8Dialect
spring.jpa.properties.hibernate.format_sql=true

# CONFIGURACIONES ADICIONALES
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
spring.jpa.open-in-view=false

# NUEVA CONFIGURACIÓN JSP
spring.mvc.view.prefix=/WEB-INF/views/layout/
spring.mvc.view.suffix=.jsp

# DESHABILITAR THYMELEAF COMPLETAMENTE
spring.thymeleaf.enabled=false
spring.thymeleaf.check-template-location=false

# LOGGING DETALLADO PARA JSP (OPCIONAL - PARA DEBUG)
logging.level.org.springframework.web=DEBUG
logging.level.org.springframework.web.servlet.view=DEBUG
```

---

### **5. 🗂️ ESTRUCTURA DE ARCHIVOS JSP**

#### **Ubicación correcta de archivos JSP:**
```
src/main/webapp/WEB-INF/views/layout/
├── index.jsp          (página principal)
├── layout.jsp         (layout base)
├── prueba-content.jsp (contenido de prueba)
├── index-content.jsp  (contenido adicional)
└── prueba.jsp         (página de prueba)
```

#### **Contenido de index.jsp (actualizado):**
```jsp
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Configurar parámetros para el layout
    request.setAttribute("pageTitle", "InventarioPlus - Sistema de Inventario");
    request.setAttribute("breadcrumb", "Inicio");
%>

<jsp:include page="layout.jsp">
    <jsp:param name="content" value="prueba-content.jsp" />
</jsp:include>
```

---

### **6. 🎮 CONTROLADOR (HomeController.java)**

```java
package com.example.InventarioPlus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    
    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("title", "InventarioPlus");
        model.addAttribute("message", "¡Bienvenido al Sistema de Inventario!");
        model.addAttribute("description", "Gestiona tu inventario de manera eficiente");
        return "index";  // Esto buscará /WEB-INF/views/layout/index.jsp
    }
    
    @GetMapping("/home")
    public String homeAlternative(Model model) {
        return home(model);
    }
    
    @GetMapping("/test")
    @org.springframework.web.bind.annotation.ResponseBody
    public String test() {
        return "¡Controller funcionando! Los mappings están bien.";
    }
}
```

---

## 🚀 **COMANDOS DE COMPILACIÓN Y EJECUCIÓN**

### **Compilar la aplicación:**
```bash
cd c:\src\inventarioPlus\InitializrSpringbootProject
mvn clean package
```

### **Ejecutar la aplicación:**
```bash
cd target
java -jar InventarioPlus-0.0.1-SNAPSHOT.war
```

---

## 🐛 **PROBLEMAS SOLUCIONADOS**

| **Problema** | **Causa** | **Solución** |
|--------------|-----------|--------------|
| Error 500 - `ClassNotFoundException: jakarta.servlet.jsp.jstl.core.Config` | Dependencia JSTL incorrecta (javax vs jakarta) | Actualizar a dependencias Jakarta |
| Error 404 - JSP no encontrado | Archivos JSP en ubicación incorrecta para JAR | Cambiar a WAR y mover JSP a webapp/ |
| Error 500 - Thymeleaf conflicto | Thymeleaf habilitado interfiriendo con JSP | Deshabilitar Thymeleaf completamente |
| Mappings no detectados | Configuración de ViewResolver faltante | Agregar WebConfig con InternalResourceViewResolver |

---

## ✅ **RESULTADO FINAL**

**URLs funcionales:**
- 🏠 **Página principal:** http://localhost:8080 
- 🧪 **Endpoint de prueba:** http://localhost:8080/test
- 🏠 **Página alternativa:** http://localhost:8080/home

**Características:**
- ✅ JSP + JSTL funcionando correctamente
- ✅ MySQL conectado y operativo
- ✅ Spring Boot 3.x con packaging WAR
- ✅ Jakarta EE compatible
- ✅ Layout personalizable con includes
- ✅ Sin errores 404/500

---

## 📚 **LECCIONES APRENDIDAS**

1. **Spring Boot 3.x** requiere dependencias **Jakarta** (no javax)
2. **JSP funciona mejor con WAR** que con JAR
3. **Los archivos JSP** deben estar en `src/main/webapp/WEB-INF/`
4. **Thymeleaf debe deshabilitarse** completamente para usar JSP
5. **ViewResolver explícito** mejora la detección de vistas

---

## 🔄 **PROCESO DE DEBUGGING SEGUIDO**

### **Paso 1: Identificación del problema inicial**
- Error 500: Thymeleaf buscando templates en lugar de JSP
- Solución: Deshabilitar Thymeleaf

### **Paso 2: Error JSTL**
- Error: `ClassNotFoundException: jakarta.servlet.jsp.jstl.core.Config`
- Solución: Actualizar dependencias de javax a jakarta

### **Paso 3: Error 404 JSP**
- Error: Archivos JSP no encontrados
- Solución: Cambiar de JAR a WAR y reorganizar estructura

### **Paso 4: Configuración ViewResolver**
- Problema: Mappings no detectando JSP correctamente
- Solución: Agregar configuración explícita de ViewResolver

---

## 📝 **NOTAS ADICIONALES**

- **Versión Spring Boot:** 3.5.6
- **Versión Java:** Compatible con Java 17 y 21
- **Base de datos:** MySQL 8.0
- **Servidor:** Tomcat embebido
- **Arquitectura:** MVC con JSP como motor de vistas

---

## 🔍 **VERIFICACIÓN DE FUNCIONAMIENTO**

Para verificar que todos los cambios funcionen correctamente:

1. **Compilar:** `mvn clean package`
2. **Ejecutar:** `java -jar target/InventarioPlus-0.0.1-SNAPSHOT.war`
3. **Probar endpoints:**
   - http://localhost:8080 → Debe mostrar el layout con contenido JSP
   - http://localhost:8080/test → Debe mostrar mensaje de confirmación
4. **Verificar logs:** No debe haber errores 404 o 500
5. **Verificar database:** Conexión MySQL exitosa

---

**Documento generado automáticamente**  
**Estado:** ✅ Completado y funcional  
**Última actualización:** 7 de octubre de 2025