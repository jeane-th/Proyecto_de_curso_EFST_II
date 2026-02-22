/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import util.Conexion;
import modelo.Integrante;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class IntegranteDAO {

    public List<Integrante> listar() {

        List<Integrante> lista = new ArrayList<>();

        String sql = """
            SELECT idIntegrante, nombre, funcion, descripcion, estado, fecha_creacion
            FROM integrantes_proyecto
            ORDER BY idIntegrante ASC
        """;

        try (
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {

            while (rs.next()) {
                Integrante i = new Integrante();

                i.setIdIntegrante(rs.getInt("idIntegrante"));
                i.setNombre(rs.getString("nombre"));
                i.setFuncion(rs.getString("funcion"));
                i.setDescripcion(rs.getString("descripcion"));
                i.setEstado(rs.getInt("estado"));
                i.setFechaCreacion(rs.getTimestamp("fecha_creacion"));

                lista.add(i);
            }

        } catch (Exception e) {
            System.out.println("❌ Error listar integrantes: " + e.getMessage());
        }

        return lista;
    }

    public void agregar(Integrante i) {

        String sql = """
            INSERT INTO integrantes_proyecto (nombre, funcion, descripcion, estado)
            VALUES (?, ?, ?, 1)
        """;

        try (
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, i.getNombre());
            ps.setString(2, i.getFuncion());
            ps.setString(3, i.getDescripcion());

            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("❌ Error agregar integrante: " + e.getMessage());
        }
    }

    public Integrante obtenerPorId(int id) {

        Integrante i = null;

        String sql = """
            SELECT idIntegrante, nombre, funcion, descripcion, estado
            FROM integrantes_proyecto
            WHERE idIntegrante = ?
        """;

        try (
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                i = new Integrante();

                i.setIdIntegrante(rs.getInt("idIntegrante"));
                i.setNombre(rs.getString("nombre"));
                i.setFuncion(rs.getString("funcion"));
                i.setDescripcion(rs.getString("descripcion"));
                i.setEstado(rs.getInt("estado"));
            }

        } catch (Exception e) {
            System.out.println("❌ Error obtener integrante: " + e.getMessage());
        }

        return i;
    }

    public void editar(Integrante i) {

        String sql = """
            UPDATE integrantes_proyecto
            SET nombre=?, funcion=?, descripcion=?
            WHERE idIntegrante=?
        """;

        try (
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, i.getNombre());
            ps.setString(2, i.getFuncion());
            ps.setString(3, i.getDescripcion());
            ps.setInt(4, i.getIdIntegrante());

            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("❌ Error editar integrante: " + e.getMessage());
        }
    }


    public void eliminar(int id) {

        String sql = "DELETE FROM integrantes_proyecto WHERE idIntegrante=?";

        try (
            Connection con = Conexion.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("❌ Error eliminar integrante: " + e.getMessage());
        }
    }
}
