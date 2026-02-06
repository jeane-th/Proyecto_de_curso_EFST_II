package modelo;

import java.sql.Timestamp;

public class Review {

    private int idReview;
    private int idCurso;
    private int idUsuario;
    private String nombreUsuario; // opcional, para mostrar en listings
    private String comentario;
    private int valoracion; // 1-5
    private Timestamp fecha;

    public Review() {
    }

    public Review(int idReview, int idCurso, int idUsuario, String comentario, int valoracion, Timestamp fecha) {
        this.idReview = idReview;
        this.idCurso = idCurso;
        this.idUsuario = idUsuario;
        this.comentario = comentario;
        this.valoracion = valoracion;
        this.fecha = fecha;
    }

    public int getIdReview() {
        return idReview;
    }

    public void setIdReview(int idReview) {
        this.idReview = idReview;
    }

    public int getIdCurso() {
        return idCurso;
    }

    public void setIdCurso(int idCurso) {
        this.idCurso = idCurso;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getComentario() {
        return comentario;
    }

    public void setComentario(String comentario) {
        this.comentario = comentario;
    }

    public int getValoracion() {
        return valoracion;
    }

    public void setValoracion(int valoracion) {
        this.valoracion = valoracion;
    }

    public Timestamp getFecha() {
        return fecha;
    }

    public void setFecha(Timestamp fecha) {
        this.fecha = fecha;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    @Override
    public String toString() {
        return "Review{" + "idReview=" + idReview + ", idCurso=" + idCurso + ", idUsuario=" + idUsuario + ", comentario=" + comentario + ", valoracion=" + valoracion + ", fecha=" + fecha + '}';
    }

}
