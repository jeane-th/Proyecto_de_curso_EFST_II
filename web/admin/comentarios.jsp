<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    // validar por sesión y rol
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
        <title>Gestión de Comentarios | Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet" />
    </head>

    <body class="bg-gray-900 text-white min-h-screen font-sans">

        <!-- header -->
        <header class="bg-gray-950 shadow-lg sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-6 flex items-center justify-between h-16">
                <h1 class="text-2xl font-bold text-blue-400">💬 Gestión de Comentarios</h1>
                <a href="${pageContext.request.contextPath}/dashboardAdmin"
                   class="bg-blue-600 hover:bg-blue-700 px-4 py-2 rounded-lg text-sm transition">
                    ⬅ Volver al Panel
                </a>
            </div>
        </header>

        <!-- main -->
        <main class="max-w-7xl mx-auto py-10 px-6">

            <h2 class="text-3xl font-bold text-blue-400 mb-6">
                Lista de Comentarios
            </h2>

            <div class="overflow-x-auto">
                <table class="table w-full border border-gray-700 text-sm">
                    <thead class="bg-gray-700 text-blue-300 uppercase">
                        <tr>
                            <th>ID</th>
                            <th>Usuario</th>
                            <th>Curso</th>
                            <th>Comentario</th>
                            <th>Valoración</th>
                            <th>Fecha</th>
                            <th>Estado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>

                    <tbody>
                        <c:forEach var="c" items="${listaComentarios}">
                            <tr class="hover:bg-gray-800">
                                <td  class="py-2 px-4">${c.idReview}</td>
                                <td  class="py-2 px-4 font-semibold text-blue-400"> ${c.usuario} </td>
                                <td  class="py-2 px-4">${c.curso}</td>
                                <td  class="py-2 px-4 max-w-xs ">${c.comentario}</td>
                                <td class="py-2 px-4">⭐ ${c.valoracion} </td>
                                <td  class="py-2 px-4 text-gray-400 text-sm"">${c.fecha} </td>
                                <td  class="py-2 px-4">
                                    <c:choose>
                                        <c:when test="${c.estado == 1}">
                                            <span class="text-green-400 font-semibold">Activo</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-red-400 font-semibold">Inactivo</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="flex gap-2">

                                    <!-- boton activar / desactivar -->
                                    <a href="${pageContext.request.contextPath}/admin/comentarios?accion=estado&id=${c.idReview}&estado=${c.estado == 1 ? 0 : 1}"

                                       class="inline-flex items-center gap-1 bg-yellow-500 hover:bg-yellow-600 text-white px-3 py-1 rounded-md text-sm whitespace-nowrap min-w-max">

                                        🔄 Estado
                                    </a>

                                    <!-- eliminar -->
                                    <a href="${pageContext.request.contextPath}/admin/comentarios?accion=eliminar&id=${c.idReview}"
                                       class="inline-flex items-center gap-1 bg-red-600 hover:bg-red-700 text-white px-3 py-1 rounded-md text-sm whitespace-nowrap min-w-max"

                                       onclick="return confirm('¿Eliminar este comentario?');">
                                        🗑️ Eliminar
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