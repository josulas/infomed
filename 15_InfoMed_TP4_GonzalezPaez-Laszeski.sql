SELECT
    p.nombre AS "Nombre del Paciente",
    c.fecha AS "Fecha de la Última Consulta",
    c.diagnostico AS "Diagnóstico de la Última Consulta"
FROM
    pacientes p
JOIN
    consultas c ON p.id_paciente = c.id_paciente
WHERE
    c.fecha = (
        SELECT MAX(fecha)
        FROM consultas
        WHERE id_paciente = p.id_paciente
    )