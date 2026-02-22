/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador.admin;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;


@WebServlet(name = "DashboardAdminServlet", urlPatterns = {"/dashboardAdmin"})
public class DashboardAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // validar
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // por rol
        String rol = (String) session.getAttribute("rol");
        if (rol == null || !rol.equalsIgnoreCase("Admin")) {
            response.sendRedirect("index.jsp");
            return;
        }

        RequestDispatcher rd = request.getRequestDispatcher("dashboardAdmin.jsp");
        rd.forward(request, response);
    }
}