package servlet;

import dao.ReviewDAO;
import dao.ReviewDAOImpl;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Review;

/**
 * Servlet para recibir POSTs de reviews.
 * Parámetros esperados (form-urlencoded o multipart): idCurso, idUsuario (o usar sesión), comentario, valoracion
 */
@WebServlet(name = "ReviewServlet", urlPatterns = {"/ReviewServlet"})
public class ReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");

        String idCursoS = request.getParameter("idCurso");
        String idUsuarioS = request.getParameter("idUsuario");
        String comentario = request.getParameter("comentario");
        String valoracionS = request.getParameter("valoracion");

        // Validaciones mínimas
        if (idCursoS == null || idUsuarioS == null || valoracionS == null) {
            // Intentar leer body como JSON simple si el cliente envió application/json
            StringBuilder body = new StringBuilder();
            try (java.io.BufferedReader br = request.getReader()) {
                String line;
                while ((line = br.readLine()) != null) {
                    body.append(line);
                }
            } catch (Exception ex) {
                // ignore
            }
            String bodyStr = body.toString().trim();
            if (!bodyStr.isEmpty()) {
                // parseo simple sin librerías externas: buscar claves básicas
                if (idCursoS == null) idCursoS = extractJsonNumber(bodyStr, "idCurso");
                if (idUsuarioS == null) idUsuarioS = extractJsonNumber(bodyStr, "idUsuario");
                if (valoracionS == null) valoracionS = extractJsonNumber(bodyStr, "valoracion");
                if (comentario == null) comentario = extractJsonString(bodyStr, "comentario");
            }
        }

        if (idCursoS == null || idUsuarioS == null || valoracionS == null) {
            response.getWriter().write("{\"success\":false,\"message\":\"Faltan parámetros\"}");
            return;
        }

        try {
            int idCurso = Integer.parseInt(idCursoS);
            int idUsuario = Integer.parseInt(idUsuarioS);
            int valoracion = Integer.parseInt(valoracionS);

            Review r = new Review();
            r.setIdCurso(idCurso);
            r.setIdUsuario(idUsuario);
            r.setComentario(comentario != null ? comentario : "");
            r.setValoracion(Math.max(1, Math.min(5, valoracion)));

            ReviewDAO dao = new ReviewDAOImpl();
            boolean ok = dao.insertar(r);
            if (ok) {
                response.getWriter().write("{\"success\":true,\"message\":\"Review agregada\"}");
            } else {
                // Si falla por no estar matriculado, devolver mensaje claro
                response.getWriter().write("{\"success\":false,\"message\":\"No se pudo agregar la review. Verifique que el usuario esté matriculado en el curso.\"}");
            }

        } catch (NumberFormatException ex) {
            response.getWriter().write("{\"success\":false,\"message\":\"Parametros numéricos inválidos\"}");
        }

    }

    // Helpers simples para extraer campos de un JSON pequeño sin dependencias
    private static String extractJsonString(String body, String key) {
        try {
            int idxKey = body.indexOf('"' + key + '"');
            if (idxKey == -1) return null;
            int colon = body.indexOf(':', idxKey);
            if (colon == -1) return null;
            int quoteStart = body.indexOf('"', colon);
            if (quoteStart == -1) return null;
            StringBuilder sb = new StringBuilder();
            for (int i = quoteStart + 1; i < body.length(); i++) {
                char c = body.charAt(i);
                if (c == '"') {
                    return sb.toString();
                }
                if (c == '\\' && i + 1 < body.length()) {
                    // minimal unescape
                    sb.append(body.charAt(i + 1));
                    i++;
                } else {
                    sb.append(c);
                }
            }
            return null;
        } catch (Exception e) {
            return null;
        }
    }

    private static String extractJsonNumber(String body, String key) {
        try {
            int idxKey = body.indexOf('"' + key + '"');
            if (idxKey == -1) return null;
            int colon = body.indexOf(':', idxKey);
            if (colon == -1) return null;
            int i = colon + 1;
            // skip spaces
            while (i < body.length() && Character.isWhitespace(body.charAt(i))) i++;
            StringBuilder sb = new StringBuilder();
            while (i < body.length()) {
                char c = body.charAt(i);
                if ((c >= '0' && c <= '9') || c == '-') {
                    sb.append(c);
                    i++;
                } else {
                    break;
                }
            }
            String s = sb.toString();
            return s.isEmpty() ? null : s;
        } catch (Exception e) {
            return null;
        }
    }

}
