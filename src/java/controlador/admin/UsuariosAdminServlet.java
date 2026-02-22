/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador.admin;

import dao.UsuarioDAO;
import dao.UsuarioDAOimpl;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import modelo.Usuario;


@WebServlet(name = "UsuariosAdminServlet", urlPatterns = {"/admin/usuarios"})
public class UsuariosAdminServlet extends HttpServlet {
    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Entrando al servlet correcto");

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

        UsuarioDAO dao = new UsuarioDAOimpl();
        String action = request.getParameter("action");

        try {
            if (action == null) {
                // listar
                List<Usuario> lista = dao.getAll();
                request.setAttribute("listaUsuarios", lista);
                request.getRequestDispatcher("/admin/usuarios.jsp").forward(request, response);
            } 
            else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect(request.getContextPath() + "/admin/usuarios");
            } 
            else if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                Usuario u = dao.obtenerPorId(id);
                request.setAttribute("usuarioEdit", u);
                request.getRequestDispatcher("/admin/editarUsuario.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Error en UsuariosAdminServlet: " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UsuarioDAO dao = new UsuarioDAOimpl();

        int id = Integer.parseInt(request.getParameter("idUsuario"));
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String rol = request.getParameter("rol");
        int estado = Integer.parseInt(request.getParameter("estado"));

        Usuario u = new Usuario();
        u.setIdUsuario(id);
        u.setNombre(nombre);
        u.setEmail(email);
        u.setRol(rol);
        u.setEstado(estado);

        dao.actualizar(u);
        response.sendRedirect(request.getContextPath() + "/admin/usuarios");
    }
}