CREATE DATABASE bd_findeanio;
GO
USE bd_findeanio;
GO

CREATE TABLE generoPelicula(-- DROP TABLE generoPelicula
	id INT PRIMARY KEY IDENTITY(1,1),
	nomGenero VARCHAR(100)
);-- SELECT * FROM generoPelicula
GO

CREATE TABLE actor(-- DROP TABLE actor
	id INT PRIMARY KEY IDENTITY(1,1),
	nomActor VARCHAR(100),
);-- SELECT * FROM actor
GO

CREATE TABLE director(-- DROP TABLE director
	id INT PRIMARY KEY IDENTITY(1,1),
	nomDirector VARCHAR(100),
);-- SELECT * FROM director;
GO

CREATE TABLE idioma(-- DROP TABLE idioma
	id INT PRIMARY KEY IDENTITY(1,1),
	nomIdioma VARCHAR(100),
);-- SELECT * FROM idioma;
GO

CREATE TABLE pelicula(-- DROP TABLE pelicula
	id INT PRIMARY KEY IDENTITY(1,1),
	nomPelicula VARCHAR(100),
	fk_genero INT REFERENCES generoPelicula(id),
	fk_actor INT REFERENCES actor(id),
	fk_idioma INT REFERENCES idioma(id),
	fk_director INT REFERENCES director(id),
	anio INT,
	pais VARCHAR(30)
);-- SELECT * FROM pelicula;
go

SELECT * FROM generoPelicula
SELECT * FROM actor
SELECT * FROM director
SELECT * FROM idioma
SELECT * FROM pelicula

INSERT INTO generoPelicula VALUES('Accion');
INSERT INTO generoPelicula VALUES('Ficcion');
INSERT INTO generoPelicula VALUES('Comedia');--g
INSERT INTO generoPelicula VALUES('Cine');-- g

INSERT INTO actor VALUES('Actor 1');-- a
INSERT INTO actor VALUES('La Roca');
INSERT INTO actor VALUES('Brat pitt');

INSERT INTO director VALUES('carlos barct');
INSERT INTO director VALUES('Miguel boce');

INSERT INTO idioma VALUES('ingles');
INSERT INTO idioma VALUES('español');

INSERT INTO pelicula VALUES('Peli','4','3','1','1',2018,'Chle');-- nueva
INSERT INTO pelicula VALUES('Pelic 3','4','3','1','1',2018,'Chle');-- nueva
INSERT INTO pelicula VALUES('Pelicul 2','2','2','2','2',2018,'Chle');-- nueva
INSERT INTO pelicula VALUES('Rapidos y Furiosos','1','1','1','1',2017,'USA');
INSERT INTO pelicula VALUES('Troya','2','2','2','2',2004,'Roma');
INSERT INTO pelicula VALUES('Deathpool','2','2','2','2',2018,'EUROPA');
INSERT INTO pelicula VALUES('Death','2','2','2','2',2018,'EUROPA');
INSERT INTO pelicula VALUES('Dea','2','2','2','2',2018,'EUROPA');


/* CONSULTA 1 --> PELICULAS*/
GO
----------------------------------------------------------------------------------
---------------------------------CONSULTAS----------------------------------------
----------------------------------------------------------------------------------
GO
/*CONSULTA 1 -->MUESTRA TODOS LOS DATOS */
SELECT
	p.id,
	p.nomPelicula AS 'Nombre de Pelicula',
	g.nomGenero AS 'Genero',
	a.nomActor AS 'Actor',
	i.nomIdioma AS 'Idioma',
	d.nomDirector AS 'Director',
	p.anio AS 'Año',
	p.pais AS 'Pais'
FROM
	pelicula p
	INNER JOIN generoPelicula g
	ON p.fk_genero = g.id
	INNER JOIN actor a
	ON p.fk_actor = a.id
	INNER JOIN idioma i
	ON p.fk_idioma = i.id
	INNER JOIN director d
	ON p.fk_director = d.id;
GO

/* CONSULTA 2 --> GENERO Y SUS PELICULAS*/
SELECT
	generoPelicula.nomGenero AS 'Genero',
	pelicula.nomPelicula AS 'Pelicula'
FROM
	pelicula pelicula
	inner JOIN  generoPelicula
	ON generoPelicula.id = pelicula.fk_genero
	ORDER BY generoPelicula.nomGenero ASC;

-------------------------------------------
GO

/* CONSULTA 3 --> IDIOMA Y SU PELICULA*/
SELECT
	pelicula.nomPelicula AS 'Pelicula',
	idioma.nomIdioma AS 'Idioma'
FROM
	pelicula pelicula
	inner JOIN  idioma
	ON idioma.id = pelicula.fk_idioma
	ORDER BY idioma.nomIdioma ASC;
-------------------------------------------
GO

/* CONSULTA 4 --> PELICULA CON SU ACTOR Y DIRECTOR */
SELECT 
	pelicula.nomPelicula AS 'Pelicula',
	actor.nomActor AS 'Actor',
	director.nomDirector AS 'Director'
FROM
	pelicula,actor,director
WHERE
	actor.id = pelicula.fk_genero AND
	director.id=pelicula.fk_actor order by nomPelicula;
GO

/* CONSULTA 5 -->  pelicula y su actor*/
SELECT 
	p.nomPelicula AS 'Pelicula',
	actor.nomActor AS 'Actor'
FROM
	pelicula p
	INNER JOIN actor
	ON actor.id = p.fk_actor
	ORDER BY actor.nomActor ASC;

GO
----------------------------------------------------------------------------------
----------------------------------FUNCIONES---------------------------------------
----------------------------------------------------------------------------------
GO
CREATE FUNCTION fechade_creacion_aactual(@anio DATETIME,GETDATE())
RETURNS TABLE 
AS
RETURN
	
GO
----------------------------------------------------------------------------------
----------------------------------TRIGGERS----------------------------------------
----------------------------------------------------------------------------------
GO
/*tabla historial--> aqui donde se guarda la informacion de actividad de ingreso y de eliminacion de peliculas*/

CREATE TABLE historial(--DROP TABLE historial
	id INT PRIMARY KEY IDENTITY(1,1),
	fecha date,
	nomPelicula VARCHAR(100),
	descripcion VARCHAR(100)
);--SELECT*FROM historial
GO
----------------------------------------------------------------------------------
/*1.- trigger es para ver que peliculas se ingresaron */
CREATE TRIGGER insert_pelicula
ON pelicula FOR INSERT
AS SET NOCOUNT ON 
BEGIN
	DECLARE @nomPelicula VARCHAR(100)
	SELECT @nomPelicula=nomPelicula FROM inserted
	INSERT INTO historial VALUES(GETDATE(),@nomPelicula,'REGISTRO INSERTADO')
END--DROP TRiGGER insert_pelicula
----------------------------------------------------------------------------------
GO
/*2.- triger para elimminar peliculas ya ingresadas */
CREATE TRIGGER delete_pelicula
ON pelicula FOR delete
AS SET NOCOUNT ON 
BEGIN
	DECLARE @nomPelicula VARCHAR(100)
	SELECT @nomPelicula=nomPelicula FROM deleted
	INSERT INTO historial VALUES(GETDATE(),@nomPelicula ,'REGISTRO ELIMINADO')
END--DROP TRiGGER delete_pelicula

delete FROM pelicula WHERE nomPelicula = 'Deathpool'
