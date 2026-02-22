<%@page contentType="text/html;charset=UTF-8" %>
<%@page import="modelo.Usuario"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // 🔒 Validación de sesión y rol Admin
    Usuario u = (Usuario) session.getAttribute("usuario");
    if (u == null || u.getRol() == null || !u.getRol().equalsIgnoreCase("Admin")) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cambiar Contraseña | Admin</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet"/>
</head>
<body class="bg-gray-900 text-white min-h-screen flex items-center justify-center">

<div class="bg-gray-800 p-8 rounded-lg shadow-lg w-full max-w-md">

    <h2 class="text-2xl font-bold text-blue-400 mb-6 text-center">
        🔒 Cambiar Contraseña
    </h2>

    <form action="${pageContext.request.contextPath}/admin/cambiar_password" method="post" class="space-y-4">

        <div>
            <label class="label">Contraseña Actual</label>
            <input type="password" name="actual" required
                   class="input input-bordered w-full text-black"/>
        </div>

        <div>
            <label class="label">Nueva Contraseña</label>
            <input type="password" name="nueva" required
                   class="input input-bordered w-full text-black"/>
        </div>

        <div>
            <label class="label">Confirmar Nueva Contraseña</label>
            <input type="password" name="confirmar" required
                   class="input input-bordered w-full text-black"/>
        </div>

        <div class="flex justify-between mt-6">
            <a href="${pageContext.request.contextPath}/dashboardAdmin" class="btn btn-outline text-white">
                ⬅ Volver al Panel
            </a>
            <button type="submit" class="btn btn-primary">Actualizar</button>
        </div>

        <c:if test="${not empty mensaje}">
            <p class="mt-4 text-center text-red-500 font-semibold">${mensaje}</p>
        </c:if>

    </form>
</div>

</body>
</html>