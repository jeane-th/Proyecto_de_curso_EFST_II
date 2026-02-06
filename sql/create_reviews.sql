-- Script SQL para crear tablas necesarias para reviews y matriculas
-- Ajusta tipos/constraints según tu BD

CREATE TABLE IF NOT EXISTS matriculas (
  idMatricula INT AUTO_INCREMENT PRIMARY KEY,
  id_usuario INT NOT NULL,
  idCurso INT NOT NULL,
  estado TINYINT(1) DEFAULT 1,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  -- FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  -- FOREIGN KEY (idCurso) REFERENCES tb_cursos(idCurso)
  INDEX(id_usuario),
  INDEX(idCurso)
);

CREATE TABLE IF NOT EXISTS reviews (
  idReview INT AUTO_INCREMENT PRIMARY KEY,
  idCurso INT NOT NULL,
  idUsuario INT NOT NULL,
  comentario TEXT,
  valoracion TINYINT NOT NULL,
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX(idCurso),
  INDEX(idUsuario)
  -- FOREIGN KEY (idUsuario) REFERENCES usuario(id_usuario),
  -- FOREIGN KEY (idCurso) REFERENCES tb_cursos(idCurso)
);

-- Ejemplos de inserción (opcionales):
-- INSERT INTO matriculas(id_usuario, idCurso, estado) VALUES(1, 2, 1);
-- INSERT INTO reviews(idCurso, idUsuario, comentario, valoracion) VALUES(2,1,'Buen curso',5);
