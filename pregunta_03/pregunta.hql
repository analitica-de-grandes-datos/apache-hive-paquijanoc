/* 
Pregunta
===========================================================================

Para resolver esta pregunta use el archivo `data.tsv`.

Escriba una consulta que devuelva los cinco valores diferentes más pequeños 
de la tercera columna.

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

        >>> Escriba su respuesta a partir de este punto <<<
*/
-- Crear una base de datos llamada "mydatabase" (opcional, si no existe)
CREATE DATABASE IF NOT EXISTS mydatabase;

-- Cambiar a la base de datos "mydatabase"
USE mydatabase;

-- Crear una tabla llamada "mytable" para cargar los datos desde el archivo TSV
CREATE TABLE IF NOT EXISTS mytable (
  col1 STRING,
  col2 STRING,
  col3 INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE;

-- Cargar los datos desde el archivo TSV en la tabla "mytable"
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE mytable;

-- Obtener los cinco valores más pequeños de la tercera columna numérica
SELECT col3
FROM mytable
ORDER BY col3
LIMIT 5;

-- Guardar el resultado en la carpeta 'output' en el directorio de trabajo
INSERT OVERWRITE LOCAL DIRECTORY 'output'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT col3
FROM (
  SELECT col3
  FROM mytable
  ORDER BY col3
  LIMIT 5
) subquery;


