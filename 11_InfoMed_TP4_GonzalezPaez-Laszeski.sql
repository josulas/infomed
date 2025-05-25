SELECT 
    p.nombre AS "Nombre del Paciente",
    c.fecha AS "Fecha",
    c.diagnostico AS "Diagnóstico"
FROM 
    Consultas c
JOIN 
    Pacientes p ON c.id_paciente = p.id_paciente
WHERE
    c.fecha BETWEEN '2024-08-01' AND '2024-08-31'