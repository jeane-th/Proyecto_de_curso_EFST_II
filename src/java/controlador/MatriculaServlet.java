/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.MatriculaDAO;
import dao.MatriculaDAOImpl;
import modelo.Usuario;

@WebServlet("/matricular")
public class MatriculaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario u = (Usuario) request.getSession().getAttribute("usuario");
        int idCurso = Integer.parseInt(request.getParameter("idCurso"));

        MatriculaDAO dao = new MatriculaDAOImpl();

        if (!dao.estaMatriculado(u.getIdUsuario(), idCurso)) {
            dao.matricular(u.getIdUsuario(), idCurso);
        }

        response.sendRedirect("perfil");
    }
}
