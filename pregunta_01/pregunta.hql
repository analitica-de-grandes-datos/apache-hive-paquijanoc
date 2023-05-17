/* 
Pregunta
===========================================================================

Para resolver esta pregunta use el archivo `data.tsv`.

Compute la cantidad de registros por cada letra de la columna 1.
Escriba el resultado ordenado por letra. 

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
  col3 STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
STORED AS TEXTFILE;

-- Cargar los datos desde el archivo TSV en la tabla "mytable"
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE mytable;

-- Calcular la cantidad de registros por cada letra en la columna 1
SELECT CONCAT(col1, ',', COUNT(*)) AS result
FROM mytable
GROUP BY col1
ORDER BY col1;

-- Guardar el resultado en la carpeta 'output' en el directorio de trabajo
INSERT OVERWRITE LOCAL DIRECTORY 'output'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT CONCAT(col1, ',', COUNT(*)) AS result
FROM mytable
GROUP BY col1
ORDER BY col1;

