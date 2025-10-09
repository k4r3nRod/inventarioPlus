<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Configurar parámetros para el layout
    request.setAttribute("pageTitle", request.getAttribute("title") != null ? 
        (String)request.getAttribute("title") : "InventarioPlus - Dashboard");
    request.setAttribute("breadcrumb", "Dashboard");
%>

<jsp:include page="layout.jsp">
    <jsp:param name="content" value="dashboard-content.jsp" />
</jsp:include>
