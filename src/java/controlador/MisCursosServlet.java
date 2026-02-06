/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import dao.MatriculaDAO;
import dao.MatriculaDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import modelo.Usuario;

@WebServlet("/misCursos")
public class MisCursosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario u = (Usuario) request.getSession().getAttribute("usuario");

        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        MatriculaDAO dao = new MatriculaDAOImpl();
        request.setAttribute("misCursos", dao.cursosPorUsuario(u.getIdUsuario()));

        request.getRequestDispatcher("misCursos.jsp").forward(request, response);
    }
}
