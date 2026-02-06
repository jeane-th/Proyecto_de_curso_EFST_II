/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import dao.CursoDAO;
import dao.CursoDAOImpl;
import dao.ReviewDAO;
import dao.ReviewDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import modelo.Curso;
import modelo.Review;
import modelo.Usuario;

@WebServlet(name = "reproductorServlet", urlPatterns = {"/reproductorServlet"})
public class reproductorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // obtenemos el id del curso
        int idCurso = Integer.parseInt(request.getParameter("id"));
        CursoDAO dao = new CursoDAOImpl();
        Curso curso = dao.buscar(idCurso);

        ReviewDAO reviewDAO = new ReviewDAOImpl();
        List<Review> reviews = reviewDAO.listarPorCurso(idCurso);
        double promedio = reviewDAO.obtenerPromedio(idCurso);
        int total = reviewDAO.contarPorCurso(idCurso);

        request.setAttribute("reviews", reviews);
        request.setAttribute("promedio", promedio);
        request.setAttribute("totalReviews", total);
        request.setAttribute("curso", curso);
        request.getRequestDispatcher("/reproductorCurso.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Usuario u = (Usuario) session.getAttribute("usuario");

        // validar que la sesion exista
        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // obtener datos del formulario
        int idCurso = Integer.parseInt(request.getParameter("idCurso"));
        int valoracion = Integer.parseInt(request.getParameter("valoracion"));
        String comentario = request.getParameter("comentario");

        // creamos el objeto review/comentario
        Review r = new Review();
        r.setIdCurso(idCurso);
        r.setIdUsuario(u.getIdUsuario());
        r.setValoracion(valoracion);
        r.setComentario(comentario);

        //  agregamos el cometario
        ReviewDAO dao = new ReviewDAOImpl();

        dao.insertar(r);

        response.sendRedirect(
                request.getContextPath() + "/reproductorServlet?id=" + idCurso
        );
    }
}
