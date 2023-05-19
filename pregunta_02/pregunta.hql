/* 
Pregunta
===========================================================================

Para resolver esta pregunta use el archivo `data.tsv`.

Construya una consulta que ordene la tabla por letra y valor (3ra columna).

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

        >>> Escriba su respuesta a partir de este punto <<<
*/
-- Crear una base de datos en Hive
CREATE DATABASE IF NOT EXISTS mydatabase;
USE mydatabase;

-- Crear una tabla para los datos de entrada
CREATE TABLE IF NOT EXISTS mytable (
  _c0 STRING,
  _c1 DATE,
  _c2 INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';

-- Cargar los datos en la tabla
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE mytable;

-- Consulta para obtener los resultados esperados
SELECT CONCAT(_c0, ',', _c1, ',', _c2) AS result
FROM mytable
ORDER BY _c0, _c2;

-- Configurar la salida en formato CSV y almacenar los resultados en archivos separados por valor de _c0
SET hive.resultset.use.unique.column.names=false;
INSERT OVERWRITE DIRECTORY 'output'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT CONCAT(_c0, ',', _c1, ',', _c2) AS result
FROM mytable
ORDER BY _c0, _c2;


