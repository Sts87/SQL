-- COMANDOS DML: MANIPULACIÓN DE DATOS CON MYSQL

use ventas_jugos;

-- 02.CREANDO LA ESTRUCTURA DE LA BASE DE DATOS
/*---------------------Creación de tablas----------------------*/
create table tb_vendedor(
matricula varchar(5) not null,
nombre varchar(100) null,
barrio varchar(50) null,
comision float null,
fecha_admision date null,
vacaciones bit(1) null,
primary key(matricula)
);

create table tb_productos(
codigo varchar(10) not null,
descripcion varchar(100) null,
sabor varchar(50) null,
tamano varchar(50) null,
envase varchar(50) null,
precio_lista float null,
primary key(codigo)
);

create table tb_venta(
numero varchar(5) not null,
fecha date,
dni varchar(11) not null,
matricula varchar(5) not null,
impuesto float,
primary key(numero)
);

create table tb_items_facturas(
numero varchar(5) not null,
codigo varchar(10) not null,
cantidad int,
precio float,
primary key(numero,codigo)
);

/* ----------------Agregación de foreign keys-------------- */
alter table tb_venta add constraint fk_cliente 
foreign key (dni) references tb_cliente(dni);

alter table tb_venta add constraint fk_vendedor 
foreign key (matricula) references tb_vendedor(matricula);

alter table tb_items_facturas add constraint fk_factura
foreign key (numero) references tb_factura(numero);

alter table tb_items_facturas add constraint fk_producto
foreign key (codigo) references tb_producto(codigo);

/*----Cambio del nombre de la tabla tb_venta a tb_factura-------*/
alter table tb_venta rename tb_factura;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- Aprendimos a crear una base de datos;
-- Aprendimos a crear una tabla;
-- La posibilidad de crear las tablas por un asistente;
-- Vimos cómo crear las relaciones entre las tablas;
-- Vimos que el nombre de la tabla también puede ser modificado tras su creación.





-- 03.INCLUYENDO DATOS EN LAS TABLAS
/* Incluyendo datos */
/*-------------Insertar valores en tabla producto---------------------*/
insert into tb_producto (codigo, descripcion, sabor, tamano, envase, precio_lista)
values (
'1040107', 'Light', 'Sandia', '350 ml', 'Lata', 4.56
);
insert into tb_producto (codigo, descripcion, sabor, tamano, envase, precio_lista)
values (
'1040108', 'Light', 'Guanabana', '350 ml', 'Lata', 4.00
);
insert into tb_producto values 
('1040109', 'Light', 'Asaí', '350 ml', 'Lata', 5.60),
('1040110', 'Light', 'Manzana', '350 ml', 'Lata', 6.00),
('1040111', 'Light', 'Mango', '350 ml', 'Lata', 3.50);

/* Incluyendo multilples registros */
/*-------------Insertar valores en tabla producto desde otra BD---------------------*/
insert into tb_producto
select 
CODIGO_DEL_PRODUCTO as codigo, 
NOMBRE_DEL_PRODUCTO as descripcion,
sabor,
tamano,
ENVASE,
PRECIO_DE_LISTA as precio_lista
from jugos_ventas.tabla_de_productos
where CODIGO_DEL_PRODUCTO not in (select codigo from tb_producto);

/*-------------Insertar valores en tabla cliente desde otra BD---------------------*/
insert into tb_cliente 
select 
dni,
nombre,
DIRECCION_1 as direccion,
BARRIO,
CIUDAD,
ESTADO,
CP,
FECHA_DE_NACIMIENTO as fecha_nacimiento,
EDAD,
SEXO,
LIMITE_DE_CREDITO as limite_credito,
VOLUMEN_DE_COMPRA as volumen_compra,
PRIMERA_COMPRA
from jugos_ventas.tabla_de_clientes
where dni not in (select dni from tb_cliente);

/* Importando datos de archivos externos */
/*-------------Insertar valores en tabla vendedor---------------------*/
select * from tb_vendedor;
/* Se inserto los datos con un archivo CSV */
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- Aprendimos a incluir datos en una tabla, a través de comandos;
-- Vimos la inclusión de varios registros en un único comando;
-- Fue mostrado cómo incluir datos en la tabla a través de un asistente;
-- Mostramos cómo incluir datos usando un archivo externo.





-- 04.ALTERANDO Y EXCLUYENDO DATOS EXISTENTES EN LAS TABLAS
/* Incluyendo datos */
/*-------------Actualizar datos de la tabla producto-----------------------------*/
update tb_producto
set precio_lista = 5
where codigo = '1000889';

update tb_producto
set descripcion = 'Sabor de la Montaña',
tamano = '1 Litro', envase = 'Botella PET'
where codigo = '1000889';

/*-------------Actualizar datos de la tabla cliente-----------------------------*/
update tb_cliente
set volumen_compra = volumen_compra / 10;  /*Afecta toda la columna volumen_compra*/

/* Usando UPDATE con FROM */
/*-------------Actualizar datos en la tabla vendedor - Vacaciones---------------------*/
update tb_vendedor a
inner join 
jugos_ventas.tabla_de_vendedores b
on a.matricula = substring(b.matricula,3,3)
set a.vacaciones = b.vacaciones;

/* Excluyendo datos de la tabla */
/*-------------Eliminar datos de la tabla cliente-----------------------------*/
INSERT INTO tb_producto (CODIGO,DESCRIPCION,SABOR,TAMANO,ENVASE,PRECIO_LISTA)
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

delete from tb_producto
where codigo = '1001000';

delete from tb_producto
where tamano = '1 Litro';

SELECT * FROM tb_producto WHERE DESCRIPCION = 'Sabor Alpino';
select codigo_del_producto from jugos_ventas.tabla_de_productos;
 
select codigo from tb_producto 
where codigo not in (select 
codigo_del_producto from jugos_ventas.tabla_de_productos);

delete from tb_producto
where codigo not in (select 
codigo_del_producto from jugos_ventas.tabla_de_productos);

/* Alterando y borrando toda la tabla */
/*-------Crear tabla producto2, actualizar precio_lista y eliminar todos los registros-------*/
CREATE TABLE `tb_producto2` (
  `codigo` varchar(10) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `sabor` varchar(50) DEFAULT NULL,
  `tamano` varchar(50) DEFAULT NULL,
  `envase` varchar(50) DEFAULT NULL,
  `precio_lista` float DEFAULT NULL,
  PRIMARY KEY (`codigo`)
);

insert into tb_producto2 select * from tb_producto;
update tb_producto2 set precio_lista = precio_lista*1.15;

delete from tb_producto2;

/* COMMIT y ROLLBACK */
/*-------Insertar datos en tabla vendedor, uso de start transaction : commit | rollback-------*/
INSERT INTO `ventas_jugos`.`tb_vendedor`
(`matricula`,
`nombre`,
`barrio`,
`comision`,
`fecha_admision`,
`vacaciones`)
VALUES
('256',
'Fernando Ruiz',
'Oblatos',
0.1,
'2015-05-14',
0);

select * from tb_vendedor;

start transaction;
INSERT INTO `ventas_jugos`.`tb_vendedor`
(`matricula`,
`nombre`,
`barrio`,
`comision`,
`fecha_admision`,
`vacaciones`)
VALUES
('257',
'Fernando Rojas',
'Oblatos',
0.1,
'2015-06-14',
0),
('258',
'David Rojas',
'Del Valle',
0.15,
'2015-06-14',
0);

update tb_vendedor set comision = comision * 1.05;

rollback;

commit;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A alterar y a excluir datos de una tabla, a través de comando o en lotes;
-- Vimos que podemos alterar o excluir todos los datos de una tabla;
-- Lo que es una transacción y como podemos deshacer modificaciones efectuadas anteriormente en la base de datos.





-- 05.AUTOINCREMENTO, PATRONES Y TRIGGERS
/* Comando AUTO_INCREMENT */
/*-------Crear tabla identificacion, usar auto_increment, insertar y eliminar registros-------*/
create table tb_identificacion(
id int not null auto_increment,
descripcion varchar(50) null,
primary key(id)
);

select * from tb_identificacion;

insert into tb_identificacion (descripcion)
values('Cliente A');

insert into tb_identificacion (descripcion)
values('Cliente B');
insert into tb_identificacion (descripcion)
values('Cliente C');
insert into tb_identificacion (descripcion)
values('Cliente D');
insert into tb_identificacion (descripcion)
values('Cliente E');
insert into tb_identificacion(DESCRIPCION)
values ('Cliente F');

delete from tb_identificacion where ID= 6;
insert into tb_identificacion(ID, DESCRIPCION)
values (100, 'Cliente G');
insert into tb_identificacion(ID, DESCRIPCION)
values (NULL, 'Cliente I');

/* Definiendo patrones para campos */
/*-------Crear tabla default, usar auto_increment, usar default, insertar y eliminar registros-------*/
create table tb_default(
id int auto_increment,
descripcion varchar(50) not null,
direccion varchar(100) null,
ciudad varchar(50) default 'Monterrey',
fecha_creacion timestamp default current_timestamp(),
primary key (id)
);

insert into tb_default (descripcion, direccion, ciudad, fecha_creacion)
values ('Cliente X', 'Calle Sol, 525', 'Cancún', '2021-01-01');

select * from tb_default;

insert into tb_default (descripcion)
values ('Cliente Y');

/* TRIGGERS #1
	
    CREATE
		[DEFINIR = user]
        TRIGGER trigger_name
        trigger_time trigger_event
        ON tbl_name FOR EACH ROW
        [trigger_order]
        trigger_body
        
	trigger_time: { BEFORE | AFTER }
    trigger_event: { INSERT | UPDATE | DELETE }
    trigger_order: { FOLLOWS | PRECEDES } other_trigger_name
*/
/*-------Crear tabla facturacion, factura 1 y items facturas 1 e insertar registros-------*/
create table tb_facturacion(
fecha date null,
venta_total float
);

select * from tb_facturacion;

CREATE TABLE `tb_factura1` (
  `numero` varchar(5) NOT NULL,
  `fecha` date DEFAULT NULL,
  `dni` varchar(11) NOT NULL,
  `matricula` varchar(5) NOT NULL,
  `impuesto` float DEFAULT NULL,
  PRIMARY KEY (`numero`),
  KEY `fk_cliente1` (`dni`),
  KEY `fk_vendedor1` (`matricula`),
  CONSTRAINT `fk_cliente1` FOREIGN KEY (`dni`) REFERENCES `tb_cliente` (`dni`),
  CONSTRAINT `fk_vendedor1` FOREIGN KEY (`matricula`) REFERENCES `tb_vendedor` (`matricula`)
);

CREATE TABLE `tb_items_facturas1` (
  `numero` varchar(5) NOT NULL,
  `codigo` varchar(10) NOT NULL,
  `cantidad` int DEFAULT NULL,
  `precio` float DEFAULT NULL,
  PRIMARY KEY (`numero`,`codigo`),
  KEY `fk_producto1` (`codigo`),
  CONSTRAINT `fk_factura1` FOREIGN KEY (`numero`) REFERENCES `tb_factura1` (`numero`),
  CONSTRAINT `fk_producto1` FOREIGN KEY (`codigo`) REFERENCES `tb_producto` (`codigo`)
);

select * from tb_items_facturas1;

select * from tb_factura1;

insert into tb_factura1
values ('0100', '2021-01-01', '1471156710', '235', 0.10);

insert into tb_items_facturas1
values ('0100', '1002767', 100, 25),
('0100', '1004327', 200, 25),
('0100', '1013793', 300, 25);

select a.fecha, sum(b.cantidad * b.precio) as venta_total from tb_factura1 a
inner join 
tb_items_facturas1 b
on a.numero = b.numero
group by a.fecha;

insert into tb_factura1
values ('0101', '2021-01-01', '1471156710', '235', 0.10);
insert into tb_items_facturas1
values ('0101', '1002767', 100, 25),
('0101', '1004327', 200, 25),
('0101', '1013793', 300, 25);

insert into tb_factura1
values ('0102', '2021-01-01', '1471156710', '235', 0.10);
insert into tb_items_facturas1
values ('0102', '1002767', 200, 25),
('0102', '1004327', 300, 25),
('0102', '1013793', 400, 25);

/* TRIGGERS #2 - continuación
 
	 CREATE
		[DEFINIR = user]
        TRIGGER trigger_name
        trigger_time trigger_event
        ON tbl_name FOR EACH ROW
        [trigger_order]
        trigger_body
        
	trigger_time: { BEFORE | AFTER }
    trigger_event: { INSERT | UPDATE | DELETE }
    trigger_order: { FOLLOWS | PRECEDES } other_trigger_name
*/
/*-------Crear trigger facturacion para insert e insertar registros-------*/
delimiter //
create trigger tg_facturacion_insert
after insert on tb_items_facturas1
for each row begin
	delete from tb_facturacion;
	insert into tb_facturacion
	select a.fecha, sum(b.cantidad * b.precio) as venta_total from tb_factura1 a
	inner join 
	tb_items_facturas1 b
	on a.numero = b.numero
	group by a.fecha;
end //

insert into tb_factura1
values ('0103', '2021-01-01', '1471156710', '235', 0.10);
insert into tb_items_facturas1
values ('0103', '1002767', 200, 25),
('0103', '1004327', 300, 25),
('0103', '1013793', 400, 25);

select * from tb_facturacion;

insert into tb_factura1
values ('0104', '2021-01-01', '1471156710', '235', 0.10);
insert into tb_items_facturas1
values ('0104', '1002767', 200, 25),
('0104', '1004327', 400, 30),
('0104', '1013793', 500, 25);

/* TRIGGERS con UPDATE y DELETE
 
	 CREATE
		[DEFINIR = user]
        TRIGGER trigger_name
        trigger_time trigger_event
        ON tbl_name FOR EACH ROW
        [trigger_order]
        trigger_body
        
	trigger_time: { BEFORE | AFTER }
    trigger_event: { INSERT | UPDATE | DELETE }
    trigger_order: { FOLLOWS | PRECEDES } other_trigger_name
*/
select * from tb_facturacion;
select * from tb_factura1;
select * from tb_items_facturas1;

update tb_items_facturas1 set cantidad = 600
where numero = '0101' and codigo = '1002767';

delete from tb_items_facturas1
where numero = '0104' and codigo = '1004327';

/*-------Crear trigger facturacion para delete-------*/
delimiter //
create trigger tg_facturacion_delete
after delete on tb_items_facturas1
for each row begin
	delete from tb_facturacion;
	insert into tb_facturacion
	select a.fecha, sum(b.cantidad * b.precio) as venta_total from tb_factura1 a
	inner join 
	tb_items_facturas1 b
	on a.numero = b.numero
	group by a.fecha;
end //

/*-------Crear trigger facturacion para update-------*/	
delimiter //
create trigger tg_facturacion_update
after update on tb_items_facturas1
for each row begin
	delete from tb_facturacion;
	insert into tb_facturacion
	select a.fecha, sum(b.cantidad * b.precio) as venta_total from tb_factura1 a
	inner join 
	tb_items_facturas1 b
	on a.numero = b.numero
	group by a.fecha;
end //

update tb_items_facturas1 set cantidad = 800
where numero = '0101' and codigo = '1002767';

delete from tb_items_facturas1
where numero = '0104' and codigo = '1013793';

/* Nota: Esta no es la forma más práctica ni recomendable de trabajar con triggers.
Los comandos dentro del trigger (como DELETE FROM tb_facturación y el INSERT) normalmente se manejan 
mediante stored procedures.*/

/*----------------------------------------------------------------------------*/
-- MANIPULACIÓN DE DATOS
-- 
-- - Stored Procedures.
-- 
-- - Herramientas ETL del mercado: Informatica, Pentaho, Power Center,
--   SAP Data Services, SQL SERVER Information Services, (...).
-- 
-- - Programación: Python, Java, PHP, .NET, (...).
/*----------------------------------------------------------------------------*/
-- Lo que aprendimos:

-- Vimos cómo funcionan los campos de autoincremento;
-- Aprendimos a determinar valores por defecto para los campos;
-- Fue mostrado cómo trabajar con TRIGGERs para ejecutar comandos al momento de la inclusión, modificación y exclusión de registros.
