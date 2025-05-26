# Trabajo Práctico N°4: Bases de Datos, _Structured Query Language_ y Manejo de Versiones

## Índice

[**Parte I - Bases de Datos**](#parte-i---bases-de-datos)

[Objetivo](#objetivo)

[Desarrollo](#desarrollo)

[Actividad](#actividad)

[Consignas](#consignas)

[Referencias](#referencias)

[**Parte II - Structured Query Language**](#parte-ii---structured-query-language)

[Objetivo](#objetivo-1)

[Desarrollo](#desarrollo-1)

[Consignas](#consignas-1)

[Referencias](#referencias-1)

## Parte I - Bases de Datos

### Objetivo

- Ejercitar el diseño e implementación de bases de datos estructuradas en el ámbito clínico

- Comprender la importancia y complejidad del manejo de bases de datos relacionales en sistemas de salud


### Desarrollo

#### **_Actividad_**

_Se desea diseñar una base de datos relacional que almacene la información sobre los pacientes, médicos, recetas y consultas en un centro de salud. En la actualidad, la gestión de esta información se lleva a cabo del siguiente modo:_

_Cuando una persona acude al centro de salud, se le toma nota en una ficha con sus datos personales: nombre, fecha de nacimiento, sexo biológico y dirección (calle, número y ciudad). Esta ficha queda registrada en el archivo de pacientes del centro. Los médicos del centro también tienen su ficha, donde se registran su nombre completo, especialidad y dirección profesional. Cada vez que un médico realiza una consulta o tratamiento a un paciente, puede emitir una receta. Esta receta incluye la fecha, el nombre del paciente atendido, el médico que la emite, el medicamento o tratamiento indicado, y la enfermedad o condición que motivó la prescripción. Esta información queda registrada y organizada para facilitar tanto el seguimiento del paciente como las auditorías clínicas. Los tratamientos pueden incluir medicamentos, indicaciones como reposo o fisioterapia, y suelen tener especificaciones temporales (por ejemplo, “tomar por 5 días” o “uso indefinido”). También se registran enfermedades o diagnósticos asociados, permitiendo análisis estadísticos o seguimiento epidemiológico. El sistema busca reemplazar los registros en papel por una solución digital que permita realizar búsquedas rápidas, obtener estadísticas de distribución demográfica, sexo y especialidad, y mantener la información organizada para su integración con otros módulos médicos como historiales clínicos, turnos o recetas médicas._


#### **_Consignas_**

1. _¿Qué tipo de base de datos es? Clasificarla según estructura y función._

Se trata de una base de datos relacional, ya que organiza la información en tablas (entidades) relacionadas entre sí mediante claves primarias y foráneas (PK y FK), evitando redundancia en el manejo de datos y facilitando las consultas complejas. En este caso, los datos de pacientes, médicos, recetas y consultas se estructuran en tablas interconectadas. Por ejemplo, una receta está vinculada a un médico y un paciente, incluyendo una columna con FK que corresponden con la PK de la entidad relacionada. La estructura relacional soporta relaciones muchos-a-muchos y uno-a-muchos, lo cuál permite asociar, por ejemplo, un paciente a múltiples recetas o un médico a sus múltiples pacientes, por lo que resulta ideal en este contexto.

En lo que respecta a su función, se trata de una base de datos transaccional, ya que finalidad principal es registrar y gestionar operaciones diarias del centro de salud, como el ingreso de datos de pacientes, emisión de recetas y registro de consultas. Está diseñada para soportar un alto volumen de transacciones (como inserciones, actualizaciones y eliminaciones), garantizando la consistencia de los datos para el seguimiento de pacientes y auditorías clínicas.

Luego, se trata de una base de datos diseñada para OLTP (OnLine Transaction Process) en el ámbito de la gestión clínica.

2. _Armar el diagrama entidad-relación de la base de datos dada._

Para este punto y el siguiente, la única modificación que consideramos con respecto al modelo original de base de datos es crear una tabla de ciudades y reemplazar la columna de ciudades de la tabla de pacientes por una columna con los ids de las ciudades referenciadas. Por supuesto que se pueden realizar más mejoras, pero con lo que respecta al desarrollo del TP, esta es la que añade más valor, ya que permite resolver el punto cinco de la parte II de una forma más limpia.

El DER para la base de datos definida se realizó en [draw.io](http://draw.io), y el resultado fue el siguiente:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfT22Y-g-SeTBtVlAkF6sx9saBHjB01icbddwIUXZcaKBCMZTH7y42Zwd7euBVEVTfsYIjnk-rGstCc-sv-1vcc3Uy7EibnmDjuA1OIZBWYHTFSQPcWEc9N9Vrm6qMFMOauF9ENVQ?key=w4SjoEIuYoQShRAaQ_QIWQ)

3. _Armar el modelo lógico entidad-relación de la base de datos dada._

El modelo lógico de entidad relación para la base de datos dada fue obtenido utilizando la herramienta de _Obtain ERD Diagram_ dentro de _PgAdmin_:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcOqab-9P2ZRiLaWZ2MiGY4MlEosBsWDH4UEZGWV_ISTmX4fIsrlk63hdSGuc4gP_IpojXs2p_j0gVSActmTCAnMKkpW2In7_HCoiXyPyWJxOAfvMeQPmINIVrXqDxTuSi9laOxPw?key=w4SjoEIuYoQShRAaQ_QIWQ)

4. _¿Considera que la base de datos está normalizada? En caso que no lo esté, ¿cómo podría hacerlo? Nota: no debe normalizar la base de datos, solo explicar como lo haría._

La base de datos cumple con la primera forma normal (1FN), ya que todos los valores son atómicos, no hay grupos repetitivos y cada entidad posee atributos univalentes claramente definidos. También se cumple la segunda forma normal (2FN), ya que cada entidad tiene una clave primaria fuerte y todos los demás atributos dependen funcionalmente de ella. 

No obstante, la base de datos no cumple necesariamente con la tercera forma normal (3FN). Esto se debe a dos razones fundamentales:

- La dirección debería existir como entidad, y cada paciente debería tener asociada una dirección haciendo referencia a la tabla de direcciones. Si dos pacientes tienen la misma relación, deja de cumplirse 3FN.

- La matrícula del médico reemplaza perfectamente el ID asociado. Las demás propiedades, por tanto, también dependen de la matrícula.

Para cumplir con 3FN, habría que crear una tabla de direcciones con los atributos de ID, Calle y Número, y reemplazar los datos correspondientes tal como se hizo con para las ciudades. Se puede incluso, sumar el ID de la ciudad dentro de la tabla de direcciones. Por otro lado, podría reemplazarse el ID del médico por su matrícula. De esta forma, se garantizarían los tres niveles de normalización para la base de datos dada.


#### **_Referencias_**

1. A. Goel, “Normalization in DBMS: 1NF, 2NF, 3NF, and BCNF \[Examples],” _Hackr.io_. \[Online]. Available: https\://hackr.io/blog/dbms-normalization

2. “draw\.io - free flowchart maker and diagrams online.” https\://draw\.io/


## Parte II - Structured Query Language

### Objetivo

- Practicar el uso de _Structured Query Language_ (SQL) en el ámbito de los sistemas informáticos de centros de salud

- Resolver situaciones cotidianas en la edición, la consulta y el curado de datos en un contexto clínico


### Desarrollo

Todas las consignas fueron resueltas utilizando _PostgreSQL_ y _Visual Studio Code_.


#### **_Consignas_**

1. _Cuando se realizan consultas sobre la tabla paciente agrupando por ciudad los tiempos de respuesta son demasiado largos. Proponer mediante una query SQL una solución a este problema._

Este es el tiempo inicial que se tarda en ejecutar una consulta que selecciona todos los pacientes y los agrupa por ciudad, contando cuántos hay en cada una.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXduLgyCohxD2RGnJboCRd9Zwwf5UvwKPlnSBr19RMYW04Zx57aa-jHeOIrjr6sFIXzNpk1_P9EOviUPbwVNhZc6mpr2zsnkeRDjCBgVqiwQVdXnN8jo0_G3_wwBfekjFZzDDFyoBg?key=w4SjoEIuYoQShRAaQ_QIWQ)

Al crear el índice con las siguiente query:
```sql
CREATE INDEX IF NOT EXISTS idx_pacientes_ciudad ON Pacientes(ciudad);
```

Los tiempos bajan ligeramente

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcXyXIh850Z9KBy5Bj32sLQzOVbCxE-3ni_WFpg4ZNic_7B6U8a6yj0i8uUzXaNWY66fgP0_xIVB0R8y3u7BYNLTpU0WEbKLlBLGbv2u0MUy9aKwX6kunttZ-uW1yrejBoVBRal?key=w4SjoEIuYoQShRAaQ_QIWQ)

Es probable que la diferencia no sea significativa debido a que no hay una gran cantidad de datos aún. Si se escala la base de datos, seguramente se notará la mejora.

2. _Se tiene la fecha de nacimiento de los pacientes. Se desea calcular la edad de los pacientes y almacenarla de forma dinámica en el sistema ya que es un valor típicamente consultado, junto con otra información relevante del paciente._

Para realizar lo pedido creamos una nueva vista, con las siguientes instrucciones SQL:
```sql
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
```

Los resultados son los siguientes:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfx6OzgKKutL4UbW2lRLKy8LmfKImnGW0FOXl_YgpixeDaWx94y-qO1ZWOee_F5I8dBX2qykDlLytcZHpvIk4kDKskGOryGexj9gIHHdFJmjK7m-GwlCzrsbcSepZTGPZSBT0xs?key=w4SjoEIuYoQShRAaQ_QIWQ)

3. _La paciente, “Luciana Gómez”, ha cambiado de dirección. Antes vivía en “Avenida Las Heras 121” en “Buenos Aires”, pero ahora vive en “Calle Corrientes 500” en “Buenos Aires”. Actualizar la dirección de este paciente en la base de datos._

Basta con utilizar una instrucción UPDATE:

```sql
UPDATE Pacientes
SET
    calle = 'Calle Corrientes',
    numero = '500'
WHERE
    nombre = 'Luciana Gómez'
```

Al volver a la vista creada en el paso anterior, puede verse el cambio.

4. _Seleccionar el nombre y la matrícula de cada médico cuya especialidad sea identificada por el id 4._

Realizamos lo pedido:

```sql
SELECT
    nombre,
    matricula
FROM
    Medicos
WHERE
    especialidad_id = 4
```

El resultado es el siguiente:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcKLwtiPdn4ls79GjjURuN7K3zUKTqxFn9l6G4gu6w8DjyzTSbpb15J68ZXXeIZbzssRqfv3y7Q4aBbQ4wXeFfNu5CdF_JUvHvMR72RLS33UDqxsZECjWtR7dK3dWcapgb45OdovQ?key=w4SjoEIuYoQShRAaQ_QIWQ)

5. _Puede pasar que haya inconsistencias en la forma en la que están escritos los nombres de las ciudades, ¿cómo se corrige esto? Agregar la query correspondiente._

Se optó por crear una nueva tabla con los nombres de las ciudades. Para poder identificar a qué ciudad correspondía cada fila, se normalizaron los nombres de las ciudades y se creó una nueva columna con el id de la ciudad referenciado a la nueva tabla. Luego, se rellenó la nueva columna de acuerdo con coincidencias en caracteres clave para cada ciudad. Finalmente, se modificaron el índice creado en el primer punto y la visa del segundo punto.

```sql
-- Creo y cargo la tabla Ciudades
CREATE TABLE IF NOT EXISTS Ciudades (
    id_ciudad SERIAL PRIMARY KEY,
    nombre VARCHAR(100) UNIQUE NOT NULL
);
INSERT INTO Ciudades (nombre)
VALUES ('Buenos Aires'), ('Córdoba'), ('Rosario'), ('Mendoza'), ('La Plata'), ('Santa Fe');

-- Primero cambiamos todas las letras a minúsculas
UPDATE Pacientes
SET ciudad = LOWER(ciudad);

-- Sacamos acentos y caracteres especiales
CREATE EXTENSION IF NOT EXISTS unaccent;
UPDATE Pacientes
SET ciudad = unaccent(ciudad);

-- Luego, eliminamos todos los caracteres que no sean letras
UPDATE Pacientes
SET ciudad = REGEXP_REPLACE(ciudad, '[^a-zA-Z]', '', 'g');

-- Añado la columna ciudad_id a la tabla Pacientes
ALTER TABLE Pacientes ADD COLUMN IF NOT EXISTS ciudad_id INT;
ALTER TABLE Pacientes
ADD CONSTRAINT fk_ciudad
FOREIGN KEY (ciudad_id) REFERENCES Ciudades(id_ciudad);

-- Añadir el ID de la ciudad correspondiente
UPDATE Pacientes
SET ciudad_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = 'Buenos Aires')
WHERE
    ciudad LIKE '%b%'
    AND ciudad LIKE '%s%'
    AND ciudad LIKE '%a%';

UPDATE Pacientes
SET ciudad_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = 'Córdoba')
WHERE
    ciudad LIKE '%c%'
    AND ciudad LIKE '%b%'
    AND ciudad LIKE '%a%';

UPDATE Pacientes
SET ciudad_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = 'Rosario')
WHERE
    ciudad LIKE '%ros%';

UPDATE Pacientes
SET ciudad_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = 'Mendoza')
WHERE
    ciudad LIKE '%m%'
    AND ciudad LIKE '%z%';

UPDATE Pacientes
SET ciudad_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = 'La Plata')
WHERE
    ciudad LIKE '%l%'
    AND ciudad LIKE '%p%';

UPDATE Pacientes
SET ciudad_id = (SELECT id_ciudad FROM Ciudades WHERE nombre = 'Santa Fe')
WHERE
    ciudad LIKE '%s%'
    AND ciudad LIKE '%f%';

-- Contamos cuantas filas han quedado sin ciudad_id
SELECT COUNT(*) FROM Pacientes WHERE ciudad_id IS NULL;

-- Ahora seguimos solo si la anterior consulta devuelve 0 filas

-- Eliminar el viejo índice creado en la consigna 01
DROP INDEX IF EXISTS idx_pacientes_ciudad;

-- Eliminamos la vista que se creó en la consigna 02
DROP VIEW IF EXISTS Vista_pacientess_Edad;
-- Crear la vista actualizada con la nueva columna ciudad_id
CREATE OR REPLACE VIEW Vista_pacientess_Edad AS
SELECT
    p.id_paciente AS "ID Paciente",
    p.nombre AS "Nombre Completo",
    p.fecha_nacimiento AS "Fecha de Nacimiento",
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, p.fecha_nacimiento)) AS "Edad",
    s.descripcion AS "Sexo",
    p.calle || ' ' || p.numero || ', ' || c.nombre AS "Dirección"
FROM
    Pacientes p
JOIN
    SexoBiologico s ON p.id_sexo = s.id_sexo
JOIN
    Ciudades c ON p.ciudad_id = c.id_ciudad;

-- Eliminar la columna ciudad de la tabla Pacientes
ALTER TABLE Pacientes DROP COLUMN IF EXISTS ciudad;


-- Crear el nuevo índice en la columna ciudad_id
CREATE INDEX IF NOT EXISTS idx_pacientes_ciudad_id ON Pacientes(ciudad_id);
```

6. _Obtener el nombre y la dirección de los pacientes que viven en Buenos Aires._

Al correr la siguiente instrucción:

```sql
SELECT
    p.nombre AS "Nombre Completo",
    p.calle || ' ' || p.numero AS "Dirección"
FROM
    Pacientes p
JOIN
    Ciudades c ON p.ciudad_id = c.id_ciudad
WHERE
    c.nombre = 'Buenos Aires'
```

Obtenemos como resultado:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXf_k6UbsGxo_GcTgNPwdhrIPt8qr0koNEnlaZ0EFG1RTpg6uVKVQw5xex7kKDGO67w-NKo_pFP85SL-sLFXsiPQNeZFZrd82MVw5d_u4NAuDj30kO6JG_KLDAsYcNjb9wD51n5Fzg?key=w4SjoEIuYoQShRAaQ_QIWQ)

7. _Cantidad de pacientes que viven en cada ciudad._

Dada nuestra nueva arquitectura de la base de datos, la consulta a realizar es la siguiente:

```sql
SELECT
    c.nombre AS "Ciudad",
    COUNT(p.id_paciente) AS "Número de Pacientes"
FROM
    Ciudades c
LEFT JOIN
    Pacientes p ON c.id_ciudad = p.ciudad_id
GROUP BY
    c.id_ciudad, c.nombre
```

El resultado obtenido se muestra a continuación:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfDI6iax3uvO-vXsEMKgudLvuMjFeBcmw9MTASaTm208880ZUZERzs-us13l2zifDvDPGtlPF5glSaemTj0dq08pYEPdKa-H8v04zXD0daQKPBZ4BZP_lWu88PcnvOJ7dPRlUpUWQ?key=w4SjoEIuYoQShRAaQ_QIWQ)

8. _Cantidad de pacientes por sexo que viven en cada ciudad._

La consulta resultante se parece bastante a la anterior:

```sql
SELECT
    c.nombre AS "Ciudad",
    SUM(CASE WHEN s.descripcion = 'Masculino' THEN 1 ELSE 0 END) AS "Hombres",
    SUM(CASE WHEN s.descripcion = 'Femenino' THEN 1 ELSE 0 END) AS "Mujeres"
FROM
    Ciudades c
LEFT JOIN
    Pacientes p ON c.id_ciudad = p.ciudad_id
LEFT JOIN
    sexobiologico s ON p.id_sexo = s.id_sexo
GROUP BY
    c.id_ciudad, c.nombre
```

Al ejecutarla, nos arroja el siguiente resultado:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdD88MA8wzCKBYb4dicXMbDDLJZZi8mEWO3AY72GywIKobaw-zftf9AUa_uNIGyrOp4y_2S9Y5kGxVlCtAHaFUDeF9upCTgp-opMR7OrbaEBu7gjEA67Vz3bBHwA3aq1N4fw2oRXg?key=w4SjoEIuYoQShRAaQ_QIWQ)

9. _Obtener la cantidad de recetas emitidas por cada médico._

La consulta que elaboramos para este punto es:

```sql
SELECT
    m.nombre AS "Nombre del Médico",
    COUNT(r.id_receta) AS "Cantidad de Recetas"
FROM
    Medicos m
LEFT JOIN
    Recetas r ON m.id_medico = r.id_medico
GROUP BY
    m.nombre
```

Los resultados son:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcx1NLJf2c7n9Y1HPfnVRsUVJjHk8h1ftraApMU3C-FkaRxVuyRMYtRXVtz0h2BxEkuI7HNirnfeT6CuqjpaZo9l-DM0Z9Is_ebm9NjlUP6xvRHXyjj5E-Z1-mynfVh67i0HXDl?key=w4SjoEIuYoQShRAaQ_QIWQ)

10. _Obtener todas las consultas médicas realizadas por el médico con ID igual a 3 durante el mes de agosto de 2024._

Realizamos la consulta descrita a continuación:

```sql
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
```

Los resultados fueron los siguientes:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXf8tsDN-xbUSYFA2dYuccqc-D92aZrkPYbBmen-wRrmxTFEYtlSG41GXU8yPyn7LuUBJTfzJQg0WpxhPDgXCHivlvYnt5zTuEbijQ5WwEgmyna5Ki10ts299cHEwgXYSm_ie_5UPw?key=w4SjoEIuYoQShRAaQ_QIWQ)

11. _Obtener el nombre de los pacientes junto con la fecha y el diagnóstico de todas las consultas médicas realizadas en agosto del 2024._

Se trata de una simplificación de la consulta anterior:

```sql
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
```

El resultado es el siguiente:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcy3O8ZUwGg4aYvDbIIcSzijHgAzpobKISSODijmrbnLRJAEJMHP-ZDA7-15Jk9vB_2qKs3oDHpdxuQbZ81VTpsBGhhkFyhqIOd5aKe6SAatD1rN1FlL600A7oTfn0DYjoMen1Tvg?key=w4SjoEIuYoQShRAaQ_QIWQ)

(Se truncaron filas)

12. _Obtener el nombre de los medicamentos prescritos más de una vez por el médico con ID igual a 2._

La consulta que realizamos en este caso es:

```sql
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
```

El único medicamento arrojado es _Omeprazol_.

13. _Obtener el nombre de los pacientes junto con la cantidad total de recetas que han recibido._

Hemos realizado la siguiente consulta para este punto:

```sql
SELECT
    p.nombre AS "Nombre del Paciente",
    COUNT(r.id_receta) AS "Cantidad de Recetas"
FROM
    pacientes p
JOIN
    recetas r ON p.id_paciente = r.id_paciente
GROUP BY
    p.nombre
```

El resultado se muestra a continuación:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcaH0-hcPx81vsUBvNcH0n6GH8zCM__xEfWyHengCOGSK_hdaAnVPJE9J_mUdi2eTm7UeWixKxFtuFPnbI2R22D7cPPrbAGFoO8TnYPeyLncTdoU2_rrVzS-QpgnQT5PKqIQFx_?key=w4SjoEIuYoQShRAaQ_QIWQ)

(Tabla truncada)

14. _Obtener el nombre del medicamento más recetado junto con la cantidad de recetas emitidas para ese medicamento._

La query realizada para este punto es la siguiente:

```sql
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
```

Se obtiene _Férula_ como el medicamente más recetado, con cuatro apariciones en total.

15. _Obtener el nombre del paciente junto con la fecha de su última consulta y el diagnóstico asociado._

Para este punto, realizamos la consulta que se muestra a continuación:

```sql
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
```

El resultado es el siguiente:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeroAoy9xH9aEzigIdsKzJp3ANERHVFXAYYRdM9l7vKU18tlU-6XacfU2a_jL1gUxECOOOwv8wfv3iiapMIT7bULsH-9aJrnUdWz-5lL1oGuHpRgCQ0efg1U6FK6xAg-RLsoVKZ-A?key=w4SjoEIuYoQShRAaQ_QIWQ)

16. _Obtener el nombre del médico junto con el nombre del paciente y el número total de consultas realizadas por cada médico para cada paciente, ordenado por médico y paciente._

La consulta realizada es la siguiente:

```sql
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
```

Los resultados se muestran en esta tabla:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXc_SXIZcKOsxbHGsjRxey30R9U1N8YFRVM06FERmWZSOsik59x1Eh2IJcn0FkRsCf2iNuAz1CT7xvljZdsf1fYWlAgyqLJ88UjP3yD83Vy9W5-U71OIsTIVibW_SoTzYm-ij0kr?key=w4SjoEIuYoQShRAaQ_QIWQ)

17. _Obtener el nombre del medicamento junto con el total de recetas prescritas para ese medicamento, el nombre del médico que lo recetó y el nombre del paciente al que se le recetó, ordenado por total de recetas en orden descendente._

La consulta realizada es la siguiente:

```sql
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
```

Se terminan listando todas las recetas, pues en ninguna con el mismo nombre de paciente y médico se repite el medicamento

18. _Obtener el nombre del médico junto con el total de pacientes a los que ha atendido, ordenado por el total de pacientes en orden descendente._

Finalmente, esta es la última consulta:

```sql
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
```

El resultado se muestra a continuación:

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdnazH-Jg7GVJiRpua-_UvRBSsgXxylDT7sEShQUo2WzBR7dy7OhkSHzPQ9JmL4SrBMD38cctOOhTtSN8IaKKgwtW4r-aWGnNtJWGd-MAeuwsLXuVr3iPiqoE4QeLJ9kFeYuMn8Kw?key=w4SjoEIuYoQShRAaQ_QIWQ)


#### **_Referencias_**

3. “PostgreSQL,” PostgreSQL, May 25, 2025. https\://www\.postgresql.org

4. “Visual Studio Code - Code editing. Redefined,” Nov. 03, 2021.  https\://code.visualstudio.com