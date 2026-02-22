/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package middleware;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;



// restringir
@WebFilter(urlPatterns = {"/perfil.jsp", "/reproductorCurso.jsp", "/dashboardAdmin"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session = request.getSession(false);
        String path = request.getRequestURI();

        // validar sesion activa
        boolean loggedIn = (session != null && session.getAttribute("usuario") != null);
        String loginURL = request.getContextPath() + "/login.jsp";

        // verifica rol
        if (path.contains("dashboardAdmin")) {
            if (!loggedIn) {
                response.sendRedirect(loginURL);
                return;
            }

            String rol = (String) session.getAttribute("rol");
            if (rol == null || !rol.equalsIgnoreCase("Admin")) {
                // redirige si no tiene rol
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
        }

        // si no está logeado redirige
        if (!loggedIn && (path.endsWith("perfil.jsp") || path.endsWith("reproductorCurso.jsp"))) {
            response.sendRedirect(loginURL);
            return;
        }

        // cadena de filtros requeridos
        chain.doFilter(request, response);
    }
}