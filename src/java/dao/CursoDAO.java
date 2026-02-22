/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.List;
import modelo.Curso;



public interface CursoDAO {

    boolean insertar(Curso c);

    List<Curso> listar();

    List<Curso> listarConMatriculas();

    Curso buscar(int idCurso);

    boolean actualizar(Curso c);

    boolean eliminar(int idCurso);

    boolean cambiarEstado(int idCurso, boolean estado);
}