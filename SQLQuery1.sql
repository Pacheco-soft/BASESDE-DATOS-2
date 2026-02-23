

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

/Esto es un coment/