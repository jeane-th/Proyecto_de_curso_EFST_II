/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador.admin;

import dao.ComentarioDAO;
import modelo.Comentario;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;


@WebServlet("/admin/comentarios")
public class ComentariosAdminServlet extends HttpServlet {

    private ComentarioDAO dao = new ComentarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("eliminar".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            dao.eliminar(id);

            // refresh
            response.sendRedirect(request.getContextPath() + "/admin/comentarios");
            return;
        }


        if ("estado".equals(accion)) {
            int id = Integer.parseInt(request.getParameter("id"));
            int estado = Integer.parseInt(request.getParameter("estado"));

            dao.cambiarEstado(id, estado);

            response.sendRedirect(request.getContextPath() + "/admin/comentarios");
            return;
        }

        //listar
        List<Comentario> lista = dao.listar();
        request.setAttribute("listaComentarios", lista);
        request.getRequestDispatcher("/admin/comentarios.jsp").forward(request, response);
    }
}
