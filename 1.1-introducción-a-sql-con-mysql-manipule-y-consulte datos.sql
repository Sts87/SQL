-- INTRODUCCIÓN A SQL CON MYSQL: MANIPULE Y CONSULTE DATOS

-- 01.INSTALANDO Y CONFIGURANDO MYSQL
/*-Historia de SQL
ANSI -> SEQUEL (CRUD)
- Data Definition Lenguage (DDL): Se encarga de manipular todas las estructuras de las bases de datos. Ejm  Create table o drop 
- Data Manipulation Lenguaje (DML): El lenguaje de manipulación de los datos. Ejm select para seleccionar unos datos, insert para insertar datos a las tablas, 
update, que sería actualizar los datos o delete, que sería borrarlos.
- Data Control Language (DCL): Se encarga de la administración en sí de toda la estructura de la base de datos. Ejm la administración de la base de datos, 
la administración de los accesos a usuarios de los logs, es toda la parte de políticas de crecimiento de la base de datos, etc.

Principales Ventajas
- Costo reducido de aprendizaje
- Portabilidad
- Longevidad
- Comunicación
- Libertad de elección

Principales desventajas
- Falta de creatividad
- NoSQL
- Falta de más estructuración de su lenguaje
-*/

/*- Historia de MySQL
- David Axmark, Allan Larsson, Michael Widenius
- Necesidad de interfaz compatible
- Desarrollaron su propia API de consulta y base de datos utilizando C++
- Software libre (Acceso a la comunidad)
- 2008 Sun Microsystems compró MySQL
- 2009 Oracle compró a Sun Microsystems y se quedó con MySQL y con Java

Características
- Servidor robusto: Multi-acess, Data Integrity, Transaction control.
- Portabilidad: Windows/Linux . Acesso de datos usando DotNET, Python, Java, JS, PHP...
- Multi-threads: Facilita la integración con Hardware + Escalabilidad
- Almacenamiento: Prioriza Velocidad/Volumen
- Velocidad: + Rápidos. e-commerce, AWS/BigQuery/Azure tienen instancias de MySQL
- Seguridad: Diversidad de mecanismos.
- Capacidad: Hasta 65000TB
- Aplicabilidad: Internet/desktop/Réplica de servidores
- Logs: Registra todo. Recuperación. Réplica de servidores 
-*/
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- Conocimos un poco sobre la historia de SQL como lenguaje de base de datos relacional.
-- Vimos un poco sobre la historia y características de la base de datos MySQL.
-- Aprendimos a instalar MySQL y Workbench.





-- 02.MANIPULANDO LA BASE DE DATOS
/*-Definiciones
- En toda base de datos hay una entidad más grande, la principal de todas, 
que se llama base de datos, y esta entidad es un repositorio que almacena datos que pueden ser consultados.
- La entidad más importante de la base de datos es la tabla. La tabla está compuesta por los siguientes elementos. 
Las columnas, que para MySQL se conocen como campos, y las filas que en MySQL o en cualquier lenguaje SQL son los registros.

Tipos de campo
- Texto: char, varchar, text...
- Numérico: int, bigint, smallint, float, bool...
- Fecha: date, datetime, timestamp...
 
Para campos
- Definido al momento de su creación
- Número limitado
- No admite datos que no fueron especificados

Para registros:
- Son los datos contenidos en los campos
- Número ilimitado
- Límite máximo dado por la capacidad de almacenamiento disponible en el disco
- Al momento de la creación de la base de datos se pueden establecer políticas de crecimiento

Clave primaria
- No es obligatorio
- Su combinación no se puede repetir en ningún otro registro de la tabla

Clave foránea
- Campo que relaciona las tablas
- Garantiza la integridad de datos

Las tablas pueden ser agrupadas (Esquemas)
- Facilitan la agrupación de tablas por temas

View (Vista)
- Consultas de n tablas al mismo tiempo
- Alto costo de procesamiento

Consulta (Query)
- Unir tablas a través de un join
- Creamos filtros

Procedures (Procedimientos)
- Lógica estructurada con lenguaje nativo del mismo SQL (if, while, for...)
- Podemos crear funciones: 
IF a > 0 THEN
X = y + z
z = INSTR(z + 1)
SELECT * FROM alpha

Trigger (Disparador)
- Avisos automáticos cuando hay algún tipo de cambio en la base de datos o en la tabla
- Ejecuta una función o procedimiento cuando la condición del trigger es satisfecha
-*/

/*-Creando una base de datos-*/
CREATE DATABASE jugos;

USE jugos;

/*-Creando una base de datos usando el asistente-*/
CREATE SCHEMA `jugos2` DEFAULT CHARACTER SET utf8 ;

/*-Eliminando una base de datos-*/
DROP SCHEMA jugos;
DROP SCHEMA jugos2;
# La otra forma es mediante el asistente

/*-MySQL por línea de comando
c:\Program Files\MySQL\MySQL Server 8.0\bin> mysql.exe -h localhost -u root -p
Presionar ENTER y después incluye la contraseña
-*/
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A acceder y navegar por Workbench.
-- A crear una base de datos por líneas de comando en SQL o por el asistente.
-- A borrar una base de datos por líneas de comando en SQL o por el asistente.
-- A acceder a una tabla por líneas de comando o por el asistente.





-- 03.ADMINISTRANDO LAS TABLAS DE LA BASE DE DATOS
/*-Tipos de datos
Números enteros
	Tipo 	Valor en Bytes	Menor valor (signed)	Menor valor (unsigned)	Mayor valor (signed)	Mayor valor (unsigned)
- TINYINT		1				  -128						0					127							255	
- SMALLINT		2				  -32768					0					32767						65535
- MEDIUMINT		3				-8388608					0					8388607						16777215
- INT			4				-2147483648					0					2147483647					4294967285
- BIGINT		8				  -2E63						0					2E63(-1)
*unsigned: Sin signo (+/-) 

Números decimales
Variables
	Tipo	Precisión en Bytes	Tipo
- FLOAT*				4			Simple
- DOUBLE*			8			Doble
*coma flotante
ej. Si declareamos un FLOAT(6,4) e incluímos el número 76.00009 el valor almacenado será 76.0001 

Fijos
		Tipo			Cantidad de dígitos
- DECIMAL o NUMERIC				65
Es un número fijo, si declaramos DECIMAL(5,3) solo podremos almacenar desde -99.999 hasta 99.999

Bit
	Tipo	Cantidad de Bits
- BIT			   64
Ej. BIT(1) puede ser 0 o 1
BIT(3) puede ser 000, 001, 010, 011, 100, 101, 110, 111

Atributos de los campos numéricos
- SIGNED ó UNSIGNED: Con signo o sin signo
- ZEROFILL: Llena los espacios con cero. Ej. INT(5); si almacenamos 54, el campo va a quedar 00054.
- AUTO_INCREMENT: Hay un incremento secuencial. Ej. 1,2,3,4,5,…; 2,4,8,10…
- OUT OF RANGE: Es un error que se presenta cuando los valores se salen de los límites.

Fecha y hora
- DATE: 1000-01-01 hasta 9999-12-31.
- DATETIME: 1000-01-01 00:00:00 hasta 9999-12-31 23:59:59.
- TIMESTAMP: 1970-01-01 00:00:01 UTC hasta 2038-01-19 UTC
- TIME: -838:59:59 y 839:59:59
- YEAR: 1901 hasta 2155 (puede expresarse en formato de 2 o 4 dígitos)

String
- CHAR: Cadena de caracteres con valor fijo de 0 a 255. Ej. CHAR(4) = “aa” -> “••aa”
- VARCHAR: Cadena de caracteres con valor variable de 0 a 255. Ej. VARCHAR(4) = “aa” -> “aa”
- BINARY: Cadena de caracteres con valor fijo de 0 a 255. (Con números binarios - bits)
- VARBINARY: Cadena de caracteres con valor variable de 0 a 255. (Con números binarios - bits)
- BLOB: Binarios largos -> TINYBLOB, MEDIUMBLOB, LONGBLOB.
- TEXT: Texto largo -> TINYTEXT, MEDIUMTEXT, LONGTEXT.
- ENUM: Definir opciones en una lista predefinida -> Talla ENUM(‘pequeño’, ‘medio’, ‘grande’)

Atributos de los campos string
- SET y COLLATE: El tipo de conjunto de caracteres que va a aceptar -> utf-8, utf-16...
	Campos espaciales (GPS)
    - GEOMETRY -> Área
    - LINESTRING -> Línea
    - POINT -> Punto
    - POLYGON -> Área
-*/

/*-Creando la primera tabla
EMPRESA DE JUGOS
Conversando con las personas en el área de registro de clientes, nos dicen que la información más importante para el cliente es 
DNI, nombre completo, dirección, edad, sexo, límite de crédito, volumen mínimo de jugo que puede comprar y si ya hizo la primera compra.
-*/
CREATE DATABASE jugos;

USE jugos;

CREATE TABLE TBCLIENTES(
DNI VARCHAR(20),
NOMBRE VARCHAR(150),
DIRECCION1 VARCHAR(150),
DIRECCION2 VARCHAR(150),
BARRIO VARCHAR(50),
CIUDAD VARCHAR(50),
ESTADO VARCHAR(50),
CP VARCHAR(10),
EDAD SMALLINT,
SEXO VARCHAR(1),
LIMITE_CREDITO FLOAT,
VOLUMEN_COMPRA FLOAT,
PRIMERA_COMPRA BIT(1)
);

/*-Creando la tabla con el asistente-*/
CREATE TABLE `jugos`.`tbproductos` (
  `producto` VARCHAR(20) NULL,
  `nombre` VARCHAR(150) NULL,
  `envase` VARCHAR(50) NULL,
  `volumen` VARCHAR(20) NULL,
  `sabor` VARCHAR(50) NULL,
  `precio` FLOAT NULL);

/*-Eliminando las tablas-*/
CREATE TABLE TBCLIENTES2(
DNI VARCHAR(20),
NOMBRE VARCHAR(150),
DIRECCION1 VARCHAR(150),
DIRECCION2 VARCHAR(150),
BARRIO VARCHAR(50),
CIUDAD VARCHAR(50),
ESTADO VARCHAR(50),
CP VARCHAR(10),
EDAD SMALLINT,
SEXO VARCHAR(1),
LIMITE_CREDITO FLOAT,
VOLUMEN_COMPRA FLOAT,
PRIMERA_COMPRA BIT(1)
);

CREATE TABLE TBCLIENTES3(
DNI VARCHAR(20),
NOMBRE VARCHAR(150),
DIRECCION1 VARCHAR(150),
DIRECCION2 VARCHAR(150),
BARRIO VARCHAR(50),
CIUDAD VARCHAR(50),
ESTADO VARCHAR(50),
CP VARCHAR(10),
EDAD SMALLINT,
SEXO VARCHAR(1),
LIMITE_CREDITO FLOAT,
VOLUMEN_COMPRA FLOAT,
PRIMERA_COMPRA BIT(1)
);

DROP TABLE TBCLIENTES3;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- Los tipos de datos que componen una tabla.
-- A crear una tabla, tanto por líneas de comando como por el asistente.
-- A eliminar una tabla.





-- 04. Mantenimiento de los datos en las tablas
/*-Insertando registros en la tabla-*/
USE jugos;

INSERT INTO tbproductos (
producto, nombre, envase, volumen, sabor, precio) VALUES 
('773912', 'clean', 'botella pet', '1 litro', 'naranja', 8.01);

SELECT * FROM tbproductos;

/*-Insertando varios registros en la tabla-*/
INSERT INTO tbproductos (
producto, nombre, envase, volumen, sabor, precio) VALUES 
('838819', 'clean', 'botella pet', '1.5 litro', 'naranja', 12.01);

INSERT INTO tbproductos (
producto, nombre, envase, volumen, sabor, precio) VALUES 
('1037797', 'clean', 'botella pet', '2 litro', 'naranja', 16.01);

INSERT INTO tbproductos (
producto, nombre, envase, volumen, sabor, precio) VALUES 
('8128292', 'clean', 'lata', '350 ml', 'naranja', 2.81);

select * FROM tbproductos;

/*-Alterando registros-*/
INSERT INTO tbproductos(
producto, nombre, envase, volumen, sabor,
precio) VALUES ('695594', 'Festival de Sabores', 'Botella PET',
'1.5 Litros', 'Asaí', 18.51);

INSERT INTO tbproductos(
producto, nombre, envase, volumen, sabor,
precio) VALUES ('1041119', 'Línea Citrus', 'Botella de Vidrio',
'700 ml', 'Lima', 4.90);

SELECT * FROM tbproductos;

UPDATE tbproductos SET producto = '812829', envase = 'Lata'
WHERE volumen = '350 ml';

UPDATE tbproductos SET precio = 28.51
WHERE producto = '695594';

UPDATE tbproductos SET sabor = 'Lima/Limón', precio = 4.90
WHERE producto = '1041119';

SELECT * FROM tbproductos;

/*-Excluyendo registros-*/
DELETE FROM tbproductos WHERE producto = '773912';

SELECT * FROM tbproductos;

/*-Incluyendo la clave primaria-*/
INSERT INTO tbproductos (
producto, nombre, envase, volumen, sabor, precio) VALUES 
('773912', 'clean', 'botella pet', '1 litro', 'naranja', 8.01);

SELECT * FROM tbproductos;

ALTER TABLE tbproductos ADD PRIMARY KEY (producto);

INSERT INTO tbproductos (
producto, nombre, envase, volumen, sabor, precio) VALUES 
('773912', 'clean', 'botella pet', '1 litro', 'naranja', 8.01);
# Al usar una llave primaria evitamos duplicidad de los datos y mantener la integridad de los datos

/*-Manipulando fechas y campos lógicos-*/
ALTER TABLE tbclientes ADD PRIMARY KEY (DNI);

ALTER TABLE tbclientes ADD COLUMN(FECHA_NACIMIENTO DATE);

INSERT INTO tbclientes (
DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD,
ESTADO, CP, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA,
PRIMERA_COMPRA, FECHA_NACIMIENTO
) VALUES (
'456879548', 'Pedro el Escamoso', 'Calle del Sol, 25' , '', 'Los Laureles', 'CDMX',
'México', '65784', 50, 'M', 1000000, 2000, 0, '1971-05-25'
);

SELECT * FROM tbclientes;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A incluir datos en una tabla, de diversas formas.
-- Vimos cómo cambiar un dato ya existente en la tabla.
-- Vimos cómo eliminar una fila de la tabla.
-- Conocimos la importancia de las claves primarias y el cuidado que debemos tener al crearlas.
-- Aprendimos a manipular campos del tipo lógicos y del tipo fecha.





-- 05.CONSULTANDO DATOS
/*-Incluyendo datos en la tabla-*/
USE jugos;

DROP TABLE tbclientes;

DROP TABLE tbproductos;

CREATE TABLE tbcliente
(DNI VARCHAR (11) ,
NOMBRE VARCHAR (100) ,
DIRECCION1 VARCHAR (150) ,
DIRECCION2 VARCHAR (150) ,
BARRIO VARCHAR (50) ,
CIUDAD VARCHAR (50) ,
ESTADO VARCHAR (4) ,
CP VARCHAR (8) ,
FECHA_NACIMIENTO DATE,
EDAD SMALLINT,
SEXO VARCHAR (1) ,
LIMITE_CREDITO FLOAT ,
VOLUMEN_COMPRA FLOAT ,
PRIMERA_COMPRA BIT );

ALTER TABLE tbcliente ADD PRIMARY KEY (DNI);

CREATE TABLE tbproducto
(PRODUCTO VARCHAR (20) ,
NOMBRE VARCHAR (150) ,
ENVASE VARCHAR (50) ,
TAMANO VARCHAR (50) ,
SABOR VARCHAR (50) ,
PRECIO_LISTA FLOAT);

ALTER TABLE tbproducto ADD PRIMARY KEY (PRODUCTO);

INSERT INTO tbcliente (DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('9283760794', 'Edson Calisaya', 'Sta Úrsula Xitla', '', 'Barrio del Niño Jesús', 'Ciudad de México', 'CDMX', '22002002', '1995-01-07', 25, 'M', 150000, 250000, 1);
INSERT INTO tbcliente (DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('7771579779', 'Marcelo Perez', 'F.C. de Cuernavaca 13', '', 'Carola', 'Ciudad de México', 'CDMX', '88202912', '1992-01-25', 29, 'M', 120000, 200000, 1);
INSERT INTO tbcliente (DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('5576228758', 'Pedro Olivera', 'Pachuca 75', '', 'Condesa', 'Ciudad de México', 'CDMX', '88192029', '1995-01-14', 25, 'F', 70000, 160000, 1);
INSERT INTO tbcliente (DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('8502682733', 'Luis Silva', 'Prol. 16 de Septiembre 1156', '', 'Contadero', 'Ciudad de México', 'CDMX', '82122020', '1995-01-07', 25, 'M', 110000, 190000, 0);
INSERT INTO tbcliente (DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('1471156710', 'Erica Carvajo', 'Heriberto Frías 1107', '', 'Del Valle', 'Ciudad de México', 'CDMX', '80012212', '1990-01-01', 30, 'F', 170000, 245000, 0);
INSERT INTO tbcliente (DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('3623344710', 'Marcos Rosas', 'Av. Universidad', '', 'Del Valle', 'Ciudad de México', 'CDMX', '22002012', '1995-01-13', 26, 'M', 110000, 220000, 1);
INSERT INTO tbcliente (DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('50534475787', 'Abel Pintos', 'Carr. México-Toluca 1499', '', 'Cuajimalpa', 'Ciudad de México', 'CDMX', '22000212', '1995-01-11', 25, 'M', 170000, 260000, 0);
INSERT INTO tbcliente (DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('5840119709', 'Gabriel Roca', 'Eje Central Lázaro Cárdenas 911', '', 'Del Valle', 'Ciudad de México', 'CDMX', '80010221', '1985-01-16', 36, 'M', 140000, 210000, 1);
INSERT INTO tbcliente (DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('94387575700', 'Walter Soruco', 'Calz. de Tlalpan 2980', '', 'Ex Hacienda Coapa', 'Ciudad de México', 'CDMX', '22000201', '1989-01-20', 31, 'M', 60000, 120000, 1);
INSERT INTO tbcliente (DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('8719655770', 'Carlos Santivañez', 'Calz. del Hueso 363', '', 'Floresta Coyoacán', 'Ciudad de México', 'CDMX', '81192002', '1983-01-20', 37, 'M', 200000, 240000, 0);
INSERT INTO tbcliente (DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('5648641702', 'Paolo Mendez', 'Martires de Tacubaya 65', '', 'Héroes de Padierna', 'Ciudad de México', 'CDMX', '21002020', '1991-01-30', 29, 'M', 120000, 220000, 0);
INSERT INTO tbcliente (DNI, NOMBRE, DIRECCION1, DIRECCION2, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) VALUES ('492472718', 'Jorge Castro', 'Federal México-Toluca 5690', '', 'Locaxco', 'Ciudad de México', 'CDMX', '22012002', '1994-01-19', 26, 'M', 75000, 95000, 1);

INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('773912', 'Clean', '1 Litro', 'Naranja', 'Botella PET', 8.01);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('838819', 'Clean', '1,5 Litros', 'Naranja', 'Botella PET', 12.01);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1037797', 'Clean', '2 Litros', 'Naranja', 'Botella PET', 16.01);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('812829', 'Clean', '350 ml', 'Naranja', 'Lata', 2.81);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('479745', 'Clean', '470 ml', 'Naranja', 'Botella de Vidrio', 3.77);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('695594', 'Festival de Sabores', '1,5 Litros', 'Asaí', 'Botella PET', 28.51);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('243083', 'Festival de Sabores', '1,5 Litros', 'Maracuyá', 'Botella PET', 10.51);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1022450', 'Festival de Sabores', '2 Litros', 'Asái', 'Botella PET', 38.01);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('231776', 'Festival de Sabores', '700 ml', 'Asaí', 'Botella de Vidrio', 13.31);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('723457', 'Festival de Sabores', '700 ml', 'Maracuyá', 'Botella de Vidrio', 4.91);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('746596', 'Light', '1,5 Litros', 'Sandía', 'Botella PET', 19.51);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1040107', 'Light', '350 ml', 'Sandía', 'Lata', 4.56);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1002334', 'Línea Citrus', '1 Litro', 'Lima/Limón', 'Botella PET', 7);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1088126', 'Línea Citrus', '1 Litro', 'Limón', 'Botella PET', 7);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1041119', 'Línea Citrus', '700 ml', 'Lima/Limón', 'Botella de Vidrio', 4.9);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1042712', 'Línea Citrus', '700 ml', 'Limón', 'Botella de Vidrio', 4.9);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('520380', 'Pedazos de Frutas', '1 Litro', 'Manzana', 'Botella PET', 12.01);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('788975', 'Pedazos de Frutas', '1,5 Litros', 'Manzana', 'Botella PET', 18.01);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('229900', 'Pedazos de Frutas', '350 ml', 'Manzana', 'Lata', 4.21);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1101035', 'Refrescante', '1 Litro', 'Frutilla/Limón', 'Botella PET', 9.01);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1086543', 'Refrescante', '1 Litro', 'Mango', 'Botella PET', 11.01);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('326779', 'Refrescante', '1,5 Litros', 'Mango', 'Botella PET', 16.51);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('826490', 'Refrescante', '700 ml', 'Frutilla/Limón', 'Botella de Vidrio', 6.31);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1096818', 'Refrescante', '700 ml', 'Mango', 'Botella de Vidrio', 7.71);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('394479', 'Sabor da Montaña', '700 ml', 'Cereza', 'Botella de Vidrio', 8.41);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('783663', 'Sabor da Montaña', '700 ml', 'Frutilla', 'Botella de Vidrio', 7.71);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1000889', 'Sabor da Montaña', '700 ml', 'Uva', 'Botella de Vidrio', 6.31);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('544931', 'Verano', '350 ml', 'Limón', 'Lata', 2.46);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('235653', 'Verano', '350 ml', 'Mango', 'Lata', 3.86);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1051518', 'Verano', '470 ml', 'Limón', 'Botella de Vidrio', 3.3);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1078680', 'Verano', '470 ml', 'Mango', 'Botella de Vidrio', 5.18);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1004327', 'Vida del Campo', '1,5 Litros', 'Sandía', 'Botella PET', 19.51);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1013793', 'Vida del Campo', '2 Litros', 'Cereza/Manzana', 'Botella PET', 24.01);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('290478', 'Vida del Campo', '350 ml', 'Sandía', 'Lata', 4.56);
INSERT INTO tbProducto (PRODUCTO, NOMBRE, TAMANO, SABOR, ENVASE, PRECIO_LISTA) VALUES ('1002767', 'Vida del Campo', '700 ml', 'Cereza/Manzana', 'Botella de Vidrio', 8.41);

SELECT * FROM tbcliente;

SELECT NOMBRE, SEXO, EDAD, DIRECCION1 FROM tbcliente;

SELECT NOMBRE AS Nombre_Completo, SEXO AS Género, EDAD AS Años, DIRECCION1 AS Domicilio FROM tbcliente;

SELECT NOMBRE, SEXO, EDAD, DIRECCION1 FROM tbcliente LIMIT 6;

/*-Filtrando registros-*/
SELECT * FROM tbproducto;

SELECT * FROM tbproducto WHERE SABOR = 'Maracuyá';

SELECT * FROM tbproducto WHERE ENVASE = 'Botella de Vidrio';

UPDATE tbproducto SET SABOR = 'Cítrico' WHERE SABOR = 'Limón';

SELECT * FROM tbproducto WHERE SABOR = 'Limón';

SELECT * FROM tbproducto WHERE SABOR = 'Cítrico';

/*-Filtrando usando mayor que menor que y diferente-*/
SELECT * FROM tbcliente;

SELECT * FROM tbcliente WHERE EDAD > 27;

SELECT * FROM tbcliente WHERE EDAD < 27;

SELECT * FROM tbcliente WHERE EDAD <= 27;

SELECT * FROM tbcliente WHERE EDAD <> 26;

SELECT * FROM tbcliente WHERE NOMBRE > 'Erica Carvajo';

SELECT * FROM tbcliente WHERE NOMBRE <= 'Erica Carvajo';

SELECT * FROM tbproducto;

SELECT * FROM tbproducto WHERE PRECIO_LISTA = 28.51; # No identifica al punto flotante. Cosas de MySQL

SELECT * FROM tbproducto WHERE PRECIO_LISTA > 28.51;

SELECT * FROM tbproducto WHERE PRECIO_LISTA < 28.51;

SELECT * FROM tbproducto WHERE PRECIO_LISTA between 28.49 AND 28.52; # Una forma de traer un float

/*-Filtrando fechas-*/
SELECT * FROM tbcliente;

SELECT * FROM tbcliente WHERE FECHA_NACIMIENTO = '1995-01-13';

SELECT * FROM tbcliente WHERE FECHA_NACIMIENTO < '1995-01-13';

SELECT * FROM tbcliente WHERE FECHA_NACIMIENTO >= '1995-01-13';

SELECT * FROM tbcliente WHERE YEAR(FECHA_NACIMIENTO) = 1995;

SELECT * FROM tbcliente WHERE DAY(FECHA_NACIMIENTO) = 20;

/*-Filtros compuestos-*/
SELECT * FROM tbproducto WHERE ENVASE = 'Lata' OR ENVASE = 'Botella PET';

SELECT * FROM tbproducto WHERE PRECIO_LISTA >= 15 AND PRECIO_LISTA <= 25;

SELECT * FROM tbproducto WHERE (PRECIO_LISTA >= 15 AND PRECIO_LISTA <=25) OR (ENVASE = 'Lata' OR ENVASE = 'Botella PET');

SELECT * FROM tbproducto WHERE (PRECIO_LISTA >= 15 AND TAMANO = '1 Litro') OR (ENVASE = 'Lata' OR ENVASE = 'Botella PET');
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A visualizar los datos de una tabla.
-- A separar la selección de datos.
-- A utilizar las condiciones mayor que y menor que en la selección de datos de la tabla.
-- A filtrar los datos a través de fechas.
-- A implementar filtros compuestos.