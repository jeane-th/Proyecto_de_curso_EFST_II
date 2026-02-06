
CREATE TABLE tb_usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    rol VARCHAR(20) DEFAULT 'USUARIO', -- ADMIN / USUARIO
    estado TINYINT DEFAULT 1,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE tb_cursos (
    idCurso INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    descripcion TEXT NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    imagen VARCHAR(255) NOT NULL,
    video VARCHAR(255) NOT NULL,
	profesor VARCHAR(100) NOT NULL,
	precio DECIMAL(10,2) NOT NULL,
	duracion VARCHAR(50),
    estado BOOLEAN
);



CREATE TABLE matriculas (
    idMatricula INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    idCurso INT NOT NULL,
    estado TINYINT DEFAULT 1,
    fecha_matricula TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (id_usuario, idCurso),
    FOREIGN KEY (id_usuario) REFERENCES tb_usuarios(id_usuario),
    FOREIGN KEY (idCurso) REFERENCES tb_cursos(idCurso)
);


CREATE TABLE reviews (
    idReview INT AUTO_INCREMENT PRIMARY KEY,
    idCurso INT NOT NULL,
    idUsuario INT NOT NULL,
    comentario TEXT,
    valoracion INT CHECK (valoracion BETWEEN 1 AND 5),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado TINYINT DEFAULT 1,
    FOREIGN KEY (idCurso) REFERENCES tb_cursos(idCurso),
    FOREIGN KEY (idUsuario) REFERENCES tb_usuarios(id_usuario)
);

INSERT INTO tb_cursos 
(titulo, descripcion, categoria, imagen, video, profesor, precio, duracion, estado) 
VALUES

('HTML y CSS desde cero',
 'Aprende a crear páginas web modernas usando HTML5 y CSS3.',
 'Desarrollo Web',
 'html_css.jpg',
 'html_css.mp4',
 'Carlos Pérez',
 99.90,
 20,
 1),

('JavaScript moderno',
 'Domina JavaScript, ES6+ y programación orientada a la web.',
 'Desarrollo Web',
 'javascript.jpg',
 'javascript.mp4',
 'Ana Torres',
 120.00,
 25,
 1),

('Diseño gráfico con Canva',
 'Aprende principios básicos de diseño gráfico usando Canva.',
 'Diseño',
 'canva.jpg',
 'canva.mp4',
 'Lucía Gómez',
 80.00,
 15,
 1),

('UX/UI para principiantes',
 'Diseña interfaces centradas en el usuario.',
 'Diseño',
 'ux_ui.jpg',
 'ux_ui.mp4',
 'Miguel Rojas',
 110.00,
 18,
 1),

('Marketing digital desde cero',
 'Estrategias de marketing digital para redes sociales.',
 'Marketing',
 'marketing_digital.jpg',
 'marketing_digital.mp4',
 'Paola Medina',
 95.00,
 16,
 1),

('Publicidad en redes sociales',
 'Aprende a crear campañas efectivas en Facebook e Instagram.',
 'Marketing',
 'publicidad_rrss.jpg',
 'publicidad_rrss.mp4',
 'Jorge Salazar',
 130.00,
 14,
 1),

('Emprendimiento y modelos de negocio',
 'Aprende a crear y validar ideas de negocio.',
 'Negocios',
 'negocios.jpg',
 'negocios.mp4',
 'Fernando Castillo',
 150.00,
 22,
 1),

('Gestión empresarial básica',
 'Conceptos fundamentales para administrar una empresa.',
 'Negocios',
 'gestion.jpg',
 'gestion.mp4',
 'Rosa Fernández',
 140.00,
 20,
 1),

('Introducción a Data Science',
 'Análisis de datos, estadísticas y machine learning básico.',
 'Data Science',
 'data_science.jpg',
 'data_science.mp4',
 'Diego Navarro',
 180.00,
 30,
 1),

('Fotografía digital para principiantes',
 'Aprende a usar tu cámara y mejorar tus fotografías.',
 'Fotografía',
 'fotografia.jpg',
 'fotografia.mp4',
 'María López',
 90.00,
 12,
 1);
