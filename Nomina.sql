CREATE DATABASE NominaDB;
GO

USE NominaDB;
GO



CREATE TABLE Departamento (
    IdDepartamento INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);
GO



CREATE TABLE Cargo (
    IdCargo INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    SalarioBase DECIMAL(10,2) NOT NULL,
    IdDepartamento INT NOT NULL,
    FOREIGN KEY (IdDepartamento) 
        REFERENCES Departamento(IdDepartamento)
);
GO



CREATE TABLE TipoContrato (
    IdTipoContrato INT IDENTITY(1,1) PRIMARY KEY,
    Descripcion VARCHAR(50) NOT NULL
);
GO


CREATE TABLE Empleado (
    IdEmpleado INT IDENTITY(1,1) PRIMARY KEY,
    Documento VARCHAR(20) UNIQUE NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    FechaIngreso DATE NOT NULL,
    IdCargo INT NOT NULL,
    IdTipoContrato INT NOT NULL,
    FOREIGN KEY (IdCargo) 
        REFERENCES Cargo(IdCargo),
    FOREIGN KEY (IdTipoContrato) 
        REFERENCES TipoContrato(IdTipoContrato)
);
GO


CREATE TABLE Nomina (
    IdNomina INT IDENTITY(1,1) PRIMARY KEY,
    IdEmpleado INT NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    TotalDevengado DECIMAL(10,2),
    TotalDeducciones DECIMAL(10,2),
    NetoPagar DECIMAL(10,2),
    FOREIGN KEY (IdEmpleado) 
        REFERENCES Empleado(IdEmpleado)
);
GO


CREATE TABLE DetalleNomina (
    IdDetalle INT IDENTITY(1,1) PRIMARY KEY,
    IdNomina INT NOT NULL,
    Concepto VARCHAR(100) NOT NULL,
    Tipo VARCHAR(20) CHECK (Tipo IN ('DEVENGADO', 'DEDUCCION')),
    Valor DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (IdNomina) 
        REFERENCES Nomina(IdNomina)
);
GO


INSERT INTO Departamento (Nombre)
  Values 
  ('Sistemas'),
  ('Contabilidad'),
  ('Recursos Humanos'),
  ('Ventas');


  INSERT INTO Cargo (Nombre,SalarioBase,IdDepartamento)
  VALUES 
  ('Desarrollador', 3500000,1),
  ('Analista Contable', 2800000,2),
  ('Auxiliar RRHH',2200000,3),
  ('Ejecutivo Comercial',3000000,4);

  INSERT INTO TipoContrato (Descripcion)
  VALUES
  ('Termino Fijo'),
  ('Termino Indefinido'),
  ('Prestacion de Servicios');


  INSERT INTO Empleado (Documento,Nombre,Apellido,FechaIngreso,IdCargo,idTipoContrato) VALUES
  ('1010', 'Juan','Perez', '2024-01-10',1,2),
  ('2020', 'Maria','Gomez','2023-05-15',2,1),
  ('3030', 'Carlos','Lopez','2022-08-01',4,2);

  INSERT INTO Nomina (IdEmpleado, FechaInicio, FechaFin)
  VALUES
  (1, '2026-05-01','2026-05-31'),
  (2, '2026-05-01','2026-05-31'),
  (3, '2026-05-01', '2026-05-31');

  INSERT INTO DetalleNomina (IdNomina,Concepto,Tipo,Valor) VALUES
  (1,'Salario Basico','DEVENGADO',3500000),
  (1,'Salud','DEDUCCION',140000),
  (1,'Pension', 'DEDUCCION',140000),

  (2, 'Salario Basico','DEVENGADO', 2800000),
  (2, 'Salud', 'DEDUCCION', 112000),
  (2, 'Pension' , 'DEDUCCION', 112000),

  (3, 'Salario Basico','DEVENGADO', 3000000),
  (3, 'Comision', 'DEVENGADO', 500000),
  (3, 'Salud', 'DEDUCCION', 140000);



-- Ver todos los empleados
SELECT * FROM Empleado;
GO

-- Empleados con contrato indefinido (IdTipoContrato = 2)
SELECT *
FROM Empleado
WHERE IdTipoContrato = 2;
GO

-- Cargos con salario mayor a 3 millones
SELECT *
FROM Cargo
WHERE SalarioBase > 3000000;
GO

-- Empleados con nombre de cargo y departamento
SELECT 
    E.Nombre,
    E.Apellido,
    C.Nombre AS Cargo,
    D.Nombre AS Departamento
FROM Empleado E
JOIN Cargo C ON E.IdCargo = C.IdCargo
JOIN Departamento D ON C.IdDepartamento = D.IdDepartamento;
GO


-- Total devengado por empleado
SELECT 
    E.Nombre,
    SUM(DN.Valor) AS TotalDevengado
FROM Empleado E
JOIN Nomina N ON E.IdEmpleado = N.IdEmpleado
JOIN DetalleNomina DN ON N.IdNomina = DN.IdNomina
WHERE DN.Tipo = 'DEVENGADO'
GROUP BY E.Nombre;
GO


SELECT 
    E.Nombre,
    SUM(DN.Valor) AS TotalDeducciones
FROM Empleado E
JOIN Nomina N ON E.IdEmpleado = N.IdEmpleado
JOIN DetalleNomina DN ON N.IdNomina = DN.IdNomina
WHERE DN.Tipo = 'DEDUCCION'
GROUP BY E.Nombre;