/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import dao.CursoDAO;
import dao.CursoDAOImpl;
import modelo.Curso;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/curso")
public class CursoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Validar parámetro
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        int idCurso;
        try {
            idCurso = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        // 2. DAO
        CursoDAO dao = new CursoDAOImpl();

        // 3. Obtener curso
        Curso curso = dao.buscar(idCurso);

        if (curso == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        // 4. Enviar a la vista (CLAVE)
        request.setAttribute("curso", curso);
        request.getRequestDispatcher("/curso.jsp").forward(request, response);
    }
}