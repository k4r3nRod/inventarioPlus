# 🗄️ CREACIÓN COMPLETA DE BASE DE DATOS - INVENTARIO PLUS

## 📋 INSTRUCCIONES DE EJECUCIÓN (EN ORDEN)

### ✅ PASO 1: Ejecutar Schema Principal
**Archivo:** `schemaInventarioPlus.sql`
**Descripción:** Crea toda la base de datos desde cero con encriptación MD5

```sql
-- Este archivo hace TODO automáticamente:
-- 1. Elimina BD existente
-- 2. Crea BD nueva
-- 3. Crea tabla Roles
-- 4. Crea tabla usuarios (y otras)
-- 5. Inserta usuarios con MD5
-- 6. Muestra verificación
```

### ✅ PASO 2: Verificar Creación (Opcional)
**Archivo:** `verificar_creacion_bd.sql`
**Descripción:** Verifica que todo se creó correctamente

---

## 🔐 ENCRIPTACIÓN MD5 IMPLEMENTADA

### Según documento `ENCRIPTACION_CONTRASEÑAS.txt`:

**Flujo de Encriptación:**
1. Usuario ingresa: `"admin123"`
2. Sistema llama: `Usuario.encriptarMD5("admin123")`
3. Se genera hash: `"0192023a7bbd73250516f069df18b500"`
4. Se almacena en BD: Hash de 32 caracteres
5. Login: Se compara hash ingresado vs hash almacenado

---

## 👥 CREDENCIALES DE ACCESO

| Usuario      | Contraseña | Hash MD5                         | Rol           |
|--------------|------------|----------------------------------|---------------|
| **admin**    | admin123   | 0192023a7bbd73250516f069df18b500 | 👑 ADMINISTRADOR |
| **jperez**   | user123    | 6ad14ba9986e3615423dfca256d04e3f | 👤 USUARIO      |
| **ctecnico** | spec123    | 5f35dc7f50c58d67c94f87d99de5b26e | 🔧 ESPECIALISTA |
| demo         | demo123    | 62cc2d8b4bf2d8728120d052163a77df | 👤 USUARIO      |
| test         | test123    | cc03e747a6afbbcbf8be7668acfebee5 | 👤 USUARIO      |
| guest        | guest123   | fcf41657f02f88137a1bcf068a32c0a3 | 👤 USUARIO      |
| especialista | user123    | 6ad14ba9986e3615423dfca256d04e3f | 🔧 ESPECIALISTA |
| superadmin   | admin123   | 0192023a7bbd73250516f069df18b500 | 👑 ADMINISTRADOR |

---

## 🏗️ ESTRUCTURA DE BASE DE DATOS

### Tablas Creadas:
- ✅ **Roles** - Definición de roles del sistema
- ✅ **usuarios** - Usuarios con encriptación MD5
- ✅ **Equipos** - Inventario de equipos
- ✅ **Prestamos** - Préstamos de equipos
- ✅ **Devoluciones** - Devoluciones de equipos
- ✅ **Inspecciones** - Inspecciones técnicas

### Características de Seguridad:
- 🔒 **Contraseñas MD5:** 32 caracteres hexadecimales
- 🔒 **Validación segura:** Comparación de hashes
- 🔒 **No texto plano:** Contraseñas originales no almacenadas

---

## 🚀 DESPUÉS DE CREAR LA BD

1. **Reinicia tu aplicación Spring Boot**
2. **Ve a:** http://localhost:8080
3. **Login con cualquier credencial** de la tabla anterior
4. **¡Disfruta del sistema con encriptación MD5!**

---

## 📝 NOTAS TÉCNICAS

### Código Java Implementado:
```java
// En Usuario.java
public static String encriptarMD5(String claveOriginal) {
    // Implementación MD5 completa
    // Genera hash de 32 caracteres hexadecimales
}

// En UsuarioService.java
public boolean validarCredenciales(String username, String password) {
    String passwordMD5 = Usuario.encriptarMD5(password);
    return passwordMD5.equals(usuario.getPassword());
}
```

### Ventajas del Sistema:
✅ Contraseñas no se almacenan en texto plano  
✅ Implementación simple y directa  
✅ Compatible con el documento especificado  
✅ Hash consistente para misma contraseña  

---

**🎉 ¡BASE DE DATOS COMPLETA CON ENCRIPTACIÓN MD5 LISTA!**