/**
 * ================================================
 * SISTEMA DE GESTIÓN DE PRÉSTAMOS DE EQUIPOS
 * Layout JavaScript - Funcionalidades principales
 * ================================================
 */

// Esperar a que el DOM esté completamente cargado
document.addEventListener('DOMContentLoaded', function() {
    initializeLayout();
});

/**
 * Inicializar todas las funcionalidades del layout
 */
function initializeLayout() {
    initializeSidebarToggle();
    initializeAlerts();
    initializeFormLoadingStates();
    initializeTooltips();
    initializeNotifications();
}

/**
 * ================================================
 * SIDEBAR FUNCTIONALITY
 * ================================================
 */

/**
 * Inicializar toggle del sidebar
 */
function initializeSidebarToggle() {
    // Toggle para móvil
    const toggleMobile = document.getElementById('toggleSidebar');
    if (toggleMobile) {
        toggleMobile.addEventListener('click', function() {
            const sidebar = document.getElementById('sidebar');
            if (sidebar) {
                sidebar.classList.toggle('show');
            }
        });
    }
    
    // Toggle para escritorio
    const toggleDesktop = document.getElementById('toggleSidebarDesktop');
    if (toggleDesktop) {
        toggleDesktop.addEventListener('click', function() {
            const sidebar = document.getElementById('sidebar');
            const mainContent = document.getElementById('mainContent');
            
            if (sidebar && mainContent) {
                sidebar.classList.toggle('collapsed');
                mainContent.classList.toggle('expanded');
                
                // Guardar estado en localStorage
                const isCollapsed = sidebar.classList.contains('collapsed');
                localStorage.setItem('sidebarCollapsed', isCollapsed);
            }
        });
    }
    
    // Restablecer estado del sidebar desde localStorage
    restoreSidebarState();
    
    // Cerrar sidebar al hacer click fuera (solo móvil)
    document.addEventListener('click', function(e) {
        if (window.innerWidth <= 768) {
            const sidebar = document.getElementById('sidebar');
            const toggleBtn = document.getElementById('toggleSidebar');
            
            if (sidebar && toggleBtn && 
                !sidebar.contains(e.target) && 
                !toggleBtn.contains(e.target) &&
                sidebar.classList.contains('show')) {
                sidebar.classList.remove('show');
            }
        }
    });
}

/**
 * Restaurar estado del sidebar desde localStorage
 */
function restoreSidebarState() {
    const isCollapsed = localStorage.getItem('sidebarCollapsed') === 'true';
    
    if (isCollapsed && window.innerWidth > 768) {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');
        
        if (sidebar && mainContent) {
            sidebar.classList.add('collapsed');
            mainContent.classList.add('expanded');
        }
    }
}

/**
 * ================================================
 * ALERTS MANAGEMENT
 * ================================================
 */

/**
 * Inicializar manejo automático de alertas
 */
function initializeAlerts() {
    // Auto-ocultar alertas después de 5 segundos
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(function(alert) {
            if (window.bootstrap && window.bootstrap.Alert) {
                const bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            } else {
                // Fallback si Bootstrap no está disponible
                alert.style.opacity = '0';
                setTimeout(() => alert.remove(), 300);
            }
        });
    }, 5000);
}

/**
 * Mostrar alerta personalizada
 * @param {string} message - Mensaje de la alerta
 * @param {string} type - Tipo de alerta (success, danger, warning, info)
 * @param {number} duration - Duración en milisegundos (opcional)
 */
function showAlert(message, type = 'info', duration = 5000) {
    const alertContainer = document.querySelector('.content-wrapper') || document.querySelector('main');
    
    if (!alertContainer) return;
    
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
    alertDiv.setAttribute('role', 'alert');
    
    const icon = getAlertIcon(type);
    
    alertDiv.innerHTML = `
        <i class="${icon} me-2"></i>
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    `;
    
    alertContainer.insertBefore(alertDiv, alertContainer.firstChild);
    
    // Auto-ocultar después del tiempo especificado
    if (duration > 0) {
        setTimeout(() => {
            if (alertDiv.parentNode) {
                const bsAlert = new bootstrap.Alert(alertDiv);
                bsAlert.close();
            }
        }, duration);
    }
}

/**
 * Obtener icono según tipo de alerta
 * @param {string} type - Tipo de alerta
 * @returns {string} - Clase del icono
 */
function getAlertIcon(type) {
    const icons = {
        'success': 'fas fa-check-circle',
        'danger': 'fas fa-exclamation-circle',
        'warning': 'fas fa-exclamation-triangle',
        'info': 'fas fa-info-circle'
    };
    return icons[type] || icons['info'];
}

/**
 * ================================================
 * FORM LOADING STATES
 * ================================================
 */

/**
 * Inicializar estados de carga en formularios
 */
function initializeFormLoadingStates() {
    document.querySelectorAll('form').forEach(function(form) {
        form.addEventListener('submit', function(e) {
            const submitBtn = form.querySelector('button[type="submit"]');
            if (submitBtn && !submitBtn.disabled) {
                setButtonLoading(submitBtn, true);
                
                // Opcional: validar formulario antes de enviar
                if (!validateForm(form)) {
                    e.preventDefault();
                    setButtonLoading(submitBtn, false);
                    return false;
                }
            }
        });
    });
}

/**
 * Establecer estado de carga en un botón
 * @param {HTMLElement} button - Elemento botón
 * @param {boolean} loading - Estado de carga
 */
function setButtonLoading(button, loading) {
    if (!button) return;
    
    if (loading) {
        button.dataset.originalText = button.innerHTML;
        button.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Procesando...';
        button.disabled = true;
    } else {
        button.innerHTML = button.dataset.originalText || button.innerHTML;
        button.disabled = false;
    }
}

/**
 * Validación básica de formularios
 * @param {HTMLElement} form - Formulario a validar
 * @returns {boolean} - True si es válido
 */
function validateForm(form) {
    const requiredFields = form.querySelectorAll('[required]');
    let isValid = true;
    
    requiredFields.forEach(function(field) {
        if (!field.value.trim()) {
            field.classList.add('is-invalid');
            isValid = false;
        } else {
            field.classList.remove('is-invalid');
        }
    });
    
    if (!isValid) {
        showAlert('Por favor, complete todos los campos requeridos.', 'warning');
    }
    
    return isValid;
}

/**
 * ================================================
 * TOOLTIPS AND POPOVERS
 * ================================================
 */

/**
 * Inicializar tooltips de Bootstrap
 */
function initializeTooltips() {
    if (window.bootstrap && window.bootstrap.Tooltip) {
        const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
        const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => 
            new bootstrap.Tooltip(tooltipTriggerEl)
        );
    }
}

/**
 * ================================================
 * NOTIFICATIONS
 * ================================================
 */

/**
 * Inicializar sistema de notificaciones
 */
function initializeNotifications() {
    // Simular notificaciones en tiempo real
    // En un entorno real, esto se conectaría con WebSockets o SSE
    updateNotificationBadge();
}

/**
 * Actualizar badge de notificaciones
 */
function updateNotificationBadge() {
    // Esta función se llamaría desde el servidor o mediante AJAX
    // Por ahora es solo una demostración
    const badge = document.querySelector('.navbar-nav .badge');
    if (badge) {
        // Simular actualización de notificaciones
        // badge.textContent = newNotificationCount;
    }
}

/**
 * ================================================
 * UTILITY FUNCTIONS
 * ================================================
 */

/**
 * Confirmar acción con modal
 * @param {string} message - Mensaje de confirmación
 * @param {Function} callback - Función a ejecutar si se confirma
 */
function confirmAction(message, callback) {
    if (confirm(message)) {
        if (typeof callback === 'function') {
            callback();
        }
    }
}

/**
 * Formatear fecha para mostrar
 * @param {Date} date - Fecha a formatear
 * @returns {string} - Fecha formateada
 */
function formatDate(date) {
    if (!(date instanceof Date)) {
        date = new Date(date);
    }
    
    return date.toLocaleDateString('es-ES', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });
}

/**
 * Copiar texto al portapapeles
 * @param {string} text - Texto a copiar
 */
function copyToClipboard(text) {
    if (navigator.clipboard) {
        navigator.clipboard.writeText(text).then(() => {
            showAlert('Texto copiado al portapapeles', 'success', 2000);
        });
    } else {
        // Fallback para navegadores más antiguos
        const textArea = document.createElement('textarea');
        textArea.value = text;
        document.body.appendChild(textArea);
        textArea.select();
        document.execCommand('copy');
        document.body.removeChild(textArea);
        showAlert('Texto copiado al portapapeles', 'success', 2000);
    }
}

/**
 * ================================================
 * RESPONSIVE HANDLING
 * ================================================
 */

// Manejar cambios de tamaño de ventana
window.addEventListener('resize', function() {
    // Restaurar sidebar en escritorio si estaba colapsado
    if (window.innerWidth > 768) {
        const sidebar = document.getElementById('sidebar');
        if (sidebar && sidebar.classList.contains('show')) {
            sidebar.classList.remove('show');
        }
    }
});

/**
 * ================================================
 * GLOBAL EXPORTS (para uso desde otros archivos)
 * ================================================
 */

// Hacer funciones disponibles globalmente
window.LayoutManager = {
    showAlert,
    setButtonLoading,
    confirmAction,
    formatDate,
    copyToClipboard,
    validateForm
};