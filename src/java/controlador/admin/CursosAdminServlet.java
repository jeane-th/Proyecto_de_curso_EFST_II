/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador.admin;

import dao.CursoDAO;
import dao.CursoDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import modelo.Curso;

@WebServlet("/admin/cursos")
public class CursosAdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String rol = (String) session.getAttribute("rol");
        if (rol == null || !rol.equalsIgnoreCase("Admin")) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        CursoDAO dao = new CursoDAOImpl();
        String action = request.getParameter("action");

        try {
            // Acción editar
            if ("editar".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Curso curso = dao.buscar(id);
                if (curso != null) {
                    request.setAttribute("curso", curso);
                    request.getRequestDispatcher("/admin/editarCurso.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/cursos?error=noEncontrado");
                }
                return;
            }

            // Acción eliminar
            if ("eliminar".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean eliminado = dao.eliminar(id);
                if (eliminado) {
                    response.sendRedirect(request.getContextPath() + "/admin/cursos?success=eliminar");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/cursos?error=eliminar");
                }
                return; // importante para que no siga con el listado
            }

            // Listar cursos
            List<Curso> listaCursos = dao.listarConMatriculas();
            request.setAttribute("listaCursos", listaCursos);
            request.getRequestDispatcher("/admin/cursos.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/cursos?error=general");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idStr = request.getParameter("idCurso");
            int idCurso = Integer.parseInt(idStr);

            String titulo = request.getParameter("titulo");
            String descripcion = request.getParameter("descripcion");
            String categoria = request.getParameter("categoria");
            String imagen = request.getParameter("imagen");
            String video = request.getParameter("video");
            String profesor = request.getParameter("profesor");
            double precio = Double.parseDouble(request.getParameter("precio"));
            int duracion = Integer.parseInt(request.getParameter("duracion"));
            boolean estado = Boolean.parseBoolean(request.getParameter("estado"));

            Curso curso = new Curso(idCurso, titulo, descripcion, categoria, imagen, video, profesor, precio, duracion, estado);
            CursoDAO dao = new CursoDAOImpl();

            boolean actualizado = dao.actualizar(curso);

            if (actualizado) {
                response.sendRedirect(request.getContextPath() + "/admin/cursos?success=actualizar");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/editarCurso.jsp?id=" + idCurso + "&error=actualizar");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/cursos?error=post");
        }
    }
}
