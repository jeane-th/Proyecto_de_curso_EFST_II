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
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import modelo.Usuario;

@WebServlet("/EliminarMatriculaServlet")
public class EliminarMatriculaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        // Seguridad
        if (usuario == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int idCurso = Integer.parseInt(request.getParameter("idCurso"));

        MatriculaDAO dao = new MatriculaDAOImpl();
        dao.eliminarMatricula(usuario.getIdUsuario(), idCurso);

        // Volver al perfil (recarga cursos)
        response.sendRedirect("perfil");
    }
}