/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;


import java.util.List;
import modelo.Curso;

public interface MatriculaDAO {

    boolean matricular(int idUsuario, int idCurso);

    boolean estaMatriculado(int idUsuario, int idCurso);
    
    boolean existeMatricula(int idUsuario, int idCurso);
    
    boolean eliminarMatricula(int idUsuario, int idCurso);

    List<Curso> cursosPorUsuario(int idUsuario);
}
