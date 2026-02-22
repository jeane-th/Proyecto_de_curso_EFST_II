<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    // validar
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String rol = (String) session.getAttribute("rol");
    if (rol == null || !rol.equalsIgnoreCase("Admin")) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Integrantes del Proyecto</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet"/>
</head>

<body class="bg-gray-900 text-white min-h-screen">

<header class="bg-gray-950 shadow sticky top-0">
    <div class="max-w-7xl mx-auto px-6 h-16 flex justify-between items-center">
        <h1 class="text-2xl font-bold text-blue-400">👨‍💻 Integrantes del Proyecto</h1>
        <a href="${pageContext.request.contextPath}/dashboardAdmin"
           class="btn btn-sm btn-primary">⬅ Volver</a>
    </div>
</header>

<main class="max-w-7xl mx-auto px-6 py-10">

    <div class="flex justify-between items-center mb-6">
        <h2 class="text-3xl font-bold text-blue-400">Listado</h2>
        <a href="${pageContext.request.contextPath}/admin/integrantes_form.jsp"
           class="btn btn-success">➕ Nuevo Integrante</a>
    </div>

    <div class="overflow-x-auto">
        <table class="table w-full bg-gray-800 text-sm">
            <thead class="bg-gray-700 text-blue-300">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Función</th>
                    <th>Descripción</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="i" items="${listaIntegrantes}">
                    <tr class="hover:bg-gray-700">
                        <td>${i.idIntegrante}</td>
                        <td class="font-semibold">${i.nombre}</td>
                        <td>${i.funcion}</td>
                        <td>${i.descripcion}</td>
                        <td class="flex gap-2">
                            <a href="${pageContext.request.contextPath}/admin/integrantes?accion=editar&id=${i.idIntegrante}"
                               class="btn btn-xs btn-warning">✏ Editar</a>
                            <a href="${pageContext.request.contextPath}/admin/integrantes?accion=eliminar&id=${i.idIntegrante}"
                               class="btn btn-xs btn-error"
                               onclick="return confirm('¿Eliminar integrante?');">
                               🗑 Eliminar
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</main>

</body>
</html>