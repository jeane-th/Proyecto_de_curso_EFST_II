/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador.admin;

import dao.IntegranteDAO;
import modelo.Integrante;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;


@WebServlet("/admin/integrantes")
public class IntegrantesAdminServlet extends HttpServlet {

    private IntegranteDAO dao = new IntegranteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion == null) {
            // lista
            List<Integrante> lista = dao.listar();
            request.setAttribute("listaIntegrantes", lista);
            request.getRequestDispatcher("/admin/integrantes.jsp").forward(request, response);
            return;
        }

        switch (accion) {
            case "editar":
                int id = Integer.parseInt(request.getParameter("id"));
                Integrante i = dao.obtenerPorId(id);
                if (i != null) {
                    request.setAttribute("integrante", i);
                    request.getRequestDispatcher("/admin/integrantes_form.jsp").forward(request, response);
                } else {
                    response.sendRedirect("integrantes");
                }
                break;

            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(idEliminar);
                response.sendRedirect("integrantes");
                break;

            default:
                response.sendRedirect("integrantes");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("idIntegrante");
        String nombre = request.getParameter("nombre");
        String funcion = request.getParameter("funcion");
        String descripcion = request.getParameter("descripcion");

        Integrante i = new Integrante();
        i.setNombre(nombre);
        i.setFuncion(funcion);
        i.setDescripcion(descripcion);

        if (idStr == null || idStr.isEmpty()) {
            // añadir
            dao.agregar(i);
        } else {
            // editar
            i.setIdIntegrante(Integer.parseInt(idStr));
            dao.editar(i);
        }

        response.sendRedirect("integrantes");
    }
}