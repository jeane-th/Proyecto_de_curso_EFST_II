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

public class MatriculaDAOImpl implements MatriculaDAO {

    @Override
    public boolean matricular(int idUsuario, int idCurso) {

        try (Connection con = Conexion.getConnection()) {

            String updateSql = """
                UPDATE matriculas
                SET estado = 1
                WHERE idUsuario = ? AND idCurso = ?
            """;

            try (PreparedStatement ps = con.prepareStatement(updateSql)) {
                ps.setInt(1, idUsuario);
                ps.setInt(2, idCurso);

                int filas = ps.executeUpdate();

                if (filas == 0) {
                    String insertSql = """
                        INSERT INTO matriculas (idUsuario, idCurso, estado)
                        VALUES (?, ?, 1)
                    """;

                    try (PreparedStatement ps2 = con.prepareStatement(insertSql)) {
                        ps2.setInt(1, idUsuario);
                        ps2.setInt(2, idCurso);
                        ps2.executeUpdate();
                    }
                }
            }

            return true;

        } catch (Exception e) {
            System.err.println("Error matricular: " + e.getMessage());
        }
        return false;
    }

    @Override
    public boolean estaMatriculado(int idUsuario, int idCurso) {

        String sql = """
            SELECT idMatricula
            FROM matriculas
            WHERE idUsuario = ? AND idCurso = ? AND estado = 1
        """;

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            ps.setInt(2, idCurso);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (Exception e) {
            System.err.println("Error validar matrícula: " + e.getMessage());
        }
        return false;
    }

    @Override
    public boolean existeMatricula(int idUsuario, int idCurso) {

        String sql = """
            SELECT idMatricula
            FROM matriculas
            WHERE idUsuario = ? AND idCurso = ?
        """;

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            ps.setInt(2, idCurso);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }

        } catch (Exception e) {
            System.err.println("Error existeMatricula: " + e.getMessage());
        }
        return false;
    }

    @Override
    public List<Curso> cursosPorUsuario(int idUsuario) {

        List<Curso> lista = new ArrayList<>();

        String sql = """
            SELECT c.*
            FROM matriculas m
            INNER JOIN tb_cursos c ON m.idCurso = c.idCurso
            WHERE m.idUsuario = ? AND m.estado = 1
        """;

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {

            ps.setInt(1, idUsuario);

            try (ResultSet rs = ps.executeQuery()) {
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
                    c.setDuracion(rs.getInt("duracion"));
                    c.setEstado(rs.getBoolean("estado"));

                    lista.add(c);
                }
            }

        } catch (Exception e) {
            System.err.println("Error listar cursos matriculados: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public boolean eliminarMatricula(int idUsuario, int idCurso) {

        String sql = """
                    UPDATE matriculas
                    SET estado = 0
                    WHERE idUsuario = ? AND idCurso = ?
                """;

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            ps.setInt(2, idCurso);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("Error eliminar matrícula: " + e.getMessage());
        }
        return false;
    }
}
