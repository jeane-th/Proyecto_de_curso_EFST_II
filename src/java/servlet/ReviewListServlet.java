package servlet;

import dao.ReviewDAO;
import dao.ReviewDAOImpl;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Review;

@WebServlet(name = "ReviewListServlet", urlPatterns = {"/ReviewListServlet"})
public class ReviewListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        String idCursoS = request.getParameter("idCurso");
        if (idCursoS == null) {
            response.getWriter().write("{\"success\":false,\"message\":\"Falta idCurso\"}");
            return;
        }
        try {
            int idCurso = Integer.parseInt(idCursoS);
            ReviewDAO dao = new ReviewDAOImpl();
            List<Review> lista = dao.listarPorCurso(idCurso);

            StringBuilder sb = new StringBuilder();
            sb.append("{\"success\":true,\"reviews\":[");
            boolean first = true;
            for (Review r : lista) {
                if (!first) sb.append(',');
                first = false;
                // construir objeto JSON simple
                sb.append('{');
                sb.append("\"idReview\":").append(r.getIdReview()).append(',');
                sb.append("\"idUsuario\":").append(r.getIdUsuario()).append(',');
                sb.append("\"nombreUsuario\":\"").append(escapeJson(r.getNombreUsuario())).append("\",");
                sb.append("\"comentario\":\"").append(escapeJson(r.getComentario())).append("\",");
                sb.append("\"valoracion\":").append(r.getValoracion()).append(',');
                sb.append("\"fecha\":\"").append(r.getFecha()).append("\"");
                sb.append('}');
            }
            sb.append("],\"count\":").append(dao.contarPorCurso(idCurso)).append(',');
            sb.append("\"avg\":").append(dao.obtenerPromedio(idCurso));
            sb.append('}');

            response.getWriter().write(sb.toString());

        } catch (NumberFormatException ex) {
            response.getWriter().write("{\"success\":false,\"message\":\"idCurso inválido\"}");
        }
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "\\r");
    }

}
