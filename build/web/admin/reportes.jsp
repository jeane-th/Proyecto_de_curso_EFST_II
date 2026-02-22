<%@ page contentType="text/html;charset=UTF-8" %>

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
    <title>Reportes | Panel Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet" />
</head>

<body class="bg-gray-900 text-white min-h-screen font-sans">


<header class="bg-gray-950 shadow-lg sticky top-0 z-50">
    <div class="max-w-7xl mx-auto px-6 flex items-center justify-between h-16">
        <h1 class="text-2xl font-bold text-blue-400">📊 Reportes Generales</h1>
        <a href="${pageContext.request.contextPath}/dashboardAdmin"
           class="text-sm bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition">
            ⬅ Volver al Panel
        </a>
    </div>
</header>


<main class="max-w-7xl mx-auto py-10 px-6">

    <h2 class="text-3xl font-bold text-blue-400 mb-8">
        Resumen del Sistema
    </h2>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">

        <div class="bg-gray-800 rounded-xl p-6 text-center shadow hover:shadow-lg transition">
            <p class="text-gray-400 uppercase text-sm">Usuarios</p>
            <h2 class="text-5xl font-bold text-blue-400 mt-2">
                ${totalUsuarios}
            </h2>
        </div>

        <div class="bg-gray-800 rounded-xl p-6 text-center shadow hover:shadow-lg transition">
            <p class="text-gray-400 uppercase text-sm">Cursos</p>
            <h2 class="text-5xl font-bold text-green-400 mt-2">
                ${totalCursos}
            </h2>
        </div>

        <div class="bg-gray-800 rounded-xl p-6 text-center shadow hover:shadow-lg transition">
            <p class="text-gray-400 uppercase text-sm">Matrículas</p>
            <h2 class="text-5xl font-bold text-yellow-400 mt-2">
                ${totalMatriculas}
            </h2>
        </div>

        <div class="bg-gray-800 rounded-xl p-6 text-center shadow hover:shadow-lg transition">
            <p class="text-gray-400 uppercase text-sm">Reviews</p>
            <h2 class="text-5xl font-bold text-purple-400 mt-2">
                ${totalReviews}
            </h2>
        </div>

    </div>

    <div class="text-center mt-10">
        <a href="${pageContext.request.contextPath}/dashboardAdmin"
           class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-lg transition">
            Volver al Panel
        </a>
    </div>

</main>

</body>
</html>