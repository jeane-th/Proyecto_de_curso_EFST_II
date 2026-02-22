/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Curso;
import util.Conexion;

public class CursoDAOImpl implements CursoDAO {

    @Override
    public boolean insertar(Curso c) {
        String sql = "INSERT INTO tb_cursos (titulo, descripcion, categoria, imagen, video, profesor, precio, duracion, estado) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, c.getTitulo());
            ps.setString(2, c.getDescripcion());
            ps.setString(3, c.getCategoria());
            ps.setString(4, c.getImagen());
            ps.setString(5, c.getVideo());
            ps.setString(6, c.getProfesor());
            ps.setDouble(7, c.getPrecio());
            ps.setInt(8, c.getDuracion());
            ps.setBoolean(9, c.isEstado());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println(" Error al insertar curso: " + e.getMessage());
            return false;
        }
    }

    @Override
    public List<Curso> listar() {
        List<Curso> lista = new ArrayList<>();
        String sql = "SELECT * FROM tb_cursos ORDER BY idCurso DESC";
        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Curso c = new Curso();
                c.setIdCurso(rs.getInt("idCurso"));
                c.setTitulo(rs.getString("titulo"));
                c.setDescripcion(rs.getString("descripcion"));
                c.setCategoria(rs.getString("categoria"));
                c.setImagen(rs.getString("imagen"));
                c.setVideo(rs.getString("video"));
                c.setProfesor(rs.getString("profesor"));
                c.setPrecio(rs.getDouble("precio"));
                c.setDuracion(rs.getInt("duracion")); // int
                c.setEstado(rs.getBoolean("estado"));
                lista.add(c);
            }

        } catch (Exception e) {
            System.err.println(" Error al listar cursos: " + e.getMessage());
        }
        return lista;
    }
// FALTA COPIAR AL PROYECTO

    @Override
    public List<Curso> listarConMatriculas() {
        List<Curso> lista = new ArrayList<>();
        String sql = """
            SELECT c.*, 
                   (SELECT COUNT(*) FROM matriculas m WHERE m.idCurso = c.idCurso AND m.estado = 1) AS totalMatriculados
            FROM tb_cursos c
            ORDER BY c.idCurso DESC
        """;

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Curso c = new Curso();
                c.setIdCurso(rs.getInt("idCurso"));
                c.setTitulo(rs.getString("titulo"));
                c.setDescripcion(rs.getString("descripcion"));
                c.setCategoria(rs.getString("categoria"));
                c.setImagen(rs.getString("imagen"));
                c.setVideo(rs.getString("video"));
                c.setProfesor(rs.getString("profesor"));
                c.setPrecio(rs.getDouble("precio"));
                c.setDuracion(rs.getInt("duracion")); // int
                c.setEstado(rs.getBoolean("estado"));
                c.setTotalMatriculados(rs.getInt("totalMatriculados"));
                lista.add(c);
            }

        } catch (Exception e) {
            System.err.println(" Error en listarConMatriculas(): " + e.getMessage());
        }
        return lista;
    }

    @Override
    public Curso buscar(int idCurso) {
        Curso c = null;
        String sql = "SELECT * FROM tb_cursos WHERE idCurso=?";
        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idCurso);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                c = new Curso();
                c.setIdCurso(rs.getInt("idCurso"));
                c.setTitulo(rs.getString("titulo"));
                c.setDescripcion(rs.getString("descripcion"));
                c.setCategoria(rs.getString("categoria"));
                c.setImagen(rs.getString("imagen"));
                c.setVideo(rs.getString("video"));
                c.setProfesor(rs.getString("profesor"));
                c.setPrecio(rs.getDouble("precio"));
                c.setDuracion(rs.getInt("duracion")); // int
                c.setEstado(rs.getBoolean("estado"));
            }

        } catch (Exception e) {
            System.err.println(" Error al buscar curso: " + e.getMessage());
        }
        return c;
    }

    @Override
    public boolean actualizar(Curso c) {
        String sql = """
            UPDATE tb_cursos
            SET titulo=?, descripcion=?, categoria=?, imagen=?, video=?, profesor=?, precio=?, duracion=?, estado=?
            WHERE idCurso=?
        """;
        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, c.getTitulo());
            ps.setString(2, c.getDescripcion());
            ps.setString(3, c.getCategoria());
            ps.setString(4, c.getImagen());
            ps.setString(5, c.getVideo());
            ps.setString(6, c.getProfesor());
            ps.setDouble(7, c.getPrecio());
            ps.setInt(8, c.getDuracion()); // int
            ps.setBoolean(9, c.isEstado());
            ps.setInt(10, c.getIdCurso());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println(" Error al actualizar curso: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean eliminar(int idCurso) {
        String sqlEliminarReviews = "DELETE FROM reviews WHERE idCurso=?";
        String sqlEliminarCurso = "DELETE FROM tb_cursos WHERE idCurso=?";
        Connection con = null;
        try {
            con = Conexion.getConnection();
            con.setAutoCommit(false);

            try (PreparedStatement psReviews = con.prepareStatement(sqlEliminarReviews)) {
                psReviews.setInt(1, idCurso);
                psReviews.executeUpdate();
            }

            boolean cursoEliminado;
            try (PreparedStatement psCurso = con.prepareStatement(sqlEliminarCurso)) {
                psCurso.setInt(1, idCurso);
                cursoEliminado = psCurso.executeUpdate() > 0;
            }
            con.commit();
            return cursoEliminado;

        } catch (Exception e) {
            System.err.println("Error al eliminar curso: " + e.getMessage());
            try {
                if (con != null) {
                    con.rollback(); 
                }
            } catch (SQLException ex) {
                System.err.println("Error al hacer rollback: " + ex.getMessage());
            }
            return false;

        } finally {
            try {
                if (con != null) {
                    con.setAutoCommit(true);
                    con.close(); 
                }
            } catch (SQLException e) {
                System.err.println("Error al cerrar conexión: " + e.getMessage());
            }
        }
    }

    @Override
    public boolean cambiarEstado(int idCurso, boolean estado) {
        String sql = "UPDATE tb_cursos SET estado=? WHERE idCurso=?";
        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setBoolean(1, estado);
            ps.setInt(2, idCurso);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println(" Error al cambiar estado del curso: " + e.getMessage());
            return false;
        }
    }
}
