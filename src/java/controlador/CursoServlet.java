/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import dao.CursoDAO;
import dao.CursoDAOImpl;
import dao.ReviewDAO;
import dao.ReviewDAOImpl;
import modelo.Curso;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import modelo.Review;


@WebServlet("/curso")
public class CursoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

        CursoDAO dao = new CursoDAOImpl();
        
        ReviewDAO reviewDAO = new ReviewDAOImpl();
        List<Review> reviews = reviewDAO.listarPorCurso(idCurso);
        double promedio = reviewDAO.obtenerPromedio(idCurso);
        int total = reviewDAO.contarPorCurso(idCurso);

        Curso curso = dao.buscar(idCurso);

        if (curso == null) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }
        
        request.setAttribute("reviews", reviews);
        request.setAttribute("promedio", promedio);
        request.setAttribute("totalReviews", total);
        request.setAttribute("curso", curso);
        request.getRequestDispatcher("/curso.jsp").forward(request, response);
    }
}