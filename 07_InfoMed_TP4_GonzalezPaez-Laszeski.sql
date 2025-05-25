SELECT 
    c.nombre AS "Ciudad",
    COUNT(p.id_paciente) AS "Número de Pacientes"
FROM 
    Ciudades c
LEFT JOIN 
    Pacientes p ON c.id_ciudad = p.ciudad_id
GROUP BY 
    c.id_ciudad, c.nombre