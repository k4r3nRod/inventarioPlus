<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'Sistema de Gestión de Préstamos de Equipos'}</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Chart.js for Dashboard -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/estilosLayout.css">
    
    <!-- CSS adicional específico de página -->
    <c:if test="${not empty additionalCSS}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/${additionalCSS}">
    </c:if>
</head>
<body>
    <!-- Botón Toggle Sidebar -->
    <button class="btn btn-primary btn-toggle-sidebar d-md-none" id="toggleSidebar">
        <i class="fas fa-bars"></i>
    </button>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <h4 class="text-white mb-0">
                <i class="fas fa-tools text-warning me-2"></i>
                Gestión de Préstamos
            </h4>
            <small class="text-light">Sistema de Equipos</small>
        </div>
        
        <ul class="sidebar-menu mt-3">
            <!-- Dashboard -->
            <li>
                <a href="${pageContext.request.contextPath}/dashboard.jsp" class="<%=request.getRequestURI().contains("dashboard") ? "active" : ""%>">
                    <i class="fas fa-tachometer-alt"></i>
                    Dashboard
                </a>
            </li>
            
            <!-- Menú completo sin restricciones -->
            <li>
                <a href="${pageContext.request.contextPath}/clientes.jsp" class="<%=request.getRequestURI().contains("cliente") ? "active" : ""%>">
                    <i class="fas fa-users"></i>
                    Clientes
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/equipos.jsp" class="<%=request.getRequestURI().contains("equipo") ? "active" : ""%>">
                    <i class="fas fa-cogs"></i>
                    Equipos
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/prestamos.jsp" class="<%=request.getRequestURI().contains("prestamo") ? "active" : ""%>">
                    <i class="fas fa-handshake"></i>
                    Préstamos
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/evaluaciones.jsp" class="<%=request.getRequestURI().contains("evaluacion") ? "active" : ""%>">
                    <i class="fas fa-clipboard-check"></i>
                    Evaluaciones
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/usuarios.jsp" class="<%=request.getRequestURI().contains("usuario") ? "active" : ""%>">
                    <i class="fas fa-user-shield"></i>
                    Usuarios
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/historial.jsp" class="<%=request.getRequestURI().contains("historial") ? "active" : ""%>">
                    <i class="fas fa-history"></i>
                    Historial
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/reportes.jsp" class="<%=request.getRequestURI().contains("reporte") ? "active" : ""%>">
                    <i class="fas fa-chart-line"></i>
                    Reportes
                </a>
            </li>
        </ul>
        
    </div>

    <!-- Main Content -->
    <div class="main-content" id="mainContent">
        <!-- Top Navigation -->
        <nav class="navbar navbar-expand-lg navbar-custom">
            <div class="container-fluid">
                <button class="btn btn-outline-light d-none d-md-block me-3" id="toggleSidebarDesktop">
                    <i class="fas fa-bars"></i>
                </button>
                
                <h5 class="navbar-brand text-white mb-0">
                    ${pageTitle != null ? pageTitle : 'Panel Principal'}
                </h5>
                
                <div class="navbar-nav ms-auto">
                    <div class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-white" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-bell me-1"></i>
                            Notificaciones
                            <span class="badge bg-danger ms-1">3</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="#"><i class="fas fa-info-circle text-primary me-2"></i>Nuevo préstamo pendiente</a></li>
                            <li><a class="dropdown-item" href="#"><i class="fas fa-exclamation-triangle text-warning me-2"></i>Equipo requiere mantenimiento</a></li>
                            <li><a class="dropdown-item" href="#"><i class="fas fa-clock text-info me-2"></i>Devolución próxima a vencer</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Page Content -->
        <main class="container-fluid py-4">
            <!-- Breadcrumb -->
            <nav aria-label="breadcrumb" class="mb-4">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/dashboard.jsp">Inicio</a></li>
                    <c:if test="${breadcrumb != null}">
                        <li class="breadcrumb-item active">${breadcrumb}</li>
                    </c:if>
                </ol>
            </nav>
            
            <!-- Mensajes de alerta -->
            <c:if test="${not empty mensaje}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    ${mensaje}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <!-- Contenido dinámico de la página -->
            <div class="content-wrapper">
                <jsp:include page="${param.content != null ? param.content : 'dashboard-content.jsp'}" />
            </div>
        </main>

        <!-- Footer -->
        <footer class="footer-custom text-center py-3 mt-auto">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6 text-md-start">
                        <p class="mb-0">
                            <i class="fas fa-copyright me-1"></i>
                            2025 Sistema de Gestión de Préstamos de Equipos
                        </p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <small class="text-light">
                            Desarrollado por el Equipo de Desarrollo
                            <i class="fas fa-heart text-danger mx-1"></i>
                        </small>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script src="${pageContext.request.contextPath}/assets/js/validaciones.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/layout.js"></script>
</body>
</html>
