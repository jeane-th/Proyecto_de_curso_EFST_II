USE bhofdycde3nrmo12f1zd;

CREATE INDEX idx_reviews_idCurso ON reviews(idCurso);

SHOW INDEX FROM reviews;

/*1. Crear tablas*/
CREATE TABLE `tb_cursos` (
  `idCurso` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) NOT NULL,
  `descripcion` text NOT NULL,
  `categoria` varchar(50) NOT NULL,
  `imagen` varchar(255) NOT NULL,
  `video` varchar(255) NOT NULL,
  `profesor` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `duracion` int NOT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idCurso`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `tb_usuarios` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `pais` varchar(100) DEFAULT NULL,
  `web` varchar(100) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `rol` varchar(20) DEFAULT 'USUARIO',
  `estado` tinyint DEFAULT '1',
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `matriculas` (
  `idMatricula` int NOT NULL AUTO_INCREMENT,
  `idUsuario` int NOT NULL,
  `idCurso` int NOT NULL,
  `fecha_matricula` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` tinyint DEFAULT '1',
  PRIMARY KEY (`idMatricula`),
  UNIQUE KEY `uk_usuario_curso` (`idUsuario`,`idCurso`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `reviews` (
  `idReview` int NOT NULL AUTO_INCREMENT,
  `idCurso` int NOT NULL,
  `idUsuario` int NOT NULL,
  `comentario` text,
  `valoracion` int DEFAULT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` tinyint DEFAULT '1',
  PRIMARY KEY (`idReview`),
  KEY `idCurso` (`idCurso`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`idCurso`) REFERENCES `tb_cursos` (`idCurso`),
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `tb_usuarios` (`idUsuario`),
  CONSTRAINT `reviews_chk_1` CHECK ((`valoracion` between 1 and 5))
);


CREATE TABLE `integrantes_proyecto` (
  `idIntegrante` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `funcion` varchar(100) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `estado` tinyint DEFAULT '1',
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idIntegrante`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


/* 2. Insertar datos de prueba*/


/*-----*/
INSERT INTO `tb_cursos` VALUES 
(1, 'HTML y CSS desde cero', 'Aprende a crear páginas web modernas usando HTML5 y CSS3.', 'Desarrollo Web', 'https://facialix.com/wp-content/uploads/2022/11/3201160_e33c_2.jpg', 'https://www.youtube.com/embed/ELSm-G201Ls', 'Carlos Pérez', 90.00, 20, 1),
(2, 'JavaScript moderno', 'Domina JavaScript, ES6+ y programación orientada a la web.', 'Desarrollo Web', 'https://i.ytimg.com/vi/DAkQ_2xmmg8/maxresdefault.jpg', 'https://www.youtube.com/embed/z95mZVUcJ-E', 'Ana Torres', 120.00, 25, 1),
(3, 'Diseño gráfico con Canva', 'Aprende principios básicos de diseño gráfico usando Canva.', 'Diséño', 'https://marketplace.canva.com/EAE76tEPGKY/1/0/1600w/canva-presentaci%C3%B3n-dise%C3%B1o-geometr%C3%ADa-minimalista-roja-verde-azul--vWadnOoSc8.jpg', 'https://www.youtube.com/embed/pQRyKB75Uk4', 'Lucía Gómez', 80.00, 15, 1),
(4, 'UX/UI para principiantes', 'Diseña interfaces centradas en el usuario.', 'Diséño', 'https://imgproxy.domestika.org/unsafe/rs:fill/plain/src://course-images/000/055/620/55620-original.jpg?1743166108', 'https://www.youtube.com/embed/XtysRVCNLT0', 'Miguel Rojas', 110.00, 18, 1),
(5, 'Marketing digital desde cero', 'Estrategias de marketing digital para redes sociales.', 'Marketing', 'https://i.ytimg.com/vi/YnhJNZxAH7A/maxresdefault.jpg', 'https://www.youtube.com/embed/v17EXDu3t0E', 'Paola Medina', 95.00, 16, 1),
(6, 'Publicidad en redes sociales', 'Aprende a crear campañas efectivas en Facebook e Instagram.', 'Marketing', 'https://i.ytimg.com/vi/YepIJeODF2k/maxresdefault.jpg', 'https://www.youtube.com/embed/e3qH2LBoz5E', 'Jimy santi', 10.00, 10, 1);

INSERT INTO `tb_usuarios` VALUES 
(1, 'Juan Jose', 'JuanJose@gmail.com', '$2a$10$1iwKT6IURNNQFQ6FaRcKCeGr9k.Gp7IA1QurajGuaUZs.NvTcfKb2', 'Perú', '', '', 'usuario', 1, '2026-02-17 02:24:34'),
(2, 'Santana', 'santana@gmail.com', '$2a$10$WESPPsxIxN5iecne1sylcuO/Z8LuFvRUh2lzquuZ8WxhCR6C0Xk8y', 'Argentina', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34'),
(3, 'josueaaa', 'josueobed13@gmail.com', '$2a$10$vA/HeWn5KaIYYxtIXyNZWO8maC92Piw1zreBexpRnTtxyF44pWGyS', 'Perú', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34'),
(4, 'eduardo', 'eduardo@gmial.com', '$2a$10$iXLkEkwmbV9br6s1YOGdBeuQbwgdes/28pyrUZXb1XHC3nMreFn3.', 'Peru', NULL, NULL, 'usuario', 0, '2026-02-17 02:24:34'),
(5, 'Ana Torres', 'anatorres@gmail.com', '$2a$10$duKADICKe6coCVTUhvZcx.Yc8WLA6L7u20Ery3FgUkRhHceQtM9J.', 'Perú', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34'),
(6, 'Luis Ramírez', 'luisramirez@gmail.com', '$2a$10$u6vVKcUICEgPhjEPyp5GvuIE.KE9FgRLH/zTGWRKyewpLQoF41l4O', 'Perú', NULL, NULL, 'usuario', 0, '2026-02-17 02:24:34'),
(7, 'Carla Mendoza', 'carla.mendoza@gmail.com', '$2a$10$POOaObqKKyyZPH3lJXPDIOEmoJLuXIHhu7619iiN4dXHVBPUfgEH.', 'Argentina', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34'),
(8, 'Diego Salazar', 'diego.salazar@gmail.com', '$2a$10$1/Ou58JadEIQLVVtEa/zaOO.e9YN4w7laWU2Zi/5/Sygkbn9kEmay', 'Argentina', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34'),
(9, 'María López', 'maria.lopez@gmail.com', '$2a$10$mPvda6VtRrmVIJgbSBaKNeabPiZWw.2x1uB8XCANrcgZ31GBaJOWi', 'Colombia', NULL, NULL, 'usuario', 0, '2026-02-17 02:24:34'),
(10, 'José Pérez', 'jose.perez@gmail.com', '$2a$10$u2rW8UsaBYvD8gxGpZwnsO8yVDxBpaj.gYCKv/d8.rr5y74G0LPz6', 'Colombia', NULL, NULL, 'usuario', 0, '2026-02-17 02:24:34'),
(13, 'Fernanda Ruiz', 'fernanda.ruiz@gmail.com', '$2a$10$g89dyUMUaOMU7.R2TsHoVeMvKkjknOeABhq0lgKQwqWgUrbe0wLFm', 'Colombia', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34'),
(14, 'Carlos Vega', 'carlos.vega@gmail.com', '$2a$10$Gsgz47Lk0XgB60aiN4xkh.9yDmEx1veOL34Btpu2Z8Lq3OHwt89iy', 'Colombia', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34'),
(42, 'Otniel', 'otnielparra@hotmail.com', '$2a$10$rW2bmKkN5GKn819knEGmqu3snrDBH2upQI0NizP.yzOHtKERrECGu', 'Ven', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34'),
(43, 'Jeane', 'jeane@gmail.com', '$2a$10$fdKZklDVTDqu9Lr2ViTxeenLFSremBPH7bvj4Kq1krX0xF6BtlFk2', 'Perú', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34'),
(51, 'Josefina', 'josefina@gmail.com', '$2a$10$QMOjDvhPD82G70B9Art2O.yKxR0dE6bOq0RwIcUorPcsFPXKyufs6', 'Argentina', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34'),
(56, 'prueba2', 'prueba2@gmail.com', '$2a$10$R7gcK/P9Kxdc8WGZFfY/SOdUcBFj1CVWnuMJD5pbN.4uMF8dGelJS', 'peru', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34'),
(57, 'prueba3@gmail.com', 'prueba3@gmail.com', '$2a$10$4H5LnCMJzOr8Bi.CkVLP1OhTBbHrWsPEEAuSBi0uCnZPRQ88IZ.n6', 'peru', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34'),
(58, 'Jeaneth Tafur Huaman', 'jeaneth@outlook.com', '$2a$10$/5nFwTlNjcM7ZUncX2GfTON9Cb0phECLqP5jwro1yVZ1Vmw.oxoYe', 'Perú', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34'),
(59, 'Jeaneth', 'Jeaneth@gmail.com', '$2a$10$73T0yRRva/u5SAvMsr7FCOztEQYKdzOULgL2iqLlWicOUutYMmUxa', 'Peru', NULL, NULL, 'Admin', 1, '2026-02-17 02:24:34'),
(60, 'Admin', 'admin@gmail.com', '$2a$10$T45MUXZP8XLehLp4d6zy7.q.FSZHx2onccPEt2x9gF7Pk9nanQuyO', 'Peru', NULL, NULL, 'usuario', 1, '2026-02-17 02:24:34');


INSERT INTO `matriculas` VALUES 
(1, 4, 2, '2026-02-17 02:24:34', 1),
(2, 4, 1, '2026-02-17 02:24:34', 1),
(3, 1, 2, '2026-02-17 02:24:34', 1),
(4, 3, 1, '2026-02-17 02:24:34', 1),
(5, 7, 3, '2026-02-17 02:24:34', 1),
(6, 3, 4, '2026-02-17 02:24:34', 0),
(7, 2, 5, '2026-02-17 02:24:34', 1),
(8, 1, 6, '2026-02-17 02:24:34', 1),
(9, 1, 9, '2026-02-17 02:24:34', 1),
(10, 8, 2, '2026-02-17 02:24:34', 1),
(11, 2, 9, '2026-02-17 02:24:34', 1),
(12, 2, 3, '2026-02-17 02:24:34', 1),
(13, 7, 2, '2026-02-17 02:24:34', 1),
(14, 8, 1, '2026-02-17 02:24:34', 1),
(15, 1, 1, '2026-02-17 02:24:34', 1),
(16, 1, 3, '2026-02-17 02:24:34', 1),
(17, 1, 5, '2026-02-17 02:24:34', 1),
(18, 6, 7, '2026-02-17 02:24:34', 1),
(19, 42, 2, '2026-02-17 02:24:34', 1),
(20, 43, 2, '2026-02-17 02:24:34', 0),
(21, 43, 5, '2026-02-17 02:24:34', 1),
(22, 5, 2, '2026-02-17 02:24:34', 1),
(23, 5, 6, '2026-02-17 02:24:34', 1),
(24, 5, 7, '2026-02-17 02:24:34', 1),
(25, 3, 2, '2026-02-17 02:24:34', 0),
(26, 3, 6, '2026-02-17 02:24:34', 1),
(27, 55, 1, '2026-02-17 02:24:34', 1),
(28, 55, 2, '2026-02-17 02:24:34', 1),
(29, 3, 5, '2026-02-17 02:24:34', 1),
(30, 3, 7, '2026-02-17 02:24:34', 1),
(31, 56, 6, '2026-02-17 02:24:34', 0),
(32, 57, 5, '2026-02-17 02:24:34', 1),
(33, 58, 6, '2026-02-17 02:24:34', 1),
(34, 58, 1, '2026-02-17 02:24:34', 1),
(35, 59, 5, '2026-02-17 02:24:34', 1),
(36, 43, 4, '2026-02-17 02:24:34', 1),
(37, 43, 3, '2026-02-17 02:24:34', 1),
(38, 60, 1, '2026-02-17 02:24:34', 1),
(39, 58, 4, '2026-02-17 02:24:34', 1);


INSERT INTO `reviews` VALUES 
(5, 2, 1, '¡Excelente curso! Me ha ayudado a comprender las novedades de ES6+ y cómo aplicarlas en proyectos reales. Las explicaciones sobre funciones flecha, promesas y módulos fueron claras y prácticas. Recomiendo este curso para cualquier persona que quiera dominar JavaScript y mejorar su programación web.', 5, '2026-02-17 02:24:34', 1),
(6, 2, 2, 'Un curso muy completo para quienes quieren entender JavaScript de verdad y no solo copiar código. Explica desde las bases hasta conceptos modernos de ES6+, usando ejemplos claros y aplicados a la web real.', 5, '2026-02-17 02:24:34', 1),
(7, 2, 3, 'Este curso es una muy buena puerta de entrada al JavaScript actual, el que realmente se usa en proyectos web hoy. Va directo a lo importante: ES6+, lógica de programación y trabajo con el navegador.Las clases son prácticas y fáciles de seguir, con ejemplos reales como manejo del DOM, eventos, funciones modernas y código más limpio y ordenado. Ayuda bastante a entender cómo funciona JavaScript “por dentro” y no solo a hacer que las cosas funcionen.', 5, '2026-02-17 02:24:34', 1),
(8, 1, 4, 'Un curso perfecto para empezar en el mundo del desarrollo web desde cero, sin necesidad de experiencia previa. Explica de forma clara cómo funciona HTML5 para la estructura y CSS3 para el diseño, con ejemplos prácticos desde la primera clase.', 4, '2026-02-17 02:24:34', 1),
(9, 3, 5, 'Un curso práctico y fácil de seguir para aprender diseño gráfico desde cero sin complicarse con programas difíciles. Enseña los principios básicos del diseño como colores, tipografías, composición y jerarquía visual, usando Canva como herramienta principal.', 4, '2026-02-17 02:24:34', 1),
(24, 2, 4, 'El curso ayuda a entender JavaScript moderno usando ES6+. Los ejemplos son claros y prácticos.', 4, '2026-02-17 02:24:34', 1),
(25, 1, 4, 'Muy buen curso para empezar desde cero. Explica HTML y CSS de forma clara y ordenada.', 4, '2026-02-17 02:24:34', 1),
(26, 2, 1, 'Contenido bien explicado que permite comprender JavaScript moderno y aplicarlo en la web.', 4, '2026-02-17 02:24:34', 1),
(27, 1, 3, 'Excelente curso para aprender HTML y CSS desde cero. Ideal para principiantes.', 5, '2026-02-17 02:24:34', 1),
(28, 3, 7, 'Curso práctico y sencillo. Canva se aprende rápido y los resultados son muy buenos.', 2, '2026-02-17 02:24:34', 1),
(29, 4, 3, 'Muy buena introducción al UX/UI. Explica conceptos clave como usabilidad y experiencia de usuario.', 4, '2026-02-17 02:24:34', 1),
(30, 5, 2, 'Curso completo para entender los fundamentos del marketing digital desde cero.', 2, '2026-02-17 02:24:34', 1),
(31, 6, 1, 'Muy útil para aprender a crear publicidad efectiva en redes sociales.', 3, '2026-02-17 02:24:34', 1),
(32, 2, 8, 'Curso bien estructurado para reforzar JavaScript moderno.', 3, '2026-02-17 02:24:34', 1),
(33, 3, 2, 'Canva explicado de forma clara y práctica. Ideal para diseño rápido.', 5, '2026-02-17 02:24:34', 1),
(34, 2, 7, 'Buen curso para entender JavaScript moderno y ES6+.', 2, '2026-02-17 02:24:34', 1),
(35, 1, 8, 'Muy recomendable para quienes empiezan en desarrollo web.', 4, '2026-02-17 02:24:34', 1),
(77, 5, 43, 'Buen curso :) =P', 4, '2026-02-17 02:24:34', 1),
(78, 5, 57, 'Muy recomendable para quienes empiezan', 5, '2026-02-17 02:24:34', 1),
(79, 1, 58, 'Muy recomendable para quienes empiezan', 4, '2026-02-17 02:24:34', 1),
(80, 5, 59, 'Muy recomendable para quienes empiezan', 3, '2026-02-17 02:24:34', 0),
(81, 5, 43, 'Muy recomendable para quienes empiezan', 4, '2026-02-17 02:24:34', 1),
(82, 2, 43, 'Muy recomendable para quienes empiezan', 5, '2026-02-17 02:24:34', 1),
(83, 2, 43, 'Muy recomendable para quienes empiezan', 5, '2026-02-17 02:24:34', 1);






