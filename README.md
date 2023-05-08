# ETL

 
<p align="center">
  <img src="https://github.com/Anton-Utray/ETL/blob/main/IMAGES/pipa_agua.jpg" alt="pipa" width="800">
</p>
 
## Índice

1. [Descripción](#descripción)
2. [Extracción](#extracción)
3. [Transformación](#transformación)
4. [Carga](#carga)
5. [Consultas y analisis](#consultas)

## Descripción del proyecto ✍️

### Restricciones ⛔ 

En el marco del boocamp de Data Analytics de IronHack, para este proyecto tendremos que realizar una ETL: 

##### Extract 👨‍💻 Transform 🧞 Load 📲

Facilisimo ¿verdad? no tan rapido...para calentarnos un poco la cabeza, necesitamos cumplir unos minimos indispensables: 

- La información tiene que venir de 3 fuentes distintas(urls)
- Tenemos que usar al menos 2 métodos distintos de extracción de datos (csv, api,   rss, web scrapping, base de datos)

### Contexto 🧭

<p align="center">
 <img src="https://github.com/Anton-Utray/ETL/blob/main/IMAGES/CT_Logo_Esp.png" alt="pipa" width="300">
</p>

La Coalición Tricolor es una red de agentes de cambio en la Ciudad de México. Están preprando un proyecto de captura de agua para comunidades que carecen de este liquido. 

Si quieres saber mas sobre el proyecto, aqui tienes el link  👉  [^1]

Después de un arduo trabajo conceptualizando todos los detalles de este proyecto, como los metodos de captura, los filtros de agua, partners instaladores... se les escapó un detalle clave ¿donde en la CDMX hace mas falta un proyecto de este tipo? 

### Objetivo 🎯 

Nuestro objetivo es recopilar datos de 3 fuentes distintas que nos ayuden a entender mejor el panorama de acceso a agua potable para los habitantes de esta urbe de 9 millones de habitantes. 

Cada una de las fuentes nos ayudará a despejar las siguientes dudas: 

- ¿Como se divide el acceso a agua por alcadías? [^2]
- ¿Como se compara al indice de desarollo de cada sitio?
- ¿En partes de la ciudad ya se estan llevando a cabo proyectos de este tipo?

## Extración 🎣 

Empezamos surfeando la web a ver que encontramos y nos topamos con el ultimo censo de hogares y viviendas del Instituto Nacional de Estadística y Geografía (INEGI), el INE mexicano. [^3]

En el encontramos una base de datos que contiene datos de acceso a agua, dividido por entidad federativa y luego por alcaldías. 

<p align="center">¡Padrisimo! 🌟</p>

Seguimos indagando y llegamos al portal de datos abiertos del gobierno de la CDMX. Filtrando sus bases de datos con la palabra clave "agua" encontramos reocpilaciones de todos los proyectos de instalaciones de sistemas de captura de agua llevados a cabo en la CDMX, que además dispone de API. [^4]

<p align="center">¡A huevo! 🍳</p>

Solo nos faltaría encontrar la ultíma pieza del puzzle: los indices de desarrollo por alcaldía. La Secretaría de Inclusión y Bienestar Social nos proporciona este analisis, en formato descargable. [^5]

<p align="center">¡Con permiso! 💅 </p>

## Transformación  🧬 

El primer archivo que corresponde a los datos de acceso a agua por alcaldia tenia una estructura un poco confusa ya que tenia filas que correspondian al subtotal de otras filas de la misma columna, otras filas que eran subtotales de valores de otras columnas y así. 

Fuimos descartando todas las filas dentro de la tabla que hiciesen referencia a aggregaciones de valores de otras columnas. Para dejar el archivo lo mas simple posible y que no sesgue nuestro analisis. 

Terminamos por descartar las columnas que no nos aportan información de importancia, en este caso: disponibilidad de drenaje y numero de viviendas (optamos mejor por el conteo por personas)

El segundo archivo, proyectos de instalación de agua,  tenia muchos valores nulos o incompletos en las columnas 'Pueblo', 'Colonia' y 'Alcaldía'. Como el foco son las alcadías, fuimos rellenando los valores incompletos de esta columna con la información disponible de las demas. En casos apoyandonos de las coordenada para ubicar la localizacion del proyecto. 

El tercer archivo no requirió de limpieza. Unicamente lo subimos al notebook para aplicarle un enconding 'latin-1' y evitar problemas con la carga de SQL.

## Carga 📥 

Desde el inicio del proyecto, el elemento conecto de este proyecto han sido las distintas alcaldías de la CDMX. Toda la información que recopilamos sirve para pintar una imagen de cada sitio. Por lo tanto, cada una de las tablas se relacionaran a la tabla conectora de 'Alcaldias'. Aquí el diagrama: 

<p align="center">
  <img src="https://github.com/Anton-Utray/ETL/blob/main/IMAGES/Diagrama%20relacional%20SQL.JPG" alt="Diagrama" width="500">
</p>

## Consultas y Analisis 📊 

<details>
<summary>Disponibilidad de Agua, total CDMX</summary>
<br>

 Población total CDMX con disponibilidad de agua entubada vs no y el % de si vs total población.
 ```
SELECT 
    SUM(CASE WHEN disponibilidad = 'si' THEN poblacion ELSE 0 END) AS poblacion_si,
    SUM(CASE WHEN disponibilidad = 'no' THEN poblacion ELSE 0 END) AS poblacion_no,
    ROUND(SUM(CASE WHEN disponibilidad = 'si' THEN poblacion ELSE 0 END) / SUM(poblacion) * 100, 2) AS porcentaje_si
FROM censo_agua;
 ```

![query1](https://github.com/Anton-Utray/ETL/blob/main/IMAGES/query1.JPG)
		       
</details>

<details>
<summary>Disponibilidad de agua entubada distribuido por alcaldías </summary>
<br>

 Población total con disponibilidad de agua entubada vs no y el % de si vs total población, agrupado por alcaldía y ordenado por poblacion no.
 ```
SELECT alcaldia,
    SUM(CASE WHEN disponibilidad = 'si' THEN poblacion ELSE 0 END) AS poblacion_si,
    SUM(CASE WHEN disponibilidad = 'no' THEN poblacion ELSE 0 END) AS poblacion_no,
    ROUND(SUM(CASE WHEN disponibilidad = 'si' THEN poblacion ELSE 0 END) / SUM(poblacion) * 100, 2) AS porcentaje_si
FROM censo_agua
GROUP BY alcaldia
ORDER BY poblacion_no DESC;
 ```

![query2](https://github.com/Anton-Utray/ETL/blob/main/IMAGES/query2.JPG)
		       
</details>

<details>
<summary>Acceso a agua del servicio publico, total CDMX</summary>
<br>

 Población total CDMX con disponibilidad de agua del servicio publico de aguas vs no y el % población total si.
 ```
SELECT 
    SUM(CASE WHEN fuente = 'Del servicio público de agua' THEN poblacion ELSE 0 END) AS poblacion_si,
    SUM(CASE WHEN fuente != 'Del servicio público de agua' THEN poblacion ELSE 0 END) AS poblacion_no,
    ROUND(SUM(CASE WHEN fuente = 'Del servicio público de agua' THEN poblacion ELSE 0 END) / SUM(poblacion) * 100, 2) AS porcentaje_si
FROM censo_agua
ORDER BY poblacion_no DESC;
 ```

![query3](https://github.com/Anton-Utray/ETL/blob/main/IMAGES/query3.JPG)
		       
</details>

<details>
<summary>Acceso a agua del servicio publico, distribuido por alcaldías</summary>
<br>

 Población con disponibilidad de agua del servicio publico de aguas vs no y el % población total si, agrupado por alcaldías.
 ```
SELECT alcaldia,
    SUM(CASE WHEN fuente = 'Del servicio público de agua' THEN poblacion ELSE 0 END) AS poblacion_si,
    SUM(CASE WHEN fuente != 'Del servicio público de agua' THEN poblacion ELSE 0 END) AS poblacion_no,
    ROUND(SUM(CASE WHEN fuente = 'Del servicio público de agua' THEN poblacion ELSE 0 END) / SUM(poblacion) * 100, 2) AS porcentaje_si
FROM censo_agua
GROUP BY alcaldia
ORDER BY poblacion_no DESC;
 ```

![query4](https://github.com/Anton-Utray/ETL/blob/main/IMAGES/query4.JPG)

<details>
<summary>Top 5 alcaldías mas vulnerables con IDS </summary>
<br>

las 5 alcaldías que cuentan con el mayor numero de personas con acceso vulnerable (!= servicio publico | sin acceso a agua entubada). Comparando con su nivel de IDS.
 ```
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
 ```

![query5](https://github.com/Anton-Utray/ETL/blob/main/IMAGES/query5.JPG)

		       
</details>

<details>
<summary>PROYECTOS SCALL por alcaldía y con IDS  </summary>
<br>

 ```
SELECT i.alcaldia, 
COUNT(p.id) as count, IDS
FROM proyectos_captacion as p
LEFT JOIN IDS as i
ON i.alcaldia_id=p.alcaldia_id
GROUP BY alcaldia, IDS;
 ```

![query6](https://github.com/Anton-Utray/ETL/blob/main/IMAGES/query6.JPG)

		       
</details>

#### footnotes: 
[^1]: https://www.coalicion-tricolor.com/_files/ugd/441226_089487397102429a8db70da4a1a9c968.pdf
[^2]: ¿Alcadías? ¿Dentro de una ciudad? Suena raro pero si. Aunque se conoce como "Ciudad de México" en verdad es un estado federado con un gobernador a su cabeza, no un alcalde. Dentro de la Ciudad de México, este estado federado se divide en 16 alcadías.
[^3]: https://www.inegi.org.mx/programas/ccpv/2020/#Tabulados
[^4]: https://datos.cdmx.gob.mx/dataset/scall/resource/02b9121c-8e6e-4e26-b5aa-f73ceabedb6b
[^5]: https://www.evalua.cdmx.gob.mx/principales-atribuciones/medicion-del-indice-de-desarrollo-social-de-las-unidades-territoriales/medicion-del-indice-de-desarrollo-social-de-las-unidades-territoriales

