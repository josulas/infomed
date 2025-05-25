SELECT 
    m.nombre AS "Nombre del Médico",
    COUNT(r.id_receta) AS "Cantidad de Recetas"
FROM 
    Medicos m
LEFT JOIN 
    Recetas r ON m.id_medico = r.id_medico
GROUP BY 
    m.nombre