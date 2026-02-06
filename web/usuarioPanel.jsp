<%@page import="java.util.List"%>
<%@page import="modelo.Usuario"%>
<%@page import="dao.UsuarioDAOImpl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    UsuarioDAOImpl dao = new UsuarioDAOImpl();
    List<Usuario> listaUsuarios = dao.listarUsuarios();
%>


<!DOCTYPE html>
<html data-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Gestión de Usuarios - AprendeYa</title>

        <link href="https://cdn.jsdelivr.net/npm/daisyui@3.9.4/dist/full.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-base-300 min-h-screen">

        <div class="p-8 text-base-content max-w-[1400px] mx-auto">

            <div class="flex items-center gap-4 mb-6">
                <a href="${pageContext.request.contextPath}/"class="btn btn-ghost btn-sm text-gray-400">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" /></svg>
                    Volver
                </a>
                <div class="text-sm breadcrumbs text-gray-400
                     <ul>
                     <li><a href="cursoPanel.jsp">Panel de Administración</a></li>
                    </ul>
                </div>
            </div>

            <div class="tabs tabs-boxed bg-transparent mb-8 gap-4 border-b border-white/10 rounded-none pb-0">
                <a href="cursoPanel.jsp" class="tab hover:text-white">Cursos</a>
                <a class="tab tab-active text-primary border-b-2 border-primary font-bold bg-transparent">Usuarios</a>
                <a class="tab hover:text-white">Matrículas</a>
                <a class="tab hover:text-white">Reseñas</a>
                <a class="tab hover:text-white">Reportes</a>
            </div>

            <div class="mb-8">
                <h1 class="text-3xl font-bold text-white mb-2">Gestión de Usuarios v2</h1>
                <p class="text-gray-400">Administra usuarios, edita datos y gestiona accesos</p>
                <p class="text-gray-400">Total registrados: <%= listaUsuarios.size()%></p>
            </div>

            <div class="bg-[#1d232a] p-4 rounded-lg border border-white/5 mb-6 flex flex-wrap gap-4 items-center">
                <div class="relative grow max-w-md">
                    <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">🔍</span>
                    <input type="text" id="searchInput" 
                           oninput="filterUsers()" placeholder="Buscar por nombre o email..." class="input input-bordered w-full pl-10 bg-[#15191e] border-white/10 focus:border-primary" />
                </div>

                <select id="roleFilter"
                        onchange="filterUsers()" class="select select-bordered bg-[#15191e] border-white/10 min-w-[180px]">
                    <option value="all">Todos los roles</option>
                    <option value="estudiante">Estudiante</option>
                    <option value="instructor">Instructor</option>
                    <option value="admin">Admin</option>
                </select>

                <select id="statusFilter" 
                        onchange="filterUsers()" class="select select-bordered bg-[#15191e] border-white/10 min-w-[180px]">
                    <option value="all" selected>Todos los estados</option>
                    <option value="active">Activo</option>
                    <option value="blocked">Bloqueado</option>
                </select>
            </div>

            <div class="overflow-x-auto bg-[#1d232a] rounded-lg border border-white/5 shadow-xl">
                <table class="table w-full">
                    <thead class="bg-base-200/50 text-gray-400 font-semibold uppercase text-xs">
                        <tr>
                            <th class="py-4 pl-6">Usuario</th>
                            <th>Rol</th>
                            <th>Cursos</th> 
                            <th>Estado</th>
                            <th class="pr-6 text-right">Acciones</th>
                        </tr>
                    </thead>
                    <tbody class="text-sm" id="usersTableBody">

                        <%
                            for (Usuario u : listaUsuarios) {
                                String iniciales = "US";
                                if (u.getNombre() != null && u.getNombre().length() >= 2) {
                                    iniciales = u.getNombre().substring(0, 2).toUpperCase();
                                }

                                String rolNormalizado = (u.getRol() != null) ? u.getRol().toLowerCase() : "usuario";
                                // Si en la BD dice 'USUARIO', visualmente es 'Estudiante'
                                String rolVisual = "Estudiante";
                                String badgeClass = "badge-primary";
                                String badgeColor = "text-blue-400 border-blue-500/20 bg-blue-500/10";

                                if ("instructor".equals(rolNormalizado)) {
                                    rolVisual = "Instructor";
                                    badgeClass = "badge-accent";
                                    badgeColor = "text-emerald-400 border-emerald-500/20 bg-emerald-500/10";
                                } else if ("admin".equals(rolNormalizado) || "administrador".equals(rolNormalizado)) {
                                    rolVisual = "Admin";
                                    badgeClass = "badge-secondary";
                                    badgeColor = "text-purple-400 border-purple-500/20 bg-purple-500/10";
                                }

                                boolean esActivo = (u.getEstado() == 1);
                                String estadoClass = esActivo ? "text-green-400 border-green-500/20 bg-green-500/10" : "text-red-400 border-red-500/20 bg-red-500/10";
                                String estadoTexto = esActivo ? "Activo" : "Bloqueado";
                                String statusKey = esActivo ? "active" : "blocked";
                        %>

                        <tr class="user-row hover:bg-white/5 border-b border-white/5 transition-colors" 
                            data-role="<%= rolVisual.toLowerCase()%>"
                            data-status="<%= statusKey%>" > <td class="pl-6 py-4">
                                <div class="flex items-center space-x-3">
                                    <div class="avatar placeholder">
                                        <div class="bg-neutral text-neutral-content mask mask-circle w-10 h-10">
                                            <span class="font-bold"><%= iniciales%></span>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="font-bold text-white"><%= u.getNombre()%></div>
                                        <div class="text-xs text-gray-500"><%= u.getEmail()%></div>
                                    </div>
                                </div>
                            </td>

                            <td>
                                <span class="badge <%= badgeClass%> badge-outline <%= badgeColor%>">
                                    <%= rolVisual%>
                                </span>
                            </td>

                            <td>
                                <div class="<%= u.getNroCursos() > 0 ? "text-white font-bold" : "text-gray-500"%>">
                                    <%= u.getNroCursos()%> inscritos
                                </div>
                            </td>

                            <td><span class="badge badge-sm <%= estadoClass%>"><%= estadoTexto%></span></td>

                            <td class="text-center">
                                <div class="dropdown dropdown-left">
                                    <div tabindex="0" role="button" class="btn btn-ghost btn-circle btn-sm">
                                        <i class="fa-solid fa-ellipsis-vertical text-lg">⋮</i>
                                    </div>

                                    <ul tabindex="0" class="dropdown-content z-[1] menu p-2 shadow bg-base-100 rounded-box w-52">
                                        <li>
                                            <a onclick="abrirModalEditar('<%= u.getIdUsuario()%>', '<%= u.getNombre()%>', '<%= u.getEmail()%>', '<%= u.getRol()%>', '<%= u.getEstado()%>')">
                                                <i class="fa-regular fa-pen-to-square"></i> Editar
                                            </a>
                                        </li>
                                        <li>
                                            <a class="text-error" href="UsuarioServlet?accion=bloquear&idUsuario=<%= u.getIdUsuario()%>">
                                                <i class="fa-solid fa-lock"></i> Bloquear Usuario
                                            </a>
                                        </li>
                                        <li>
                                            <a class="text-error font-bold" 
                                               href="UsuarioServlet?accion=eliminar&idUsuario=<%= u.getIdUsuario()%>"
                                               onclick="return confirm('⚠️ ¿Estás seguro de eliminar a este usuario? Pasará a estado Inactivo.')">
                                                <i class="fa-solid fa-trash-can"></i> Eliminar
                                            </a>
                                        </li>

                                    </ul>
                                </div>
                            </td>

                        </tr>

                        <% }%>

                    </tbody>
                </table>

                <div id="noResults" class="hidden p-8 text-center text-gray-500">
                    No se encontraron usuarios con ese filtro.
                </div>
            </div>
        </div>

        <script>
            function filterUsers() {
                console.log("¡Ejecutando filtro!"); // Si ves esto en la consola, ¡ya ganamos!

                const roleFilter = document.getElementById('roleFilter');
                const statusFilter = document.getElementById('statusFilter');
                const searchInput = document.getElementById('searchInput');
                const rows = document.querySelectorAll('.user-row');
                const noResults = document.getElementById('noResults');

                const selectedRole = roleFilter.value.toLowerCase();
                const selectedStatus = statusFilter.value;
                const searchTerm = searchInput.value.toLowerCase();

                let visibleCount = 0;

                rows.forEach(row => {
                    const rowRole = row.getAttribute('data-role');
                    const rowStatus = row.getAttribute('data-status');
                    const rowText = row.innerText.toLowerCase();

                    const matchesRole = (selectedRole === 'all') || (rowRole === selectedRole);
                    const matchesStatus = (selectedStatus === 'all') || (rowStatus === selectedStatus);
                    const matchesSearch = rowText.includes(searchTerm);

                    if (matchesRole && matchesStatus && matchesSearch) {
                        row.style.display = '';
                        visibleCount++;
                    } else {
                        row.style.display = 'none';
                    }
                });

                // 4. Mensaje de "No hay resultados"
                if (visibleCount === 0) {
                    noResults.classList.remove('hidden');
                } else {
                    noResults.classList.add('hidden');
                }
            }
        </script>

        <dialog id="modal_editar_usuario" class="modal">
            <div class="modal-box w-11/12 max-w-3xl bg-slate-900 text-white">
                <h3 class="font-bold text-lg mb-4">Editar Usuario</h3>

                <form action="UsuarioServlet" method="POST">
                    <input type="hidden" name="accion" value="actualizar">
                    <input type="hidden" name="idUsuario" id="modal_id"> <div class="grid grid-cols-2 gap-4">
                        <div class="form-control">
                            <label class="label"><span class="label-text text-white">Nombre</span></label>
                            <input type="text" name="nombre" id="modal_nombre" class="input input-bordered bg-slate-800" />
                        </div>

                        <div class="form-control">
                            <label class="label"><span class="label-text text-white">Email</span></label>
                            <input type="email" name="email" id="modal_email" class="input input-bordered bg-slate-800" />
                        </div>

                        <div class="form-control">
                            <label class="label"><span class="label-text text-white">Rol</span></label>
                            <select name="rol" id="modal_rol" class="select select-bordered bg-slate-800">
                                <option value="Admin">Admin</option>
                                <option value="Estudiante">Estudiante</option>
                                <option value="Instructor">Instructor</option>
                            </select>
                        </div>

                        <div class="form-control">
                            <label class="label"><span class="label-text text-white">Estado</span></label>
                            <select name="estado" id="modal_estado" class="select select-bordered bg-slate-800">
                                <option value="1">Activo</option>
                                <option value="0">Inactivo</option>
                            </select>
                        </div>
                    </div>

                    <div class="modal-action mt-6">
                        <button type="button" class="btn btn-ghost" onclick="document.getElementById('modal_editar_usuario').close()">Cancelar</button>
                        <button type="submit" class="btn btn-primary bg-blue-600 border-none hover:bg-blue-700 text-white">Guardar Cambios</button>
                    </div>
                </form>
            </div>
            <form method="dialog" class="modal-backdrop">
                <button>close</button>
            </form>
        </dialog>

        <script>
            function abrirModalEditar(id, nombre, email, rol, estado) {
                document.getElementById('modal_id').value = id;
                document.getElementById('modal_nombre').value = nombre;
                document.getElementById('modal_email').value = email;
                document.getElementById('modal_rol').value = rol;
                document.getElementById('modal_estado').value = estado;

                document.getElementById('modal_editar_usuario').showModal();
            }
        </script>

    </body>
</html>
