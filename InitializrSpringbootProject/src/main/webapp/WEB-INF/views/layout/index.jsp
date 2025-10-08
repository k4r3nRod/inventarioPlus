<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Configurar parámetros para el layout
    request.setAttribute("pageTitle", "InventarioPlus - Sistema de Inventario");
    request.setAttribute("breadcrumb", "Inicio");
%>

<jsp:include page="layout.jsp">
    <jsp:param name="content" value="index-content.jsp" />
</jsp:include>
