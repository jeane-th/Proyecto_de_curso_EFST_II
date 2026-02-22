package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import modelo.Usuario;
import modelo.Curso;
import dao.CursoDAO;
import dao.CursoDAOImpl;

import org.openpdf.text.*;
import org.openpdf.text.pdf.*;

@WebServlet("/CertificadoServlet")
public class CertificadoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔹 1. Validar sesión
        Usuario u = (Usuario) request.getSession().getAttribute("usuario");

        if (u == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 🔹 2. Obtener idCurso
        String param = request.getParameter("idCurso");
        if (param == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Curso no especificado");
            return;
        }

        int idCurso = Integer.parseInt(param);

        // 🔹 3. Obtener curso desde DAO
        CursoDAO cursoDAO = new CursoDAOImpl();
        Curso c = cursoDAO.buscar(idCurso);

        if (c == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Curso no encontrado");
            return;
        }

        String nombre = u.getNombre();
        String tituloCurso = c.getTitulo();
        int horas = c.getDuracion();

        // 🔹 4. Configurar respuesta PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=certificado.pdf");

        try {
            Document document = new Document(PageSize.A4.rotate());
            PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            Image fondo = Image.getInstance(
                    getServletContext().getRealPath("/img/fondo.png")
            );

            // Tamaño completo de página
            fondo.scaleAbsolute(
                    document.getPageSize().getWidth(),
                    document.getPageSize().getHeight()
            );

            fondo.setAbsolutePosition(0, 0);

            // Agregar como fondo (antes del contenido)
            PdfContentByte canvas = writer.getDirectContentUnder();
            canvas.addImage(fondo);

            // 🔹 Fuentes
            Font nombreFont = new Font(Font.HELVETICA, 24, Font.BOLD);
            Font normalFont = new Font(Font.HELVETICA, 18, Font.NORMAL);

            // 🔹 Espacio superior
            document.add(new Paragraph("\n\n\n\n\n\n\n\n\n\n"));

            // 🔹 Nombre grande
            Paragraph pNombre = new Paragraph(nombre, nombreFont);
            pNombre.setAlignment(Element.ALIGN_CENTER);
            document.add(pNombre);

            document.add(new Paragraph("\n\n\n"));

            // 🔹 Texto principal
            Paragraph pTexto = new Paragraph(tituloCurso, normalFont);
            pTexto.setAlignment(Element.ALIGN_CENTER);
            document.add(pTexto);

            document.add(new Paragraph("\n"));

            // 🔹 Texto principal
            Paragraph pHoras = new Paragraph(String.valueOf("                     "+horas), normalFont);
            pHoras.setAlignment(Element.ALIGN_CENTER);
            document.add(pHoras);

            document.add(new Paragraph("\n\n\n\n\n\n\n"));

            // 🔹 Fecha automática
            String fecha = java.time.LocalDate.now()
                    .format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"));

            Paragraph pFecha = new Paragraph("Fecha: " + fecha, normalFont);
            pFecha.setAlignment(Element.ALIGN_CENTER);
            document.add(pFecha);

            document.close();

        } catch (DocumentException e) {
            throw new IOException("Error generando PDF: " + e.getMessage());
        }
    }
}
