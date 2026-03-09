--------------------------------------------------------------
-- EJERCICIO 1: Consultas básicas y Composiciones
--------------------------------------------------------------

-- Consulta todas las películas de género 'Ciencia Ficción' y las ordena alfabéticamente por título
SELECT titulo, genero
FROM PELICULAS
WHERE genero = 'Ciencia Ficción'
ORDER BY titulo ASC;


-- Consulta que muestra el nombre del cine y el título de la película para todas las proyecciones realizadas
-- Utiliza JOIN interno para combinar las tablas PROYECCIONES, CINES y PELICULAS
SELECT c.nombre AS cine, p.titulo AS pelicula
FROM PROYECCIONES pr
JOIN CINES c ON pr.id_cine = c.id_cine
JOIN PELICULAS p ON pr.id_pelicula = p.id_pelicula;


-- Consulta que muestra todos los cines y el id de las películas proyectadas
-- Incluye los cines que todavía no han proyectado ninguna película usando LEFT JOIN
SELECT c.nombre AS cine, pr.id_pelicula
FROM CINES c
LEFT JOIN PROYECCIONES pr ON c.id_cine = pr.id_cine
ORDER BY c.nombre;


--------------------------------------------------------------
-- EJERCICIO 2: Consultas de Resumen y Agrupación
--------------------------------------------------------------

-- Consulta que calcula la recaudación total acumulada por cada cine
-- Muestra el nombre del cine y la suma de todas sus proyecciones
SELECT c.nombre AS cine, 
       SUM(pr.recaudacion) AS recaudacion_total
FROM CINES c
JOIN PROYECCIONES pr ON c.id_cine = pr.id_cine
GROUP BY c.nombre
ORDER BY c.nombre;


-- Consulta que muestra solo los cines cuya recaudación total supera los 5.000€
-- Se utiliza HAVING porque filtramos sobre un valor agregado (SUM)
SELECT c.nombre AS cine, SUM(pr.recaudacion) AS recaudacion_total
FROM CINES c
JOIN PROYECCIONES pr ON c.id_cine = pr.id_cine
GROUP BY c.nombre
HAVING SUM(pr.recaudacion) > 1000
ORDER BY c.nombre;


--------------------------------------------------------------
-- EJERCICIO 3: Subconsultas y Herramientas
--------------------------------------------------------------

-- Consulta que obtiene los títulos de las películas que tuvieron una recaudación en una sesión
-- superior a la recaudación media de todas las sesiones usando una subconsulta
SELECT DISTINCT p.titulo
FROM PELICULAS p
JOIN PROYECCIONES pr ON p.id_pelicula = pr.id_pelicula
WHERE pr.recaudacion > (
    -- Subconsulta que calcula la recaudación media de todas las sesiones
    SELECT AVG(recaudacion) 
    FROM PROYECCIONES
);


--------------------------------------------------------------
-- EJERCICIO 4: Optimización de Consultas
--------------------------------------------------------------

-- Crear un índice para acelerar búsquedas por fecha en la tabla PROYECCIONES
CREATE INDEX idx_proyecciones_fecha
ON PROYECCIONES(fecha);


-- Versión ineficiente: usa funciones sobre la columna y evita el uso de índices
SELECT DISTINCT p.titulo
FROM PELICULAS p
JOIN PROYECCIONES pr ON p.id_pelicula = pr.id_pelicula
WHERE EXTRACT(YEAR FROM pr.fecha) = 2023;


-- Versión eficiente: utiliza un rango de fechas que permite aprovechar el índice
SELECT DISTINCT p.titulo
FROM PELICULAS p
JOIN PROYECCIONES pr ON p.id_pelicula = pr.id_pelicula
WHERE pr.fecha >= TO_DATE('2023-01-01','YYYY-MM-DD')
  AND pr.fecha <  TO_DATE('2024-01-01','YYYY-MM-DD');






















