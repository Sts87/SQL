-- PROCEDURES SQL: EJECUTANDO CÓDIGO EN MYSQL

use jugos_ventas;

-- 02.STORED PROCEDURES BÁSICO
/*-Conceptos básicos
			Sintaxis básica
CREATE PROCEDURE
<nombre del procedimiento> (parámetros)
BEGIN
DECLARE	<declaración de variables>;
...
<ejecucciones del procedimiento>
...
END;
-*/

USE `jugos_ventas`;
DROP procedure IF EXISTS `no_hace_nada`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `no_hace_nada` ()
BEGIN

END$$

DELIMITER ;

/*-Creando los primeros Stored Procedures
			Sintaxis para nombrar Stored Procedures            
-- Debe tener letras, números, '$' y '_'.
-- Tamaño máximo de 64 caracteres.
-- Nombre debe ser único.
-- Case Sensitive.
-*/
--------------------------------------
USE `jugos_ventas`;
DROP procedure IF EXISTS `hola_mundo`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `hola_mundo` ()
BEGIN
select 'Hola Mundo!!!!';
END$$

DELIMITER ;

call hola_mundo;
--------------------------------------
USE `jugos_ventas`;
DROP procedure IF EXISTS `muestra_numero`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `muestra_numero` ()
BEGIN
select (9+5)*2 as resultado;
END$$

DELIMITER ;
call muestra_numero;
--------------------------------------
USE `jugos_ventas`;
DROP procedure IF EXISTS `concatenar`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `concatenar` ()
BEGIN
select concat('Hola Mundo', ' ', '!!!!') as resultado;
END$$

DELIMITER ;

call concatenar;
--------------------------------------
USE `jugos_ventas`;
DROP procedure IF EXISTS `concatenar_con_comentarios`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `concatenar_con_comentarios` ()
BEGIN
/*
Este es un ejemplo de comentario
al interior de un procedure
*/

-- Así se comenta un stored procedure.
# Así también.
select concat('Hola a todos!!', ' ', 'Este procedure concatena strings');
END$$

DELIMITER ;

call concatenar_con_comentarios;

/*-Alterando y excluyendo Stored Procedures-*/

USE `jugos_ventas`;
DROP procedure IF EXISTS `concatenar_con_comentarios`;

USE `jugos_ventas`;
DROP procedure IF EXISTS `jugos_ventas`.`concatenar_con_comentarios`;
;

DELIMITER $$
USE `jugos_ventas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `concatenar_con_comentarios`()
BEGIN
/*
Este es un ejemplo de comentario
al interior de un procedure
*/

-- Así se comenta un stored procedure.
# Así también.
select concat('Hola a todos!!', ' ', 'Este procedure concatena strings') as resultado;
END$$

DELIMITER ;
;

call concatenar_con_comentarios;
--------------------------------------
USE `jugos_ventas`;
DROP procedure IF EXISTS `concatenar2`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `concatenar2` ()
BEGIN
select concat('Hola ', '¿Cómo estás?') as resultado;
END$$

DELIMITER ;

call concatenar2;
--------------------------------------
/*-Declarando Variables
			Declarando Variables
DECLARE <nombre de la variable> <datetype> DEFAULT <value>;
-- Datatype es obligatorio. Default es opcional.
-- Debe tener letras, números, '$' y '_'. Se pueden declarar varias siempre y cuando sean del mismo tipo.alter
-- Tamaño máximo de 255 caracteres.
-- Nombre debe ser único en el S.P. - Case Sensitive.
-- Si no tiene Default, su valor será NULL.
-- La línea de declaración finaliza con ';'.

			Algunos tipos de variables
-- VARCHAR(n). Caracteres de texto con tamaño máximo de n caracteres.
-- INTEGER. Tipo entero.
-- DECIMAL (p,s). Variable decimal con p dígitos y s casillas decimales.
-- DATE. Para almacenar una fecha.
-- TIMESTAMP. Para almacenar fecha y horario.
-*/

USE `jugos_ventas`;
DROP procedure IF EXISTS `jugos_ventas`.`exhibir_variable`;
;

DELIMITER $$
USE `jugos_ventas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `exhibir_variable`()
BEGIN
declare texto char(20) default 'Hola Mundo!!!!!!!';
select texto;
END$$

DELIMITER ;

call exhibir_variable;
--------------------------------------
USE `jugos_ventas`;
DROP procedure IF EXISTS `declaracion`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `declaracion` ()
BEGIN
declare v varchar(30) default 'caracteres variables';
declare i integer default 564;
declare d decimal (5,3) default 89.765;
declare f date default '2021-01-01';
declare ts timestamp default current_timestamp();
select v;
select i;
select d;
select f;
select ts;
END$$

DELIMITER ;

call declaracion;
--------------------------------------
USE `jugos_ventas`;
DROP procedure IF EXISTS `jugos_ventas`.`sin_declaracion`;
;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `sin_declaracion`()
BEGIN
select texto;
END$$

DELIMITER ;

call sin_declaracion;
/* Nota. Se puede crear un procedimiento sin haberlo declarado; pero nos dará error al ejecutarlo*/
--------------------------------------
USE `jugos_ventas`;
DROP procedure IF EXISTS `atribuir_valores`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `atribuir_valores` ()
BEGIN
declare numero integer default 987;
select numero;
set numero = 324;
select numero;
END$$

DELIMITER ;

call atribuir_valores;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A crear un Stored Procedure (SP) que devuelve un texto;
-- Cómo un SP devuelve un valor en su salida;
-- A utilizar funciones de MySQL y realizar comentarios al interior del SP;
-- Cómo alterar un SP existente;
-- Cómo excluir un SP.





-- 03.INTERACCIONES CON LA BASE DE DATOS
/*-Manipulando la base de datos-*/
INSERT INTO tabla_de_productos (CODIGO_DEL_PRODUCTO,NOMBRE_DEL_PRODUCTO,SABOR,TAMANO,ENVASE,PRECIO_DE_LISTA)
     VALUES ('1001001','Sabor Alpino','Mango','700 ml','Botella',7.50),
         ('1001000','Sabor Alpino','Melón','700 ml','Botella',7.50),
         ('1001002','Sabor Alpino','Guanábana','700 ml','Botella',7.50),
         ('1001003','Sabor Alpino','Mandarina','700 ml','Botella',7.50),
         ('1001004','Sabor Alpino','Banana','700 ml','Botella',7.50),
         ('1001005','Sabor Alpino','Asaí','700 ml','Botella',7.50),
         ('1001006','Sabor Alpino','Mango','1 Litro','Botella',7.50),
         ('1001007','Sabor Alpino','Melón','1 Litro','Botella',7.50),
         ('1001008','Sabor Alpino','Guanábana','1 Litro','Botella',7.50),
         ('1001009','Sabor Alpino','Mandarina','1 Litro','Botella',7.50),
         ('1001010','Sabor Alpino','Banana','1 Litro','Botella',7.50),
         ('1001011','Sabor Alpino','Asaí','1 Litro','Botella',7.50);

SELECT * FROM tabla_de_productos WHERE NOMBRE_DEL_PRODUCTO LIKE 'Sabor Alp%';

UPDATE tabla_de_productos SET PRECIO_DE_LISTA= 5 WHERE NOMBRE_DEL_PRODUCTO LIKE 'Sabor Alp%';

SELECT * FROM tabla_de_productos WHERE NOMBRE_DEL_PRODUCTO LIKE 'Sabor Alp%';

DELETE FROM tabla_de_productos WHERE NOMBRE_DEL_PRODUCTO LIKE 'Sabor Alp%';

SELECT * FROM tabla_de_productos WHERE NOMBRE_DEL_PRODUCTO LIKE 'Sabor Alp%';
--------------------------------------
USE `jugos_ventas`;
DROP procedure IF EXISTS `manipulacion`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `manipulacion` ()
BEGIN
INSERT INTO tabla_de_productos (CODIGO_DEL_PRODUCTO,NOMBRE_DEL_PRODUCTO,SABOR,TAMANO,ENVASE,PRECIO_DE_LISTA)
     VALUES ('1001001','Sabor Alpino','Mango','700 ml','Botella',7.50),
         ('1001000','Sabor Alpino','Melón','700 ml','Botella',7.50),
         ('1001002','Sabor Alpino','Guanábana','700 ml','Botella',7.50),
         ('1001003','Sabor Alpino','Mandarina','700 ml','Botella',7.50),
         ('1001004','Sabor Alpino','Banana','700 ml','Botella',7.50),
         ('1001005','Sabor Alpino','Asaí','700 ml','Botella',7.50),
         ('1001006','Sabor Alpino','Mango','1 Litro','Botella',7.50),
         ('1001007','Sabor Alpino','Melón','1 Litro','Botella',7.50),
         ('1001008','Sabor Alpino','Guanábana','1 Litro','Botella',7.50),
         ('1001009','Sabor Alpino','Mandarina','1 Litro','Botella',7.50),
         ('1001010','Sabor Alpino','Banana','1 Litro','Botella',7.50),
         ('1001011','Sabor Alpino','Asaí','1 Litro','Botella',7.50);

SELECT * FROM tabla_de_productos WHERE NOMBRE_DEL_PRODUCTO LIKE 'Sabor Alp%';

UPDATE tabla_de_productos SET PRECIO_DE_LISTA= 5 WHERE NOMBRE_DEL_PRODUCTO LIKE 'Sabor Alp%';

SELECT * FROM tabla_de_productos WHERE NOMBRE_DEL_PRODUCTO LIKE 'Sabor Alp%';

DELETE FROM tabla_de_productos WHERE NOMBRE_DEL_PRODUCTO LIKE 'Sabor Alp%';

SELECT * FROM tabla_de_productos WHERE NOMBRE_DEL_PRODUCTO LIKE 'Sabor Alp%';
END$$

DELIMITER ;

call manipulacion;
--------------------------------------
USE `jugos_ventas`;
DROP procedure IF EXISTS `incluir_producto`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `incluir_producto` ()
BEGIN
DECLARE vcodigo VARCHAR(20) DEFAULT '3003001';
DECLARE vnombre VARCHAR(20) DEFAULT 'Sabor Intenso';
DECLARE vsabor VARCHAR(20) DEFAULT 'Tutti frutti';
DECLARE vtamano VARCHAR(20) DEFAULT '700 ml';
DECLARE venvase VARCHAR(20) DEFAULT 'Botella PET';
DECLARE vprecio DECIMAL(4,2) DEFAULT 7.25;
INSERT INTO tabla_de_productos (CODIGO_DEL_PRODUCTO,NOMBRE_DEL_PRODUCTO,SABOR,TAMANO,ENVASE,PRECIO_DE_LISTA)
     VALUES (vcodigo, vnombre, vsabor, vtamano, venvase, vprecio);
END$$

DELIMITER ;

call incluir_producto;
--------------------------------------
/*-Parámetros-*/
USE `jugos_ventas`;
DROP procedure IF EXISTS `incluir_producto_parametros`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `incluir_producto_parametros` (vcodigo VARCHAR(20), vnombre VARCHAR(20),
vsabor VARCHAR(20), vtamano VARCHAR(20), venvase VARCHAR(20), vprecio DECIMAL(4,2)
)
BEGIN
INSERT INTO tabla_de_productos (CODIGO_DEL_PRODUCTO,NOMBRE_DEL_PRODUCTO,SABOR,TAMANO,ENVASE,PRECIO_DE_LISTA)
     VALUES (vcodigo, vnombre, vsabor, vtamano, venvase, vprecio);
END$$

DELIMITER ;

call incluir_producto_parametros ('1000800', 'Sabor del Mar', 'Naranja', '700 ml', 'Botella de Vidrio', 2.25);

select * from tabla_de_productos where CODIGO_DEL_PRODUCTO = '1000800';
--------------------------------------
/*-Control de errores-*/
call incluir_producto_parametros ('1000800', 'Sabor del Mar', 'Naranja', '700 ml', 'Botella de Vidrio', 2.25);

select * from tabla_de_productos where CODIGO_DEL_PRODUCTO = '1000800';

USE `jugos_ventas`;
DROP procedure IF EXISTS `incluir_producto_parametros`;

USE `jugos_ventas`;
DROP procedure IF EXISTS `jugos_ventas`.`incluir_producto_parametros`;
;

DELIMITER $$
USE `jugos_ventas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `incluir_producto_parametros`(vcodigo VARCHAR(20), vnombre VARCHAR(20),
vsabor VARCHAR(20), vtamano VARCHAR(20), venvase VARCHAR(20), vprecio DECIMAL(4,2)
)
BEGIN
DECLARE mensaje varchar(40);
INSERT INTO tabla_de_productos (CODIGO_DEL_PRODUCTO,NOMBRE_DEL_PRODUCTO,SABOR,TAMANO,ENVASE,PRECIO_DE_LISTA)
     VALUES (vcodigo, vnombre, vsabor, vtamano, venvase, vprecio);
SET mensaje = 'Producto incluido con éxito!';
SELECT mensaje;
END$$

DELIMITER ;

call incluir_producto_parametros ('1000801', 'Sabor del Mar', 'Naranja', '700 ml', 'Botella de Vidrio', 3.25);
--------------------------------------
USE `jugos_ventas`;
DROP procedure IF EXISTS `incluir_producto_parametros`;

USE `jugos_ventas`;
DROP procedure IF EXISTS `jugos_ventas`.`incluir_producto_parametros`;
;

DELIMITER $$
USE `jugos_ventas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `incluir_producto_parametros`(vcodigo VARCHAR(20), vnombre VARCHAR(20),
vsabor VARCHAR(20), vtamano VARCHAR(20), venvase VARCHAR(20), vprecio DECIMAL(4,2)
)
BEGIN
DECLARE mensaje varchar(40);
DECLARE EXIT HANDLER FOR 1062
BEGIN
	SET mensaje = 'Producto duplicado! ';
	SELECT mensaje;
END;
INSERT INTO tabla_de_productos (CODIGO_DEL_PRODUCTO,NOMBRE_DEL_PRODUCTO,SABOR,TAMANO,ENVASE,PRECIO_DE_LISTA)
     VALUES (vcodigo, vnombre, vsabor, vtamano, venvase, vprecio);
SET mensaje = 'Producto incluido con éxito!';
SELECT mensaje;
END$$

DELIMITER ;

call incluir_producto_parametros ('1000801', 'Sabor del Mar', 'Naranja', '700 ml', 'Botella de Vidrio', 3.25);
--------------------------------------
/*-Atribución de valor usando SELECT-*/
select * from tabla_de_productos;

USE `jugos_ventas`;
DROP procedure IF EXISTS `mostrar_sabor`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `mostrar_sabor` (vcodigo varchar(15))
BEGIN
DECLARE vsabor VARCHAR(20);
SELECT SABOR INTO vsabor FROM tabla_de_productos WHERE CODIGO_DEL_PRODUCTO = vcodigo;
SELECT vsabor;
END$$

DELIMITER ;

call mostrar_sabor('1101035');
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- Cómo manipular comandos SQL dentro del SP;
-- Cómo ingresar parámetros para un SP;
-- Cómo tratar los errores;
-- La atribución de variables a través de un comando SELECT.





-- 04.CONTROL DE FLUJO
/*-IF THEN ELSE
	IF <condition> THEN
	<if_statements>;
	ELSE
	<else_statements>;
	END IF;
-*/
select * from tabla_de_clientes;

USE `jugos_ventas`;
DROP procedure IF EXISTS `edad_clientes`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `edad_clientes` (vdni varchar(20))
BEGIN
DECLARE vresultado VARCHAR(50);
DECLARE vfecha DATE;
SELECT FECHA_DE_NACIMIENTO INTO vfecha FROM tabla_de_clientes WHERE DNI = vdni;
IF vfecha < '1995-01-01' THEN
SET vresultado = 'Cliente Viejo.';
ELSE
SET vresultado = 'Cliente Joven.';
END IF;
SELECT vresultado;
END$$

DELIMITER ;

call edad_clientes(50534475787);

call edad_clientes(5648641702);
--------------------------------------
/*-IF THEN ELSEIF
			Control de flujo IF THEN ELSE IF
	IF <condition> THEN
	<if_statements>;
	ELSEIF <condition>
	<elseif_statements>;
    (...)
    ELSEIF <condition>
    <elseif_statements>;
    ELSE
    <else_statements>;
	END IF;
-*/
select * from tabla_de_productos;
/*
precio >= 12 producto costoso.
precio >= 7 y precio < 12 producto asequible.
precio < 7 producto barato.
*/
select precio_de_lista from tabla_de_productos 
where CODIGO_DEL_PRODUCTO = '1000800';

USE `jugos_ventas`;
DROP procedure IF EXISTS `precio_producto`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `precio_producto` (vcodigo varchar(20))
BEGIN
DECLARE vresultado VARCHAR(40);
DECLARE vprecio FLOAT;
SELECT precio_de_lista INTO vprecio FROM tabla_de_productos 
WHERE CODIGO_DEL_PRODUCTO = vcodigo;
IF vprecio >=12 THEN
SET vresultado = 'Producto costoso.';
ELSEIF vprecio >= 7 AND vprecio < 12 THEN
SET vresultado = 'Producto asequible.'; 
ELSE
SET vresultado = 'Producto barato.';
END IF;
SELECT vresultado;
END$$

DELIMITER ;

call precio_producto('1000801');

call precio_producto('1013793');

call precio_producto('1096818');
--------------------------------------
/*-CASE END CASE
	CASE <selector>
	WHEN <selector_value_1> THEN <then_stament_1>;
	WHEN <selector_vaue_2> THEN <then_statement_2>;
	(...)
	WHEN <selector_value_n> THEN <then_statement_n>;
	[ELSE <else_statements>]
	END CASE;
-*/
select distinct sabor from tabla_de_productos;
/*
Maracuyá Rico
Limón Rico
Frutilla Rico
Uva Rico
Sandía Normal
Mango Normal
Los demás Comunes
*/
select sabor from tabla_de_productos where CODIGO_DEL_PRODUCTO = '1002767';

USE `jugos_ventas`;
DROP procedure IF EXISTS `define_sabor`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `define_sabor` (vcodigo varchar(20))
BEGIN
DECLARE vsabor VARCHAR(20);
SELECT sabor INTO vsabor FROM tabla_de_productos WHERE CODIGO_DEL_PRODUCTO = vcodigo;
CASE
	WHEN vsabor in ('Maracuyá', 'Limón', 'Frutilla', 'Uva')
		THEN SELECT 'Muy Rico';
	WHEN vsabor in ('Sandía', 'Mango')
		THEN SELECT 'Normal';
	ELSE SELECT 'Jugos comunes';
END CASE;
END$$

DELIMITER ;

call define_sabor('1002767');

call define_sabor('544931');

call define_sabor('243083');

call define_sabor('1096818');
--------------------------------------
/*-CASE NOT FOUND-*/
USE `jugos_ventas`;
DROP procedure IF EXISTS `define_sabor_con_error`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `define_sabor_con_error` (vcodigo VARCHAR(20))
BEGIN
DECLARE vsabor VARCHAR(20);
SELECT sabor INTO vsabor FROM tabla_de_productos WHERE CODIGO_DEL_PRODUCTO = vcodigo;
CASE
	WHEN vsabor in ('Maracuyá', 'Limón', 'Frutilla', 'Uva')
		THEN SELECT 'Muy Rico';
	WHEN vsabor in ('Sandía', 'Mango')
		THEN SELECT 'Normal';
END CASE;
END$$

DELIMITER ;

select sabor, codigo_del_producto from tabla_de_productos;

call define_sabor_con_error('1000800');
--------------------------------------
USE `jugos_ventas`;
DROP procedure IF EXISTS `define_sabor_con_error`;

USE `jugos_ventas`;
DROP procedure IF EXISTS `jugos_ventas`.`define_sabor_con_error`;
;

DELIMITER $$
USE `jugos_ventas`$$	
CREATE DEFINER=`root`@`localhost` PROCEDURE `define_sabor_con_error`(vcodigo VARCHAR(20))
BEGIN
DECLARE vsabor VARCHAR(20);
DECLARE mensajeerror VARCHAR(50);
DECLARE CONTINUE HANDLER FOR 1339
SET mensajeerror = 'Sabor no definido en ningún caso';
SELECT sabor INTO vsabor FROM tabla_de_productos WHERE CODIGO_DEL_PRODUCTO = vcodigo;
CASE
	WHEN vsabor in ('Maracuyá', 'Limón', 'Frutilla', 'Uva')
		THEN SELECT 'Muy Rico';
	WHEN vsabor in ('Sandía', 'Mango')
		THEN SELECT 'Normal';
END CASE;
SELECT mensajeerror;
END$$

DELIMITER ;

call define_sabor_con_error('1000800');
--------------------------------------
/*-CASE condicional-*/
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `precio_producto_case`(vcodigo varchar(20))
BEGIN
DECLARE vresultado VARCHAR(40);
DECLARE vprecio FLOAT;
SELECT precio_de_lista INTO vprecio FROM tabla_de_productos 
WHERE CODIGO_DEL_PRODUCTO = vcodigo;
CASE
	WHEN vprecio >= 12 THEN SET vresultado = 'Producto costoso.';
	WHEN vprecio >= 7 AND vprecio < 12 THEN SET vresultado = 'Producto asequible.';
    WHEN vprecio < 7 THEN SET vresultado = 'Producto barato.';
END CASE;
SELECT vresultado;
END $$

DELIMITER ;

call precio_producto_case('1000801');

call precio_producto_case('1013793');

call precio_producto_case('1096818');
--------------------------------------
/*-Looping
			Control de flujo WHILE
	WHILE <condition>
	DO <statements>;
	END WHILE;
-*/
create table tb_looping (ID int);
select * from  tb_looping;

USE `jugos_ventas`;
DROP procedure IF EXISTS `looping`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `looping` (vinicial INT, vfinal INT)
BEGIN
DECLARE	vcontador INT;
DELETE FROM tb_looping;
SET vcontador = vinicial;
WHILE vcontador <= vfinal
DO
INSERT INTO tb_looping values(vcontador);
SET vcontador = vcontador+1;
END WHILE;
SELECT * FROM tb_looping;
END$$

DELIMITER ;

call looping(1,10);
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- El control de flujo IF-THEN-ELSE;
-- Una variante del comando anterior llamada IF-THEN-ELSEIF;
-- La estructura CASE;
-- Cómo tratar los errores del comando CASE cuando no todas las opciones son contempladas en el mismo;
-- A utilizar el CASE condicional, semejante al IF-THEN-ELSEIF;
-- El uso de Loops para repetir un conjunto de comandos hasta que una condición sea satisfecha.





-- 05.CURSOR Y FUNCIÓN
/*-Problema con SELECT INTO-*/
USE `jugos_ventas`;
DROP procedure IF EXISTS `problema_de_select_into`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `problema_de_select_into` ()
BEGIN
DECLARE vnombre VARCHAR(50);
SELECT NOMBRE INTO vnombre FROM tabla_de_clientes;
SELECT vnombre;
END$$

DELIMITER ;

call problema_de_select_into;
--------------------------------------
/*-Definición de CURSOR-*/
-- Un Cursor es una estructura implementada en MySQL que permite la interacción línea por línea mediante un orden determinado.

-- Fases para uso del Cursor

-- Declaración: Definir la consulta que será depositada en el cursor.
-- Abertura: Abrimos el cursor para recorrerlo una línea a la vez.
-- Recorrido: Línea por línea hasta el final.
-- Cierre: Cerramos	el cursor.
-- Limpiar: Limpia el cursor de la memoria.

USE `jugos_ventas`;
DROP procedure IF EXISTS `cursor_1`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `cursor_1` ()
BEGIN
DECLARE vnombre VARCHAR(50);
DECLARE c CURSOR FOR SELECT NOMBRE FROM tabla_de_clientes LIMIT 4;
OPEN c;
FETCH c INTO vnombre;
SELECT vnombre;
FETCH c INTO vnombre;
SELECT vnombre;
FETCH c INTO vnombre;
SELECT vnombre;
FETCH c INTO vnombre;
SELECT vnombre;
CLOSE c;
END$$

DELIMITER ;

call cursor_1;

select nombre from tabla_de_clientes limit 4;
--------------------------------------
/*-Looping con CURSOR-*/
USE `jugos_ventas`;
DROP procedure IF EXISTS `cursor_looping`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `cursor_looping` ()
BEGIN
DECLARE	fin_c INT DEFAULT 0;
DECLARE vnombre VARCHAR(50);
DECLARE c CURSOR FOR SELECT NOMBRE FROM tabla_de_clientes;
DECLARE CONTINUE HANDLER FOR NOT FOUND
SET fin_c = 1;
OPEN c;
WHILE fin_c = 0
DO
FETCH c INTO vnombre;
IF fin_c = 0
THEN SELECT vnombre;
END IF;
END WHILE;
CLOSE c;
END$$

DELIMITER ;

call cursor_looping;

select nombre from tabla_de_clientes;
--------------------------------------
/*-CURSOR accediendo a más de un campo-*/
select * from tabla_de_clientes;

USE `jugos_ventas`;
DROP procedure IF EXISTS `cursor_looping_varios_campos`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE PROCEDURE `cursor_looping_varios_campos` ()
BEGIN
DECLARE fin_c INT DEFAULT 0;
DECLARE vbarrio, vciudad, vestado, vcp VARCHAR(50);
DECLARE vnombre, vdireccion VARCHAR(150);
DECLARE c CURSOR FOR SELECT NOMBRE, DIRECCION_1, BARRIO, CIUDAD, ESTADO, CP FROM tabla_de_clientes;
DECLARE CONTINUE HANDLER FOR NOT FOUND
SET fin_c = 1;
OPEN c;
WHILE fin_c = 0
DO
FETCH c INTO vnombre, vdireccion, vbarrio, vciudad, vestado, vcp;
IF fin_c = 0
THEN SELECT CONCAT(vnombre, ' Dirección: ', vdireccion, ' Barrio: ', vbarrio, ' - ', vciudad, ' - ', vestado, ' - ', vcp) AS RESULTADO;
END IF;
END WHILE;
CLOSE c;
END$$

DELIMITER ;

call cursor_looping_varios_campos();
--------------------------------------
/*-Funciones
	CREATE FUNCTION function_name(parameters)
	RETURNS datatype;
	BEGIN
	DECLARE <declare_statement>;
	(...)
	<executable_statement>;
	(...)
	RETURN <statement>;
	(...)
	END;
-*/
set global log_bin_trust_function_creators = 1;
-- (Normalmente la instalación de MySQL no permite que el usuario cree funciones por defecto.)

USE `jugos_ventas`;
DROP function IF EXISTS `f_define_sabor`;

DELIMITER $$
USE `jugos_ventas`$$
CREATE FUNCTION `f_define_sabor` (vsabor VARCHAR(40))
RETURNS VARCHAR(40)
BEGIN
DECLARE vretorno VARCHAR(40) DEFAULT '';
CASE vsabor
WHEN 'Maracuyá' THEN SET vretorno = 'Muy Rico';
WHEN 'Limón' THEN SET vretorno = 'Muy Rico';
WHEN 'Frutilla' THEN SET vretorno = 'Muy Rico';
WHEN 'Uva' THEN SET vretorno = 'Muy Rico';
WHEN 'Sandía' THEN SET vretorno = 'Normal';
WHEN 'Mango' THEN SET vretorno = 'Normal';
ELSE SET vretorno = 'Jugos comunes';
END CASE;
RETURN vretorno;
END$$

DELIMITER ;

select f_define_sabor('Maracuyá');

select nombre_del_producto, sabor, f_define_sabor(sabor) as tipo from tabla_de_productos;

select nombre_del_producto, sabor from tabla_de_productos
where f_define_sabor(sabor) = 'Muy rico';
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A conocer la estructura de CURSOR que permite atribuir valores resultantes de un SELECT con múltiples líneas;
-- Vimos que podemos atribuir al CURSOR más de una columna;
-- A usar el CURSOR en conjunto con un ciclo de lazo (Loop);
-- Cómo crear y utilizar una función.
