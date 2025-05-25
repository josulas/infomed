SELECT 
    c.nombre AS "Ciudad",
    SUM(CASE WHEN s.descripcion = 'Masculino' THEN 1 ELSE 0 END) AS "Hombres",
    SUM(CASE WHEN s.descripcion = 'Femenino' THEN 1 ELSE 0 END) AS "Mujeres"
FROM 
    Ciudades c
LEFT JOIN 
    Pacientes p ON c.id_ciudad = p.ciudad_id
LEFT JOIN
    sexobiologico s ON p.id_sexo = s.id_sexo
GROUP BY 
    c.id_ciudad, c.nombre