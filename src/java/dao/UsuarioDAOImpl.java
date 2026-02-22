/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelo.Usuario;
import org.mindrot.jbcrypt.BCrypt;
import util.Conexion;

public class UsuarioDAOimpl implements UsuarioDAO {

    @Override
    public Usuario validar(String email, String password) {

        String sql = "SELECT * FROM tb_usuarios WHERE email=? AND password=? AND estado=1";

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setIdUsuario(rs.getInt("idUsuario"));
                    u.setNombre(rs.getString("nombre"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setRol(rs.getString("rol"));
                    u.setEstado(rs.getInt("estado"));
                    return u;
                }
            }

        } catch (Exception e) {
            System.err.println("Error en validar: " + e.getMessage());
        }

        return null;
    }

    @Override
    public Usuario login(String email, String password) {

        String sql = "SELECT * FROM tb_usuarios WHERE email=? AND estado=1";

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    String hash = rs.getString("password");

                    if (BCrypt.checkpw(password, hash)) {
                        Usuario u = new Usuario();
                        u.setIdUsuario(rs.getInt("idUsuario"));
                        u.setNombre(rs.getString("nombre"));
                        u.setEmail(rs.getString("email"));
                        u.setPais(rs.getString("pais"));
                        u.setRol(rs.getString("rol"));
                        u.setEstado(rs.getInt("estado"));
                        return u;
                    }
                }
            }

        } catch (Exception e) {
            System.err.println("Error en login: " + e.getMessage());
        }

        return null;
    }

    @Override
    public List<Usuario> getAll() {

        List<Usuario> lista = new ArrayList<>();

        String sql = "SELECT u.*, "
                + "(SELECT COUNT(*) FROM matriculas m WHERE m.idUsuario = u.idUsuario) AS total_cursos "
                + "FROM tb_usuarios u";

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("idUsuario"));
                u.setNombre(rs.getString("nombre"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setPais(rs.getString("pais"));
                u.setRol(rs.getString("rol"));
                u.setEstado(rs.getInt("estado"));
                u.setNroCursos(rs.getInt("total_cursos"));
                u.setFechaRegistro(rs.getTimestamp("fecha_registro"));
                lista.add(u);
            }

        } catch (Exception e) {
            System.err.println("Error en getAll: " + e.getMessage());
        }

        return lista;
    }

    @Override
    public boolean insertar(Usuario usuario) {

        String sql = "INSERT INTO tb_usuarios(nombre, email, password, pais, rol, estado) VALUES(?,?,?,?,?,1)";

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            String hash = BCrypt.hashpw(usuario.getPassword(), BCrypt.gensalt());

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getEmail());
            ps.setString(3, hash);
            ps.setString(4, usuario.getPais());
            ps.setString(5, "usuario");

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("Error en insertar: " + e.getMessage());
        }

        return false;
    }

    @Override
    public boolean actualizar(Usuario usuario) {

        String sql = "UPDATE tb_usuarios SET nombre=?, email=?, rol=?, estado=? WHERE idUsuario=?";

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getEmail());
            ps.setString(3, usuario.getRol());
            ps.setInt(4, usuario.getEstado());
            ps.setInt(5, usuario.getIdUsuario());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("Error en actualizar: " + e.getMessage());
        }

        return false;
    }

    @Override
    public boolean eliminar(int id) {

        String sql = "DELETE FROM tb_usuarios WHERE idUsuario=?";

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("Error en eliminar: " + e.getMessage());
        }

        return false;
    }

    @Override
    public Usuario obtenerPorId(int id) {

        String sql = "SELECT * FROM tb_usuarios WHERE idUsuario=?";

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    Usuario u = new Usuario();
                    u.setIdUsuario(rs.getInt("idUsuario"));
                    u.setNombre(rs.getString("nombre"));
                    u.setEmail(rs.getString("email"));
                    u.setPassword(rs.getString("password"));
                    u.setRol(rs.getString("rol"));
                    u.setEstado(rs.getInt("estado"));
                    return u;
                }
            }

        } catch (Exception e) {
            System.err.println("Error en obtenerPorId: " + e.getMessage());
        }

        return null;
    }

    @Override
    public boolean cambiarEstado(int id, int nuevoEstado) {

        String sql = "UPDATE tb_usuarios SET estado=? WHERE idUsuario=?";

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, nuevoEstado);
            ps.setInt(2, id);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("Error en cambiarEstado: " + e.getMessage());
        }

        return false;
    }

    @Override
    public boolean cambiarPassword(int idUsuario, String nuevaPasswordHash) {

        String sql = "UPDATE tb_usuarios SET password=? WHERE idUsuario=?";

        try (Connection con = Conexion.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, nuevaPasswordHash);
            ps.setInt(2, idUsuario);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            System.err.println("Error en cambiarPassword: " + e.getMessage());
        }

        return false;
    }
}
