-- ADMINISTRACIÓN DE MYSQL: SEGURIDAD Y OPTIMIZACIÓN DE LA BASE DE DATOS - PARTE 2

-- 01.Plan de ejecución
/*-Plan de ejecución || Visualizando el plan de ejecución-*/
# explain format=json ******* \G;
# cost 3.75
select A.CODIGO_DEL_PRODUCTO from tabla_de_productos A;

# cost 60654.92
select A.CODIGO_DEL_PRODUCTO, C.CANTIDAD from tabla_de_productos A
inner join items_facturas C 
on A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO;

# cost 211939.80
select A.CODIGO_DEL_PRODUCTO, YEAR(FECHA_VENTA) as ANO, C.CANTIDAD from tabla_de_productos A
inner join items_facturas C 
on A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO
inner join facturas B
on C.NUMERO = B.NUMERO;

# cost 211939.80
select A.CODIGO_DEL_PRODUCTO, YEAR(FECHA_VENTA) AS ANO, SUM(C.CANTIDAD) AS CANTIDAD from tabla_de_productos A
inner join items_facturas C 
on A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO
inner join facturas B
on C.NUMERO = B.NUMERO
group by A.CODIGO_DEL_PRODUCTO, ANO
order by A.CODIGO_DEL_PRODUCTO, ANO;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A identificar un plan de ejecución.
-- Cómo analizar el plan de ejecución.
-- Visualizar el plan de ejecución.





-- 02.Indices
/*-Concepto de índices
				Índices
- Facilita la búsqueda de datos dentro de la tabla. (Diccionario)
- Sin estructura de índices => recorrer toda la tabla hasta encontrar el registro.

Consideraciones sobre MyISAM
- Modificación en la tabla original => Todos los índices se actualizan.
- Muchos índices => Más tiempo de ejecución.

Consideraciones sobre InnoDB
- La tabla viene ordenada automáticamente con la clave primaria.
- Mejor desempeño en las consultas buscando a través de clave primaria.
- Costo para hallar registro de campo que no es PK en InnoDB == MyISAM.
-*/

/*-Algoritmo B-Tree
				ÍNDICES
MyISAM
- Crea una estructura separada para índices PK y no PK.
- La columna del índice es ordenada y toma como referencia la posición de la fila de la tabla original.
- Implementa índices HASH y B-TREE.

InnoDB
- La tabla original ya es ordenada con la PK.
- Los índices que no son PK poseen estructuras separadas y toman como referencia el valor de la PK.
- Solo trabaja con B-TREE.

Hash y B-Tree son algoritmos de búsqueda en listas ordenadas.

				B-TREE
Árbol Binario
- Valores a la izquierda del nodo son menores.
- Valores a la derecha del nodo son mayores.
- Hallar 33 - pero no va estar balanceado.

Consideraciones sobre B-TREE
- Balanced - Binary Tree (Nodos distribuídos de forma balanceada)
- +4 Billones de registros en 32 niveles
- Ejemplo: 
				256 512 768
	64 128 192  320 384 448  832 896 960
       ...			...			 ...
-*/

/*-Algoritmo HASH
- Mapea datos grandes de tamaños variables en un tamaño fijo.
- Ejemplo:
ADSNFDJHDAUHVMLRURJGKÇIRTJHNJG.................................101254102200  
KJFDKK.................................................................035215658965  
172666INHFJHDYJLPP9998U8UF............................650002550055  
DF..............................................................................987545854580  

- Cuando abrimos un libro, buscamos en el índice para encontrar la página que deseamos consultar.  
- Criptografía, almacenar contraseñas, entre otros.
-*/

/*-Usando índices-*/
# explain format = json ******* \g;
# cost 8849.05
select * from facturas where fecha_venta = '20170101';

alter table facturas add index(fecha_venta);
# cost 54.05
select * from facturas where fecha_venta = '20170101';

alter table facturas drop index fecha_venta;
# cost 9065.80
select * from facturas where fecha_venta = '20170101';
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A reconocer el concepto de índices.
-- El funcionamiento del algoritmo B-Tree.
-- El funcionamiento del algoritmo Hash.
-- A utilizar índices.





-- 03.Trabajando con índices y Mysqlslap
/*-Utilizando Workbench-*/
# cost 3.75
explain format=json select A.CODIGO_DEL_PRODUCTO from tabla_de_productos A;

# cost 60654.92
select A.CODIGO_DEL_PRODUCTO, C.CANTIDAD from tabla_de_productos A
inner join items_facturas C 
on A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO;

# cost 211939.80
select A.CODIGO_DEL_PRODUCTO, YEAR(FECHA_VENTA) as ANO, C.CANTIDAD from tabla_de_productos A
inner join items_facturas C 
on A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO
inner join facturas B
on C.NUMERO = B.NUMERO;

# cost 211939.80
select A.CODIGO_DEL_PRODUCTO, YEAR(FECHA_VENTA) AS ANO, SUM(C.CANTIDAD) AS CANTIDAD from tabla_de_productos A
inner join items_facturas C 
on A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO
inner join facturas B
on C.NUMERO = B.NUMERO
group by A.CODIGO_DEL_PRODUCTO, ANO
order by A.CODIGO_DEL_PRODUCTO, ANO;

CREATE TABLE `facturas1` (
  `DNI` varchar(11) NOT NULL,
  `MATRICULA` varchar(5) NOT NULL,
  `FECHA_VENTA` date DEFAULT NULL,
  `NUMERO` int NOT NULL,
  `IMPUESTO` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `items_facturas1` (
  `NUMERO` int NOT NULL,
  `CODIGO_DEL_PRODUCTO` varchar(10) NOT NULL,
  `CANTIDAD` int NOT NULL,
  `PRECIO` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tabla_de_productos1` (
  `CODIGO_DEL_PRODUCTO` varchar(10) NOT NULL,
  `NOMBRE_DEL_PRODUCTO` varchar(50) DEFAULT NULL,
  `TAMANO` varchar(10) DEFAULT NULL,
  `SABOR` varchar(20) DEFAULT NULL,
  `ENVASE` varchar(20) DEFAULT NULL,
  `PRECIO_DE_LISTA` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into facturas1 select * from facturas;

insert into items_facturas1 select * from items_facturas;

insert into tabla_de_productos1 select * from tabla_de_productos;

# cost 3.75
explain format=json select A.CODIGO_DEL_PRODUCTO from tabla_de_productos1 A;

# cost 60654.92 -> 727805.42
select A.CODIGO_DEL_PRODUCTO, C.CANTIDAD from tabla_de_productos1 A
inner join items_facturas1 C 
on A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO;

# cost 211939.80 -> 6387835356.57
select A.CODIGO_DEL_PRODUCTO, YEAR(FECHA_VENTA) as ANO, C.CANTIDAD from tabla_de_productos1 A
inner join items_facturas1 C 
on A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO
inner join facturas1 B
on C.NUMERO = B.NUMERO;

# cost 211939.80 -> 6387835356.57
select A.CODIGO_DEL_PRODUCTO, YEAR(FECHA_VENTA) AS ANO, SUM(C.CANTIDAD) AS CANTIDAD from tabla_de_productos1 A
inner join items_facturas1 C 
on A.CODIGO_DEL_PRODUCTO = C.CODIGO_DEL_PRODUCTO
inner join facturas1 B
on C.NUMERO = B.NUMERO
group by A.CODIGO_DEL_PRODUCTO, ANO
order by A.CODIGO_DEL_PRODUCTO, ANO;
# No tener una llave primaria va a perjudicar notablemente el desempeño de las consultas

/*-Mysqlslap-*/
# cost 25.90
select * from facturas where fecha_venta = '20170101';
alter table facturas add index(fecha_venta);
# cost 8866.15
select * from facturas1 where FECHA_VENTA = '20170101';
/*
C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqlslap -uroot -p --concurrency=100 --iterations=10 --create-schema=juegos_ventas --query="SELECT * FROM facturas WHERE FECHA_VENTA='20170101';"
Enter password: ********
Benchmark
        Average number of seconds to run all queries: 0.259 seconds
        Minimum number of seconds to run all queries: 0.078 seconds
        Maximum number of seconds to run all queries: 1.094 seconds
        Number of clients running queries: 100
        Average number of queries per client: 1


C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqlslap -uroot -p --concurrency=100 --iterations=10 --create-schema=juegos_ventas --query="SELECT * FROM facturas1 WHERE FECHA_VENTA='20170101';"
Enter password: ********
Benchmark
        Average number of seconds to run all queries: 2.770 seconds
        Minimum number of seconds to run all queries: 2.328 seconds
        Maximum number of seconds to run all queries: 3.453 seconds
        Number of clients running queries: 100
        Average number of queries per client: 1

C:\Program Files\MySQL\MySQL Server 8.0\bin>
*/
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- Cómo el índice mejora el plan de ejecución.
-- Que las claves primarias y foráneas crean índices y ayudan a mejorar el plan de ejecución.
-- A usar la herramienta mysqlslap para simular conexiones.





-- 04.GESTIÓN DE USUARIOS
/*-Creando usuario administrador
Mediante Administration - Users and Privileges - Add Acount - Establecemos los datos del nuevo usuario,
reemplazamos el % con localhost. Podemos establecer un númeor de queries, el 0 significa ilimitado.
Para Administrative Roles seleccionamos DBA y se seleccionara todo, y por último damos click en apply. 
-*/
# Otra forma
create user 'admin02'@'localhost' identified by 'admin02';

grant all privileges on *.* to 'admin02'@'localhost' with grant option; # *.* signfica todas las bases de datos y las tablas

/*-Creando usuario normal
Mediante Administration - Users and Privileges - Add Acount - Establecemos los datos del nuevo usuario,
reemplazamos el % con localhost. Podemos establecer un númeor de queries, el 0 significa ilimitado.
Para Administrative Roles seleccionamos solo algunos Global Privilegios como
SELECT, UPDATE, INSERT, DELETE, EXECUTE, LOCK TABLES, CREATE TEMPORARY TABLES, etc. El rol será Custom.
-*/
# Otra forma
create user 'user02'@'localhost' identified by 'user02';
grant select, update, insert, delete, execute, lock tables, 
create temporary tables on *.* to 'user02'@'localhost';

/*-Creando usuario para solo lectura-*/
create user 'read01'@'localhost' identified by 'read01';
grant select, execute on *.* to 'read01'@'localhost'; # Solo lectura como por ejemplo en un rol de BI.
/*Se debe tener en cuenta que en a pesar de que el usuario no tenga los privilegios de INSERT, UPDATE y DELETE, 
los comandos que realizan estas ejecuciones en la tabla, que se encuentran al interior del Stored Procedure, serán ejecutados, 
porque la característica EXECUTE se sobrepone a los mismos.*/

/*-Creando usuario para backup-*/
create user 'back01'@'localhost' identified by 'back01'; # identified by '' lo que esta dentro de las comillas es la contraseña
grant select, reload, lock tables, replication client on *.* to 'back01'@'localhost';
# La otra forma es mediante Administration - Users and Privileges
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A crear usuarios administradores y a remover el usuario root.
-- Cómo crear un usuario con privilegios para acceso normal (sin ser administrador).
-- Cómo crear un usuario que solo tiene acceso de lectura a los datos.
-- Cómo crear un usuario que solamente ejecuta backups.
-- A crear los usuarios a través de cajas de diálogo de Workbench y a través de líneas de comando.





-- 05.Gestión de privilegios
/*-Accediendo desde cualquier servidor
Mediante Administration - Users and Privileges - Add Acount - Establecemos los datos del nuevo usuario,
dejamos el % -> Esto significa cualquier IP. Podemos establecer un número de queries, el 0 significa ilimitado, y seleccionar el Rol en Administrative Role.
-*/
# Otra forma
create user 'admingeneric02'@'%' identified by 'admingeneric02';
grant all privileges on *.* to 'admingeneric02'@'%' with grant option;
/*
				Usando "%"
- 192.168.1.% => 192.168.1.0 - 192.168.1.255
- 192.168.1.1__ => 192.168.1.100 - 192.168.1.255
- client__.mycompany.com => clientXY.mycompany.com
*/

/*-Limitando acceso a los esquemas
Mediante Administration - Users and Privileges - Add Acount - Establecemos los datos del user03, dejamos
el % -> Esto significa cualquier IP. Nos vamos a Administrative Roles seleccionamos UPDATE, SELECT, INSERT, LOCK TABLES,
EXECUTE, DELETE, CREATE TEMPORARY TABLES. Luego nos vamos a Schema Privileges - Selected schema - seleccionamos jugos_ventas y apply.
-*/
# Otra forma
create user 'user04'@'%' identified by 'user04';
grant select, insert, update, delete, create temporary tables, lock tables,
execute on jugos_ventas.* to 'user04'@'%';

# Otro ejemplo
create user 'user05'@'%' identified by 'user05';
grant select, insert, update, delete on jugos_ventas.facturas to 'user05'@'%';
grant select on jugos_ventas.tabla_de_vendedores to 'user05'@'%';

/*-Revocando privilegios
Mediante Administration - Users and Privileges - Seleccionamos el usurio - Administrative Roles o Schema Privileges
y Revoke All Privileges.
-*/
# Otra forma
select * from mysql.user;

show grants for 'user02'@'localhost';

revoke all privileges, grant option from 'user02'@'localhost';
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- Cómo limitar el acceso de usuario mediante la dirección IP.
-- A limitar el acceso por base y por tabla.
-- Cómo revocar los privilegios de los usuarios.