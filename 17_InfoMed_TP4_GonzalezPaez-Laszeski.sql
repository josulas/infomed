SELECT
    med.nombre AS "Nombre del Medicamento",
    COUNT(r.id_receta) AS "Total de Recetas",
    m.nombre AS "Nombre del Médico",
    p.nombre AS "Nombre del Paciente"
FROM
    medicamentos med
JOIN
    recetas r ON med.id_medicamento = r.id_medicamento
JOIN
    medicos m ON r.id_medico = m.id_medico
JOIN
    pacientes p ON r.id_paciente = p.id_paciente
GROUP BY
    med.nombre, m.nombre, p.nombre
ORDER BY
    COUNT(r.id_receta) DESC