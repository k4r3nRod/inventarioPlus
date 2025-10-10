<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión - InventarioPlus</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom Login CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
</head>
<body>
    <div class="login-container">
        <!-- Header del Login -->
        <div class="login-header">
            <div class="login-icon">
                <i class="fas fa-boxes"></i>
            </div>
            <h2>InventarioPlus</h2>
            <p>Sistema de Gestión de Inventario</p>
        </div>
        
        <!-- Body del Login -->
        <div class="login-body">
            <!-- Mensaje de logout -->
            <c:if test="${param.logout == 'true'}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle me-2"></i>
                    Has cerrado sesión correctamente.
                </div>
            </c:if>
            
            <!-- Mensaje de error -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    ${error}
                </div>
            </c:if>
            
            <!-- Información de credenciales de prueba -->
            <div class="credentials-info">
                <h6><i class="fas fa-info-circle me-1"></i> Credenciales de Prueba</h6>
                <small>
                    <strong>Administrador:</strong> admin / admin123<br>
                    <strong>Usuario:</strong> usuario / user123<br>
                    <strong>Empleado:</strong> karen / karen123
                </small>
            </div>
            
            <!-- Formulario de Login -->
            <form method="post" action="${pageContext.request.contextPath}/login" class="login-form">
                <div class="form-group">
                    <label for="username">Usuario</label>
                    <div class="input-group">
                        <i class="fas fa-user input-icon"></i>
                        <input type="text" 
                               class="form-control" 
                               id="username" 
                               name="username" 
                               required 
                               placeholder="Ingrese su usuario"
                               autocomplete="username">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <div class="input-group">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" 
                               class="form-control" 
                               id="password" 
                               name="password" 
                               required 
                               placeholder="Ingrese su contraseña"
                               autocomplete="current-password">
                    </div>
                </div>
                
                <button type="submit" class="btn btn-login">
                    <i class="fas fa-sign-in-alt me-2"></i>
                    Iniciar Sesión
                </button>
            </form>
        </div>
        
        <!-- Footer del Login -->
        <div class="login-footer">
            <p>
                <i class="fas fa-copyright me-1"></i>
                2025 InventarioPlus - Sistema de Gestión de Inventario
            </p>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Script para mejorar UX -->
    <script>
        // Auto-focus en el campo de usuario
        document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('username').focus();
        });
        
        // Animación al enviar formulario
        document.querySelector('.login-form').addEventListener('submit', function() {
            const button = document.querySelector('.btn-login');
            button.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Iniciando sesión...';
            button.disabled = true;
        });
        
        // Validación en tiempo real
        const inputs = document.querySelectorAll('.form-control');
        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                if (this.value.trim() === '') {
                    this.classList.add('is-invalid');
                } else {
                    this.classList.remove('is-invalid');
                    this.classList.add('is-valid');
                }
            });
        });
    </script>
</body>
</html>