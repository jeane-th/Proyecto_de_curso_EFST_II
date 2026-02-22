<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Editar Curso</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-900 text-white">
        <header class="bg-gray-950 shadow-lg sticky top-0 z-50">
            <div class="max-w-7xl mx-auto px-6 flex items-center justify-between h-16">
                <h1 class="text-2xl font-bold text-blue-400">✏️ Editar Curso</h1>
                <a href="${pageContext.request.contextPath}/admin/cursos"
                   class="text-sm bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg transition">⬅ Volver a Cursos</a>
            </div>
        </header>

        <div class="max-w-3xl mx-auto mt-12 bg-gray-800 p-6 rounded-lg shadow-lg">
            <h2 class="text-2xl font-bold text-blue-400 mb-6 text-center">Curso</h2>

            <form action="${pageContext.request.contextPath}/admin/cursos" method="post">
                <input type="hidden" name="idCurso" value="${curso.idCurso}">
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
                                      class="w-full px-3 py-2 rounded bg-gray-700 text-white">${curso.descripcion}</textarea>
                        </div>

                        <div class="mb-4">
                            <label class="block mb-2 text-blue-400">Categoría:</label>
                            <input type="text" name="categoria"  required value="${curso.categoria}" 
                                   class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                        </div>

                        <div class="mb-4">
                            <label class="block mb-2 text-blue-400">Imagen URL:</label>
                            <input type="text" name="imagen" required value="${curso.imagen}" 
                                   class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                        </div>

                    </div>
                    <div class="flex-1">
                        <div class="mb-4">
                            <label class="block mb-2 text-blue-400" >Video URL:</label>
                            <input type="text" name="video" required value="${curso.video}" 
                                   class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                        </div>

                        <div class="mb-4">
                            <label class="block mb-2 text-blue-400" >Profesor:</label>
                            <input type="text" name="profesor" required value="${curso.profesor}" 
                                   class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                        </div>
                        <div class="mb-4">
                            <label class="block mb-2 text-blue-400">Precio:</label>
                            <input type="number" name="precio" required value="${curso.precio}" 
                                   class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                        </div>

                        <div class="mb-4">
                            <label class="block mb-2 text-blue-400">Duración (horas)</label>
                            <input type="number" name="duracion" required value="${curso.duracion}" 
                                   class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                        </div>
                        <div class="mb-6">
                            <label class="block mb-2 text-blue-400">Estado:</label>
                            <select name="estado" required class="w-full px-3 py-2 rounded bg-gray-700 text-white">
                                <option value="true" <c:if test="${curso.estado}">selected</c:if>>Activo</option>
                                <option value="false" <c:if test="${not curso.estado}">selected</c:if>>Inactivo</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="flex justify-between">
                        <button type="submit" class="bg-blue-600 hover:bg-blue-700 px-4 py-2 rounded-lg">Guardar</button>
                        <a href="${pageContext.request.contextPath}/admin/cursos" 
                       class="bg-gray-600 hover:bg-gray-700 px-4 py-2 rounded-lg">Cancelar</a>
                </div>

            </form>
        </div>


    </body>
</html>