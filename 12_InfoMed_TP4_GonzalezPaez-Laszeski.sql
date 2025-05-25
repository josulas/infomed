SELECT
    mto.nombre AS "Nombre del Medicamento"
FROM
    Medicamentos mto
JOIN
    recetas r ON mto.id_medicamento = r.id_medicamento
JOIN
    medicos m ON r.id_medico = m.id_medico
WHERE
    m.id_medico = 2
GROUP BY
    mto.nombre
HAVING
    COUNT(*) > 1