/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.Conexion;


public class ReporteDAO {

    public int totalUsuarios() {
        String sql = "SELECT COUNT(*) FROM tb_usuarios";
        return obtenerTotal(sql);
    }

    public int totalCursos() {
        String sql = "SELECT COUNT(*) FROM tb_cursos";
        return obtenerTotal(sql);
    }

    public int totalMatriculas() {
        String sql = "SELECT COUNT(*) FROM matriculas";
        return obtenerTotal(sql);
    }

    public int totalReviews() {
        String sql = "SELECT COUNT(*) FROM reviews";
        return obtenerTotal(sql);
    }

    private int obtenerTotal(String sql) {
        int total = 0;
        try (
            Connection cn = Conexion.getConnection();
            PreparedStatement ps = cn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
        ) {
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return total;
    }
}