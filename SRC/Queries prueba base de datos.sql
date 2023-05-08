USE agua_cdmx;

-- 1. población total CDMX con disponibilidad de agua entubada vs no y el % de si vs total población

SELECT 
    SUM(CASE WHEN disponibilidad = 'si' THEN poblacion ELSE 0 END) AS poblacion_si,
    SUM(CASE WHEN disponibilidad = 'no' THEN poblacion ELSE 0 END) AS poblacion_no,
    ROUND(SUM(CASE WHEN disponibilidad = 'si' THEN poblacion ELSE 0 END) / SUM(poblacion) * 100, 2) AS porcentaje_si
FROM censo_agua;

-- 2. población total con disponibilidad de agua entubada vs no y el % de si vs total población, agrupado por alcaldía y ordenado por poblacion no

SELECT alcaldia,
    SUM(CASE WHEN disponibilidad = 'si' THEN poblacion ELSE 0 END) AS poblacion_si,
    SUM(CASE WHEN disponibilidad = 'no' THEN poblacion ELSE 0 END) AS poblacion_no,
    ROUND(SUM(CASE WHEN disponibilidad = 'si' THEN poblacion ELSE 0 END) / SUM(poblacion) * 100, 2) AS porcentaje_si
FROM censo_agua
GROUP BY alcaldia
ORDER BY poblacion_no DESC;

-- 3. Población total CDMX con disponibilidad de agua del servicio publico de aguas vs no y el % población total si

SELECT 
    SUM(CASE WHEN fuente = 'Del servicio público de agua' THEN poblacion ELSE 0 END) AS poblacion_si,
    SUM(CASE WHEN fuente != 'Del servicio público de agua' THEN poblacion ELSE 0 END) AS poblacion_no,
    ROUND(SUM(CASE WHEN fuente = 'Del servicio público de agua' THEN poblacion ELSE 0 END) / SUM(poblacion) * 100, 2) AS porcentaje_si
FROM censo_agua
ORDER BY poblacion_no DESC;

-- 4. Same as arriba pero por alcaldía

SELECT alcaldia,
    SUM(CASE WHEN fuente = 'Del servicio público de agua' THEN poblacion ELSE 0 END) AS poblacion_si,
    SUM(CASE WHEN fuente != 'Del servicio público de agua' THEN poblacion ELSE 0 END) AS poblacion_no,
    ROUND(SUM(CASE WHEN fuente = 'Del servicio público de agua' THEN poblacion ELSE 0 END) / SUM(poblacion) * 100, 2) AS porcentaje_si
FROM censo_agua
GROUP BY alcaldia
ORDER BY poblacion_no DESC;

-- 5. Alcaldías con mayor numero de población con acceso vulnerable y con IDS
SELECT c.alcaldia,
    SUM(CASE WHEN fuente = 'Del servicio público de agua' THEN poblacion ELSE 0 END) AS poblacion_si,
    SUM(CASE WHEN fuente != 'Del servicio público de agua' THEN poblacion ELSE 0 END) AS poblacion_no,
    ROUND(SUM(CASE WHEN fuente = 'Del servicio público de agua' THEN poblacion ELSE 0 END) / SUM(poblacion) * 100, 2) AS porcentaje_si,
    IDS
FROM censo_agua as c
JOIN alcaldias as a 
ON c.alcaldia_id = a.alcaldia_id
JOIN IDS i ON i.alcaldia_id = a.alcaldia_id
GROUP BY alcaldia, IDS
ORDER BY poblacion_no DESC
LIMIT 5;

-- 6 PROYECTOS SCALL por alcaldía y con IDS 

SELECT i.alcaldia, 
COUNT(p.id) as count, IDS
FROM proyectos_captacion as p
LEFT JOIN IDS as i
ON i.alcaldia_id=p.alcaldia_id
GROUP BY alcaldia, IDS;