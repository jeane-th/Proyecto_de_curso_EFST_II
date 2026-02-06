<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <!-- libreria control -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <!-- libreria de funciones -->
<!DOCTYPE html>
<html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
        <link href="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.css" rel="stylesheet" />
        <link rel="icon" type="image/svg+xml" href="icons/icon_book.svg">
        <title>AprendeYa | Login</title>
    </head>
    <body class="bg-gray-900">
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

        <main class="bg-blue-950/50 py-16 mt-16">
            <section
                class="p-5 max-w-md mx-auto rounded-lg border border-gray-200 shadow-sm border-gray-700 bg-gray-800">
                <div class="mb-5">
                    <div class="size-16 bg-blue-600 text-white rounded-full flex items-center justify-center mx-auto mb-4">
                        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 24 24" fill="none"
                             stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                             class="lucide lucide-user-icon lucide-user">
                        <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2" />
                        <circle cx="12" cy="7" r="4" />
                        </svg>
                    </div>
                    <h2 class="text-2xl font-bold text-center text-white mb-2">Iniciar sesión</h2>
                    <p class="text-center text-white mb-6">Ingresa a tu cuenta para matricularte</p>
                </div>
                <form id="formLogin" class="max-w-sm mx-auto" action="login" method="post">
                    <div class="mb-5">
                        <label for="email" class="block mb-2.5 text-sm font-medium text-gray-700 text-white">Email</label>
                        <input type="email" name="email" id="email"
                               class="border border-gray-300 text-gray-900 rounded-xl  focus:border-blue-500 block w-full p-2.5 bg-gray-700 placeholder-gray-400 text-white"
                               placeholder="name@flowbite.com">
                    </div>
                    <div class="mb-5">
                        <label for="password"
                               class="block mb-2.5 text-sm font-medium text-gray-700 text-white">Contraseña</label>
                        <input type="password" name="password" id="password"
                               class="border border-gray-300 text-gray-900 rounded-xl  focus:border-blue-500 block w-full p-2.5 bg-gray-700 placeholder-gray-400 text-white"
                               placeholder="********">
                    </div>
                    <button type="submit"
                            class="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-1 px-2 p rounded-xl cursor-pointer w-full px-4 py-2.5 my-4">Iniciar
                        sesion</button>
                    <div class="pt-4 border-t border-gray-300 border-gray-700 mt-4">
                        <p class=" text-sm font-medium text-gray-700 text-white select-none h-6 w-full text-center">¿No
                            tienes una cuenta?<a href="registro.jsp" class="text-blue-600 hover:underline ml-2">Registrate aquí
                            </a></p>
                    </div>
                </form>
                <!-- <div>
                    <p class="text-red-500 h-6 w-full text-center">
                <c:if test="${not empty error}">
                    ${error}
                </c:if>
            </p>
        </div> -->
            </section>
        </main>
        <script src="https://cdn.jsdelivr.net/npm/flowbite@4.0.1/dist/flowbite.min.js"></script>

        <!-- Librería JustValidate (SIN defer) -->
        <script src="https://cdn.jsdelivr.net/npm/just-validate@latest/dist/just-validate.production.min.js"></script>

        <!-- Tu validación -->
        <script>
            const validate = new JustValidate('#formLogin', {
                errorFieldCssClass: 'border-red-500',
                errorLabelCssClass: 'text-red-500 text-sm mt-1',
                focusInvalidField: true
            });

            validate
                    .addField('#email', [
                        {rule: 'required', errorMessage: 'Complete su email'},
                        {rule: 'email', errorMessage: 'Email inválido'}
                    ])
                    .addField('#password', [
                        {rule: 'required', errorMessage: 'Complete su contraseña'},
                        {rule: 'minLength', value: 6, errorMessage: 'Mínimo 6 caracteres'}
                    ]);

            .onSuccess((event) => {
                event.target.submit();
            });
        </script>

    </body>

</html>
