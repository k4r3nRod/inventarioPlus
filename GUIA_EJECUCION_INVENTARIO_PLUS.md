# 📋 Guía Completa: Ejecutar InventarioPlus con JSP

## 🎯 **Objetivo**
Esta guía te ayudará a ejecutar tu aplicación Spring Boot "InventarioPlus" que utiliza JSP como motor de plantillas.

---

## 📁 **Requisitos Previos**
- ✅ Java 17 instalado
- ✅ Maven instalado
- ✅ MySQL Server ejecutándose
- ✅ Base de datos `InventarioPlus` creada
- ✅ Usuario MySQL: `root` / Password: `root`

---

## 🚀 **Comandos para Ejecutar la Aplicación**

### **Método 1: Comandos Paso a Paso**

#### **1. Abrir PowerShell y navegar al proyecto:**
```powershell
cd c:\src\inventarioPlus\InitializrSpringbootProject
```

#### **2. Verificar que el puerto 8080 esté libre:**
```powershell
netstat -ano | findstr :8080
```

#### **3. Si hay procesos usando el puerto, detenerlos:**
```powershell
# Si aparece un proceso, copiar el PID (último número) y ejecutar:
taskkill /PID [número_del_PID] /F

# Ejemplo:
# taskkill /PID 12345 /F
```

#### **4. Limpiar y compilar el proyecto:**
```powershell
mvn clean package
```

#### **5. Ejecutar la aplicación:**
```powershell
java -jar target/InventarioPlus-0.0.1-SNAPSHOT.jar
```

#### **6. Abrir en el navegador:**
```
http://localhost:8080
```

---

### **Método 2: Comandos en Secuencia (Rápido)**

```powershell
# Navegar al directorio
cd c:\src\inventarioPlus\InitializrSpringbootProject

# Detener procesos en puerto 8080 (si los hay)
for /f "tokens=5" %a in ('netstat -ano ^| findstr :8080') do taskkill /PID %a /F

# Compilar y ejecutar
mvn clean package && java -jar target/InventarioPlus-0.0.1-SNAPSHOT.jar
```

---

### **Método 3: Una Sola Línea (Ultra Rápido)**

```powershell
cd c:\src\inventarioPlus\InitializrSpringbootProject; mvn clean package; java -jar target/InventarioPlus-0.0.1-SNAPSHOT.jar
```

---

## 📊 **Qué Esperar Durante la Ejecución**

### **Durante la Compilación (`mvn clean package`):**
```
[INFO] Scanning for projects...
[INFO] Building InventarioPlus 0.0.1-SNAPSHOT
[INFO] --- clean:3.4.1:clean (default-clean) @ InventarioPlus ---
[INFO] Deleting target directory
[INFO] --- compiler:3.14.0:compile (default-compile) @ InventarioPlus ---
[INFO] Compiling 2 source files
[INFO] --- jar:3.4.2:jar (default-jar) @ InventarioPlus ---
[INFO] Building jar: target\InventarioPlus-0.0.1-SNAPSHOT.jar
[INFO] --- spring-boot:3.5.6:repackage (repackage) @ InventarioPlus ---

✅ MENSAJE CLAVE: "Adding welcome page template: index"

[INFO] BUILD SUCCESS
```

### **Durante la Ejecución (`java -jar`):**
```
  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v3.5.6)

INFO - Starting InventarioPlusApplication
INFO - No active profile set, falling back to 1 default profile: "default"
INFO - HikariPool-1 - Added connection com.mysql.cj.jdbc.ConnectionImpl
INFO - Started InventarioPlusApplication in X.XXX seconds

✅ MENSAJE CLAVE: "Started InventarioPlusApplication"
```

---

## 🌐 **URLs Disponibles**

| URL | Descripción |
|-----|-------------|
| `http://localhost:8080/` | Página principal (index.jsp) |
| `http://localhost:8080/home` | Página alternativa |
| `http://localhost:8080/prueba` | Página de prueba (si existe) |

---

## 🛠️ **Solución de Problemas Comunes**

### **Error: "Port 8080 was already in use"**
```powershell
# Encontrar el proceso
netstat -ano | findstr :8080

# Detener el proceso
taskkill /PID [número] /F
```

### **Error: "Unable to access jarfile"**
```powershell
# Verificar que estás en el directorio correcto
pwd
# Debe mostrar: C:\src\inventarioPlus\InitializrSpringbootProject

# Verificar que el JAR existe
ls target/*.jar
```

### **Error: "Unknown database 'inventarioplus'"**
```sql
-- Crear la base de datos en MySQL
CREATE DATABASE InventarioPlus;
```

### **Error 404 en el navegador**
- ✅ Verificar que aparezca el mensaje: "Adding welcome page template: index"
- ✅ Verificar que los archivos JSP estén en: `src/main/webapp/WEB-INF/views/layout/`

### **Error 500 en el navegador**
- ✅ Revisar los logs en la consola
- ✅ Verificar conexión a MySQL
- ✅ Verificar que `index-content.jsp` exista
- ✅ Verificar que `index.jsp` tenga los imports JSP correctos:
  ```jsp
  <%@ page contentType="text/html;charset=UTF-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  ```
- ✅ No usar `response.sendRedirect()` en JSP con Spring Boot

---

## 🛑 **Para Detener la Aplicación**

```powershell
# En la consola donde se ejecuta:
Ctrl + C

# O desde otra terminal:
taskkill /IM java.exe /F
```

---

## 🏗️ **Estructura del Proyecto**

```
InitializrSpringbootProject/
├── src/main/
│   ├── java/com/example/InventarioPlus/
│   │   ├── InventarioPlusApplication.java
│   │   └── controller/HomeController.java
│   ├── resources/
│   │   ├── application.properties
│   │   └── templates/ (para Thymeleaf - no se usa)
│   └── webapp/WEB-INF/views/layout/
│       ├── layout.jsp
│       ├── index.jsp
│       └── index-content.jsp
├── target/
│   └── InventarioPlus-0.0.1-SNAPSHOT.jar
└── pom.xml
```

---

## ✅ **Configuración Actual**

### **Tecnologías Utilizadas:**
- **Backend**: Spring Boot 3.5.6
- **Templates**: JSP + JSTL
- **Base de Datos**: MySQL
- **Servidor Web**: Tomcat Embebido
- **Puerto**: 8080

### **Dependencias JSP en pom.xml:**
```xml
<dependency>
    <groupId>org.apache.tomcat.embed</groupId>
    <artifactId>tomcat-embed-jasper</artifactId>
    <scope>provided</scope>
</dependency>
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>jstl</artifactId>
    <version>1.2</version>
</dependency>
```

### **Configuración JSP en application.properties:**
```properties
spring.mvc.view.prefix=/WEB-INF/views/layout/
spring.mvc.view.suffix=.jsp
```

---

## 📱 **Resultado Esperado**

Al abrir `http://localhost:8080` deberías ver:
- ✅ Página de bienvenida de InventarioPlus
- ✅ Layout profesional con Bootstrap
- ✅ Navbar de navegación
- ✅ Secciones de funcionalidades (Productos, Categorías, Reportes)
- ✅ Estadísticas del inventario
- ✅ Footer informativo

---

## 🎯 **Comandos de Mantenimiento**

### **Para desarrollo (con recarga automática):**
```powershell
mvn spring-boot:run
```

### **Para limpiar completamente:**
```powershell
mvn clean
```

### **Para solo compilar:**
```powershell
mvn compile
```

### **Para ejecutar tests:**
```powershell
mvn test
```

---

## 📞 **Contacto y Soporte**

Si tienes problemas:
1. Verifica que todos los requisitos previos estén instalados
2. Asegúrate de estar en el directorio correcto
3. Revisa los logs de la consola para identificar errores específicos
4. Verifica que MySQL esté ejecutándose y la base de datos exista

---

**¡Tu aplicación InventarioPlus está lista para ejecutarse!** 🚀

---

*Documento creado: 7 de octubre de 2025*  
*Versión de la aplicación: InventarioPlus 0.0.1-SNAPSHOT*  
*Tecnología: Spring Boot + JSP + MySQL*