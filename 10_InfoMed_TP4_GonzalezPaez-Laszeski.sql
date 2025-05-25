SELECT 
    c.id_consulta as "ID de la Consulta",
    c.fecha AS "Fecha",
    c.id_medico AS "ID del Médico",
    m.nombre AS "Nombre del Médico",
    c.id_paciente AS "ID del Paciente",
    p.nombre AS "Nombre del Paciente",
    c.diagnostico AS "Diagnóstico",
    c.tratamiento AS "Tratamiento",
    c.snomed_codigo AS "Código SNOMED"
FROM 
    Consultas c
JOIN 
    Pacientes p ON c.id_paciente = p.id_paciente
JOIN 
    Medicos m ON c.id_medico = m.id_medico
WHERE 
    m.id_medico = 3
    AND c.fecha BETWEEN '2024-08-01' AND '2024-08-31'