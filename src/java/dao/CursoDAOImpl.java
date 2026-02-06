/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.List;
import java.sql.*;
import java.util.ArrayList;
import modelo.Curso;
import util.Conexion;

public class CursoDAOImpl implements CursoDAO {

    @Override
    public boolean agregar(Curso c) {
        String sql = "INSERT INTO tb_cursos "
                + "(titulo, descripcion, categoria, imagen, video, profesor, precio, duracion, estado) "
                + "VALUES (?,?,?,?,?,?,?,?,?)";

        try (
                Connection con = Conexion.getConnection(); 
                PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setString(1, c.getTitulo());
            ps.setString(2, c.getDescripcion());
            ps.setString(3, c.getCategoria());
            ps.setString(4, c.getImagen());
            ps.setString(5, c.getVideo());
            ps.setString(6, c.getProfesor());
            ps.setDouble(7, c.getPrecio());
            ps.setInt(8, c.getDuracion()); // ej: "10 horas"
            ps.setBoolean(9, true); // activo por defecto
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (Exception e) {
            System.out.println("Error al agregar curso: " + e.getMessage());
            return false;
        }
    }

    @Override
    public List<Curso> listar() {
        List<Curso> lista = new ArrayList<>();
        String sql = "SELECT * FROM tb_cursos;";
        try (
                Connection conecDB = Conexion.getConnection(); PreparedStatement ps = conecDB.prepareStatement(sql); ResultSet rs = ps.executeQuery();) {
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

        } catch (Exception e) {
            System.out.println("Error al listar los cursos: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public Curso buscar(int idCurso) {
        String sql = "select * from tb_cursos where idCurso = ?";
        try (
                Connection con = Conexion.getConnection(); 
                PreparedStatement ps = con.prepareStatement(sql);) {
            
            ps.setInt(1, idCurso);
            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return new Curso(
                            rs.getInt("idCurso"),
                            rs.getString("titulo"),
                            rs.getString("descripcion"),
                            rs.getString("categoria"),
                            rs.getString("imagen"),
                            rs.getString("video"),
                            rs.getString("profesor"),
                            rs.getDouble("precio"),
                            rs.getInt("duracion"),
                            rs.getBoolean("estado")
                    );
                }
            }
        } catch (Exception e) {
            System.out.println("Error al buscar curso: " + e.getMessage());
        }
        return null;
    }

    @Override
    public boolean actualizar(Curso c) {
        String sql = "UPDATE tb_cursos SET titulo = ?, descripcion = ?, categoria = ?, imagen = ?, video = ?, profesor = ?, precio = ?, duracion = ?, estado = ? WHERE idCurso = ?;";
        try (
                Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setString(1, c.getTitulo());
            ps.setString(2, c.getDescripcion());
            ps.setString(3, c.getCategoria());
            ps.setString(4, c.getImagen());
            ps.setString(5, c.getVideo());
            ps.setString(6, c.getProfesor());
            ps.setDouble(7, c.getPrecio());
            ps.setInt(8, c.getDuracion());
            ps.setBoolean(9, c.isEstado());
            ps.setInt(10, c.getIdCurso());
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (Exception e) {
            System.out.println("Error al actualizar curso: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean eliminar(int idCurso) {
        String sql = "DELETE FROM tb_cursos WHERE idCurso = ?";
        try (
                Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setInt(1, idCurso);
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (Exception e) {
            System.out.println("Error al eliminar curso: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean cambiarEstado(int idCurso, boolean estado) {
        String sql = "UPDATE tb_cursos SET estado = ? WHERE idCurso = ?;";
        try (
                Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setBoolean(1, estado);
            ps.setInt(2, idCurso);
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (Exception e) {
            System.out.println("Error al cambiar estado de curso: " + e.getMessage());
            return false;
        }
    }

}
