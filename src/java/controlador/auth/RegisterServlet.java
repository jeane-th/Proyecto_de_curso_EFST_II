/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador.auth;

import dao.UsuarioDAO;
import dao.UsuarioDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Usuario;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/registro"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // servlet del registro
        Usuario u = new Usuario();
        u.setNombre(request.getParameter("nombre"));
        u.setEmail(request.getParameter("email"));
        u.setPassword(request.getParameter("password"));
        u.setPais(request.getParameter("pais"));
        UsuarioDAO dao = new UsuarioDAOImpl();
        if (dao.insertar(u)) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Error al registar");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
