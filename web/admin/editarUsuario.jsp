<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-900 text-white">
<div class="max-w-md mx-auto mt-12 bg-gray-800 p-6 rounded-lg shadow-lg">
    <h2 class="text-2xl font-bold text-blue-400 mb-6 text-center">👤 Editar Usuario</h2>

    <form action="${pageContext.request.contextPath}/admin/usuarios" method="post">
        <input type="hidden" name="idUsuario" value="${usuarioEdit.idUsuario}">

        <div class="mb-4">
            <label class="block mb-2">Nombre:</label>
            <input type="text" name="nombre" value="${usuarioEdit.nombre}" 
                   class="w-full px-3 py-2 rounded bg-gray-700 text-white">
        </div>

        <div class="mb-4">
            <label class="block mb-2">Email:</label>
            <input type="email" name="email" value="${usuarioEdit.email}"
                   class="w-full px-3 py-2 rounded bg-gray-700 text-white">
        </div>

        <div class="mb-4">
            <label class="block mb-2">Rol:</label>
            <select name="rol" class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                <option value="Admin" ${usuarioEdit.rol eq 'Admin' ? 'selected' : ''}>Admin</option>
                <option value="usuario" ${usuarioEdit.rol eq 'usuario' ? 'selected' : ''}>Usuario</option>
            </select>
        </div>

        <div class="mb-6">
            <label class="block mb-2">Estado:</label>
            <select name="estado" class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                <option value="1" ${usuarioEdit.estado == 1 ? 'selected' : ''}>Activo</option>
                <option value="0" ${usuarioEdit.estado == 0 ? 'selected' : ''}>Inactivo</option>
            </select>
        </div>

        <div class="flex justify-between">
            <button type="submit" class="bg-blue-600 hover:bg-blue-700 px-4 py-2 rounded-lg">Guardar</button>
            <a href="${pageContext.request.contextPath}/admin/usuarios" 
               class="bg-gray-600 hover:bg-gray-700 px-4 py-2 rounded-lg">Cancelar</a>
        </div>
    </form>
</div>
</body>
</html>

