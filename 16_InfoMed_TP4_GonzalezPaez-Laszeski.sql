SELECT
    m.nombre AS "Nombre del Médico",
    p.nombre AS "Nombre del Paciente",    
    COUNT(c.id_consulta) AS "Número de Consultas"
FROM
    pacientes p
JOIN
    consultas c on p.id_paciente = c.id_paciente
JOIN
    medicos m on c.id_medico = m.id_medico
GROUP BY
    p.nombre, m.nombre
ORDER BY
    m.nombre, p.nombre;