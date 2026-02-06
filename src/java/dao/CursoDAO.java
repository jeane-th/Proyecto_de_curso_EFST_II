/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.util.List;
import modelo.Curso;

//Agregar curso 
//Listar cursos totales 
//Buscar curso por id 
//Actualizar curso 
//Eliminar curso 
//Desactivar curso 
//Filtrar curso por categoría 
public interface CursoDAO {

    boolean agregar(Curso c);

    List<Curso> listar();

    Curso buscar(int idCurso);

    boolean actualizar(Curso c);

    boolean eliminar(int idCurso);

    boolean cambiarEstado(int idCurso, boolean estado); 
}
