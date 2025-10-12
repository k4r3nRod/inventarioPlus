<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - InventarioPlus</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/estilosLayout.css">
</head>
<body>
    <div class="container-fluid">
        <!-- Header/Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">
                    <i class="fas fa-boxes"></i> InventarioPlus
                </a>
                <div class="navbar-nav ms-auto">
                    <span class="navbar-text me-3">
                        <i class="fas fa-user"></i> ${nombreCompleto}
                    </span>
                    <a class="nav-link" href="/logout">
                        <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                    </a>
                </div>
            </div>
        </nav>

<!-- Dashboard Principal -->
<div class="row">
    <!-- Información del Usuario -->
    <div class="col-12 mb-4">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0">
                    <i class="fas fa-user-circle"></i> Bienvenido
                </h5>
            </div>
            <div class="card-body">
                <h4>¡Hola, <strong>${nombreCompleto}</strong>!</h4>
                <p class="text-muted mb-2">
                    <i class="fas fa-user"></i> Usuario: <strong>${usuario}</strong>
                </p>
                <p class="text-muted mb-0">
                    <i class="fas fa-user-tag"></i> Rol: 
                    <span class="badge ${rol == 1 ? 'bg-danger' : 'bg-success'}">
                        <c:choose>
                            <c:when test="${rol == 1}">ADMINISTRADOR</c:when>
                            <c:when test="${rol == 2}">ESPECIALISTA</c:when>
                            <c:when test="${rol == 3}">USUARIO</c:when>
                            <c:when test="${rol == 4}">CLIENTE</c:when>
                            <c:otherwise>DESCONOCIDO</c:otherwise>
                        </c:choose>
                    </span>
                </p>
                <div class="mt-3">
                    <a href="/logout" class="btn btn-outline-secondary btn-sm">
                        <i class="fas fa-sign-out-alt"></i> Cerrar Sesión
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Estadísticas del Sistema -->
<div class="row">
    <div class="col-md-3 mb-4">
        <div class="card text-white bg-primary">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4>150</h4>
                        <small>Productos</small>
                    </div>
                    <div class="align-self-center">
                        <i class="fas fa-boxes fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-3 mb-4">
        <div class="card text-white bg-success">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4>25</h4>
                        <small>Categorías</small>
                    </div>
                    <div class="align-self-center">
                        <i class="fas fa-tags fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-3 mb-4">
        <div class="card text-white bg-warning">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4>8</h4>
                        <small>Stock Bajo</small>
                    </div>
                    <div class="align-self-center">
                        <i class="fas fa-exclamation-triangle fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-3 mb-4">
        <div class="card text-white bg-info">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4>$45,230</h4>
                        <small>Valor Total</small>
                    </div>
                    <div class="align-self-center">
                        <i class="fas fa-dollar-sign fa-2x"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Acciones Rápidas -->
<div class="row">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fas fa-bolt"></i> Acciones Rápidas
                </h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <a href="#" class="btn btn-outline-primary w-100">
                            <i class="fas fa-plus-circle"></i><br>
                            Agregar Producto
                        </a>
                    </div>
                    <div class="col-md-4 mb-3">
                        <a href="#" class="btn btn-outline-success w-100">
                            <i class="fas fa-search"></i><br>
                            Buscar Inventario
                        </a>
                    </div>
                    <div class="col-md-4 mb-3">
                        <a href="#" class="btn btn-outline-info w-100">
                            <i class="fas fa-chart-bar"></i><br>
                            Ver Reportes
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Actividad Reciente (solo para admin) -->
<c:if test="${rol == 1}">
<div class="row mt-4">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fas fa-history"></i> Actividad Reciente
                </h5>
            </div>
            <div class="card-body">
                <div class="timeline">
                    <div class="alert alert-light">
                        <small class="text-muted">
                            <i class="fas fa-info-circle"></i> 
                            Aquí se mostrarán las últimas actividades del sistema...
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</c:if>

    </div> <!-- Cierre del container-fluid -->

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/assets/js/layout.js"></script>
    
    <!-- jQuery (opcional para funcionalidades adicionales) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>