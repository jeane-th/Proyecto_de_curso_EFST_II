
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- libreria control -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <!-- libreria de funciones -->

<!DOCTYPE html>
<html lang="es" data-theme="night">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <script src="https://cdn.tailwindcss.com"></script>

        <link href="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/npm/daisyui@4.7.2/dist/full.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

        <title>AprendeYa | ${curso.titulo}</title>

        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            'brand-blue': '#2563eb',
                            'brand-dark': '#0f172a',
                            'brand-card': '#1e293b',
                        }
                    }
                }
            }
        </script>
    </head>

    <body class="bg-brand-dark text-white font-sans">


        <header class="h-16 fixed top-0 left-0 w-full z-50 bg-gray-900 shadow-lg">
            <div class="max-w-7xl mx-auto px-6 flex items-center justify-between text-white h-full">
                <!-- Logo -->
                <div>

                    <a href="${pageContext.request.contextPath}/" class="flex items-center">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5"
                             stroke="currentColor" class="text-blue-600 size-8 text-xl font-bold mr-3 h-6 sm:h-9">
                        <path stroke-linecap="round" stroke-linejoin="round"
                              d="M12 6.042A8.967 8.967 0 0 0 6 3.75c-1.052 0-2.062.18-3 .512v14.25A8.987 8.987 0 0 1 6 18c2.305 0 4.408.867 6 2.292m0-14.25a8.966 8.966 0 0 1 6-2.292c1.052 0 2.062.18 3 .512v14.25A8.987 8.987 0 0 0 18 18a8.967 8.967 0 0 0-6 2.292m0-14.25v14.25" />
                        </svg>
                        <span class="text-3xl font-bold">AprendeYa</span>
                    </a>
                </div>
                <!-- Menu -->
                <nav>

                    <a href="${pageContext.request.contextPath}/" class="px-2">Inicio</a>
                    <a href="${pageContext.request.contextPath}/perfil" class="px-2">Mis cursos</a>
                </nav>
                <c:choose>
                    <c:when test="${not empty sessionScope.usuario}">
                        <!-- Usuario logueado -->
                        <div>

                            <button type="button" class="" id="user-menu-button" aria-expanded="false"
                                    data-dropdown-toggle="dropdown">
                                <span class="sr-only">Open user menu</span>
                                <span
                                    class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-1 px-2 w-8 h-8 rounded-full flex items-center justify-center cursor-pointer"> 
                                    ${fn:toUpperCase(fn:substring(sessionScope.usuario.nombre, 0, 1))}
                                </span>
                            </button>

                            <div class="hidden z-50 my-4 w-56 text-white rounded shadow bg-gray-700" id="dropdown">
                                <div class="py-3 px-4">
                                    <span class="block font-semibold">${sessionScope.usuario.nombre}</span>
                                    <span class="block truncate">${sessionScope.usuario.email}</span>
                                </div>
                                <ul class="py-1" aria-labelledby="dropdown">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/perfil"
                                           class="flex items-center py-2 px-4  hover:bg-gray-100 hover:bg-gray-600 hover:text-white gap-2">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
                                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                 stroke-linejoin="round" class="lucide lucide-book-copy-icon lucide-book-copy">
                                            <path d="M5 7a2 2 0 0 0-2 2v11" />
                                            <path d="M5.803 18H5a2 2 0 0 0 0 4h9.5a.5.5 0 0 0 .5-.5V21" />
                                            <path
                                                d="M9 15V4a2 2 0 0 1 2-2h9.5a.5.5 0 0 1 .5.5v14a.5.5 0 0 1-.5.5H11a2 2 0 0 1 0-4h10" />
                                            </svg>
                                            Perfil
                                        </a>
                                    </li>
                                    <li>
                                        <a href="#"
                                           class="flex items-center py-2 px-4  hover:bg-gray-100 hover:bg-gray-600 hover:text-white gap-2">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
                                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                                 stroke-linejoin="round" class="lucide lucide-cog-icon lucide-cog">
                                            <path d="M11 10.27 7 3.34" /> <path d="m11 13.73-4 6.93" /><path d="M12 22v-2" /> <path d="M12 2v2" /><path d="M14 12h8" /><path d="m17 20.66-1-1.73" /> 
                                            <path d="m17 3.34-1 1.73" /><path d="M2 12h2" /><path d="m20.66 17-1.73-1" /> <path d="m20.66 7-1.73 1" /><path d="m3.34 17 1.73-1" /> <path d="m3.34 7 1.73 1" /> 
                                            <circle cx="12" cy="12" r="2" />  <circle cx="12" cy="12" r="8" />
                                            </svg>
                                            Administrador
                                        </a>
                                    </li>
                                </ul>
                                <ul class="py-1" aria-labelledby="dropdown">
                                    <li>
                                        <a href="${pageContext.request.contextPath}/LogoutServlet" class="block py-2 px-4  hover:bg-gray-600">Cerrar sesión</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <!-- Usuario NO logueado -->
                        <a href="${pageContext.request.contextPath}/login.jsp"
                           class="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-1 px-2 p rounded-xl cursor-pointer px-4 py-2.5 my-4">
                            Iniciar sesión</a>
                        </c:otherwise>
                    </c:choose>
            </div>
        </header>

        <main class="mt-24 max-w-6xl mx-auto px-6">

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-10">


                <div class="lg:col-span-2 bg-brand-card border border-gray-800 rounded-xl shadow-xl overflow-hidden">

                    <img src="${curso.imagen}" class="w-full h-72 object-cover">

                    <div class="p-8 space-y-4">

                        <span class="badge bg-blue-900 text-blue-200 border-none">
                            ${curso.categoria}
                        </span>

                        <h1 class="text-4xl font-bold">
                            ${curso.titulo}
                        </h1>

                        <p class="text-gray-400">
                            ${curso.descripcion}
                        </p>

                        <div class="flex flex-wrap gap-6 text-sm text-gray-400 pt-4">
                            <span><i class="fa-solid fa-user mr-1"></i> ${curso.profesor}</span>
                            <span><i class="fa-regular fa-clock mr-1"></i> ${curso.duracion} horas</span>
                            <span class="text-yellow-400 font-bold">
                                <i class="fa-solid fa-star"></i> 4.8
                            </span>
                        </div>

                    </div>
                </div>

                <div class="bg-brand-card border border-gray-800 rounded-xl shadow-xl p-6 h-fit">

                    <p class="text-3xl font-bold text-blue-400 mb-4">
                        S/ ${curso.precio}
                    </p>

                    <c:choose>

                        <c:when test="${not empty sessionScope.usuario}">
                            <form action="${pageContext.request.contextPath}/matricular" method="post">
                                <input type="hidden" name="idCurso" value="${curso.idCurso}">
                                <button type="submit"
                                        class="btn w-full bg-brand-blue hover:bg-blue-700 text-white border-none">
                                    Matricularme
                                </button>
                            </form>
                        </c:when>

                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login.jsp"
                               class="btn w-full bg-brand-blue hover:bg-blue-700 text-white border-none text-center">
                                Matricularme
                            </a>
                        </c:otherwise>

                    </c:choose>

                    <div class="mt-6 text-sm text-gray-400 space-y-2">
                        <p>✔ Acceso de por vida</p>
                        <p>✔ Certificado digital</p>
                        <p>✔ Contenido actualizado</p>
                    </div>
                </div>

            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.js"></script>
    </body>
</html>
