# Configuración de MySQL Workbench para InventarioPlus

## 📋 Requisitos Previos
- MySQL Server instalado y funcionando
- MySQL Workbench instalado
- Puerto 3306 disponible (puerto por defecto de MySQL)

## 🔧 Pasos de Configuración

### 1. Configurar Conexión en MySQL Workbench

1. **Abrir MySQL Workbench**
2. **Crear nueva conexión:**
   - Click en el "+" junto a "MySQL Connections"
   - Connection Name: `InventarioPlus_Local`
   - Hostname: `127.0.0.1` o `localhost`
   - Port: `3306`
   - Username: `root` (o tu usuario de MySQL)
   - Password: `[tu contraseña de MySQL]`

### 2. Configurar la Contraseña en la Aplicación

Edita el archivo `application.properties` y actualiza la línea:
```properties
spring.datasource.password=[TU_CONTRASEÑA_MYSQL]
```

### 3. Crear la Base de Datos

Ejecuta el siguiente script SQL en MySQL Workbench:

```sql
-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS inventario_plus
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

-- Usar la base de datos
USE inventario_plus;

-- Verificar que se creó correctamente
SHOW DATABASES LIKE 'inventario_plus';
```

### 4. Verificar la Conexión

Una vez que la aplicación esté ejecutándose, visita:
- **Test de conexión:** http://localhost:8080/api/database/test
- **Información de BD:** http://localhost:8080/api/database/info

## 🔍 Configuración Actual de la Aplicación

```properties
# URL de conexión
spring.datasource.url=jdbc:mysql://localhost:3306/inventario_plus?useSSL=false&serverTimezone=America/Mexico_City&allowPublicKeyRetrieval=true&createDatabaseIfNotExist=true

# Credenciales (ACTUALIZAR CON TUS DATOS)
spring.datasource.username=root
spring.datasource.password=

# Configuración JPA
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

## 📊 Usuarios de Prueba

La aplicación creará automáticamente estos usuarios:

| Username | Password | Rol     | Nombre Completo        |
|----------|----------|---------|------------------------|
| admin    | admin123 | ADMIN   | Administrador del Sistema |
| usuario  | user123  | USUARIO | Usuario Empleado       |
| karen    | karen123 | USUARIO | Karen Rodriguez        |

## 🛠️ Solución de Problemas

### Error: "Access denied for user"
- Verifica que el usuario y contraseña sean correctos
- Asegúrate de que el usuario tenga permisos para crear bases de datos

### Error: "Connection timeout"
- Verifica que MySQL Server esté ejecutándose
- Confirma que el puerto 3306 esté disponible

### Error: "Unknown database"
- La aplicación creará la base de datos automáticamente si no existe
- Si falla, crea manualmente la base de datos `inventario_plus`

## 📝 Notas Importantes

1. **Zona Horaria:** Configurada para `America/Mexico_City`
2. **Encoding:** UTF-8 (utf8mb4) para soporte completo de caracteres
3. **DDL Auto:** `update` - Las tablas se crean/actualizan automáticamente
4. **Pool de Conexiones:** HikariCP configurado para 10 conexiones máximo

## 🔐 Seguridad

⚠️ **IMPORTANTE:** Cambia las contraseñas por defecto antes de usar en producción.

## 📞 Comandos Útiles de MySQL

```sql
-- Ver todas las bases de datos
SHOW DATABASES;

-- Usar la base de datos
USE inventario_plus;

-- Ver todas las tablas
SHOW TABLES;

-- Ver estructura de tabla usuarios
DESCRIBE usuarios;

-- Ver todos los usuarios
SELECT * FROM usuarios;
```