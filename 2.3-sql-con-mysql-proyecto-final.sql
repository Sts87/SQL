-- SQL CON MYSQL:PROYECTO FINAL

/*
--------------------------------------------------------------------------------------------------------
 La idea es generar una aplicación práctica que nos permita crear una venta ficticia colocando
 al interior de un stored procedure los siguientes parámetros como son fecha, el número máximo
 de items que pueden ir en esta venta y el número máximo de productos que se pueden vender de cada ítem.
 
La idea es generar un cliente de forma aleatoria, un vendedor de forma aleatoria para colocarlos 
en el encabezado de nuestra factura y de la misma forma generar códigos de productos de forma aleatoria
y cantidades aleatorias para insertarlos a los items que se estarán vendiendo a través de esta negociación.
--------------------------------------------------------------------------------------------------------
*/

-- 01.PROYECTANDO LA BASE DE DATOS
/*-Creando la base de datos #1-*/
create schema empresa;
use empresa;

create table clientes(
DNI varchar(11) not null,
NOMBRE varchar (100) null,
DIRECCION varchar(150),
BARRIO varchar(50),
CIUDAD varchar(50),
ESTADO varchar(10),
CP varchar(10),
FECHA_NACIMIENTO date,
EDAD smallint,
SEXO varchar(1),
LIMITE_CREDITO float,
VOLUMEN_COMPRA float,
PRIMERA_COMPRA bit,
primary key (DNI)
);

select * from clientes;

CREATE TABLE `empresa`.`vendedores` (
  `MATRICULA` VARCHAR(5) NOT NULL,
  `NOMBRE` VARCHAR(100) NULL,
  `BARRIO` VARCHAR(50) NULL,
  `COMISION` FLOAT NULL,
  `FECHA_ADMISION` DATE NULL,
  `VACACIONES` BIT(1) NULL,
  PRIMARY KEY (`MATRICULA`));
  
  select * from vendedores;
  
CREATE TABLE productos (
CODIGO VARCHAR(10) NOT NULL,
DESCRIPCION VARCHAR(100),
SABOR VARCHAR(50),
TAMANO VARCHAR(50),
ENVASE VARCHAR(50),
PRECIO FLOAT, 
PRIMARY KEY (CODIGO)
);
  
select * from productos;
  
/*-Creando la base de datos #2-*/
CREATE TABLE facturas (
NUMERO VARCHAR(5) NOT NULL,
FECHA DATE,
DNI VARCHAR(11) NOT NULL,
MATRICULA VARCHAR(5) NOT NULL,
IMPUESTO FLOAT,
PRIMARY KEY (NUMERO),
FOREIGN KEY (DNI) REFERENCES clientes(DNI),
FOREIGN KEY (MATRICULA) REFERENCES vendedores(MATRICULA)
);
  
select * from facturas;
  
CREATE TABLE items (
NUMERO VARCHAR(5) NOT NULL,
CODIGO VARCHAR(10) NOT NULL,
CANTIDAD INT,
PRECIO FLOAT,
PRIMARY KEY (NUMERO, CODIGO),
FOREIGN KEY (NUMERO) REFERENCES facturas(NUMERO),
FOREIGN KEY (CODIGO) REFERENCES productos(CODIGO)
);
  
select * from items;
  
/*-Insertando registros #1-*/
INSERT INTO clientes VALUES ('3623344710', 'Marcos Rosas', 'Av. Universidad', 
'Del Valle', 'Ciudad de México', 'EM', '22002012', '1995-01-13', 26, 'M', 110000, 220000, 1);

select * from clientes;

INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('9283760794', 'Edson Calisaya', 'Sta Úrsula Xitla', 'Barrio del Niño Jesús', 'Ciudad de México', 'EM', '22002002', '1995-01-07', 25, 'M', 150000, 250000, 1);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('7771579779', 'Marcelo Perez', 'F.C. de Cuernavaca 13', 'Carola', 'Ciudad de México', 'EM', '88202912', '1992-01-25', 29, 'M', 120000, 200000, 1);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('5576228758', 'Patricia Olivera', 'Pachuca 75', 'Condesa', 'Ciudad de México', 'EM', '88192029', '1995-01-14', 25, 'F', 70000, 160000, 1);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('8502682733', 'Luis Silva', 'Prol. 16 de Septiembre 1156', 'Contadero', 'Ciudad de México', 'EM', '82122020', '1995-01-07', 25, 'M', 110000, 190000, 0);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('1471156710', 'Erica Carvajo', 'Heriberto Frías 1107', 'Del Valle', 'Ciudad de México', 'EM', '80012212', '1990-01-01', 30, 'F', 170000, 245000, 0);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('2600586709', 'Raúl Meneses', 'Estudiantes 89', 'Centro', 'Ciudad de México', 'EM', '22002012', '1999-08-13', 21, 'M', 120000, 210000, 1);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('50534475787', 'Abel Pintos', 'Carr. México-Toluca 1499', 'Cuajimalpa', 'Ciudad de México', 'EM', '22000212', '1995-01-11', 25, 'M', 170000, 260000, 0);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('5840119709', 'Gabriel Roca', 'Eje Central Lázaro Cárdenas 911', 'Del Valle', 'Ciudad de México', 'EM', '80010221', '1985-01-16', 36, 'M', 140000, 210000, 1);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('8719655770', 'Carlos Santivañez', 'Calz. del Hueso 363', 'Floresta Coyoacán', 'Ciudad de México', 'EM', '81192002', '1983-01-20', 37, 'M', 200000, 240000, 0);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('19290992743', 'Rodrigo Villa', 'Libertadores 65', 'Héroes', 'Ciudad de México', 'EM', '21002020', '1998-05-30', 22, 'M', 120000, 220000, 0);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('5648641702', 'Paolo Mendez', 'Martires de Tacubaya 65', 'Héroes de Padierna', 'Ciudad de México', 'EM', '21002020', '1991-01-30', 29, 'M', 120000, 220000, 0);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('492472718', 'Jorge Castro', 'Federal México-Toluca 5690', 'Locaxco', 'Ciudad de México', 'EM', '22012002', '1994-01-19', 26, 'M', 75000, 95000, 1);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('9275760794', 'Alberto Rodriguez', 'Circunvalación Oblatos 690', 'Oblatos', 'Guadalajara', 'JC', '44700000', '1991-12-28', 26, 'M', 75000, 95000, 1);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('94387575700', 'María Jimenez', 'Av. Libertadores 457', 'Barragán Hernández', 'Guadalajara', 'JC', '44469000', '1995-05-13', 26, 'F', 120000, 300000, 1);
INSERT INTO CLIENTES (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('95939180787', 'Ximena Gómez', 'Jaguares 822', 'Alcalde Barranquitas', 'Guadalajara', 'JC',	'44270000', '1992-01-05', 16, 'F', 90000, 18000, 0);

select * from clientes;

INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('773912', 'Clean', '1 Litro', 'Naranja', 'Botella PET', 8.01);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('838819', 'Clean', '1,5 Litros', 'Naranja', 'Botella PET', 12.01);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1037797', 'Clean', '2 Litros', 'Naranja', 'Botella PET', 16.01);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('812829', 'Clean', '350 ml', 'Naranja', 'Lata', 2.81);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('479745', 'Clean', '470 ml', 'Naranja', 'Botella de Vidrio', 3.77);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('695594', 'Festival de Sabores', '1,5 Litros', 'Asaí', 'Botella PET', 28.51);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('243083', 'Festival de Sabores', '1,5 Litros', 'Maracuyá', 'Botella PET', 10.51);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1022450', 'Festival de Sabores', '2 Litros', 'Asái', 'Botella PET', 38.01);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('231776', 'Festival de Sabores', '700 ml', 'Asaí', 'Botella de Vidrio', 13.31);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('723457', 'Festival de Sabores', '700 ml', 'Maracuyá', 'Botella de Vidrio', 4.91);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('746596', 'Light', '1,5 Litros', 'Sandía', 'Botella PET', 19.51);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1040107', 'Light', '350 ml', 'Sandía', 'Lata', 4.56);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1002334', 'Línea Citrus', '1 Litro', 'Lima/Limón', 'Botella PET', 7);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1088126', 'Línea Citrus', '1 Litro', 'Limón', 'Botella PET', 7);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1041119', 'Línea Citrus', '700 ml', 'Lima/Limón', 'Botella de Vidrio', 4.9);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1042712', 'Línea Citrus', '700 ml', 'Limón', 'Botella de Vidrio', 4.9);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('520380', 'Pedazos de Frutas', '1 Litro', 'Manzana', 'Botella PET', 12.01);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('788975', 'Pedazos de Frutas', '1,5 Litros', 'Manzana', 'Botella PET', 18.01);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('229900', 'Pedazos de Frutas', '350 ml', 'Manzana', 'Lata', 4.21);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1101035', 'Refrescante', '1 Litro', 'Frutilla/Limón', 'Botella PET', 9.01);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1086543', 'Refrescante', '1 Litro', 'Mango', 'Botella PET', 11.01);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('326779', 'Refrescante', '1,5 Litros', 'Mango', 'Botella PET', 16.51);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('826490', 'Refrescante', '700 ml', 'Frutilla/Limón', 'Botella de Vidrio', 6.31);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1096818', 'Refrescante', '700 ml', 'Mango', 'Botella de Vidrio', 7.71);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('394479', 'Sabor da Montaña', '700 ml', 'Cereza', 'Botella de Vidrio', 8.41);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('783663', 'Sabor da Montaña', '700 ml', 'Frutilla', 'Botella de Vidrio', 7.71);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1000889', 'Sabor da Montaña', '700 ml', 'Uva', 'Botella de Vidrio', 6.31);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('544931', 'Verano', '350 ml', 'Limón', 'Lata', 2.46);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('235653', 'Verano', '350 ml', 'Mango', 'Lata', 3.86);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1051518', 'Verano', '470 ml', 'Limón', 'Botella de Vidrio', 3.3);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1078680', 'Verano', '470 ml', 'Mango', 'Botella de Vidrio', 5.18);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1004327', 'Vida del Campo', '1,5 Litros', 'Sandía', 'Botella PET', 19.51);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1013793', 'Vida del Campo', '2 Litros', 'Cereza/Manzana', 'Botella PET', 24.01);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('290478', 'Vida del Campo', '350 ml', 'Sandía', 'Lata', 4.56);
INSERT INTO PRODUCTOS (CODIGO, DESCRIPCION, TAMANO, SABOR, ENVASE, PRECIO) VALUES ('1002767', 'Vida del Campo', '700 ml', 'Cereza/Manzana', 'Botella de Vidrio', 8.41);

select * from productos;

INSERT VENDEDORES (MATRICULA, NOMBRE, COMISION, FECHA_ADMISION, VACACIONES, BARRIO) VALUES ('00235','Miguel Pavón Silva',0.08,'2014-08-15', 0,'Condesa');
INSERT VENDEDORES (MATRICULA, NOMBRE, COMISION, FECHA_ADMISION, VACACIONES, BARRIO) VALUES ('00236', 'Claudia Morales',0.08,'2013-09-17', 1,'Del Valle');
INSERT VENDEDORES (MATRICULA, NOMBRE, COMISION, FECHA_ADMISION, VACACIONES, BARRIO) VALUES ('00237', 'Concepción Martinez',0.11,'2017-03-18', 1,'Contadero');
INSERT VENDEDORES (MATRICULA, NOMBRE, COMISION, FECHA_ADMISION, VACACIONES, BARRIO) VALUES ('00238', 'Patricia Sánchez',0.11,'2016-08-21', 0,'Oblatos');

select * from vendedores;

/*-Insertando registros #2-*/
insert into items select NUMERO, CODIGO_DEL_PRODUCTO AS CODIGO, CANTIDAD, PRECIO from jugos_ventas.items_facturas;
insert into facturas select NUMERO, FECHA_VENTA AS FECHA, DNI, MATRICULA, IMPUESTO from jugos_ventas.facturas;

select * from facturas F 
inner join items I 
on F.NUMERO = I.NUMERO;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A crear de una base de datos.
-- A crear tablas a través de líneas de script y del asistente de Workbench.
-- A insertar registros en las tablas mediante líneas de comando y realizando la importación desde otra base de datos.
-- A importar datos a través de una carpeta dump.
-- A crear claves primarias y claves foráneas.
-- A generar un diagrama Entidad-Relación.
-- A realizar consultas a la base de datos.
-- A realizar consultas en diversas entidades.





-- 02.FUNCION ALEATORIA
/*-Funcion aleatorio-*/
-- (RAND() * (MAX-MIN+1)) + MIN
select (rand() * (250-20+1))+20 as aleatorio;

select floor((rand() * (250-20+1))+20) as aleatorio;

/*-Función número aleatorio-*/
set global	log_bin_trust_function_creators = 1;

USE `empresa`;
DROP function IF EXISTS `f_aleatorio`;

DELIMITER $$
USE `empresa`$$
CREATE FUNCTION `f_aleatorio` (min INT, max INT)
RETURNS INTEGER
BEGIN
DECLARE vresultado INT;
SELECT floor((rand() * (max-min+1))+min) INTO vresultado;
RETURN vresultado;
END$$

DELIMITER ;

select f_aleatorio(250,20) as resultado;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A trabajar con la función RAND() de MySQL.
-- A generar números aleatorios empleando la función RAND().
-- A crear una función para obtener un número entero de forma aleatoria.





-- 03.FUNCIÓN CLIENTE ALEATORIO
/*-Función cliente aleatorio #1-*//*-Utilizando LIMIT-*/
-- DECLARE vresultado VARCHAR(11);
-- DECLARE vmax INT;
-- DECLARE valeatorio INT;
-- SELECT COUNT(*) INTO vmax FROM clientes;
-- SET valeatorio = f_aleatorio(1, vmax);
-- RETURN vresultado;

select * from clientes;

select * from clientes limit 5;

select * from clientes limit 5,1;

select * from clientes limit 16,1;

/*-Función cliente aleatorio #2-*/
USE `empresa`;
DROP function IF EXISTS `aleatorio`;

DELIMITER $$
USE `empresa`$$
CREATE FUNCTION `f_cliente_aleatorio` ()
RETURNS VARCHAR(11)
BEGIN
DECLARE vresultado VARCHAR(11);
DECLARE vmax INT;
DECLARE valeatorio INT;
SELECT COUNT(*) INTO vmax FROM clientes;
SET valeatorio = f_aleatorio(1, vmax);
SET valeatorio = valeatorio-1;
SELECT DNI INTO vresultado FROM clientes LIMIT valeatorio,1;
RETURN vresultado;
END$$

DELIMITER ;

select f_cliente_aleatorio() as cliente;

/*-Función producto aleatorio-*/
USE `empresa`;
DROP function IF EXISTS `f_producto_aleatorio`;

DELIMITER $$
USE `empresa`$$
CREATE FUNCTION `f_producto_aleatorio` ()
RETURNS VARCHAR(10)
BEGIN
DECLARE vresultado VARCHAR(10);
DECLARE vmax INT;
DECLARE valeatorio INT;
SELECT COUNT(*) INTO vmax FROM productos;
SET valeatorio = f_aleatorio(1,vmax);
SET valeatorio = valeatorio-1;
SELECT CODIGO INTO vresultado FROM productos LIMIT valeatorio,1;
RETURN vresultado;
END$$

DELIMITER ;

select f_producto_aleatorio() as producto;

/*-Función vendedor aleatorio-*/
USE `empresa`;
DROP function IF EXISTS `f_vendedor_aleatorio`;

DELIMITER $$
USE `empresa`$$
CREATE FUNCTION `f_vendedor_aleatorio` ()
RETURNS VARCHAR(5) 
BEGIN
DECLARE vresultado VARCHAR(5);
DECLARE vmax INT;
DECLARE valeatorio INT;
SELECT COUNT(*) INTO vmax FROM vendedores;
SET valeatorio = f_aleatorio(1,vmax);
SET valeatorio = valeatorio-1;
SELECT MATRICULA INTO vresultado FROM vendedores LIMIT valeatorio,1;
RETURN vresultado;
END$$

DELIMITER ;

select f_vendedor_aleatorio() as vendedor;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A crear una función para obtener un registro de una tabla de forma aleatoria.
-- A trabajar con el comando LIMIT para seleccionar un registro en específico.





-- 04.GENERANDO VENTAS Y PROBLEMA CON PK
/*-Inluyendo venta #1-*/
select f_cliente_aleatorio() as CLIENTE,
f_producto_aleatorio() as PRODUCTO,
f_vendedor_aleatorio() as VENDEDOR;

/*-Inluyendo venta #2-*/
SELECT MAX(NUMERO) FROM facturas;

USE `empresa`;
DROP procedure IF EXISTS `sp_venta`;

DELIMITER $$
USE `empresa`$$
CREATE PROCEDURE `sp_venta`(fecha DATE, maxitems INT, maxcantidad INT)
BEGIN
DECLARE vcliente VARCHAR(11);
DECLARE vproducto VARCHAR(10);
DECLARE vvendedor VARCHAR(5);
DECLARE vcantidad INT;
DECLARE vprecio FLOAT;
DECLARE vitems INT;
DECLARE vnfactura INT;
DECLARE vcontador INT DEFAULT 1;
SELECT MAX(NUMERO) + 1 INTO vnfactura FROM facturas;
SET vcliente = f_cliente_aleatorio();
SET vvendedor = f_vendedor_aleatorio();
INSERT INTO facturas (NUMERO, FECHA, DNI, MATRICULA, IMPUESTO) VALUES (vnfactura, fecha, vcliente, vvendedor, 0.16);
SET vitems = f_aleatorio(1, maxitems);
WHILE vcontador <= vitems
DO
SET vproducto = f_producto_aleatorio();
SET vcantidad = f_aleatorio(1,maxcantidad);
SELECT PRECIO INTO vprecio FROM productos WHERE CODIGO = vproducto;
INSERT INTO items(NUMERO, CODIGO, CANTIDAD, PRECIO) VALUES(vnfactura, vproducto, vcantidad, vprecio);
SET vcontador = vcontador + 1;
END WHILE;
END$$

DELIMITER ;

call sp_venta('20210619', 15, 100);

/*-Solucionando problema de PK-*/
select max(numero) from facturas;

select count(*) from facturas;

select numero from facturas order by numero desc limit 88000;

CREATE TABLE facturas (
NUMERO INT NOT NULL,
FECHA DATE,
DNI VARCHAR(11) NOT NULL,
MATRICULA VARCHAR(5) NOT NULL,
IMPUESTO FLOAT,
PRIMARY KEY (NUMERO),
FOREIGN KEY (DNI) REFERENCES clientes(DNI),
FOREIGN KEY (MATRICULA) REFERENCES vendedores(MATRICULA)
);
  
CREATE TABLE items (
NUMERO INT NOT NULL,
CODIGO VARCHAR(10) NOT NULL,
CANTIDAD INT,
PRECIO FLOAT,
PRIMARY KEY (NUMERO, CODIGO),
FOREIGN KEY (NUMERO) REFERENCES facturas(NUMERO),
FOREIGN KEY (CODIGO) REFERENCES productos(CODIGO)
);

insert into items select NUMERO, CODIGO_DEL_PRODUCTO AS CODIGO, CANTIDAD, PRECIO from jugos_ventas.items_facturas;
insert into facturas select NUMERO, FECHA_VENTA AS FECHA, DNI, MATRICULA, IMPUESTO from jugos_ventas.facturas;

call sp_venta('20210619', 3, 100);

select max(numero) from facturas;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A crear un Stored Procedure para generar una venta.
-- A utilizar ciclos iterativos con el comando WHILE.
-- A solucionar problemas con la Clave primaria.





-- 05.STORED PROCEDURES Y TRIGGERS
/*-Consulta la facturación-*/
SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS FACTURACION
FROM facturas A
INNER JOIN
items B
ON A.NUMERO = B.NUMERO
WHERE A.FECHA = '20210619'
GROUP BY A.FECHA;

call sp_venta('20210619', 3, 100);

call sp_venta('20210619', 20, 100);

USE `empresa`;
DROP procedure IF EXISTS `sp_venta`;

USE `empresa`;
DROP procedure IF EXISTS `empresa`.`sp_venta`;
;

DELIMITER $$
USE `empresa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_venta`(fecha DATE, maxitems INT, maxcantidad INT)
BEGIN
DECLARE vcliente VARCHAR(11);
DECLARE vproducto VARCHAR(10);
DECLARE vvendedor VARCHAR(5);
DECLARE vcantidad INT;
DECLARE vprecio FLOAT;
DECLARE vitems INT;
DECLARE vnfactura INT;
DECLARE vcontador INT DEFAULT 1;
DECLARE vnumitems INT;
SELECT MAX(NUMERO) + 1 INTO vnfactura FROM facturas;
SET vcliente = f_cliente_aleatorio();
SET vvendedor = f_vendedor_aleatorio();
INSERT INTO facturas (NUMERO, FECHA, DNI, MATRICULA, IMPUESTO) VALUES (vnfactura, fecha, vcliente, vvendedor, 0.16);
SET vitems = f_aleatorio(1, maxitems);
WHILE vcontador <= vitems
DO
SET vproducto = f_producto_aleatorio();
SELECT COUNT(*) INTO vnumitems FROM items 
WHERE CODIGO = vproducto AND NUMERO = vnfactura;
IF vnumitems = 0 THEN
	SET vcantidad = f_aleatorio(1,maxcantidad);
	SELECT PRECIO INTO vprecio FROM productos WHERE CODIGO = vproducto;
	INSERT INTO items(NUMERO, CODIGO, CANTIDAD, PRECIO) VALUES(vnfactura, vproducto, vcantidad, vprecio);
END IF;
SET vcontador = vcontador + 1;
END WHILE;
END$$

DELIMITER ;

call sp_venta('20210619', 100, 100);

/*-Mejorando TRIGGERS-*/
CREATE TABLE facturacion(
FECHA DATE NULL,
VENTA_TOTAL FLOAT
);

DELIMITER //
CREATE TRIGGER TG_FACTURACION_INSERT 
AFTER INSERT ON items
FOR EACH ROW BEGIN
  DELETE FROM facturacion;
  INSERT INTO facturacion
  SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
  FROM facturas A
  INNER JOIN
  items B
  ON A.NUMERO = B.NUMERO
  GROUP BY A.FECHA;
END //

DELIMITER //
CREATE TRIGGER TG_FACTURACION_DELETE
AFTER DELETE ON items
FOR EACH ROW BEGIN
  DELETE FROM facturacion;
  INSERT INTO facturacion
  SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
  FROM facturas A
  INNER JOIN
  items B
  ON A.NUMERO = B.NUMERO
  GROUP BY A.FECHA;
END //

DELIMITER //
CREATE TRIGGER TG_FACTURACION_UPDATE
AFTER UPDATE ON items
FOR EACH ROW BEGIN
  DELETE FROM facturacion;
  INSERT INTO facturacion
  SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
  FROM facturas A
  INNER JOIN
  items B
  ON A.NUMERO = B.NUMERO
  GROUP BY A.FECHA;
END //

select * from facturacion;

call sp_venta('20210622', 15, 100);

select * from facturacion where fecha = '20210622';

USE `empresa`;
DROP procedure IF EXISTS `sp_triggers`;

DELIMITER $$
USE `empresa`$$
CREATE PROCEDURE `sp_triggers` ()
BEGIN
DELETE FROM facturacion;
INSERT INTO facturacion
SELECT A.FECHA, SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
FROM facturas A
INNER JOIN
items B
ON A.NUMERO = B.NUMERO
GROUP BY A.FECHA;
END$$

DELIMITER ;

DROP TRIGGER TG_FACTURACION_INSERT;
DROP TRIGGER TG_FACTURACION_UPDATE;
DROP TRIGGER TG_FACTURACION_DELETE;

DELIMITER //
CREATE TRIGGER TG_FACTURACION_INSERT 
AFTER INSERT ON items
FOR EACH ROW BEGIN
  CALL sp_triggers;
END //

DELIMITER //
CREATE TRIGGER TG_FACTURACION_DELETE
AFTER DELETE ON items
FOR EACH ROW BEGIN
  CALL sp_triggers;
END //

DELIMITER //
CREATE TRIGGER TG_FACTURACION_UPDATE
AFTER UPDATE ON items
FOR EACH ROW BEGIN
  CALL sp_triggers;
END //

call sp_venta('20210622', 15, 100);

select * from facturacion where fecha = '20210622';
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A realizar consultas y almacenarlas en tablas auxiliares.
-- A trabajar con TRIGGERS.
-- A mejorar los TRIGGERS empleando Stored Procedures.
