/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador.admin;

import dao.UsuarioDAOimpl;
import modelo.Usuario;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


@WebServlet("/admin/cambiar_password")
public class CambiarPasswordServlet extends HttpServlet {

    private UsuarioDAOimpl dao = new UsuarioDAOimpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario u = (Usuario) request.getSession().getAttribute("usuario");

        if (u == null || u.getRol() == null || !u.getRol().equalsIgnoreCase("Admin")) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.getRequestDispatcher("/admin/cambiar_password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario u = (Usuario) request.getSession().getAttribute("usuario");
        if (u == null || u.getRol() == null || !u.getRol().equalsIgnoreCase("Admin")) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String actual = request.getParameter("actual");
        String nueva = request.getParameter("nueva");
        String confirmar = request.getParameter("confirmar");

        // validaciones
        if (actual == null || nueva == null || confirmar == null ||
            actual.isEmpty() || nueva.isEmpty() || confirmar.isEmpty()) {
            request.setAttribute("mensaje", "Todos los campos son obligatorios");
            request.getRequestDispatcher("/admin/cambiar_password.jsp").forward(request, response);
            return;
        }

        if (!nueva.equals(confirmar)) {
            request.setAttribute("mensaje", "La nueva contraseña y la confirmación no coinciden");
            request.getRequestDispatcher("/admin/cambiar_password.jsp").forward(request, response);
            return;
        }

        // verifica contraseña
        Usuario usuarioBD = dao.obtenerPorId(u.getIdUsuario());
        if (!BCrypt.checkpw(actual, usuarioBD.getPassword())) {
            request.setAttribute("mensaje", "La contraseña actual es incorrecta");
            request.getRequestDispatcher("/admin/cambiar_password.jsp").forward(request, response);
            return;
        }

        // hash
        String hash = BCrypt.hashpw(nueva, BCrypt.gensalt());

        // actualiza
        boolean actualizado = dao.cambiarPassword(u.getIdUsuario(), hash);

        if (actualizado) {
            // actualiza la sesion con la contraseña
            usuarioBD.setPassword(hash);
            request.getSession().setAttribute("usuario", usuarioBD);

            request.setAttribute("mensaje", "Contraseña actualizada correctamente");
        } else {
            request.setAttribute("mensaje", "Error al actualizar la contraseña");
        }

        request.getRequestDispatcher("/admin/cambiar_password.jsp").forward(request, response);
    }
}