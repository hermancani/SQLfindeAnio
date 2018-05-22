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
