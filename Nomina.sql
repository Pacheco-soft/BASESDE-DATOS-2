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