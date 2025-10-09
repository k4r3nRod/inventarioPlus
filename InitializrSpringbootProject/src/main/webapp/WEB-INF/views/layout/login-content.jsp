<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container-fluid py-4">
    <!-- Hero Section -->
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-lg border-0 rounded-lg">
                <div class="card-header bg-primary text-white text-center py-4">
                    <h3 class="font-weight-light mb-0">
                        <i class="fas fa-sign-in-alt me-2"></i>
                        Iniciar Sesión
                    </h3>
                    <p class="mb-0 text-white-50">Accede a InventarioPlus</p>
                </div>
                
                <div class="card-body p-5">
                    <!-- Mensaje de logout exitoso -->
                    <c:if test="${param.logout != null}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>
                            Has cerrado sesión correctamente.
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <!-- Mensaje de error -->
                    <c:if test="${error != null}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <!-- Formulario de Login -->
                    <form method="post" action="${pageContext.request.contextPath}/login" id="loginForm">
                        <div class="form-floating mb-3">
                            <input type="text" 
                                   class="form-control" 
                                   id="username" 
                                   name="username" 
                                   placeholder="Usuario"
                                   required>
                            <label for="username">
                                <i class="fas fa-user me-2"></i>Usuario
                            </label>
                        </div>
                        
                        <div class="form-floating mb-4">
                            <input type="password" 
                                   class="form-control" 
                                   id="password" 
                                   name="password" 
                                   placeholder="Contraseña"
                                   required>
                            <label for="password">
                                <i class="fas fa-lock me-2"></i>Contraseña
                            </label>
                        </div>
                        
                        <div class="d-flex align-items-center justify-content-between mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="rememberMe">
                                <label class="form-check-label" for="rememberMe">
                                    Recordarme
                                </label>
                            </div>
                            <a href="#" class="text-decoration-none">¿Olvidaste tu contraseña?</a>
                        </div>
                        
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary btn-lg">
                                <i class="fas fa-sign-in-alt me-2"></i>
                                Iniciar Sesión
                            </button>
                        </div>
                    </form>
                </div>
                
                <div class="card-footer bg-light text-center py-3">
                    <div class="small text-muted">
                        ¿No tienes cuenta? 
                        <a href="#" class="text-decoration-none">Contacta al administrador</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Información de credenciales de prueba -->
    <div class="row justify-content-center mt-4">
        <div class="col-md-6 col-lg-5">
            <div class="card border-info">
                <div class="card-header bg-info text-white">
                    <h6 class="mb-0">
                        <i class="fas fa-info-circle me-2"></i>
                        Credenciales de Prueba
                    </h6>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-12">
                            <strong>Administrador:</strong><br>
                            <code>Usuario: admin | Contraseña: admin123</code>
                        </div>
                        <div class="col-12 mt-2">
                            <strong>Usuario Regular:</strong><br>
                            <code>Usuario: usuario | Contraseña: user123</code>
                        </div>
                        <div class="col-12 mt-2">
                            <strong>Karen:</strong><br>
                            <code>Usuario: karen | Contraseña: karen123</code>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts adicionales para el login -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Validación del formulario
    const form = document.getElementById('loginForm');
    const username = document.getElementById('username');
    const password = document.getElementById('password');
    
    form.addEventListener('submit', function(e) {
        let isValid = true;
        
        // Limpiar errores previos
        username.classList.remove('is-invalid');
        password.classList.remove('is-invalid');
        
        // Validar usuario
        if (username.value.trim() === '') {
            username.classList.add('is-invalid');
            isValid = false;
        }
        
        // Validar contraseña
        if (password.value.trim() === '') {
            password.classList.add('is-invalid');
            isValid = false;
        }
        
        if (!isValid) {
            e.preventDefault();
            showToast('Por favor completa todos los campos', 'error');
        }
    });
    
    // Función para mostrar notificaciones
    function showToast(message, type) {
        // Esta función se puede expandir para mostrar notificaciones
        console.log(`${type}: ${message}`);
    }
});
</script>