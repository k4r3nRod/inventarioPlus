<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Configurar parámetros para el layout
    request.setAttribute("pageTitle", "Iniciar Sesión - InventarioPlus");
    request.setAttribute("breadcrumb", "Login");
%>

<jsp:include page="layout.jsp">
    <jsp:param name="content" value="login-content.jsp" />
</jsp:include>