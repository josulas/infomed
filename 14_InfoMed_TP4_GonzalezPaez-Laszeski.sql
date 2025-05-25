SELECT
    m.nombre AS "Nombre del Medicamento",
    COUNT(r.id_receta) AS "Cantidad de Recetas"
FROM
    medicamentos m
JOIN
    recetas r ON m.id_medicamento = r.id_medicamento
GROUP BY
    m.nombre
HAVING
    COUNT(r.id_receta) = (
        SELECT MAX(receta_count) 
        FROM (
            SELECT COUNT(id_receta) AS receta_count
            FROM recetas
            GROUP BY id_medicamento
        ) AS subquery
    )