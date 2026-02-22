package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import modelo.Review;
import util.Conexion;

public class ReviewDAOImpl implements ReviewDAO {

    @Override
    public boolean insertar(Review r) {
        // validar si está matriculado
        String checkSql = "SELECT COUNT(*) AS cnt FROM matriculas WHERE idUsuario = ? AND idCurso = ? AND estado = 1";
        String insertSql = "INSERT INTO reviews(idCurso, idUsuario, comentario, valoracion, fecha) VALUES(?,?,?,?,NOW())";

        try (Connection con = Conexion.getConnection();
                PreparedStatement psCheck = con.prepareStatement(checkSql)) {

            psCheck.setInt(1, r.getIdUsuario());
            psCheck.setInt(2, r.getIdCurso());
            try (ResultSet rs = psCheck.executeQuery()) {
                if (rs.next()) {
                    int cnt = rs.getInt("cnt");
                    if (cnt == 0) {
                        
                        return false;
                    }
                }
            }

            try (PreparedStatement psIns = con.prepareStatement(insertSql)) {
                psIns.setInt(1, r.getIdCurso());
                psIns.setInt(2, r.getIdUsuario());
                psIns.setString(3, r.getComentario());
                psIns.setInt(4, r.getValoracion());
                int filas = psIns.executeUpdate();
                return filas > 0;
            }

        } catch (Exception e) {
            System.err.println("Error en ReviewDAOImpl.insertar: " + e.getMessage());
        }
        return false;
    }

    @Override
    public List<Review> listarPorCurso(int idCurso) {
        List<Review> lista = new ArrayList<>();
        String sql = "SELECT r.idReview, r.idCurso, r.idUsuario, r.comentario, r.valoracion, r.fecha, u.nombre "
                + "FROM reviews r LEFT JOIN tb_usuarios u ON r.idUsuario = u.idUsuario "
                + "WHERE r.idCurso = ? ORDER BY r.fecha DESC";
        try (Connection con = Conexion.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCurso);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Review r = new Review();
                    r.setIdReview(rs.getInt("idReview"));
                    r.setIdCurso(rs.getInt("idCurso"));
                    r.setIdUsuario(rs.getInt("idUsuario"));
                    r.setComentario(rs.getString("comentario"));
                    r.setValoracion(rs.getInt("valoracion"));
                    r.setFecha(rs.getTimestamp("fecha"));
                    r.setNombreUsuario(rs.getString("nombre"));
                    lista.add(r);
                }
            }
        } catch (Exception e) {
            System.err.println("Error en listarPorCurso: " + e.getMessage());
        }
        return lista;
    }

    @Override
    public double obtenerPromedio(int idCurso) {
        String sql = "SELECT AVG(valoracion) AS avgVal FROM reviews WHERE idCurso = ?";
        try (Connection con = Conexion.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCurso);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("avgVal");
                }
            }
        } catch (Exception e) {
            System.err.println("Error en obtenerPromedio: " + e.getMessage());
        }
        return 0.0;
    }

    @Override
    public int contarPorCurso(int idCurso) {
        String sql = "SELECT COUNT(*) AS cnt FROM reviews WHERE idCurso = ?";
        try (Connection con = Conexion.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idCurso);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("cnt");
                }
            }
        } catch (Exception e) {
            System.err.println("Error en contarPorCurso: " + e.getMessage());
        }
        return 0;
    }

}
