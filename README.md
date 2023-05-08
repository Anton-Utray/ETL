# ETL
 PASALO POR UN SPELL CHECKER CHICO TRILINGUE
 
<p align="center">
  <img src="https://github.com/Anton-Utray/ETL/blob/main/IMAGES/pipa_agua.jpg" alt="pipa" width="800">
</p>
 
## Índice

1. [Descripción](#descripción)
2. [Contexto](#contexto)
3. [Extracción](#extracción)
4. [Transformación](#transformación)
5. [Carga](#carga)
6. [Consultas y analisis](#consultas)
7. [Bibliographía](#bibliographia)

## Descripción del proyecto

![Ironhack logo](https://i.imgur.com/1QgrNNw.png) 

En el marco del boocamp de Data Analytics de IronHack, para este proyecto tendremos que realizar una ETL: 

##### Extract 👨‍💻 
##### Transform 🧞
##### Load 📲 

Facilisimo ¿verdad? no tan rapido...para calentarnos un poco la cabeza, necesitamos cumplir unos minimos indispensables: 

     - La información tiene que venir de 3 fuentes distintas(urls)
     - Tenemos que usar al menos 2 métodos distintos de extracción de datos (csv, api,   rss, web scrapping, base de datos)

## Contexto y Objetivo

**Contexto**

<p align="center">
 <img src="https://github.com/Anton-Utray/ETL/blob/main/IMAGES/CT_Logo_Esp.png" alt="pipa" width="300">
</p>

La Coalición Tricolor es una red de agentes de cambio en la Ciudad de México. Están preprando un proyecto de captura de agua para comunidades que carecen de este liquido. 

Si quieres saber mas sobre el proyecto, tienes el link en la bibliographía 👇 

Después de un arduo trabajo conceptualizando todos los detalles de este proyecto, como los metodos de captura, los filtros de agua, partners instaladores... se les escapó un detalle clave ¿donde en la CDMX hace mas falta un proyecto de este tipo? 

**Objetivo**

Nuestro objetivo es recopilar datos de 3 fuentes distintas que nos ayuden a entender mejor el panorama de acceso a agua potable para los habitantes de esta urbe de 9 millones de habitantes. 

Cada una de las fuentes nos ayudará a despejar las siguientes dudas: 

¿Como se divide el acceso a agua por alcadías? [^1]
¿Como se compara al indice de desarollo de cada sitio?
¿En partes de la ciudad ya se estan llevando a cabo proyectos de este tipo?

## Extración

**Tirandonos al vacío**

Empezamos surfeando la web a ver que encontramos y nos topamos con el ultimo censo de hogares y viviendas del Instituto Nacional de Estadística y Geografía (INEGI), el INE mexicano. 

En el encontramos una base de datos que contiene datos de acceso a agua, dividido por entidad federativa y luego por alcaldías. 

¡Padrisimo! 🌟 

Seguimos indagando y llegamos al portal de datos abiertos del gobierno de la CDMX. Filtrando sus bases de datos con la palabra clave "agua" encontramos reocpilaciones de todos los proyectos de instalaciones de sistemas de captura de agua llevados a cabo en la CDMX, que además dispone de API. 

¡A huevo! 🍳

Solo nos faltaría encontrar la ultíma pieza del puzzle: los indices de desarrollo por alcaldía. La Secretaría de Inclusión y Bienestar Social nos proporciona este analisis, en formato descargable. 

¡con permiso! 💅 

## Transformación

## Carga

<p align="center">
  <img src="https://github.com/Anton-Utray/ETL/blob/main/IMAGES/Diagrama%20relacional%20SQL.JPG" alt="Diagrama" width="500">
</p>


## Consultas y Analisis 

## Bibliographía

https://www.coalicion-tricolor.com/_files/ugd/441226_089487397102429a8db70da4a1a9c968.pdf
https://www.inegi.org.mx/programas/ccpv/2020/#Tabulados
https://datos.cdmx.gob.mx/dataset/scall/resource/02b9121c-8e6e-4e26-b5aa-f73ceabedb6b
https://www.evalua.cdmx.gob.mx/principales-atribuciones/medicion-del-indice-de-desarrollo-social-de-las-unidades-territoriales/medicion-del-indice-de-desarrollo-social-de-las-unidades-territoriales


footnotes: 
[^1]: ¿Alcadías? ¿Dentro de una ciudad? Suena raro pero si. Aunque se conoce como "Ciudad de México" en verdad es un estado federado con un gobernador a su cabeza, no un alcalde. Dentro de la Ciudad de México, este estado federado se divide en 16 alcadías.
