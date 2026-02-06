/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador.auth;

import dao.UsuarioDAO;
import dao.UsuarioDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.Usuario;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException{
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            UsuarioDAO dao = new UsuarioDAOImpl();
            Usuario u = dao.login(email, password);
            
            if(u != null){
                HttpSession session = request.getSession();
                session.setAttribute("usuario",u);
                response.sendRedirect(request.getContextPath()+"/");
                System.out.println("Sesion: "+u);
            }else{
                request.setAttribute("error", "Error en las credenciales");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
