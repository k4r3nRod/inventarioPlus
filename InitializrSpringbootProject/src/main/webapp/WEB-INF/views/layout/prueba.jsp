<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Configurar parámetros para el layout
    request.setAttribute("pageTitle", "Página de Prueba - Sistema Demo");
    request.setAttribute("breadcrumb", "Prueba");
%>

<jsp:include page="layout.jsp">
    <jsp:param name="content" value="prueba-content.jsp" />
</jsp:include>