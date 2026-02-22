/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador.auth;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutServlet"})
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // obtener sesion
        HttpSession session = request.getSession(false);

        if (session != null) {
            System.out.println("Cerrando sesión de: " + session.getAttribute("usuario"));
            session.invalidate(); // 🧹 Eliminar todos los atributos de la sesión
        }

        // redirigir al login
        response.sendRedirect(request.getContextPath() + "/login.jsp?logout=success");
    }
}
