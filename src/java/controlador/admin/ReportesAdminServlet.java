/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador.admin;

import dao.ReporteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/admin/reportes")
public class ReportesAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ReporteDAO dao = new ReporteDAO();

        request.setAttribute("totalUsuarios", dao.totalUsuarios());
        request.setAttribute("totalCursos", dao.totalCursos());
        request.setAttribute("totalMatriculas", dao.totalMatriculas());
        request.setAttribute("totalReviews", dao.totalReviews());

        request.getRequestDispatcher("/admin/reportes.jsp")
               .forward(request, response);
    }
}