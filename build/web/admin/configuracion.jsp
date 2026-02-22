<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Configuración | Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet" />
</head>

<body class="bg-gray-900 text-white min-h-screen">

    <div class="max-w-5xl mx-auto py-10 px-6">
        <h1 class="text-3xl font-bold text-blue-400 mb-6">⚙ Configuración</h1>

        <div class="grid md:grid-cols-2 gap-6">

            <!-- formulario integrantes -->
            <div class="card bg-gray-800 border border-gray-700">
                <div class="card-body">
                    <h2 class="card-title text-blue-400">Integrantes del Proyecto</h2>
                    <p class="text-gray-400">
                        Gestiona los integrantes y su rol en el proyecto.
                    </p>
                    <a href="${pageContext.request.contextPath}/admin/integrantes" 
                       class="btn bg-blue-600 hover:bg-blue-700 border-none">
                        Gestionar Integrantes
                    </a>
                </div>
            </div>

            <!-- formulario cambiar contraseña -->
            <div class="card bg-gray-800 border border-gray-700">
                <div class="card-body">
                    <h2 class="card-title text-blue-400">Cambiar Contraseña</h2>
                    <p class="text-gray-400">
                        Actualiza la contraseña del administrador.
                    </p>
                    <a href="${pageContext.request.contextPath}/admin/cambiar_password" 
                        class="btn bg-yellow-600 hover:bg-yellow-700 border-none">
                        Cambiar Contraseña
                    </a>
                </div>
            </div>

        </div>

        <div class="mt-8">
            <a href="${pageContext.request.contextPath}/dashboardAdmin"
               class="btn bg-gray-700 hover:bg-gray-600 border-none">
                ⬅ Volver al Panel
            </a>
        </div>
    </div>

</body>
</html>