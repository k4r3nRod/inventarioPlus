<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Hero Section -->
<div class="container-fluid" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 80px 0;">
    <div class="container text-center">
        <h1 class="display-4 fw-bold mb-4">¡Bienvenido al Sistema de Inventario!</h1>
        <p class="lead mb-4">Gestiona tu inventario de manera eficiente</p>
        <div class="mt-4">
            <a href="#" class="btn btn-light btn-lg me-3">
                <i class="fas fa-box"></i> Ver Productos
            </a>
            <a href="#" class="btn btn-outline-light btn-lg">
                <i class="fas fa-tags"></i> Categorías
            </a>
        </div>
    </div>
</div>

<!-- Features Section -->
<div class="container py-5">
    <div class="row text-center mb-5">
        <div class="col">
            <h2 class="h1 fw-bold">Funcionalidades Principales</h2>
            <p class="lead text-muted">Todo lo que necesitas para gestionar tu inventario</p>
        </div>
    </div>
    
    <div class="row g-4">
        <!-- Productos -->
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body text-center p-4">
                    <div class="mb-3">
                        <i class="fas fa-box fa-3x text-primary"></i>
                    </div>
                    <h5 class="card-title">Gestión de Productos</h5>
                    <p class="card-text">Añade, edita y elimina productos de tu inventario con facilidad.</p>
                    <a href="#" class="btn btn-primary">Ver Productos</a>
                </div>
            </div>
        </div>
        
        <!-- Categorías -->
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body text-center p-4">
                    <div class="mb-3">
                        <i class="fas fa-tags fa-3x text-success"></i>
                    </div>
                    <h5 class="card-title">Categorías</h5>
                    <p class="card-text">Organiza tus productos por categorías para una mejor gestión.</p>
                    <a href="#" class="btn btn-success">Ver Categorías</a>
                </div>
            </div>
        </div>
        
        <!-- Reportes -->
        <div class="col-md-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body text-center p-4">
                    <div class="mb-3">
                        <i class="fas fa-chart-bar fa-3x text-warning"></i>
                    </div>
                    <h5 class="card-title">Reportes</h5>
                    <p class="card-text">Genera reportes detallados sobre el estado de tu inventario.</p>
                    <a href="#" class="btn btn-warning">Ver Reportes</a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Stats Section -->
<div class="bg-light py-5">
    <div class="container">
        <div class="row text-center">
            <div class="col-md-3">
                <div class="mb-3">
                    <h3 class="display-4 fw-bold text-primary">0</h3>
                    <p class="text-muted">Productos Registrados</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="mb-3">
                    <h3 class="display-4 fw-bold text-success">0</h3>
                    <p class="text-muted">Categorías</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="mb-3">
                    <h3 class="display-4 fw-bold text-warning">$0</h3>
                    <p class="text-muted">Valor Total</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="mb-3">
                    <h3 class="display-4 fw-bold text-info">0</h3>
                    <p class="text-muted">Stock Bajo</p>
                </div>
            </div>
        </div>
    </div>
</div>