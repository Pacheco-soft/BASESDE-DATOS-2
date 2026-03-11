CREATE DATABASE CONSULTASDB;

USE CONSULTASDB;


CREATE TABLE Estudiantes (

id INT ,
nombre VARCHAR(100) NOT NULL,
edad INT ,
ciudad VARCHAR(50),
id_curso INT,

);

CREATE TABLE Cursos (
id INT,
nombre_curso VARCHAR (50),
duracion INT,

);

CREATE TABLE Matriculas (
id INT,
id_estudiante INT,
id_curso INT,
);


INSERT INTO Estudiantes (id, nombre, edad, ciudad, id_curso) VALUES
(1, 'Carlos Ramírez', 22, 'Bogotá', 1),
(2, 'María López', 25, 'Medellín', 2),
(3, 'Juan Pérez', 19, 'Cali', 3),
(4, 'Ana Torres', 21, 'Barranquilla', 1),
(5, 'Luis Herrera', 23, 'Cartagena', 4),
(6, 'Sofía Gómez', 20, 'Bogotá', 2),
(7, 'Diego Martínez', 27, 'Medellín', 5),
(8, 'Laura Sánchez', 22, 'Cali', 3),
(9, 'Andrés Morales', 24, 'Bucaramanga', 4),
(10, 'Valentina Ruiz', 18, 'Bogotá', 1),
(11, 'Felipe Castro', 26, 'Manizales', 5),
(12, 'Isabela Vargas', 21, 'Pereira', 2),
(13, 'Santiago Díaz', 23, 'Cali', 3),
(14, 'Camila Ortiz', 20, 'Medellín', 4),
(15, 'Mateo Rojas', 25, 'Bogotá', 5),
(16, 'Daniela Flores', 19, 'Barranquilla', 1),
(17, 'Sebastián Reyes', 22, 'Cartagena', 2),
(18, 'Gabriela Mendoza', 24, 'Bucaramanga', 3),
(19, 'Nicolás Guerrero', 21, 'Bogotá', 4),
(20, 'Paula Jiménez', 23, 'Medellín', 5);


INSERT INTO Cursos (id, nombre_curso, duracion) VALUES
(1, 'Desarrollo Web', 60),
(2, 'Base de Datos', 45),
(3, 'Calculo integral', 30),
(4, 'Algebra lineal', 90),
(5, 'Ingles', 75);


INSERT INTO Matriculas (id, id_estudiante, id_curso) VALUES
(1, 1, 4),
(2, 2, 2),
(3, 3, 3),
(4, 4, 1),
(5, 5, 4),
(6, 6, 2),
(7, 7, 5),
(8, 8, 3),
(9, 9, 4),
(10, 10, 1),
(11, 11, 5),
(12, 12, 2),
(13, 13, 3),
(14, 14, 4),
(15, 15, 5),
(16, 16, 1),
(17, 17, 2),
(18, 18, 3),
(19, 19, 4),
(20, 20, 5);



SELECT nombre,edad 
FROM Estudiantes;

SELECT *
FROM Estudiantes
WHERE edad > 18;

SELECT * 
FROM Estudiantes
ORDER BY nombre ASC;


INSERT INTO Estudiantes (id, nombre, edad, ciudad, id_curso) VALUES
(21, 'Carlos Diaz', 20,'Medellin', 3)

UPDATE Estudiantes
SET edad=25
WHERE id=5;

DELETE Estudiantes
WHERE id=10;

SELECT Estudiantes.nombre, Cursos.nombre_curso
FROM Estudiantes
INNER JOIN Cursos ON Estudiantes.id_curso = Cursos.id;


SELECT COUNT(*) FROM Estudiantes;

SELECT id_curso, COUNT(*) 
FROM Estudiantes
GROUP BY id_curso;

SELECT id_curso, COUNT(*) AS TOTAL
FROM Matriculas
GROUP BY id_curso
HAVING COUNT(*) > 10;