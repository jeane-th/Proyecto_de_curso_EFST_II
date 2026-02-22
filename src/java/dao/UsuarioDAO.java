/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.List;
import modelo.Usuario;

public interface UsuarioDAO {

    // inicio
    public Usuario validar(String email, String password);

    // obtener lista usuarios
    public List<Usuario> getAll();

    // insertar nuevo
    public boolean insertar(Usuario usuario);

    // actualizar
    public boolean actualizar(Usuario usuario);

    // eliminar
    public boolean eliminar(int id);

    // prepargar datos
    public Usuario obtenerPorId(int id);

    // login
    public Usuario login(String email, String password);

    // estado
    public boolean cambiarEstado(int id, int nuevoEstado);

    // cambiar contraseña
    public boolean cambiarPassword(int idUsuario, String nuevaPasswordHash);

}
