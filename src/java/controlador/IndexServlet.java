/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controlador;

import dao.CursoDAO;
import dao.CursoDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import modelo.Curso;

@WebServlet("") // para ejecutar al cargar la pagina de inicio
public class IndexServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CursoDAO dao = new CursoDAOImpl();
        List<Curso> cursos = dao.listar();
        System.out.println("Cantidad de cursos: " + cursos.size());
        cursos.forEach(c -> System.out.println(c.getTitulo()));
        System.out.println("Se ejecuto el GET");
        request.setAttribute("listaCursos", dao.listar());
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
