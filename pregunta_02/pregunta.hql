/* 
Pregunta
===========================================================================

Para resolver esta pregunta use el archivo `data.tsv`.

Construya una consulta que ordene la tabla por letra y valor (3ra columna).

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

-- Ordenar la tabla por letra (col1) y valor (col3)
SELECT CONCAT(col1, ',', col2, ',', col3) AS result
FROM mytable
ORDER BY col1, col3;

-- Guardar el resultado en la carpeta 'output' en el directorio de trabajo
INSERT OVERWRITE LOCAL DIRECTORY 'output'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT CONCAT(col1, ',', col2, ',', col3) AS result
FROM mytable
ORDER BY col1, col3;


