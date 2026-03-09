# Lenguaje SQL y Consulta de Datos DML

Para esta práctcica vamos a usar el sistema "CineGuest2.0"

---

## Creación de Tablas

### 1.1 - Tabla CINES
```mysql
CREATE TABLE CINES (
    id_cine NUMBER PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    ciudad VARCHAR2(50) NOT NULL
);
```

### 1.2 - Tabla PELICULAS
```mysql
CREATE TABLE PELICULAS (
    id_pelicula NUMBER PRIMARY KEY,
    titulo VARCHAR2(100) NOT NULL,
    director VARCHAR2(50),
    genero VARCHAR2(50)
);
```

### 1.3 - Tabla PROYECCIONES
```mysql
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
```

---

## Ejercicio 1: Consultas Básicas y Composiciones

### 1. Películas de 'Ciencia Ficción' ordenadas por título
```mysql
SELECT titulo, genero
FROM PELICULAS
WHERE genero = 'Ciencia Ficcion'
ORDER BY titulo ASC;
```

### 2. Nombre del cine y título de la película (INNER JOIN)
```mysql
SELECT c.nombre AS cine, p.titulo AS pelicula
FROM PROYECCIONES pr
JOIN CINES c ON pr.id_cine = c.id_cine
JOIN PELICULAS p ON pr.id_pelicula = p.id_pelicula;
```

### 3. Cines sin proyecciones (LEFT JOIN)
```mysql
SELECT c.nombre AS cine, pr.id_pelicula
FROM CINES c
LEFT JOIN PROYECCIONES pr ON c.id_cine = pr.id_cine
ORDER BY c.nombre;
```

---

## Ejercicio 2: Resumen y Agrupación

### 1. Recaudación total por cine
```mysql
SELECT c.nombre AS cine,
       SUM(pr.recaudacion) AS recaudacion_total
FROM CINES c
JOIN PROYECCIONES pr ON c.id_cine = pr.id_cine
GROUP BY c.nombre
ORDER BY c.nombre;
```

### 2. Cines con recaudación > 5.000€ — se usa `HAVING` porque filtra sobre un valor agregado (`SUM`), no sobre filas individuales
```mysql
SELECT c.nombre AS cine, SUM(pr.recaudacion) AS recaudacion_total
FROM CINES c
JOIN PROYECCIONES pr ON c.id_cine = pr.id_cine
GROUP BY c.nombre
HAVING SUM(pr.recaudacion) > 5000
ORDER BY c.nombre;
```

---

## Ejercicio 3: Subconsultas y Herramientas

### 1. Películas con recaudación superior a la media
```mysql
SELECT DISTINCT p.titulo
FROM PELICULAS p
JOIN PROYECCIONES pr ON p.id_pelicula = pr.id_pelicula
WHERE pr.recaudacion > (
    SELECT AVG(recaudacion)
    FROM PROYECCIONES
);
```

### 2. MySQL Workbench vs CLI
Ambas herramientas ejecutan el mismo comando DML (`SELECT`). Los resultados son idénticos, solo cambia la presentación visual.

---

## Ejercicio 4: Optimización de Consultas

### 1. Índice sobre la columna `fecha`
```mysql
CREATE INDEX idx_proyecciones_fecha
ON PROYECCIONES(fecha);
```
El índice crea un árbol B sobre `fecha`, evitando el recorrido completo de la tabla en cada búsqueda.

### 2. Versión ineficiente vs eficiente — películas de 2023

```mysql
-- Ineficiente: EXTRACT rompe el índice
SELECT DISTINCT p.titulo
FROM PELICULAS p
JOIN PROYECCIONES pr ON p.id_pelicula = pr.id_pelicula
WHERE EXTRACT(YEAR FROM pr.fecha) = 2023;
```

```mysql
-- Eficiente: rango de fechas aprovecha el índice
SELECT DISTINCT p.titulo
FROM PELICULAS p
JOIN PROYECCIONES pr ON p.id_pelicula = pr.id_pelicula
WHERE pr.fecha >= TO_DATE('2023-01-01', 'YYYY-MM-DD')
  AND pr.fecha <  TO_DATE('2024-01-01', 'YYYY-MM-DD');
```
