package dao;

import java.util.List;
import modelo.Review;

public interface ReviewDAO {

    boolean insertar(Review r);

    List<Review> listarPorCurso(int idCurso);

    double obtenerPromedio(int idCurso);

    int contarPorCurso(int idCurso);

}
