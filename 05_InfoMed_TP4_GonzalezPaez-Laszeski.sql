-- Creo y cargo la tabla Ciudades
CREATE TABLE IF NOT EXISTS Ciudades (
    id_ciudad SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL
);
INSERT INTO Ciudades (nombre)
VALUES ('Buenos Aires'), ('Córdoba'), ('Rosario'), ('Mendoza'), ('La Plata'), ('Santa Fe');

-- Primero cambiamos todas las letras a minúsculas
UPDATE Pacientes
SET ciudad = LOWER(ciudad);

-- Sacamos acentos y caracteres especiales
CREATE EXTENSION IF NOT EXISTS unaccent;
UPDATE Pacientes
SET ciudad = unaccent(ciudad);

-- Luego, eliminamos todos los caracteres que no sean letras
UPDATE Pacientes
SET ciudad = REGEXP_REPLACE(ciudad, '[^a-zA-Z]', '', 'g');

-- Añado la columna ciudad_id a la tabla Pacientes
ALTER TABLE Pacientes ADD COLUMN IF NOT EXISTS ciudad_id INT;
ALTER TABLE Pacientes
ADD CONSTRAINT fk_ciudad
FOREIGN KEY (ciudad_id) REFERENCES Ciudades(id_ciudad);

-- Añadir el ID de la ciudad correspondiente
UPDATE Pacientes
SET ciudad_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = 'Buenos Aires')
WHERE 
    ciudad LIKE '%b%' 
    AND ciudad LIKE '%s%' 
    AND ciudad LIKE '%a%';

UPDATE Pacientes
SET ciudad_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = 'Córdoba')
WHERE 
    ciudad LIKE '%c%' 
    AND ciudad LIKE '%b%' 
    AND ciudad LIKE '%a%';

UPDATE Pacientes
SET ciudad_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = 'Rosario')
WHERE 
    ciudad LIKE '%ros%';

UPDATE Pacientes
SET ciudad_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = 'Mendoza')
WHERE 
    ciudad LIKE '%m%' 
    AND ciudad LIKE '%z%';

UPDATE Pacientes
SET ciudad_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = 'La Plata')
WHERE 
    ciudad LIKE '%l%' 
    AND ciudad LIKE '%p%';

UPDATE Pacientes
SET ciudad_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = 'Santa Fe')
WHERE 
    ciudad LIKE '%s%' 
    AND ciudad LIKE '%f%';

-- Contamos cuantas filas han quedado sin ciudad_id
SELECT COUNT(*) FROM Pacientes WHERE ciudad_id IS NULL;

-- Ahora seguimos solo si la anterior consulta devuelve 0 filas

-- Eliminar el viejo índice creado en la consigna 01
DROP INDEX IF EXISTS idx_pacientes_ciudad;

-- Eliminamos la vista que se creó en la consigna 02
DROP VIEW IF EXISTS Vista_pacientess_Edad;
-- Crear la vista actualizada con la nueva columna ciudad_id
CREATE OR REPLACE VIEW Vista_pacientess_Edad AS
SELECT 
    p.id_paciente AS "ID Paciente",
    p.nombre AS "Nombre Completo",
    p.fecha_nacimiento AS "Fecha de Nacimiento",
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento)) AS "Edad",
    s.descripcion AS "Sexo",
    p.calle || ' ' || p.numero || ', ' || c.nombre AS "Dirección"
FROM
    Pacientes p
JOIN
    SexoBiologico s ON p.id_sexo = s.id_sexo
JOIN
    Ciudades c ON p.ciudad_id = c.id_ciudad;

-- Eliminar la columna ciudad de la tabla Pacientes
ALTER TABLE Pacientes DROP COLUMN IF EXISTS ciudad;

-- Crear el nuevo índice en la columna ciudad_id
CREATE INDEX IF NOT EXISTS idx_pacientes_ciudad_id ON Pacientes(ciudad_id);