-- CONSULTAS SQL: AVANZANDO EN SQL CON MYSQL

-- 01.CONFIGURANDO EL AMBIENTE Y CONOCIENDO SQL
/*-Preparando el ambiente-*/
CREATE DATABASE jugos_ventas;

USE jugos_ventas;
/*Se va importar la base de datos del archivo DumpJugosVentas mediante Administration - Data Import/Restore
- Import from Dump Project Folder - Ponemos la ruta del archivo DumpoJugosVentas y presionamos el botón inferior Start Import 
*/

SELECT * FROM facturas;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A recuperar el ambiente;
-- Un poco sobre la historia de SQL;
-- Un poco sobre la historia de MYSQL.





-- 02.FILTRANDO LAS CONSULTAS DE LOS DATOS
/*-Conociendo la base de datos
Sección Database - Reverse Engineer - Presionamos Next y seleccionamos la base de datos que queramos para ver su Diagrama EER
-*/

/*-Revisando consultas-*/
SELECT NOMBRE, DIRECCION1, DIRECCION_2, BARRIO, CIUDAD, ESTADO,
CP, FECHA_DE_NACIMIENTO, EDAD, SEXO, LIMITE_DE_CREDITO, VOLUMEN_DE_COMPRA,
PRIMERA_COMPRA FROM tabla_de_clientes;

SELECT * FROM tabla_de_clientes;

SELECT DNI, NOMBRE FROM tabla_de_clientes;

SELECT DNI AS IDENTIFICACION, NOMBRE AS CLIENTE FROM tabla_de_clientes;

SELECT * FROM tabla_de_productos;

SELECT * FROM tabla_de_productos WHERE SABOR = 'Uva';

SELECT * FROM tabla_de_productos WHERE SABOR = 'Mango';

SELECT * FROM tabla_de_productos WHERE ENVASE = 'Botella PET';

SELECT * FROM tabla_de_productos WHERE ENVASE = 'botella pet';

SELECT * FROM tabla_de_productos WHERE PRECIO_DE_LISTA > 16;

SELECT * FROM tabla_de_productos WHERE PRECIO_DE_LISTA <= 17;

SELECT * FROM tabla_de_productos WHERE PRECIO_DE_LISTA BETWEEN 16 AND 16.02;

/*-Consultas condicionales-
Operación OR
El resultado de la operación es verdadero si alguna de sus condiciones es verdadera.

Operación AND
El resultado de la operación es verdadero si todas sus condiciones son verdaderas.

Operación NOR (NOT OR)
La negación de la operación OR.

Operación NAND (NOT AND)
La negación de la operación AND.

Verdadero = 1 y Falso = 0
*/

/*-Aplicando consultas condicionales-*/
SELECT * FROM tabla_de_productos;

SELECT * FROM tabla_de_productos WHERE SABOR = 'mango' AND TAMANO = '470 ml';

SELECT * FROM tabla_de_productos WHERE SABOR = 'mango' OR TAMANO = '470 ml';

SELECT * FROM tabla_de_productos WHERE NOT (SABOR = 'mango') OR TAMANO = '470 ml';

SELECT * FROM tabla_de_productos WHERE NOT (SABOR = 'mango' AND TAMANO = '470 ml');

SELECT * FROM tabla_de_productos WHERE SABOR = 'mango' AND NOT (TAMANO = '470 ml');

SELECT * FROM tabla_de_productos WHERE SABOR IN ('MANGO', 'UVA');

SELECT * FROM tabla_de_productos WHERE SABOR = 'MANGO' OR SABOR ='UVA';

SELECT * FROM tabla_de_clientes WHERE CIUDAD IN ('ciudad de México', 'Guadalajara');

SELECT * FROM tabla_de_clientes WHERE CIUDAD IN ('ciudad de México', 'Guadalajara') 
AND EDAD > 21;

SELECT * FROM tabla_de_clientes WHERE CIUDAD IN ('ciudad de México', 'Guadalajara') 
AND (EDAD BETWEEN 20 AND 25);

/*-Usando LIKE
Filtrando las consultas de datos
	SELECT * FROM tb WHERE CAMPO 
	LIKE '%<condición>';
<condición> el texto utilizado
% Representa cualquier registro genérico antes de la condición.

Ejm.
		Nombre
- Miguel Suárez Diaz
- Raul José Suárez
- Manuela Diaz Avendaño
- Mario García Rojas
- Carlos Santiago Pérez
- Daniela Suárez
- Pedro González
- Pablo Restrepo Villa
- José Manuel Sánchez

SELECT * FROM tb WHERE CAMPO LIKE ‘%suárez%’;
% Representa cualquier registro genérico antes o después de la condición.

SELECT * FROM tb WHERE CAMPO LIKE ‘%suárez’;
Registros que terminan con suárez.
-*/
SELECT * FROM tabla_de_productos WHERE SABOR LIKE '%manzana';

SELECT * FROM tabla_de_productos WHERE SABOR LIKE '%manzana' AND ENVASE = 'Botella PET';
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- La importancia de conocer la base de datos antes de realizar las consultas;
-- El comando de consultas y cómo podemos crear filtros;
-- A mezclar filtros condicionales con AND y OR;
-- A utilizar >, >=, <, <=, = ou <> en los filtros que implican valores;
-- El funcionamiento del comando LIKE.





-- 03.PRESENTACIÓN DE LOS DATOS DE UNA CONSULTA
/*-Usando DISTINCT
Solo devuelve registros con valores diferentes.
	SELECT DISTINCT * FROM tb;
-*/
SELECT ENVASE, TAMANO FROM tabla_de_productos;

SELECT DISTINCT ENVASE, TAMANO FROM tabla_de_productos;

SELECT DISTINCT ENVASE, TAMANO, SABOR FROM tabla_de_productos
WHERE SABOR = 'Naranja';

/*-Usando LIMIT
Limita el número de registros exhibidos.
	SELECT * FROM tb LIMIT 4;
    SELECT * FROM tb LIMIT 3,2;
-*/
SELECT * FROM tabla_de_productos;

SELECT * FROM tabla_de_productos LIMIT 5;

SELECT * FROM tabla_de_productos LIMIT 5,4;

/*-Usando ORDER BY
Presenta el resultado de la consulta ordenado por el campo determinado al ejecutar ORDER BY.
SELECT * FROM tb ORDER BY campo;

Dicho orden es ascendente por defecto (ASC) pero se puede hacer de forma descendiente (DESC) también.
SELECT * FROM tb ORDER BY campo DESC;

Se pueden emplear n campos al mismo tiempo como criterio de selección.
SELECT * FROM tb ORDER BY campo_1 DESC, campo_2 ASC;
-*/
SELECT * FROM tabla_de_productos;

SELECT * FROM tabla_de_productos ORDER BY PRECIO_DE_LISTA;

SELECT * FROM tabla_de_productos ORDER BY PRECIO_DE_LISTA DESC;

SELECT * FROM tabla_de_productos ORDER BY NOMBRE_DEL_PRODUCTO;

SELECT * FROM tabla_de_productos ORDER BY NOMBRE_DEL_PRODUCTO DESC;

SELECT * FROM tabla_de_productos ORDER BY ENVASE DESC, NOMBRE_DEL_PRODUCTO ASC;

/*-Usando GROUP BY
SELECT <campos> FROM tb GROUP BY campo;
Presenta el resultado agrupando valores numéricos empleando una clave de criterio.

SELECT X, SUM(Y) FROM tb GROUP BY X;
Podemos utilizar:
SUM() -> Suma
MAX() -> Máximo
MIN() -> Mínimo
AVG() -> Promedio
COUNT() -> Contador

SELECT X, MAX(Y) FROM tb GROUP BY X;

SELECT X, MIN(Y) FROM tb GROUP BY X;

SELECT X, AVG(Y) FROM tb GROUP BY X;

SELECT X, COUNT(Y) FROM tb GROUP BY X;

SELECT SUM(Y) FROM tb; Si se omite el campo de agregación, la operación se va a efectuar en toda la tabla.

SELECT MAX(Y) FROM tb; Si se omite el campo de agregación, la operación se va a efectuar en toda la tabla.

SELECT AVG(Y) FROM tb; Si se omite el campo de agregación, la operación se va a efectuar en toda la tabla.

SELECT COUNT(Y) FROM tb; Si se omite el campo de agregación, la operación se va a efectuar en toda la tabla.
-*/
SELECT ESTADO, LIMITE_DE_CREDITO FROM tabla_de_clientes;

SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS LIMITE_TOTAL FROM tabla_de_clientes
GROUP BY ESTADO;

SELECT ENVASE, PRECIO_DE_LISTA FROM tabla_de_productos;

SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS MAYOR_PRECIO FROM tabla_de_productos
GROUP BY ENVASE;

SELECT ENVASE, COUNT(*) FROM tabla_de_productos
GROUP BY ENVASE;

SELECT BARRIO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabla_de_clientes
GROUP BY BARRIO;

SELECT BARRIO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabla_de_clientes
WHERE CIUDAD = 'CIUDAD DE MÉXICO'
GROUP BY BARRIO;

SELECT CIUDAD, BARRIO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabla_de_clientes
WHERE CIUDAD = 'CIUDAD DE MÉXICO'
GROUP BY BARRIO;

SELECT CIUDAD, BARRIO, SUM(LIMITE_DE_CREDITO) AS LIMITE FROM tabla_de_clientes
WHERE CIUDAD = 'GUADALAJARA'
GROUP BY BARRIO;

SELECT ESTADO, BARRIO, MAX(LIMITE_DE_CREDITO) AS LIMITE FROM tabla_de_clientes
GROUP BY ESTADO, BARRIO;

SELECT ESTADO, BARRIO, MAX(LIMITE_DE_CREDITO) AS LIMITE,
EDAD FROM tabla_de_clientes
WHERE EDAD >= 20
GROUP BY ESTADO, BARRIO, EDAD
ORDER BY EDAD;

/*-Usando HAVING
Es un filtro que se aplica sobre el resultado de una agregación.
SELECT X, SUM(Y) FROM tb GROUP BY X;

Queremos visualizar los campos cuya suma sea mayor que 4
SELECT X, SUM(Y) FROM tb GROUP BY X HAVING SUM(Y) > 4;
-*/
SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS LIMITE_TOTAL 
FROM tabla_de_clientes
WHERE LIMITE_TOTAL >300000
GROUP BY ESTADO; # Esta mal

SELECT ESTADO, SUM(LIMITE_DE_CREDITO) AS LIMITE_TOTAL 
FROM tabla_de_clientes
GROUP BY ESTADO 
HAVING LIMITE_TOTAL > 300000;

SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS PRECIO_MAXIMO,
MIN(PRECIO_DE_LISTA) AS PRECIO_MINIMO
FROM tabla_de_productos
GROUP BY ENVASE;

SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS PRECIO_MAXIMO,
MIN(PRECIO_DE_LISTA) AS PRECIO_MINIMO
FROM tabla_de_productos
GROUP BY ENVASE
HAVING SUM(PRECIO_DE_LISTA) > 80;

SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS PRECIO_MAXIMO,
MIN(PRECIO_DE_LISTA) AS PRECIO_MINIMO, SUM(PRECIO_DE_LISTA) AS SUMA_PRECIO
FROM tabla_de_productos
GROUP BY ENVASE
HAVING SUM(PRECIO_DE_LISTA) > 80;

SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS PRECIO_MAXIMO,
MIN(PRECIO_DE_LISTA) AS PRECIO_MINIMO, SUM(PRECIO_DE_LISTA) AS SUMA_PRECIO
FROM tabla_de_productos
GROUP BY ENVASE
HAVING SUM(PRECIO_DE_LISTA) >= 80 AND MAX(PRECIO_DE_LISTA) >= 5;

/*-Usando CASE
Se realiza un test en uno o más campos y, dependiendo del resultado obtendremos
un valor específico
CASE
	WHEN <condición_1> THEN <value_1>
    WHEN <condición_2> THEN <value_2>
    ...
    WHEN <condición_n> THEN <value_n>
    ELSE <valor_ELSE>
END

Empleado en clasificación de registros
SELECT X
CASE
	WHEN Y >= 8 AND Y <=10 THEN  'Muy bueno'
    WHEN Y >= 7 AND Y < 8 THEN 'Bueno'
    WHEN Y >= 5 AND Y < 7 THEN 'Regular'
    ELSE 'Malo'
END
FROM tb;
-*/
SELECT * FROM tabla_de_productos;

SELECT NOMBRE_DEL_PRODUCTO, PRECIO_DE_LISTA,
CASE
	WHEN PRECIO_DE_LISTA >= 12 THEN 'Costoso'
    WHEN PRECIO_DE_LISTA >= 5 AND PRECIO_DE_LISTA < 12 THEN 'Asequible'
    ELSE 'Barato'
END AS PRECIO
FROM tabla_de_productos;

SELECT ENVASE, SABOR,
CASE
	WHEN PRECIO_DE_LISTA >= 12 THEN 'Costoso'
    WHEN PRECIO_DE_LISTA >= 5 AND PRECIO_DE_LISTA < 12 THEN 'Asequible'
    ELSE 'Barato'
END AS PRECIO, MIN(PRECIO_DE_LISTA) AS PRECIO_MINIMO
FROM tabla_de_productos
WHERE TAMANO = '700 ml'
GROUP BY ENVASE, SABOR, 
CASE
	WHEN PRECIO_DE_LISTA >= 12 THEN 'Costoso'
    WHEN PRECIO_DE_LISTA >= 5 AND PRECIO_DE_LISTA < 12 THEN 'Asequible'
    ELSE 'Barato'
END
ORDER BY ENVASE;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A presentar solamente filas distintas en una selección;
-- A ordenar la salida de la selección;
-- A agrupar los registros por un conjunto de campos y aplicando un criterio de agrupamiento sobre los campos numéricos (SUM, MIN, MAX, AVG, etc);
-- A utilizar el comando HAVING para aplicar un filtro utilizando los campos numéricos agrupados como condición;
-- A limitar la salida de las consultas;
-- A usar el comando CASE para clasificar un determinado campo por un criterio.





-- 04.UNIENDO TABLAS Y CONSULTAS
/*-Usando JOINS
Estructura JOIN
Permite unir 2 o más tablas a través de un campo en camún

INNER JOIN
Devuelve únicamente los registros con llaves correspondientes.
SELECT A.NOMBRE, B.HOBBY FROM TABLA_IZQ A
INNER JOIN
TABLA_DER B 
ON A.ID = B.ID

A = {1,2,3} B = {1,2,5,6}
INNER JOIN = {1,2}

LEFT JOIN
Mantiene todos los registros de la tabla de la izquierda y devuelve únicamente los correspondientes
de la tabla de la derecha.
SELECT A.NOMBRE, B.HOBBY FROM TABLA_IZQ A
LEFT JOIN 
TABLA_DER B
ON A.ID = B.ID

A = {1,2,3] B = {1,2,5,6}
LEFT JOIN = {1,2,3}

RIGHT JOIN
Mantiene todos los registros de la tabla de la derecha y devuelve únicamente los correspondientes 
de la tabla de la izquierda.
SELECT A.NOMBRE, B.HOBBY FROM TABLA_IZQ A
RIGHT JOIN
TABLA_DER B
ON A.ID = B.ID

A = {1,2,3} B = {1,2,5,6}
RIGHT JOIN = {1,2,5,6}

FULL JOIN
Mantiene y devuelve todos los registros de las tablas.
SELECT A.NOMBRE, B.HOBBY FROM TABLA_IZQ A
FULL JOIN
TABLA_DER B
ON A.ID = B.ID

A = {1,2,3} B = {1,2,5,6}
FULL JOIN = {1,2,3,5,6}

CROSS JOIN
Devuelve el producto cartesiano de los registros de las tablas.
SELECT A.NOMBRE, B.HOBBY FROM TABLA_IZQ A, TABLA_DER B

NOMBRE | ID
Alejandro | 2
Zaida | 7
Ximena | 8
Elías | 10
Tatiana | 15
Penélope | 9

ID | HOBBY
4 | Lectura
5 | Fútbol
6 | Tenis
7 | Alpinismo
8 | Fotografía
9 | Hipismo
Van a aparecer 36 registros con la combinación de todos los hobbies y los
nombres de cada tabla.
-*/
SELECT * FROM tabla_de_vendedores;

SELECT * FROM facturas;

SELECT * FROM tabla_de_vendedores A
INNER JOIN
facturas B
ON A.MATRICULA = B.MATRICULA;

SELECT A.NOMBRE, B.MATRICULA, COUNT(*) FROM tabla_de_vendedores A
INNER JOIN
facturas B
ON A.MATRICULA = B.MATRICULA
GROUP BY A.NOMBRE, B.MATRICULA;

# Forma antigua de hacer un INNER JOIN usando un CROSS JOIN
SELECT A.NOMBRE, B.MATRICULA, COUNT(*) 
FROM tabla_de_vendedores A, facturas B
WHERE A.MATRICULA = B.MATRICULA
GROUP BY A.NOMBRE, B.MATRICULA;

/*-Ejemplos de LEFT y RIGHT JOIN-*/
SELECT COUNT(*) FROM tabla_de_clientes;

SELECT DISTINCT A.DNI, A.NOMBRE, B.DNI FROM tabla_de_clientes A 
INNER JOIN facturas B
ON A.DNI = B.DNI;

SELECT DISTINCT A.DNI, A.NOMBRE, A.CIUDAD, B.DNI FROM tabla_de_clientes A 
LEFT JOIN facturas B
ON A.DNI = B.DNI
WHERE B.DNI IS NULL;

SELECT DISTINCT B.DNI, B.NOMBRE, B.CIUDAD, A.DNI FROM facturas A
RIGHT JOIN tabla_de_clientes B
ON A.DNI = B.DNI
WHERE A.DNI IS NULL;

/*-Ejemplos de FULL y CROSS JOIN-*/
SELECT * FROM tabla_de_clientes;

SELECT * FROM tabla_de_vendedores;

SELECT tabla_de_clientes.NOMBRE, tabla_de_clientes.BARRIO,
tabla_de_vendedores.NOMBRE
FROM tabla_de_clientes
INNER JOIN tabla_de_vendedores
ON tabla_de_clientes.BARRIO = tabla_de_vendedores.BARRIO;

SELECT tabla_de_clientes.NOMBRE, tabla_de_clientes.CIUDAD, tabla_de_clientes.BARRIO,
tabla_de_vendedores.NOMBRE
FROM tabla_de_clientes
LEFT JOIN tabla_de_vendedores
ON tabla_de_clientes.BARRIO = tabla_de_vendedores.BARRIO;

SELECT tabla_de_clientes.NOMBRE, tabla_de_clientes.CIUDAD, tabla_de_clientes.BARRIO,
tabla_de_vendedores.NOMBRE, tabla_de_vendedores.VACACIONES
FROM tabla_de_clientes
RIGHT JOIN tabla_de_vendedores
ON tabla_de_clientes.BARRIO = tabla_de_vendedores.BARRIO;

SELECT tabla_de_clientes.NOMBRE, tabla_de_clientes.CIUDAD, tabla_de_clientes.BARRIO,
tabla_de_vendedores.NOMBRE, tabla_de_vendedores.VACACIONES
FROM tabla_de_clientes
RIGHT JOIN tabla_de_vendedores
ON tabla_de_clientes.BARRIO = tabla_de_vendedores.BARRIO;

SELECT tabla_de_clientes.NOMBRE, tabla_de_clientes.CIUDAD, tabla_de_clientes.BARRIO,
tabla_de_vendedores.NOMBRE, VACACIONES # Esto se da porque VACACIONES es una columna única de tabla_de_vendedores
FROM tabla_de_clientes
RIGHT JOIN tabla_de_vendedores
ON tabla_de_clientes.BARRIO = tabla_de_vendedores.BARRIO;

SELECT tabla_de_clientes.NOMBRE, tabla_de_clientes.CIUDAD, tabla_de_clientes.BARRIO,
tabla_de_vendedores.NOMBRE, VACACIONES
FROM tabla_de_clientes
FULL JOIN tabla_de_vendedores # EN MySQL no funciona el FULL JOIN, funciona haciendo un RIGHT JOIN y un LEFT JOIN
ON tabla_de_clientes.BARRIO = tabla_de_vendedores.BARRIO;

SELECT tabla_de_clientes.NOMBRE, tabla_de_clientes.CIUDAD, tabla_de_clientes.BARRIO,
tabla_de_vendedores.NOMBRE, VACACIONES
FROM tabla_de_clientes, tabla_de_vendedores
WHERE tabla_de_clientes.BARRIO = tabla_de_vendedores.BARRIO;

SELECT tabla_de_clientes.NOMBRE, tabla_de_clientes.CIUDAD, tabla_de_clientes.BARRIO,
tabla_de_vendedores.NOMBRE, VACACIONES
FROM tabla_de_clientes, tabla_de_vendedores;

/*-Uniendo consultas
UNION
Permite unir 2 o más tablas. (Implícitamente ejecuta DISTINCT)
El número de campos en las tablas debe ser igual (mismos campos y mismos tipos).
<consulta 1>
UNION
<consulta 2>;

A = {1,2,3} B = {1,2,5,6}
UNION = {1,2,3,5,6}

UNION ALL
<consulta 1>
UNION ALL
<consulta 2>;

A = {1,2,3} B = {1,2,5,6}
UNION ALL = {1,2,3,1,2,5,6}
-*/
SELECT DISTINCT BARRIO FROM tabla_de_clientes;

SELECT DISTINCT BARRIO FROM tabla_de_vendedores;

SELECT DISTINCT BARRIO FROM tabla_de_clientes
UNION
SELECT DISTINCT BARRIO FROM tabla_de_vendedores;

SELECT DISTINCT BARRIO FROM tabla_de_clientes
UNION ALL
SELECT DISTINCT BARRIO FROM tabla_de_vendedores;

SELECT DISTINCT BARRIO, NOMBRE, 'Cliente' AS TIPO FROM tabla_de_clientes
UNION 
SELECT DISTINCT BARRIO, NOMBRE, 'Vendedor' AS TIPO FROM tabla_de_vendedores;

SELECT DISTINCT BARRIO, NOMBRE, 'Cliente' AS TIPO_CLIENTE FROM tabla_de_clientes
UNION 
SELECT DISTINCT BARRIO, NOMBRE, 'Vendedor' AS TIPO_VENDEDOR FROM tabla_de_vendedores;

# Tienen que ser del mismo tipo
SELECT DISTINCT BARRIO, NOMBRE, 'Cliente' AS TIPO_CLIENTE, DNI FROM tabla_de_clientes
UNION 
SELECT DISTINCT BARRIO, NOMBRE, 'Vendedor' AS TIPO_VENDEDOR, MATRICULA FROM tabla_de_vendedores;

SELECT tabla_de_clientes.NOMBRE, tabla_de_clientes.CIUDAD, tabla_de_clientes.BARRIO,
tabla_de_vendedores.NOMBRE, VACACIONES
FROM tabla_de_clientes
LEFT JOIN tabla_de_vendedores
ON tabla_de_clientes.BARRIO = tabla_de_vendedores.BARRIO
UNION
SELECT tabla_de_clientes.NOMBRE, tabla_de_clientes.CIUDAD, tabla_de_clientes.BARRIO,
tabla_de_vendedores.NOMBRE, VACACIONES
FROM tabla_de_clientes
RIGHT JOIN tabla_de_vendedores
ON tabla_de_clientes.BARRIO = tabla_de_vendedores.BARRIO;

/*-Subconsultas
Permite realizar una consulta al interior de otra.
Tabla 1:
X | Y
A	3
Z	5
Z	1
A	1
E	4
T	3
Z	8
Z	2
T	1

Tabla 2:
Y
1
2
3

SELECT X, Y FROM tb1
WHERE Y IN (1,2);

SELECT X.Y FROM tb1
WHERE Y IN (1,2,3);
¿Será que podemos seleccionar los valores de Y sin necesidad de
listarlos uno por uno?
¡Sí!

SELECT X, Y FROM tb1
WHERE Y IN (SELECT Y FROM tb2);
Generamos una consulta dentro de otra consulta.

SELECT X, SUM(Y) AS NEW_Y FROM tb1 GROUP BY X;
X | NEW_Y
A	4
E	4
T	4
Z	16
Creamos una nueva consulta
SELECT Z.X, Z.NEW_Y 
FROM (SELECT X, SUM(Y) AS NEW_Y FROM tb1 GROUP BY X) Z
WHERE Z.NEW_Y = 4;
X | NEW_Y
A	4
E	4
T	4
-*/
SELECT DISTINCT BARRIO FROM tabla_de_vendedores;

SELECT * FROM tabla_de_clientes
WHERE BARRIO IN ('Condesa', 'Del Valle', 'Contadero','Oblatos');

SELECT * FROM tabla_de_clientes
WHERE BARRIO IN (SELECT DISTINCT BARRIO FROM tabla_de_vendedores);

SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS PRECIO_MAXIMO FROM tabla_de_productos
GROUP BY ENVASE;

SELECT X.ENVASE, X.PRECIO_MAXIMO FROM 
(SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS PRECIO_MAXIMO FROM tabla_de_productos
GROUP BY ENVASE) X
WHERE X.PRECIO_MAXIMO >= 10;

/*-Views
Es una tabla lógica que resulta de una consulta que puede ser usada posteriormente 
en cualquier otra consulta.
Tabla 1:
X | Y
A	3
Z	5
Z	1
A	1
E	4
T	3
Z	8
Z	2
T	1

SELECT X, SUM(Y) AS NEW_Y FROM tb1 GROUP BY X
Al almacenar la consulta, crearemos una View y la llamaremos VW_VIEW
X | NEW_Y
A	4
E	4
T	4
Z	16
La view tiene un costo de procesamiento, siempre que la invoquemos la misma
tendrá que ejecutar su consulta. (Especie de subconsulta)
SELECT * FROM VW_VIEW
X | NEW_Y
A	4
E	4
T	4
Z	16

TB3
W | Y
F  4
H  4
H  5
G  6
F  5
P  16
L  7
M  15
N  6
SELECT VW_VIEW.X, TB3.W FROM VM_VIEW
INNER JOIN
TB3 ON VW_VIEW.NEW_y = TB3.Y
WHERE TB3.Y = 16
X | W
Z	P
-*/
SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS PRECIO_MAXIMO FROM tabla_de_productos
GROUP BY ENVASE;

# Click derecho en Views - Create View - Creamos la view y apply
USE `jugos_ventas`;
CREATE  OR REPLACE VIEW `vw_envases_grandes` AS
SELECT ENVASE, MAX(PRECIO_DE_LISTA) AS PRECIO_MAXIMO FROM tabla_de_productos
GROUP BY ENVASE;

SELECT X.ENVASE, X.PRECIO_MAXIMO FROM
vw_envases_grandes X
WHERE PRECIO_MAXIMO >= 10;

SELECT A.NOMBRE_DEL_PRODUCTO, A.ENVASE, A.PRECIO_DE_LISTA, B.PRECIO_MAXIMO FROM tabla_de_productos A
INNER JOIN
vw_envases_grandes B
ON A.ENVASE = B.ENVASE;

SELECT A.NOMBRE_DEL_PRODUCTO, A.ENVASE, A.PRECIO_DE_LISTA, ((A.PRECIO_DE_LISTA/B.PRECIO_MAXIMO)-1)*100 AS PORCENTAJE_DE_VARIACION 
FROM tabla_de_productos A
INNER JOIN
vw_envases_grandes B
ON A.ENVASE = B.ENVASE;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A conectar dos o más tablas a través de comandos de JOIN;
-- Los tipos de JOIN existentes y cuáles son soportados por MySQL;
-- Los comandos UNION y UNION ALL, para unir dos o más selecciones siempre y cuando tengan los mismos campos seleccionados;
-- A utilizar una consulta como criterio de filtro de otra consulta;
-- A utilizar una consulta dentro de otra consulta;
-- A Crear y utilizar vistas (Views).





-- 05.FUNCIONES DE MYSQL
/*-Funciones con STRINGS-*/
SELECT LTRIM("		MySQL es fácil");

SELECT RTRIM("MySQL es fácil		");

SELECT TRIM("		MySQL es fácil		");

SELECT CONCAT("MySQL es fácil,", " no lo crees?");

SELECT UPPER("mysql es una base de datos interesante.");

SELECT LOWER("MYSQL ES UNA BASE DE DATOS INTERESANTE.");

SELECT SUBSTRING("mysql es una base de datos interesante.", 14,4);

SELECT CONCAT(NOMBRE, " ", DNI) FROM tabla_de_clientes;

/*-Funciones de fecha-*/
SELECT CURDATE();

SELECT CURRENT_TIMESTAMP();

SELECT YEAR(CURRENT_TIMESTAMP());

SELECT MONTH(CURRENT_TIMESTAMP());

SELECT DAY(CURRENT_TIMESTAMP());

SELECT MONTHNAME(CURRENT_TIMESTAMP());

SELECT DAYNAME(CURRENT_TIMESTAMP());

SELECT DATEDIFF(CURRENT_TIMESTAMP(), "2021-01-01") AS DIFERENCIA_DE_DIAS;

SELECT DATEDIFF(CURRENT_TIMESTAMP(), "1984-06-20") AS DIFERENCIA_DE_DIAS;

SELECT CURRENT_TIMESTAMP() AS DIA_HOY, DATE_SUB(CURRENT_TIMESTAMP(), INTERVAL 1 MONTH) AS RESULTADO;

SELECT DISTINCT FECHA_VENTA, DAYNAME(FECHA_VENTA) AS DIA, MONTHNAME(FECHA_VENTA) AS MES,
YEAR(FECHA_VENTA) AS AÑO FROM facturas;

/*-Funciones matemáticas-*/
SELECT (34+346-67)/15 * 29 AS RESULTADO;

SELECT CEILING (23.1222);

SELECT FLOOR (23.999999);

SELECT RAND() AS RESULTADO;

SELECT ROUND(254.545,2);

SELECT ROUND(254.545,1);

SELECT NUMERO, CANTIDAD, PRECIO, CANTIDAD * PRECIO AS FACTURACION
FROM items_facturas;

SELECT NUMERO, CANTIDAD, PRECIO, ROUND(CANTIDAD * PRECIO,2) AS FACTURACION
FROM items_facturas;

/*-Convirtiendo datos-*/
SELECT CURRENT_TIMESTAMP() AS RESULTADO;

SELECT CONCAT("La fecha y la hora de hoy son: ", CURRENT_TIMESTAMP()) AS RESULTADO;

SELECT CONCAT("La fecha y la hora de hoy son: ", DATE_FORMAT(CURRENT_TIMESTAMP(), "%W, %d/%m/%Y a las %T")) AS RESULTADO;

SELECT CONVERT(23.45, CHAR) AS RESULTADO;

SELECT SUBSTRING(CONVERT(23.45, CHAR), 3,1) AS RESULTADO;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- Algunas funciones de tipo STRING para texto;
-- Funciones matemáticas;
-- Funciones de tipo DATE para fechas;
-- Abordamos funciones de conversión.





-- 06.EJEMPLO DE INFORMES
/*-Informe de ventas válidas #1-*/
SELECT * FROM FACTURAS;

SELECT * FROM items_facturas;

SELECT F.DNI, F.FECHA_VENTA, IFa.CANTIDAD FROM facturas F
INNER JOIN
items_facturas IFa
ON  F.NUMERO = IFa.NUMERO;

# CANTIDAD DE VENTAS POR MES PARA CADA CLIENTE
SELECT F.DNI, DATE_FORMAT(F.FECHA_VENTA, "%m-%Y") AS MES_AÑO,
SUM(IFa.CANTIDAD) AS CANTIDAD_VENDIDA FROM facturas F
INNER JOIN
items_facturas IFa
ON  F.NUMERO = IFa.NUMERO
GROUP BY F.DNI, DATE_FORMAT(F.FECHA_VENTA, "%m-%Y");

/*-Informe de ventas válidas #2-*/
# LIMITE DE VENTAS POR CLIENTE (VOLUMEN EN DECILITROS)
SELECT * FROM tabla_de_clientes TC;

SELECT DNI, NOMBRE, VOLUMEN_DE_COMPRA from tabla_de_clientes TC;

SELECT F.DNI, TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, '%m - %Y') AS MES_AÑO, 
SUM(IFA.CANTIDAD) AS CANTIDAD_VENDIDA, 
MAX(VOLUMEN_DE_COMPRA)/10 AS CANTIDAD_MAXIMA
FROM facturas F
INNER JOIN
items_facturas IFa
on F.NUMERO = IFa.NUMERO
inner join
tabla_de_clientes TC
on TC.dni = F.DNI
GROUP BY F.DNI, TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, '%m - %Y');

SELECT A.DNI, A.NOMBRE, A.MES_AÑO,
CANTIDAD_VENDIDA - CANTIDAD_MAXIMA AS DIFERENCIA,
CASE
	WHEN (CANTIDAD_VENDIDA - CANTIDAD_MAXIMA) <= 0 THEN 'Venta Válida'
    ELSE 'Venta Inválida'
END AS STATUS_VENTA
FROM 
(SELECT F.DNI, TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, '%m - %Y') AS MES_AÑO, 
SUM(IFA.CANTIDAD) AS CANTIDAD_VENDIDA, 
MAX(VOLUMEN_DE_COMPRA)/10 AS CANTIDAD_MAXIMA
FROM facturas F
INNER JOIN
items_facturas IFa
on F.NUMERO = IFa.NUMERO
inner join
tabla_de_clientes TC
on TC.dni = F.DNI
GROUP BY F.DNI, TC.NOMBRE, DATE_FORMAT(F.FECHA_VENTA, '%m - %Y')) A;

/*-Informe de ventas por sabor
Nos pidieron de gerencia en el cual nos piden las ventas realizadas por sabor en el año 2016,
el total de ventas realizadas por sabor. Quieren saber la cantidad de litros y el porcentaje de 
participación de estas ventas en orden descendente, o sea de mayor a menor.
-*/
SELECT P.SABOR, IFa.CANTIDAD, F.FECHA_VENTA FROM
tabla_de_productos P
INNER JOIN
items_facturas IFa
ON P.CODIGO_DEL_PRODUCTO = IFa.CODIGO_DEL_PRODUCTO
INNER JOIN
facturas F
ON F.NUMERO = IFa.NUMERO;

# CANTIDAD VENDIDA POR SABOR AÑO 2016
SELECT P.SABOR, SUM(IFa.CANTIDAD) AS CANTIDAD_TOTAL, YEAR(F.FECHA_VENTA) AS AÑO FROM tabla_de_productos P
INNER JOIN
items_facturas IFa
ON P.CODIGO_DEL_PRODUCTO = IFa.CODIGO_DEL_PRODUCTO
INNER JOIN 
facturas F
ON F.NUMERO = IFa.NUMERO
WHERE YEAR(F.FECHA_VENTA) = 2016
GROUP BY P.SABOR, YEAR(F.FECHA_VENTA)
ORDER BY SUM(IFa.CANTIDAD) DESC;

SELECT SUM(IFa.CANTIDAD) AS CANTIDAD_TOTAL, YEAR(F.FECHA_VENTA) AS AÑO FROM tabla_de_productos P
INNER JOIN
items_facturas IFa
ON P.CODIGO_DEL_PRODUCTO = IFa.CODIGO_DEL_PRODUCTO
INNER JOIN 
facturas F
ON F.NUMERO = IFa.NUMERO
WHERE YEAR(F.FECHA_VENTA) = 2016
GROUP BY YEAR(F.FECHA_VENTA);

# CANTIDAD VENDIDA POR SABOR AÑO 2016
SELECT * FROM (
SELECT P.SABOR, SUM(IFa.CANTIDAD) AS CANITDAD_TOTAL, YEAR(F.FECHA_VENTA) AS AÑO FROM tabla_de_productos P
INNER JOIN
items_facturas IFa
ON P.CODIGO_DEL_PRODUCTO = IFa.CODIGO_DEL_PRODUCTO
INNER JOIN 
facturas F
ON F.NUMERO = IFa.NUMERO
WHERE YEAR(F.FECHA_VENTA) = 2016
GROUP BY P.SABOR, YEAR(F.FECHA_VENTA)
ORDER BY SUM(IFa.CANTIDAD) DESC) VENTAS_SABOR
INNER JOIN (
SELECT SUM(IFa.CANTIDAD) AS CANITDAD_TOTAL, YEAR(F.FECHA_VENTA) AS AÑO FROM tabla_de_productos P
INNER JOIN
items_facturas IFa
ON P.CODIGO_DEL_PRODUCTO = IFa.CODIGO_DEL_PRODUCTO
INNER JOIN 
facturas F
ON F.NUMERO = IFa.NUMERO
WHERE YEAR(F.FECHA_VENTA) = 2016
GROUP BY YEAR(F.FECHA_VENTA)) VENTA_TOTAL
ON VENTA_TOTAL.AÑO = VENTAS_SABOR.AÑO;

SELECT VENTAS_SABOR.SABOR, VENTAS_SABOR.AÑO, VENTAS_SABOR.CANTIDAD_TOTAL,
ROUND((VENTAS_SABOR.CANTIDAD_TOTAL/VENTA_TOTAL.CANTIDAD_TOTAL)*100,2) AS PORCENTAJE
FROM (
SELECT P.SABOR, SUM(IFa.CANTIDAD) AS CANTIDAD_TOTAL, YEAR(F.FECHA_VENTA) AS AÑO FROM tabla_de_productos P
INNER JOIN
items_facturas IFa
ON P.CODIGO_DEL_PRODUCTO = IFa.CODIGO_DEL_PRODUCTO
INNER JOIN 
facturas F
ON F.NUMERO = IFa.NUMERO
WHERE YEAR(F.FECHA_VENTA) = 2016
GROUP BY P.SABOR, YEAR(F.FECHA_VENTA)
ORDER BY SUM(IFa.CANTIDAD) DESC) VENTAS_SABOR
INNER JOIN 
(
SELECT SUM(IFa.CANTIDAD) AS CANTIDAD_TOTAL, YEAR(F.FECHA_VENTA) AS AÑO FROM tabla_de_productos P
INNER JOIN
items_facturas IFa
ON P.CODIGO_DEL_PRODUCTO = IFa.CODIGO_DEL_PRODUCTO
INNER JOIN 
facturas F
ON F.NUMERO = IFa.NUMERO
WHERE YEAR(F.FECHA_VENTA) = 2016
GROUP BY YEAR(F.FECHA_VENTA)) VENTA_TOTAL
ON VENTA_TOTAL.AÑO = VENTAS_SABOR.AÑO
ORDER BY VENTAS_SABOR.CANTIDAD_TOTAL DESC; 
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- Colocamos en práctica nuestro conocimiento generando dos informes conforme a lo especificado por la gerencia de la empresa de jugo de frutas.