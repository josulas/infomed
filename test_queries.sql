-- Para el punto 1: seleccionamos todos los pacientes, agrupando por ciudad y contando el número de pacientes por ciudad. 
-- Veremos cómo al añadir un índice, la consulta se ejecuta más rápido.
SELECT ciudad, COUNT(*) AS num_pacientes
FROM pacientes
GROUP BY ciudad
