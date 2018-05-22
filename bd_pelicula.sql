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

CREATE VIEW getPelicula AS
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

	SELECT * FROM getPelicula;