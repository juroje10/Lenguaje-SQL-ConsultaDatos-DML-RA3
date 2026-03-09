-- Tabla CINES
CREATE TABLE CINES (
    id_cine NUMBER PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    ciudad VARCHAR2(50) NOT NULL
);

-- Tabla PELICULAS
CREATE TABLE PELICULAS (
    id_pelicula NUMBER PRIMARY KEY,
    titulo VARCHAR2(100) NOT NULL,
    director VARCHAR2(50),
    genero VARCHAR2(50)
);

-- Tabla PROYECCIONES
CREATE TABLE PROYECCIONES (
    id_proyeccion NUMBER PRIMARY KEY,
    id_cine NUMBER,
    id_pelicula NUMBER,
    fecha DATE,
    hora VARCHAR2(5),
    recaudacion NUMBER(10,2),
    CONSTRAINT fk_cine FOREIGN KEY (id_cine) REFERENCES CINES(id_cine),
    CONSTRAINT fk_pelicula FOREIGN KEY (id_pelicula) REFERENCES PELICULAS(id_pelicula)
);


-- Inserciones en CINES
INSERT INTO CINES VALUES (1, 'Cinepolis Centro', 'Madrid');
INSERT INTO CINES VALUES (2, 'Multicines Luna', 'Barcelona');
INSERT INTO CINES VALUES (3, 'Cine Estrella', 'Valencia');
INSERT INTO CINES VALUES (4, 'Cinemagic', 'Sevilla');
INSERT INTO CINES VALUES (5, 'Cine Sol', 'Bilbao');

-- Inserciones en PELICULAS
INSERT INTO PELICULAS VALUES (1, 'Interstellar', 'Christopher Nolan', 'Ciencia Ficción');
INSERT INTO PELICULAS VALUES (2, 'Avatar', 'James Cameron', 'Ciencia Ficción');
INSERT INTO PELICULAS VALUES (3, 'Titanic', 'James Cameron', 'Romance');
INSERT INTO PELICULAS VALUES (4, 'Inception', 'Christopher Nolan', 'Ciencia Ficción');
INSERT INTO PELICULAS VALUES (5, 'La La Land', 'Damien Chazelle', 'Musical');

-- Inserciones en PROYECCIONES
INSERT INTO PROYECCIONES VALUES (1, 1, 1, TO_DATE('2026-03-01','YYYY-MM-DD'), '18:00', 1200.50);
INSERT INTO PROYECCIONES VALUES (2, 1, 2, TO_DATE('2026-03-01','YYYY-MM-DD'), '21:00', 1500.00);
INSERT INTO PROYECCIONES VALUES (3, 2, 3, TO_DATE('2026-03-02','YYYY-MM-DD'), '19:00', 900.00);
INSERT INTO PROYECCIONES VALUES (4, 2, 4, TO_DATE('2026-03-02','YYYY-MM-DD'), '22:00', 1100.00);
INSERT INTO PROYECCIONES VALUES (5, 3, 5, TO_DATE('2026-03-03','YYYY-MM-DD'), '20:00', 800.00);













