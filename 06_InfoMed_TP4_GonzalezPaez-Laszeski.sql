-- Obtener el nombre y la dirección de los pacientes que viven en Buenos Aires
SELECT 
    p.nombre AS "Nombre Completo",
    p.calle || ' ' || p.numero AS "Dirección"
FROM 
    Pacientes p
JOIN 
    Ciudades c ON p.ciudad_id = c.id_ciudad
WHERE 
    c.nombre = 'Buenos Aires'