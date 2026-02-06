<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- libreria control -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <!-- libreria de funciones -->

<!DOCTYPE html>
<html lang="es" >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <link href="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.css" rel="stylesheet" />
        <link rel="icon" type="image/svg+xml" href="icons/icon_book.svg">
        <title>AprendeYa | Perfil</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    <body>
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

        <main class="pt-16 ">
            <!-- Fondo degradado -->
            <section class="bg-gradient-to-br from-blue-900 via-blue-700 to-gray-900 text-white">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12 md:items-start">
                    <div class="flex flex-col items-center md:flex-row gap-6">
                        <div class="w-32 h-32 rounded-full border-4 border-white shadow-lg
                             text-white flex items-center justify-center text-5xl flex-shrink-0">
                            <!-- Toma la primera letra y q sea mayuscula -->
                            ${fn:toUpperCase(fn:substring(sessionScope.usuario.nombre, 0, 1))}
                        </div>
                        <div class="flex flex-col">
                            <div class="flex flex-col items-center md:items-start md:flex-row md:justify-start
                                 text-center md:text-left gap-4">
                                <h1 class="text-3xl font-bold mb-2 text-center md:text-left">
                                    ${sessionScope.usuario.nombre}</h1>
                            </div>
                            <div class="flex flex-col items-center md:items-start md:flex-row md:justify-start
                                 text-center md:text-left gap-2 md:gap-6 ">
                                <div class="flex items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-mail-icon lucide-mail"><path d="m22 7-8.991 5.727a2 2 0 0 1-2.009 0L2 7"/><rect x="2" y="4" width="20" height="16" rx="2"/></svg>
                                    <!-- Email de sesion de usuario -->
                                    <span>${sessionScope.usuario.email}</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-map-pin-icon lucide-map-pin"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg>
                                    <span>${sessionScope.usuario.pais}</span>
                                </div>
                            </div>

                        </div>
                        <div class="bg-white/10 backdrop-blur-sm rounded-lg p-4 ml-100">
                            <c:set var="totalCursos" value="${fn:length(listaCursos)}" />
                            <div class="flex items-center gap-3">
                                <svg xmlns="http://www.w3.org/2000/svg" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" 
                                     stroke-linejoin="round" class="lucide lucide-book-open-icon lucide-book-open"><path d="M12 7v14"/>
                                <path d="M3 18a1 1 0 0 1-1-1V4a1 1 0 0 1 1-1h5a4 4 0 0 1 4 4 4 4 0 0 1 4-4h5a1 1 0 0 1 1 1v13a1 1 0 0 1-1 1h-6a3 3 0 0 0-3 3 3 3 0 0 0-3-3z"/></svg>
                                <div>
                                    <div class="text-2xl font-bold">${totalCursos}</div>
                                    <div class="text-sm text-blue-100">Cursos Inscritos</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- tarjetas resumen de usuario -->
                    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mt-8">

                    </div>
                </div>
            </section>
            <section class="bg-gray-50 py-8 antialiased bg-gray-900 md:py-12">
                <div class="mx-auto max-w-screen-xl px-4 2xl:px-0">
                    <!-- Heading & Filters -->
                    <div class="mb-4 items-end justify-between space-y-4 sm:flex sm:space-y-0 md:mb-8">
                        <h2 class="mt-3 text-xl font-semibold text-gray-900 text-white sm:text-2xl">Mis cursos</h2>
                    </div>




                    <div class="mb-4 grid gap-4 sm:grid-cols-2 md:mb-8 lg:grid-cols-3 xl:grid-cols-4">

                        <c:choose>

                            <c:when test="${empty listaCursos}">
                                <div class="col-span-full text-center text-gray-500 text-gray-400 text-lg py-12">
                                    Aún no estás matriculado a ningún curso
                                </div>
                            </c:when>

                            <c:otherwise>
                                <c:forEach var="c" items="${listaCursos}">
                                    <div class="rounded-lg border border-gray-200  shadow-sm border-gray-700 bg-gray-800">

                                        <div class="rounded-t-lg w-64 w-full overflow-hidden">
                                            <img 
                                                src="${c.imagen}"
                                                class="w-full h-full object-cover"
                                                alt=""
                                                >
                                        </div>

                                        <div class="m-6">

                                            <div class="mb-4 flex items-center justify-between gap-4">
                                                <span class="me-2 rounded bg-blue-100 px-2.5 py-0.5 text-xs font-medium bg-blue-900 text-gray-300">
                                                    ${c.categoria}
                                                </span> 
                                                <div class="flex items-center justify-end gap-1">
                                                    <button type="button" 
                                                            class="rounded-lg p-2 text-gray-500 hover:bg-gray-100 hover:text-gray-900 
                                                            text-gray-400 hover:bg-gray-700 hover:text-white
                                                            cursor-pointer">
                                                        <span class="sr-only"> Add to Favorites </span>
                                                        <svg class="h-5 w-5" aria-hidden="true"
                                                             xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                                        <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                                              d="M12 6C6.5 1 1 8 5.8 13l6.2 7 6.2-7C23 8 17.5 1 12 6Z" />
                                                        </svg>
                                                    </button>
                                                </div>
                                            </div>

                                            <p class="text-lg font-semibold leading-tight text-gray-900 text-white">
                                                ${c.titulo}
                                            </p>

                                            <p class="text-base mt-2 font-medium text-gray-500 text-gray-400">
                                                Por: ${c.profesor}
                                            </p>

                                            <div class="mt-4 mb-4 flex items-center gap-2">
                                                <p class="text-sm font-medium text-gray-900 text-white">⭐5.0</p>
                                                <div class=" flex flex-rown items-center ml-4">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-alarm-clock-icon lucide-alarm-clock text-gray-500"><circle cx="12" cy="13" r="8"/><path d="M12 9v4l2 2"/><path d="M5 3 2 6"/><path d="m22 6-3-3"/><path d="M6.38 18.7 4 21"/><path d="M17.64 18.67 20 21"/>
                                                    </svg>
                                                    <p class="text-sm font-medium text-gray-500 text-gray-400 ml-1">
                                                        ${c.duracion} horas
                                                    </p>
                                                </div>

                                            </div>

                                            <div class="mt-4 flex items-center justify-between gap-2">

                                                <a href="${pageContext.request.contextPath}/reproductorServlet?id=${c.idCurso}" class="w-full">
                                                    <button type="button"
                                                            class="inline-flex items-center rounded-lg bg-blue-700 px-4 py-2.5 text-sm font-medium text-white 
                                                            hover:bg-blue-800 focus:outline-none focus:ring-4 focus:ring-primary-300 
                                                            bg-blue-600 hover:bg-blue-700 focus:ring-primary-800 w-full
                                                            justify-center cursor-pointer">
                                                        Ver curso
                                                    </button>
                                                </a>

                                                <form action="${pageContext.request.contextPath}/EliminarMatriculaServlet" 
                                                      method="post"
                                                      onsubmit="return confirm('¿Seguro que deseas eliminar este curso?');">

                                                    <input type="hidden" name="idCurso" value="${c.idCurso}">

                                                    <button type="submit"
                                                            class="inline-flex items-center rounded-lg bg-red-600 px-4 py-2.5 text-sm font-medium text-white 
                                                            hover:bg-red-700 focus:outline-none focus:ring-4 focus:ring-red-300 
                                                            bg-red-500 hover:bg-red-600 focus:ring-red-800
                                                            cursor-pointer">
                                                        Eliminar
                                                    </button>
                                                </form>

                                            </div>

                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>

                        </c:choose>

                    </div>






                    <!--                    <div class="w-full text-center">
                                            <button type="button" class="rounded-lg border border-gray-200 bg-white px-5 py-2.5 text-sm font-medium text-gray-900 hover:bg-gray-100 hover:text-gray-700 focus:z-10 focus:outline-none focus:ring-4 focus:ring-gray-100 border-gray-600 bg-gray-800 text-gray-400 hover:bg-gray-700 hover:text-white focus:ring-gray-700">Show more</button>
                                        </div>-->
                </div>

            </section>
        </main>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.js"></script>

    </body>
</html>



