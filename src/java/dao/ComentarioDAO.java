/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import util.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Comentario;

public class ComentarioDAO {

  
    public List<Comentario> listar() {

        List<Comentario> lista = new ArrayList<>();

        String sql = """
            SELECT r.idReview,
                   r.comentario,
                   r.valoracion,
                   r.fecha,
                   r.estado,
                   u.idUsuario,
                   u.nombre AS usuario,
                   c.idCurso,
                   c.titulo AS curso
            FROM reviews r
            JOIN tb_usuarios u ON r.idUsuario = u.idUsuario
            JOIN tb_cursos c ON r.idCurso = c.idCurso
            ORDER BY r.fecha DESC
        """;

        try (
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {
                Comentario c = new Comentario();

                c.setIdReview(rs.getInt("idReview"));
                c.setComentario(rs.getString("comentario"));
                c.setValoracion(rs.getInt("valoracion"));
                c.setFecha(rs.getTimestamp("fecha"));
                c.setEstado(rs.getInt("estado"));

                c.setIdUsuario(rs.getInt("idUsuario"));
                c.setUsuario(rs.getString("usuario"));

                c.setIdCurso(rs.getInt("idCurso"));
                c.setCurso(rs.getString("curso"));

                lista.add(c);
            }

        } catch (Exception e) {
            System.out.println("❌ Error listar comentarios: " + e.getMessage());
        }

        return lista;
    }

 
    public void cambiarEstado(int idReview, int estado) {

        String sql = "UPDATE reviews SET estado=? WHERE idReview=?";

        try (
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, estado);
            ps.setInt(2, idReview);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("❌ Error cambiar estado comentario: " + e.getMessage());
        }
    }


    public void eliminar(int idReview) {

        String sql = "DELETE FROM reviews WHERE idReview=?";

        try (
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, idReview);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("❌ Error eliminar comentario: " + e.getMessage());
        }
    }
}
