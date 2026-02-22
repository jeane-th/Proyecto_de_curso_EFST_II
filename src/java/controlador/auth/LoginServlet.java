/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador.auth;

import dao.UsuarioDAO;
import dao.UsuarioDAOimpl;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Usuario;


@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private UsuarioDAO dao = new UsuarioDAOimpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Usuario u = dao.login(email, password);

        if (u != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuario", u);
            session.setAttribute("rol", u.getRol());

            if ("Admin".equalsIgnoreCase(u.getRol())) {
                response.sendRedirect(request.getContextPath() + "/dashboardAdmin");
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }

        } else {
            request.setAttribute("error", "❌ Usuario o contraseña incorrectos, intenta nuevamente.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet encargado del inicio de sesión de usuarios.";
    }
}
