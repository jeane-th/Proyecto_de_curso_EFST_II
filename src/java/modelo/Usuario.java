/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;


import java.sql.Timestamp;

public class Usuario {
 
    private int idUsuario;
    private String nombre;
    private String email;
    private String password;
    private String pais;
    private String rol;
    private int estado;
    private int nroCursos;
    private Timestamp fechaRegistro;

    public Usuario() {
    }

    public Usuario(int idUsuario, String nombre, String email, String password, String pais, String rol, int estado) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.email = email;
        this.password = password;
        this.pais = pais;
        this.rol = rol;
        this.estado = estado;
    }

    public Usuario(String nombre, String email, String password, String pais, String rol, int estado) {
        this.nombre = nombre;
        this.email = email;
        this.password = password;
        this.pais = pais;
        this.rol = rol;
        this.estado = estado;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public int getNroCursos() {
        return nroCursos;
    }

    public void setNroCursos(int nroCursos) {
        this.nroCursos = nroCursos;
    }

    public Timestamp getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Timestamp fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }
}