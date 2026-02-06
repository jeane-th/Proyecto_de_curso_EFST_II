/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

public class Curso {

    private int idCurso;
    private String titulo;
    private String descripcion;
    private String categoria;
    private String imagen;
    private String video;
    private String profesor;
    private double precio;
    private int duracion; // en horas
    private boolean estado;

    public Curso() {
    }

    public Curso(int idCurso, String titulo, String descripcion, String categoria, String imagen, String video, String profesor, double precio, int duracion, boolean estado) {
        this.idCurso = idCurso;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.categoria = categoria;
        this.imagen = imagen;
        this.video = video;
        this.profesor = profesor;
        this.precio = precio;
        this.duracion = duracion;
        this.estado = estado;
    }

    public Curso(String titulo, String descripcion, String categoria, String imagen, String video, String profesor, double precio, int duracion, boolean estado) {
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.categoria = categoria;
        this.imagen = imagen;
        this.video = video;
        this.profesor = profesor;
        this.precio = precio;
        this.duracion = duracion;
        this.estado = estado;
    }

    public int getIdCurso() {
        return idCurso;
    }

    public void setIdCurso(int idCurso) {
        this.idCurso = idCurso;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public String getVideo() {
        return video;
    }

    public void setVideo(String video) {
        this.video = video;
    }

    public String getProfesor() {
        return profesor;
    }

    public void setProfesor(String profesor) {
        this.profesor = profesor;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }

    public int getDuracion() {
        return duracion;
    }

    public void setDuracion(int duracion) {
        this.duracion = duracion;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    
    
    @Override
    public String toString() {
        return idCurso + " | " + titulo + " | " + descripcion + " | " + categoria + " | " + imagen + " | " + video + " | " + estado;
    }
}
