<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Contenido del Dashboard -->
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <!-- Header del Dashboard -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h1 class="h2 text-primary-custom">
                        <i class="fas fa-tachometer-alt me-2"></i>
                        Dashboard
                    </h1>
                    <p class="text-muted">Panel de control del sistema de gestión de préstamos</p>
                </div>
                <div>
                    <button class="btn btn-primary-custom" onclick="actualizarDatos()">
                        <i class="fas fa-sync-alt me-1"></i>
                        Actualizar
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Tarjeta de Bienvenida -->
    <div class="row mb-4">
        <div class="col-lg-4 col-md-6 mb-3">
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="card-title mb-0">
                        <i class="fas fa-user-circle"></i> Bienvenido
                    </h5>
                </div>
                <div class="card-body">
                    <h4>¡Hola, <strong>Administrador del Sistema</strong>!</h4>
                    <p class="text-muted mb-2">
                        <i class="fas fa-user"></i> Usuario: <strong>${sessionScope.usuario}</strong>
                    </p>
                    <p class="text-muted mb-0">
                        <i class="fas fa-user-tag"></i> Rol: 
                        <span class="badge bg-danger">
                            <c:choose>
                                <c:when test="${sessionScope.rol == 1}">ADMINISTRADOR</c:when>
                                <c:when test="${sessionScope.rol == 2}">EVALUADOR</c:when>
                                <c:when test="${sessionScope.rol == 3}">PRESTAMISTA</c:when>
                                <c:otherwise>USUARIO</c:otherwise>
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
    
    <!-- Métricas principales -->
    <div class="row mb-4">
        <div class="col-lg-3 col-md-6 mb-3">
            <div class="card metric-card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0">
                            <i class="fas fa-users metric-icon text-primary"></i>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <div class="metric-value text-primary" id="metric-clientes">25</div>
                            <div class="metric-label">Clientes Activos</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-lg-3 col-md-6 mb-3">
            <div class="card metric-card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0">
                            <i class="fas fa-cogs metric-icon text-success"></i>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <div class="metric-value text-success" id="metric-equipos">48</div>
                            <div class="metric-label">Equipos Disponibles</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-lg-3 col-md-6 mb-3">
            <div class="card metric-card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0">
                            <i class="fas fa-handshake metric-icon text-warning"></i>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <div class="metric-value text-warning" id="metric-prestamos">37</div>
                            <div class="metric-label">Total Préstamos Activos</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-lg-3 col-md-6 mb-3">
            <div class="card metric-card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-shrink-0">
                            <i class="fas fa-clock metric-icon text-danger"></i>
                        </div>
                        <div class="flex-grow-1 ms-3">
                            <div class="metric-value text-danger" id="metric-vencimientos">3</div>
                            <div class="metric-label">Próximos Vencimientos</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Gráficos principales -->
    <div class="row mb-4">
        <!-- Equipos más usados (gráfico de barras) -->
        <div class="col-lg-8">
            <div class="card card-custom">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0">
                        <i class="fas fa-chart-bar me-2"></i>
                        Equipos Más Usados
                    </h5>
                </div>
                <div class="card-body">
                    <canvas id="equiposMasUsadosChart" height="100"></canvas>
                </div>
            </div>
        </div>
        
        <!-- Préstamos aprobados vs rechazados (gráfico circular) -->
        <div class="col-lg-4">
            <div class="card card-custom">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0">
                        <i class="fas fa-chart-pie me-2"></i>
                        Préstamos: Aprobados vs Rechazados
                    </h5>
                </div>
                <div class="card-body">
                    <canvas id="prestamosAprobadosChart"></canvas>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Gráficos adicionales -->
    <div class="row mb-4">
        <div class="col-lg-8">
            <div class="card card-custom">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0">
                        <i class="fas fa-chart-line me-2"></i>
                        Préstamos por Mes
                    </h5>
                </div>
                <div class="card-body">
                    <canvas id="prestamosChart" height="100"></canvas>
                </div>
            </div>
        </div>
        
        <div class="col-lg-4">
            <div class="card card-custom">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0">
                        <i class="fas fa-chart-doughnut me-2"></i>
                        Estados de Equipos
                    </h5>
                </div>
                <div class="card-body">
                    <canvas id="equiposChart"></canvas>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Acciones rápidas -->
    <div class="row mb-4">
        <div class="col-12">
            <div class="card card-custom">
                <div class="card-header card-header-custom">
                    <h5 class="mb-0">
                        <i class="fas fa-bolt me-2"></i>
                        Acciones Rápidas
                    </h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        
                        <c:if test="${sessionScope.rol == 1 || sessionScope.rol == 2}">
                        <div class="col-md-3 mb-2">
                            <a href="clientes.jsp" class="btn btn-outline-primary w-100 quick-action-btn">
                                <i class="fas fa-user-plus me-2"></i>
                                Nuevo Cliente
                            </a>
                        </div>
                        <div class="col-md-3 mb-2">
                            <a href="equipos.jsp" class="btn btn-outline-success w-100 quick-action-btn">
                                <i class="fas fa-plus-circle me-2"></i>
                                Agregar Equipo
                            </a>
                        </div>
                        </c:if>
                        
                        <div class="col-md-3 mb-2">
                            <a href="prestamos.jsp" class="btn btn-outline-warning w-100">
                                <i class="fas fa-handshake me-2"></i>
                                Nuevo Préstamo
                            </a>
                        </div>
                        
                        <c:if test="${sessionScope.rol == 2}">
                        <div class="col-md-3 mb-2">
                            <a href="evaluaciones.jsp" class="btn btn-outline-info w-100">
                                <i class="fas fa-clipboard-check me-2"></i>
                                Evaluaciones
                            </a>
                        </div>
                        </c:if>
                        
                        <c:if test="${sessionScope.rol == 1}">
                        <div class="col-md-3 mb-2">
                            <a href="reportes.jsp" class="btn btn-outline-secondary w-100">
                                <i class="fas fa-chart-bar me-2"></i>
                                Reportes
                            </a>
                        </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</div>



<script>
// Inicializar gráficos
document.addEventListener('DOMContentLoaded', function() {
    // Inicializar todos los gráficos del dashboard
    initEquiposMasUsadosChart();
    initPrestamosAprobadosChart();
    initPrestamosChart();
    initEquiposChart();
});

function initPrestamosChart() {
    const ctx = document.getElementById('prestamosChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'],
            datasets: [{
                label: 'Préstamos',
                data: [12, 19, 15, 25, 22, 30],
                borderColor: 'rgb(52, 152, 219)',
                backgroundColor: 'rgba(52, 152, 219, 0.1)',
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}

function initEquiposChart() {
    const ctx = document.getElementById('equiposChart').getContext('2d');
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Disponibles', 'En Préstamo', 'Mantenimiento'],
            datasets: [{
                data: [48, 12, 5],
                backgroundColor: [
                    '#27ae60',
                    '#f39c12',
                    '#e74c3c'
                ]
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    position: 'bottom'
                }
            }
        }
    });
}

// Gráfico de Equipos Más Usados (Barras Horizontales)
function initEquiposMasUsadosChart() {
    const ctx = document.getElementById('equiposMasUsadosChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ['Laptops Dell', 'Proyectores Epson', 'Tablets iPad', 'Cámaras Canon', 'Micrófonos Shure', 'Switches Cisco'],
            datasets: [{
                label: 'Veces Prestado',
                data: [45, 32, 28, 25, 18, 15],
                backgroundColor: [
                    '#3498db',
                    '#2ecc71',
                    '#f39c12',
                    '#9b59b6',
                    '#e74c3c',
                    '#1abc9c'
                ],
                borderColor: [
                    '#2980b9',
                    '#27ae60',
                    '#e67e22',
                    '#8e44ad',
                    '#c0392b',
                    '#16a085'
                ],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            indexAxis: 'y', // Barras horizontales
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return context.parsed.x + ' préstamos';
                        }
                    }
                }
            },
            scales: {
                x: {
                    beginAtZero: true,
                    title: {
                        display: true,
                        text: 'Número de Préstamos'
                    }
                },
                y: {
                    title: {
                        display: true,
                        text: 'Equipos'
                    }
                }
            }
        }
    });
}

// Gráfico de Préstamos Aprobados vs Rechazados (Circular)
function initPrestamosAprobadosChart() {
    const ctx = document.getElementById('prestamosAprobadosChart').getContext('2d');
    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: ['Aprobados', 'Rechazados', 'Pendientes'],
            datasets: [{
                data: [78, 12, 10],
                backgroundColor: [
                    '#27ae60', // Verde para aprobados
                    '#e74c3c', // Rojo para rechazados
                    '#f39c12'  // Amarillo para pendientes
                ],
                borderColor: [
                    '#229954',
                    '#cb4335',
                    '#d68910'
                ],
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    position: 'bottom',
                    labels: {
                        padding: 15,
                        usePointStyle: true
                    }
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            const total = context.dataset.data.reduce((a, b) => a + b, 0);
                            const percentage = ((context.parsed / total) * 100).toFixed(1);
                            return context.label + ': ' + context.parsed + ' (' + percentage + '%)';
                        }
                    }
                }
            }
        }
    });
}

function actualizarDatos() {
    LayoutManager.showAlert('Datos actualizados correctamente', 'success', 3000);
    // Aquí se haría la llamada AJAX para actualizar los datos reales
    
    // Simular actualización de métricas
    setTimeout(() => {
        // Actualizar números de las tarjetas con una pequeña animación
        animateMetricValue('metric-clientes', 25, 27);
        animateMetricValue('metric-equipos', 48, 50);
        animateMetricValue('metric-prestamos', 37, 39);
        animateMetricValue('metric-vencimientos', 3, 2);
    }, 500);
}

// Función para animar cambios en métricas
function animateMetricValue(elementId, fromValue, toValue) {
    const element = document.getElementById(elementId);
    if (!element) return;
    
    const duration = 1000;
    const steps = 20;
    const stepValue = (toValue - fromValue) / steps;
    const stepTime = duration / steps;
    
    let currentValue = fromValue;
    let step = 0;
    
    const interval = setInterval(() => {
        step++;
        currentValue += stepValue;
        element.textContent = Math.round(currentValue);
        
        if (step >= steps) {
            clearInterval(interval);
            element.textContent = toValue;
        }
    }, stepTime);
}
</script>