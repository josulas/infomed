SELECT
    p.nombre AS "Nombre del Paciente",
    COUNT(r.id_receta) AS "Cantidad de Recetas"
FROM
    pacientes p
JOIN
    recetas r ON p.id_paciente = r.id_paciente
GROUP BY
    p.nombre