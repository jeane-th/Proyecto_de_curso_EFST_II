
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    // validar desde el jsp
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
<html lang="es" data-theme="night">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel de Administración | AprendeYa</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.css" rel="stylesheet" />
    <link rel="icon" type="image/svg+xml" href="icons/icon_book.svg">
</head>

<body class="bg-gray-900 text-white font-sans min-h-screen">

    <header class="bg-gray-950 shadow-lg sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-6 flex items-center justify-between h-16">
            <div class="flex items-center space-x-3">
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                     stroke="currentColor" class="text-blue-600 size-8">
                    <path stroke-linecap="round" stroke-linejoin="round"
                          d="M12 6.042A8.967 8.967 0 0 0 6 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 0 1 6 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 0 1 6-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0 0 18 18a8.967 8.967 0 0 0-6 2.292m0-14.25v14.25" />
                </svg>
                <span class="text-2xl font-bold">Panel Admin | AprendeYa</span>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/"
                   class="text-sm bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition">
                    Volver al Inicio
                </a>
            </div>
        </div>
    </header>

    <main class="max-w-7xl mx-auto py-12 px-6">
        <h1 class="text-4xl font-bold text-blue-400 mb-8 text-center">Panel de Administración</h1>
        <p class="text-center text-gray-400 mb-12">
            Bienvenido <strong>${sessionScope.usuario.nombre}</strong> |
            Rol: <span class="text-blue-400 font-semibold">${sessionScope.usuario.rol}</span>
        </p>

        <div class="grid gap-8 md:grid-cols-2 lg:grid-cols-3">

            <!-- Gestión de Usuarios -->
            <div class="card bg-gray-800 border border-gray-700 hover:border-blue-600 transition transform hover:scale-105">
                <div class="card-body text-center">
                    <h2 class="text-2xl font-bold text-blue-400 mb-2">Usuarios</h2>
                    <p class="text-gray-400 mb-4">Administra las cuentas de usuarios registrados.</p>
                    <a href="${pageContext.request.contextPath}/admin/usuarios"
                       class="btn bg-blue-600 hover:bg-blue-700 border-none">Ver Usuarios</a>
                </div>
            </div>

            <div class="card bg-gray-800 border border-gray-700 hover:border-blue-600 transition transform hover:scale-105">
                <div class="card-body text-center">
                    <h2 class="text-2xl font-bold text-blue-400 mb-2">Cursos</h2>
                    <p class="text-gray-400 mb-4">Agrega, edita o elimina cursos disponibles.</p>
                    <a href="${pageContext.request.contextPath}/admin/cursos"
                       class="btn bg-blue-600 hover:bg-blue-700 border-none">Ver Cursos</a>
                </div>
            </div>

            <div class="card bg-gray-800 border border-gray-700 hover:border-blue-600 transition transform hover:scale-105">
                <div class="card-body text-center">
                    <h2 class="text-2xl font-bold text-blue-400 mb-2">Reportes</h2>
                    <p class="text-gray-400 mb-4">Consulta métricas del sistema y rendimiento.</p>
                    <a href="${pageContext.request.contextPath}/admin/reportes"
                       class="btn bg-blue-600 hover:bg-blue-700 border-none">Ver Reportes</a>
                </div>
            </div>

            <div class="card bg-gray-800 border border-gray-700 hover:border-blue-600 transition transform hover:scale-105">
                <div class="card-body text-center">
                    <h2 class="text-2xl font-bold text-blue-400 mb-2">Comentarios</h2>
                    <p class="text-gray-400 mb-4">Revisa y modera reseñas de los cursos.</p>
                    <a href="${pageContext.request.contextPath}/admin/comentarios"
                       class="btn bg-blue-600 hover:bg-blue-700 border-none">Ver Reseñas</a>
                </div>
            </div>

            <div class="card bg-gray-800 border border-gray-700 hover:border-blue-600 transition transform hover:scale-105">
                <div class="card-body text-center">
                    <h2 class="text-2xl font-bold text-blue-400 mb-2">Cerrar Sesión</h2>
                    <p class="text-gray-400 mb-4">Salir del panel de administración.</p>
                    <a href="${pageContext.request.contextPath}/LogoutServlet"
                       class="btn bg-red-600 hover:bg-red-700 border-none">Cerrar Sesión</a>
                </div>
            </div>
        </div>
    </main>

    <footer class="footer footer-center p-4 bg-gray-900 text-gray-500 border-t border-gray-800 mt-12">
        <p>© 2026 AprendeYa. Todos los derechos reservados.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.js"></script>
</body>
</html>