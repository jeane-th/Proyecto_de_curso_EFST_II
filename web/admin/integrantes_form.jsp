<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
    <title>Formulario Integrante</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet"/>
</head>

<body class="bg-gray-900 text-white min-h-screen flex items-center justify-center">

<div class="bg-gray-800 p-8 rounded-lg shadow-lg w-full max-w-lg">

    <h2 class="text-2xl font-bold text-blue-400 mb-6 text-center">
        ${integrante == null ? "➕ Nuevo Integrante" : "✏ Editar Integrante"}
    </h2>

    <form action="${pageContext.request.contextPath}/admin/integrantes" method="post" class="space-y-4">

        <input type="hidden" name="idIntegrante" value="${integrante.idIntegrante}"/>

        <div>
            <label class="label">Nombre</label>
            <input type="text" name="nombre" required
                   value="${integrante.nombre}"
                   class="input input-bordered w-full text-black"/>
        </div>

        <div>
            <label class="label">Función</label>
            <input type="text" name="funcion" required
                   value="${integrante.funcion}"
                   class="input input-bordered w-full text-black"/>
        </div>

        <div>
            <label class="label">Descripción</label>
            <textarea name="descripcion"
                      class="textarea textarea-bordered w-full text-black">${integrante.descripcion}</textarea>
        </div>

        <div class="flex justify-between mt-6">
            <a href="${pageContext.request.contextPath}/admin/integrantes" class="btn btn-outline">Cancelar</a>
            <button type="submit" class="btn btn-primary">Guardar</button>
        </div>

    </form>
</div>

</body>
</html>