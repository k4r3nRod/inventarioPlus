<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
                    <span class="badge ${rol == 'ADMIN' ? 'bg-danger' : 'bg-success'}">
                        ${rol}
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
<c:if test="${rol == 'ADMIN'}">
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