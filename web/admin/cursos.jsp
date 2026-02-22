<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    //validacion
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
    <title>Gestión de Cursos | Panel Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet" type="text/css" />
</head>

<body class="bg-gray-900 text-white min-h-screen font-sans">

<header class="bg-gray-950 shadow-lg sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-6 flex items-center justify-between h-16">
        <h1 class="text-2xl font-bold text-blue-400">📚 Gestión de Cursos</h1>
        <a href="${pageContext.request.contextPath}/dashboardAdmin"
           class="text-sm bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition">⬅ Volver al Panel</a>
    </div>
</header>

<main class="max-w-7xl mx-auto py-10 px-6">
    <div class="flex justify-between items-center mb-6">
        <h2 class="text-3xl font-bold text-blue-400">Lista de Cursos Disponibles</h2>
        <a href="${pageContext.request.contextPath}/admin/agregarCurso.jsp"
           class="bg-green-600 hover:bg-green-700 text-white px-4 py-2 rounded-lg font-semibold transition">
           ➕ Nuevo Curso
        </a>
    </div>

    <!-- Mensajes de éxito o error -->
    <c:if test="${param.success == 'insertar'}">
        <div class="bg-green-600 text-white px-4 py-2 mb-4 rounded">
            ✅ Curso agregado correctamente.
        </div>
    </c:if>

    <c:if test="${param.success == 'actualizar'}">
        <div class="bg-green-600 text-white px-4 py-2 mb-4 rounded">
            ✅ Curso actualizado correctamente.
        </div>
    </c:if>

    <c:if test="${param.success == 'eliminar'}">
        <div class="bg-green-600 text-white px-4 py-2 mb-4 rounded">
            ✅ Curso eliminado correctamente.
        </div>
    </c:if>

    <c:if test="${param.error != null}">
        <div class="bg-red-600 text-white px-4 py-2 mb-4 rounded">
            ⚠ Ocurrió un error al procesar la acción. Intenta nuevamente.
        </div>
    </c:if>

    <div class="overflow-x-auto">
        <table class="table w-full border border-gray-700 text-sm">
            <thead class="bg-gray-800 text-blue-300 uppercase">
                <tr>
                    <th>ID</th>
                    <th>Título</th>
                    <th>Categoría</th>
                    <th>Profesor</th>
                    <th>Precio</th>
                    <th>Duración</th>
                    <th>Matriculados</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="c" items="${listaCursos}">
                    <tr class="hover:bg-gray-800">
                        <td class="py-2 px-4">${c.idCurso}</td>
                        <td class="py-2 px-4 font-semibold text-blue-400">${c.titulo}</td>
                        <td class="py-2 px-4">${c.categoria}</td>
                        <td class="py-2 px-4">${c.profesor}</td>
                        <td class="py-2 px-4 text-green-400">S/ ${c.precio}</td>                     
                        <td class="py-2 px-4">${c.duracion}</td>
                        <td class="py-2 px-4 text-yellow-400 font-semibold">${c.totalMatriculados}</td>
                        <td class="py-2 px-4">
                            <c:choose>
                                <c:when test="${c.estado}">
                                    <span class="text-green-400 font-semibold">Activo</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-red-400 font-semibold">Inactivo</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="py-2 px-4 flex gap-2">
                            <a href="${pageContext.request.contextPath}/admin/cursos?action=editar&id=${c.idCurso}"
                                class="bg-yellow-500 hover:bg-yellow-600 text-white px-3 py-1 rounded text-xs font-semibold transition">
                                ✏ Editar
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/cursos?action=eliminar&id=${c.idCurso}"
                                class="bg-red-600 hover:bg-red-700 text-white px-3 py-1 rounded text-xs font-semibold transition"
                                onclick="return confirm('¿Estás seguro de eliminar el curso \"${c.titulo}\"?');">
                                 🗑 Eliminar
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