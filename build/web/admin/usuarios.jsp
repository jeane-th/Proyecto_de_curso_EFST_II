<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // seguridad
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
        <title>Gestión de Usuarios | Panel Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet" type="text/css" />
    </head>

    <body class="bg-gray-900 text-white font-sans min-h-screen">

        <header class="bg-gray-950 shadow-lg sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-6 flex items-center justify-between h-16">
                <h1 class="text-2xl font-bold text-blue-400">👥 Gestión de Usuarios</h1>
                <a href="${pageContext.request.contextPath}/dashboardAdmin"
                   class="text-sm bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition">⬅ Volver al Panel</a>
            </div>
        </header>

        <main class="max-w-7xl mx-auto py-10 px-6">
            <h2 class="text-3xl font-bold mb-6 text-center text-blue-400">Lista de Usuarios Registrados</h2>

            <div class="overflow-x-auto">
                <table class="table w-full border border-gray-700">
                    <thead class="bg-gray-800 text-blue-300 uppercase text-sm">
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Email</th>
                            <th>País</th>
                            <th>Rol</th>
                            <th>Estado</th>
                            <th>Fecha Registro</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${listaUsuarios}">
                            <tr class="hover:bg-gray-800 transition">
                                <td class="py-2 px-4">${u.idUsuario}</td>
                                <td class="py-2 px-4">${u.nombre}</td>
                                <td class="py-2 px-4">${u.email}</td>
                                <td class="py-2 px-4">${u.pais}</td>
                                <td class="py-2 px-4">
                                    <span class="${u.rol eq 'Admin' ? 'text-blue-400 font-semibold' : 'text-gray-300'}">${u.rol}</span>
                                </td>
                                <td class="py-2 px-4">
                                    <c:choose>
                                        <c:when test="${u.estado == 1}">
                                            <span class="text-green-400 font-semibold">Activo</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-red-400 font-semibold">Inactivo</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="py-2 px-4 text-gray-400 text-sm">${u.fechaRegistro}</td>

                                <!-- funciones -->
                                <td class="py-2 px-4 space-x-2 text-center">
                                    <!-- editar -->
                                    <a href="${pageContext.request.contextPath}/admin/usuarios?action=edit&id=${u.idUsuario}"
                                       class="inline-block bg-yellow-500 hover:bg-yellow-600 text-white px-3 py-1 rounded-md text-sm">
                                        ✏️ Editar
                                    </a>
                                    <!-- eliminar -->
                                    <a href="${pageContext.request.contextPath}/admin/usuarios?action=delete&id=${u.idUsuario}"
                                       class="inline-block  bg-red-600 hover:bg-red-700 text-white px-3 py-1 rounded-md text-sm"
                                       onclick="return confirm('¿Seguro que deseas eliminar este usuario?');">
                                        🗑️ Eliminar
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="text-center mt-8">
                <a href="${pageContext.request.contextPath}/dashboardAdmin"
                   class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-lg transition">
                    Volver al Panel
                </a>
            </div>
        </main>

    </body>
</html>