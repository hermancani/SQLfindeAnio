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
INSERT INTO pelicula VALUES('Pelicula','4','3','1','1','2018','Chle');-- nueva
INSERT INTO pelicula VALUES('Pelicula 3','4','3','1','1','2018','Chle');-- nueva
INSERT INTO pelicula VALUES('Pelicula 2','2','2','2','2','2018','Chle');-- nueva
INSERT INTO pelicula VALUES('Rapidos y Furiosos','1','1','1','1',2017,'USA');
INSERT INTO pelicula VALUES('Troya','2','2','2','2','2004','Roma');

-- DROP DATABASE bd_findeanio
GO

/* CONSULTA 1 --> PELICULAS*/

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

		/* CONSULTA 5 -->  pelicula y su actor*/

	SELECT 
		p.nomPelicula AS 'Pelicula',
		actor.nomActor AS 'Actor'
	FROM
		pelicula p
		INNER JOIN actor
		ON actor.id = p.fk_actor
		ORDER BY actor.nomActor ASC;
	
		

		
		/*SELECT pelicula.nomPelicula as 'pelicula', COUNT(pelicula.fk_genero) AS 'genero' FROM pelicula
		INNER JOIN generoPelicula ON generoPelicula.id = pelicula.fk_genero
		GROUP BY pelicula.nomPelicula*/
----------------------------------------------------------------------------------
-------------------------------PROCEDIMIENTOS-------------------------------------
----------------------------------------------------------------------------------
GO
CREATE PROCEDURE agregar_pelicula 
@nomPelicula VARCHAR(100),
@nomGenero VARCHAR(100),
@nomActor VARCHAR(100)
AS
	BEGIN
	DECLARE @existe_nomPelicula BIT
	DECLARE @existe_nomGenero BIT
	DECLARE @existe_nomActor BIT
	DECLARE @id_pelicula INT
	DECLARE @id_generoPelicula INT
	DECLARE @id_actor INT
	
	SET @existe_nomPelicula =(SELECT COUNT(*)FROM pelicula WHERE @nompelicula = @nomPelicula)
	IF @existe_nomPelicula=0
	BEGIN
	INSERT INTO pelicula VALUES(@nomPelicula)
			PRINT 'Pelicula Agregado!! :3'
		END
	ELSE
		BEGIN 
		PRINT 'Pelicula ya existe :C'
		UPDATE pelicula SET @nomPelicula = @nomPelicula
		WHERE @nomPelicula = @nomPelicula
	END
END



DROP DATABASE bd_findeanio