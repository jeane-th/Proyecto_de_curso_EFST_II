<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
    // Validación de sesión
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
        <title>Agregar Curso | Panel Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet" type="text/css" />
    </head>

    <body class="bg-gray-900 text-white min-h-screen font-sans">

        <header class="bg-gray-950 shadow-lg sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-6 flex items-center justify-between h-16">
                <h1 class="text-2xl font-bold text-blue-400">➕ Agregar Curso</h1>
                <a href="${pageContext.request.contextPath}/admin/cursos"
                   class="text-sm bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition">⬅ Volver a Cursos</a>
            </div>
        </header>

        <main class="max-w-3xl mx-auto py-10 px-6">

            <!-- Mensajes de error o éxito -->
            <c:if test="${param.error != null}">
                <div class="bg-red-600 text-white px-4 py-2 mb-4 rounded">
                    ⚠ Ocurrió un error al agregar el curso. Intenta nuevamente.
                </div>
            </c:if>

            <div class="max-w-3xl mx-auto mt-12 bg-gray-800 p-6 rounded-lg shadow-lg">
                <h2 class="text-2xl font-bold text-blue-400 mb-6 text-center">Curso</h2>
                <form action="${pageContext.request.contextPath}/admin/agregarCurso" method="post">
                    <div class="flex flex-row gap-10">
                        <div class="flex-1">
                            <div class="mb-4 w-full">
                                <label class="block mb-2 text-blue-400">Título:</label>
                                <input type="text" name="titulo" required value="${curso.titulo}" 
                                       class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                            </div>

                            <div class="mb-4">
                                <label class="block mb-4 text-blue-400">Descripción:</label>
                                <textarea name="descripcion"
                                          rows="4"
                                          required
                                          class="w-full px-3 py-2 rounded bg-gray-700 text-white"></textarea>
                            </div>

                            <div class="mb-4">
                                <label class="block mb-2 text-blue-400">Categoría:</label>
                                <input type="text" name="categoria"  required 
                                       class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                            </div>

                            <div class="mb-4">
                                <label class="block mb-2 text-blue-400">Imagen URL:</label>
                                <input type="text" name="imagen" required 
                                       class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                            </div>

                        </div>
                        <div class="flex-1">
                            <div class="mb-4">
                                <label class="block mb-2 text-blue-400" >Video URL:</label>
                                <input type="text" name="video" required
                                       class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                            </div>

                            <div class="mb-4">
                                <label class="block mb-2 text-blue-400" >Profesor:</label>
                                <input type="text" name="profesor" required 
                                       class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                            </div>
                            <div class="mb-4">
                                <label class="block mb-2 text-blue-400">Precio:</label>
                                <input type="number" name="precio" required
                                       class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                            </div>

                            <div class="mb-4">
                                <label class="block mb-2 text-blue-400">Duración (horas)</label>
                                <input type="number" name="duracion" required 
                                       class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                            </div>
                            <div class="mb-6">
                                <label class="block mb-2 text-blue-400">Estado:</label>
                                <select name="estado" required class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                                    <option value="true">Activo</option>
                                    <option value="false">Inactivo</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="flex justify-between">
                        <button type="submit" class="bg-green-600 hover:bg-green-700  px-4 py-2 rounded-lg">Guardar</button>
                        <a href="${pageContext.request.contextPath}/admin/cursos" 
                           class="bg-gray-600 hover:bg-gray-700 px-4 py-2 rounded-lg">Cancelar</a>
                    </div>

                </form>

            </div>

        </main>

    </body>
</html>