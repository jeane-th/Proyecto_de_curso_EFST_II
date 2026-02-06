<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <!-- libreria de funciones -->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <link href="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.css" rel="stylesheet" />
        <link rel="icon" type="image/svg+xml" href="icons/icon_book.svg">
        <title>AprendeYa | Curso: </title>
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
            <c:if test="${not empty curso}">
                <section class="pb-8 pt-2 antialiased bg-gray-900 md:py-16">
                    <div class="mx-auto max-w-screen-xl px-4 2xl:px-0">
                        <div class="mx-auto max-w-5xl">

                            <div class="mb-6 md:mb-12">
                                <iframe class="h-[260px] md:h-[540px] w-full rounded-lg" src="${curso.video}" title="Flowbite Crash Course in 20 mins | Introduction to UI components using Tailwind CSS" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
                            </div>
                            <p class="text-white text-3xl font-bold mb-2">${curso.titulo}</p>
                            <div class="mx-auto space-y-6 mb-4" >
                                <p class="text-base font-normal text-gray-500 text-gray-400">${curso.descripcion}.</p>
                            </div>
                            <section class="bg-gray-900 py-8 lg:py-16 antialiased">
                                <div class="mx-auto px-4">
                                    <div class="flex justify-between items-center mb-6">
                                        <h2 class="text-lg lg:text-2xl font-bold text-white">       Comentarios (${totalReviews})</h2>
                                    </div>
                                    <!-- FORMULARIO DE COMENTARIOS -->
                                    <c:if test="${not empty sessionScope.usuario}">
                                        <form action="${pageContext.request.contextPath}/reproductorServlet" method="post">
                                            <input type="hidden" name="idCurso" value="${curso.idCurso}">


                                            <div class="mb-4">
                                                <label class="text-white">Valoración:</label>
                                                <select name="valoracion" required class="p-2 pr-5 rounded-xl bg-gray-900 border-2 border-gray-600">
                                                    <option value="5">⭐⭐⭐⭐⭐   </option>
                                                    <option value="4">⭐⭐⭐⭐ </option>
                                                    <option value="3">⭐⭐⭐ </option>
                                                    <option value="2">⭐⭐ </option>
                                                    <option value="1">⭐ </option>
                                                </select>

                                            </div>
                                            <div class="py-2 px-4 mb-4 rounded-lg rounded-t-lg border border-gray-200 bg-gray-800 border-gray-700">

                                                <textarea id="comentario" rows="6" name="comentario" 
                                                          class="px-0 w-full text-sm text-gray-900 border-0 focus:ring-0 focus:outline-none text-white placeholder-gray-400 bg-gray-800"
                                                          placeholder="Escribe tu comentario..." required></textarea>
                                            </div>

                                            <button type="submit" class="inline-flex items-center py-2.5 px-4 text-xs font-medium text-center text-white bg-blue-700 rounded-lg focus:ring-4 focus:ring-blue-200 focus:ring-blue-900 hover:bg-blue-800">Enviar comentario</button>
                                        </form>
                                    </c:if>

                                    <c:if test="${empty sessionScope.usuario}">
                                        <p>Debes iniciar sesión para dejar un comentario.</p>
                                    </c:if>
                                    <section class="mt-8">
                                        <c:choose>
                                            <c:when test="${empty reviews}">
                                                <p class="text-gray-500">Aún no hay comentarios para este curso.</p>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="space-y-4">
                                                    <c:forEach var="r" items="${reviews}">
                                                        <div class="bg-gray-800 rounded-lg shadow p-4">
                                                            <div class="flex items-center gap-2     mb-2">
                                                                <span
                                                                    class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-1 px-2 w-6 h-6 rounded-full flex items-center justify-center cursor-pointer"> 
                                                                    ${fn:toUpperCase(fn:substring(r.nombreUsuario, 0, 1))}
                                                                </span>
                                                                <span class="font-semibold text-gray-200">
                                                                    ${r.nombreUsuario}
                                                                </span>
                                                                <span class="text-sm text-gray-300">
                                                                    ⭐ ${r.valoracion}/5
                                                                </span>
                                                                <span class="font-semibold text-gray-200">
                                                                    ${fn:toUpperCase(fn:substring(r.fecha, 0, 10))}
                                                                </span>
                                                            </div>
                                                            <p class="text-gray-300">
                                                                ${r.comentario}
                                                            </p>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </section>
                                </div>
                            </section>
                        </div>
                    </div>
                </section>
            </c:if>
        </main>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.js"></script>
    </body>
</html>
