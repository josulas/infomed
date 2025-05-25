DROP VIEW IF EXISTS Vista_pacientess_Edad;
CREATE OR REPLACE VIEW Vista_pacientess_Edad AS
SELECT 
    p.id_paciente AS "ID Paciente",
    p.nombre AS "Nombre Completo",
    p.fecha_nacimiento AS "Fecha de Nacimiento",
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento)) AS "Edad",
    s.descripcion AS "Sexo",
    p.calle || ' ' || p.numero || ', ' || p.ciudad AS "Dirección"
FROM 
    pacientes p
JOIN 
    SexoBiologico s ON p.id_sexo = s.id_sexo;