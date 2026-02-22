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
import modelo.Curso;


@WebServlet("/admin/agregarCurso")
public class AgregarCursoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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

        try {
            // Obtener valores del formulario
            String titulo = request.getParameter("titulo");
            String descripcion = request.getParameter("descripcion");
            String categoria = request.getParameter("categoria");
            String imagen = request.getParameter("imagen");
            String video = request.getParameter("video");
            String profesor = request.getParameter("profesor");
            double precio = Double.parseDouble(request.getParameter("precio"));
            int duracion = Integer.parseInt(request.getParameter("duracion"));
            boolean estado = "on".equals(request.getParameter("estado"));

            // Crear objeto Curso
            Curso curso = new Curso();
            curso.setTitulo(titulo);
            curso.setDescripcion(descripcion);
            curso.setCategoria(categoria);
            curso.setImagen(imagen != null ? imagen : "");
            curso.setVideo(video != null ? video : "");
            curso.setProfesor(profesor);
            curso.setPrecio(precio);
            curso.setDuracion(duracion);
            curso.setEstado(estado);

            // Insertar en BD
            CursoDAO dao = new CursoDAOImpl();
            boolean insertado = dao.insertar(curso);

            if (insertado) {
                response.sendRedirect(request.getContextPath() + "/admin/cursos?success=insertar");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/agregarCurso.jsp?error=insertar");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/agregarCurso.jsp?error=post");
        }
    }
}