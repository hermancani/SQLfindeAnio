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
INSERT INTO actor VALUES('La Roca');
INSERT INTO actor VALUES('Brat pitt');
INSERT INTO director VALUES('carlos barct');
INSERT INTO director VALUES('Miguel boce');
INSERT INTO idioma VALUES('ingles');
INSERT INTO idioma VALUES('español');
INSERT INTO pelicula VALUES('Rapidos y Furiosos','1','1','1','1','1',2017,'USA');
INSERT INTO pelicula VALUES('Troya','2','2','2','2','2',2004,'Roma');

DROP DATABASE bd_findeanio