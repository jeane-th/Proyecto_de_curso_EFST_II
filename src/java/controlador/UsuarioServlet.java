/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controlador;

import dao.UsuarioDAO;
import dao.UsuarioDAOImpl;
import modelo.Usuario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})

public class UsuarioServlet extends HttpServlet {

    // Instanciamos el DAO una sola vez
    private final UsuarioDAO dao = new UsuarioDAOImpl();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Configuramos la codificación para aceptar tildes y ñ
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Capturamos la acción que viene del formulario (input hidden)
        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "actualizar":
                    actualizarUsuario(request, response);
                    break;

                case "bloquear":
                    // 1. Recibimos el ID desde la URL
                    int idBloquear = Integer.parseInt(request.getParameter("idUsuario"));

                    // 2. Llamamos al método francotirador para poner estado = 0 (Inactivo)
                    dao.cambiarEstado(idBloquear, 0);

                    // 3. Regresamos al panel
                    response.sendRedirect("usuarioPanel.jsp");
                    break;
                case "eliminar":
                    int idEliminar = Integer.parseInt(request.getParameter("idUsuario"));

                    // Llamamos a TU función específica
                    dao.eliminar(idEliminar);

                    response.sendRedirect("usuarioPanel.jsp");
                    break;
                default:
                    response.sendRedirect("usuarioPanel.jsp");
            }
        } else {
            response.sendRedirect("usuarioPanel.jsp");
        }
    }

    private void actualizarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. Recibimos los datos del Modal
            // 'idUsuario' viene del input hidden
            int id = Integer.parseInt(request.getParameter("idUsuario"));
            String nombre = request.getParameter("nombre");
            String email = request.getParameter("email");

            // OJO AQUÍ: Asumo que el Select de Rol envía un número (1, 2, 3)
            String rol = request.getParameter("rol");

            int estado = Integer.parseInt(request.getParameter("estado"));

            // 2. Creamos el objeto Usuario con los nuevos datos
            Usuario u = new Usuario();
            u.setIdUsuario(id);
            u.setNombre(nombre);
            u.setEmail(email);
            u.setRol(rol);
            u.setEstado(estado);

            // 3. Llamamos al DAO para guardar en la BD
            boolean exito = dao.actualizar(u);

            // 4. Redireccionamos según el resultado
            if (exito) {
                // Puedes usar una variable de sesión para mostrar una alerta de éxito
                request.getSession().setAttribute("mensaje", "Usuario actualizado correctamente.");
            } else {
                request.getSession().setAttribute("error", "No se pudo actualizar el usuario.");
            }

            // Vuelve a la página donde está la tabla
            response.sendRedirect("usuarioPanel.jsp");

        } catch (NumberFormatException e) {
            System.out.println("Error al convertir números: " + e.getMessage());
            response.sendRedirect("usuarioPanel.jsp?error=datos_invalidos");
        } catch (Exception e) {
            System.out.println("Error general: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("usuarioPanel.jsp?error=desconocido");
        }
    }

    // Métodos estándar doPost y doGet que llaman a processRequest
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
