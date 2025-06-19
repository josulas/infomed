SELECT
    m.nombre AS "Nombre del Médico",
    COUNT(p.id_paciente) AS "Número de Pacientes"
FROM
    medicos m
JOIN
    consultas c ON m.id_medico = c.id_medico
JOIN
    pacientes p ON c.id_paciente = p.id_paciente
GROUP BY
    m.nombre
ORDER BY
    "Número de Pacientes" DESC