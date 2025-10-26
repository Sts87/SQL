-- ADMINISTRACIÓN DE MYSQL: SEGURIDAD Y OPTIMIZACIÓN DE LA BASE DE DATOS - PARTE 1

-- 01.RECUPERACIÓN DE LA BASE DE DATOS
/*-Recuperando la base de datos-*/
create schema jugos_ventas;
	# Se importa la carpeta DumpJugosventas base de datos por administración. 
use jugos_ventas;
select * from facturas;
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A instalar el servidor MySQL.
-- A recuperar el ambiente que será utilizado en este entrenamiento.





-- 02.PAPEL DEL DBA
/*-Papel del DBA
- ¿Quién es el DBA?
# Profesional responsable de administrar la base de datos
- Funciones
# Evalúa el ambiente. (Hardware necesario para la instalación y mantenimiento de
MySQL de acuerdo con las necesasidades operativas de la empresa)
# Configura accesos a la base de datos de forma segura. (Conexiones/IDE/otras interfaces)
# Mantener la base con buen desempeño. (Saber trabajar con los índices, que mejoran las consultas a la base de datos)
# Almacenar los datos - Realizar Backup de los mismos.
# Apoyar el área de desarrollo con el conocimiento de los datos. Eliminar datos no deseados/ defragmentar la base/entre otros.
# Monitorear la instalación de MySQL. Gestionar recursos usados por la base y adecuarla a las necesidades de los usuários.
# Configurar el ambiente y sus diversas propiedades. (my.ini)
# Administrar usuarios que tendrán acceso a la base: Otorga niveles de acceso a los usuarios.
-*/

/*-Conexiones de MySQL
# MySQL nos permite crear diferentes conexiones y eliminarlas. La información principal para crear conexiones es
Usuario, Servidor, Puerta y Contraseña.
-*/

/*-Servicio de MySQL
# El servicio de MySQL en Windows puede detenerse para hacer mantenimiento al servicio o para modificar 
las variables de entorno en el archivo (my.ini).
# Se puede detener el servicio por consola mediante "net stop mysql80".
-*/
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A crear conexiones y a distribuirlas entre los clientes.
-- A detener y a reiniciar el servicio de MySQL.





-- 03.TUNING Y MECANISMOS DE ALMACENAMIENTO
/*-Tunning de Hardware
			TUNING
- 4 formas de configurar el ambiente de MySQL para hacer el tuning:
- Esquemas, índices, variables internas de MySQL (mysqld) y Hardware/Sistema Operativo.

HARDWARE:
- Trabajar con Sistemas Operativos de 64-bits (MySQL puede  usar vários procesadores en paralelo y puede llegar
a consumir toda la capacidad de memoria de la máquina).

- Configuración de la RAM (Existe un parámetro interno que nos permite indicar el máximo de RAM que nuestros
procesos podrán consumir - Obs: No exceder el 50% de RAM disponible en la máquina).

Ej.
1 DB de 1GB no va consumir más de 8GB de RAM, pero en un ambiente real no habrá solo una conexión ejecutando
operaciones en la base. (Dependiendo de la manera como se utilice la DB, 8GB de RAM será poco).

- Tipo de lectura de disco: Está almacenado en HDD/SSD?
Hoy existen SCSI, SATA, SAS => Mejor desempeño de los HDD

- Uso del controlador de disco RAID(0, 1, 5 y 10). Son empleados para la seguridad de los datos.

- RAID 0: Divide los datos en dos HD diferentes, aunque observamos tan solo 1 drive, el sistema operativo divide 
el dato en los discos.

- RAID 1: Uno de los HD es copia del otro (Lo que se haga en un disco automáticamente se reproduce en el otro).

- RAID 5: Divide los datos en más de dos HD, aunque observamos tan solo 1 drive y el sistema operativo divide 
el dato en todos los discos.
- RAID 10: Los HD tienen espejos (Lo que se haga disco automáticamente se reproduce).

- Aunque RAID 1 y 10  gastan más espacio físico con redundancia, son más seguros porque hay Back-up disponible.
-*/

/*-Variables de ambiente
- Son variables que se declaran afuera del programa para que al momento de su inicialización queden predefinidos diversos parámetros de funcionamiento.

- Existen 250+ variables de ambiente en MYSQL. Sufre modificaciones con cada nueva versión.

- SHOW STATUS muestra los valores actuales de las variables de ambiente.

- 2 tipos: GLOBAL y SESSION. La primera vale para todas las conexiones del entorno MySQL. La última, solamente para la conexión actual.

- my.ini (Linux my.cnf). Dos directivas: [mysqld] y [client]
https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html
-*/
-- El archivo oculto my.ini esta en programData Mysql 8.0
show global status like 'Created_tmp_disk_tables';

show global status like 'Created_tmp_tables';

show global variables like 'tmp_table_size';

set global tmp_table_size = 136700160; # Mientras el servidor este activo aumenta a esa cantidad Mb para la creación de tablas temporales

/*-Mecanismos de almacenamiento
- La forma de almacenar la información en las tablas. (Recursos más exclusivos dentro de la base de datos).
- MySQL 8.0 Community dispone de 9 Mecanismos para almacenar datos en las tablas. (Una misma DB puede usar diversos mecanismos en sus tablas).
- ENGINE: Es el parámetro que indica el mecanismo de almacenamiento empleado en la tabla.
- Los 3 principales engines son: MyISAM, InnoDB y MEMORY.

				MyISAM
- No es transaccional. (No está diseñado para que varios usuarios realicen alteraciones a las tablas simultáneamente).
- Solamente permite el bloqueo a nivel de tabla. (Lectura más rápida)
- Recomendable para tablas que no están cambiando continuamente.
- La clave externa no soporta Full Text.
- Almacena datos de manera más compacta. (Optimiza espacio de almacenamiento).

				MyISAM - Variables de Ambiente
- key_buffer_size: Determina el tamaño de cache para almacenar los índices de MyISAM. Varía de 8MB ~ 4GB de acuerdo con el OS.
- concurrent_insert: Comportamiento de inserciones concurrentes dentro de una tabla MyISAM.
	0 = Inserciones simultáneas desactivadas.
	1 = Inserciones simultáneas sin intervalo de datos (Al mismo tiempo).
	2 = Inserciones simultáneas con intervalo de datos.
- delay_key_write: Atraso entre la actualización de índices y el momento en que se crea la tabla. (Espera a que todos los registros sean insertados para después actualizar los índices).
- max_write_lock_count: Determina el número de grabaciones en las tablas que tendrán precedencia a las lecturas. (Priorizar la cantidad de grabaciones que se realizarán antes de las lecturas en varias conexiones)
- preload_buffer_size: Tamaño del buffer a ser usado antes de cargar los índices de caches de claves de las tablas: 32 KB.
*Observación: El uso de estas variables de ambiente se realizará en la medida que el DBA entienda mejor su ambiente y los mecanismos de MyISAM. Es recomendable utilizar la configuración por defecto al usar el mecanismo MyISAM.

				MyISAM - Aplicaciones
- myisamchk: Analiza, optimiza y repara tablas MyISAM. (Las reconstruye)
- myisampack: Crea tablas MyISAM compactadas que serán usadas solo para lectura. No es posible hacer inserciones a las tablas. (Mejor desempeño para lectura)
- myisam_ftdump: Exhibe información más completa de los campos de tipo texto.
-*/

/*-InnoDB y MEMORY
				InnoDB
- Mecanismo de almacenamiento transaccional más utilizado en MySQL. (Sí está diseñado para que vários
usuarios realicen operaciones en las tablas simultáneamente).
- Soporte transaccional completo / Soporte a claves externas.
- Cache de buffer configurado de forma separada tanto para la base como para el índice.
- Bloqueo de tabla a nivel de línea.
- Indexación BTREE.
- Back-up de DB online - Sin bloqueo.

				InnoDB - Variables de Ambiente
Tablas
- innodb_data_file_path: Determina camino y tamaño máximo del archivo dentro del sistema donde se almacenará la información.
- innodb_data_home_dir: Camino común del directorio de todos los archivos innodb; cuando se especifica, graba todo dentro de ese directorio.
*Default =/mysqldata
- innodb_file_per_table: Separa el almacenamiento de los datos y sus índices. Por defecto almacena datos e índices de forma compartida.

Desempeño
- innodb_buffer_pool_size: Determina tamaño de almacenamiento que innodb va a usar para almacenar índices y datos en cache.
- innodb_flush_log_at_trx_commit: Determina la frecuencia con que el buffer de log-in es habilitado para el disco. Crece con el uso
y después de un lapso es descargado al HD.
- innodb_log_file_size: Tamaño en Bytes con el cual se crearán los archivos log-in. Por defecto es 5MB.

MEMORY
- Mecanismo de almacenamiento que crea tablas en memoria RAM. No en disco.
- No soporta clave externa.
- Acceso muy rápido a la información.
- Los datos necesitan ser reinicializados junto con el servidor.
- Bloqueo a nivel de tabla.
- Índice utiliza HASH por defecto y BTREE.
- Formato de línea de longitud fija. (No soporta BLOB/TEXT)
-*/
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- La importancia de las variables de entorno/ambiente.
-- Cómo modificar las variables de ambiente utilizando Workbench.
-- A distinguir qué son los mecanismos de almacenamiento y los tipos principales, con sus características.





-- 04.USANDO MECANISMOS DE ALMACENAMIENTO Y DIRECTORIOS
/*-Usando mecanismos de almacenamiento-*/
create schema sakila;
use sakila;

create table df_table (
ID INT, 
NOMBRE VARCHAR(100)
); # Por defecto la tabla fue creada con el mecanismo de almacenamiento InnoDB

alter table df_table engine = MyISAM; # Se cambio a MyISAM

create table df_table1 (
ID INT, 
NOMBRE VARCHAR(100)
) engine = MEMORY; # Tipo memory

show engines; # Información de todos los engines
drop database sakila;

/*-Creando la base de datos-*/
create database base;
use base;

CREATE SCHEMA `base2` ; # Pequeña explicación de Charset y Collation

/*-Cambiando el directorio de la base de datos-*/
show variables where variable_name like '%dir';
# Nos vamos a la ubicacion de datadir, si queremos modificar la ruta se hará por my.ini cambiando la ruta a otra carpeta (se recimienda copiar y pegar la carpeta Data para evitar errores).
# Además reiniciamos el servicio de MySQL8.0 y listo. Util cuando no hay más espacio de disco.
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A determinar el mecanismo de almacenamiento al momento de crear las tablas.
-- A alterar el mecanismo de almacenamiento con las tablas creadas.
-- A crear y eliminar bases de datos.
-- A cambiar el directorio donde se almacena la base de datos.





-- 05.BACK-UP DE LA BASE DE DATOS
/*-Back up con mysqldump
- Es una copia de seguridad de la base que se realiza	periodicamente para recuperarla 
en caso de problemas con la base de datos.

BACK-UP LÓGICO
- Exporta todas las estructuras, tablas, rutinas, (...) a un script sql que al ser ejecutado recrea la base de datos.
- Permite la manipulación externa, antes de recuperar la información.
- Es más lento porque se ejecuta comando a comando.

BACK-UP FÍSICO
- Contiene todos los archivos binarios del sistema donde la información está almacenada, pero sin los respectivos comandos.
- Es más rápido que el back-up lógico, pero es menos flexible. (No permite editar tablas y datos antes de su restauración)

mysqldump: Para crear back-ups lógicos
- Sintaxis: mysqldump [options]
- Usuario, contraseña, servidor
- --all-databases indica  que el back-up será completo.
- > <nombre-archivo> muestra el archivo de salida del back-up.
- Si desea incluir stored procedures y eventos usar --routines y --events.
https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html
-*/
/*
C:\Users\camac>cd\

C:\>cd "Program Files"

C:\Program Files>cd MySQL

C:\Program Files\MySQL>cd "MySQL Server 8.0"

C:\Program Files\MySQL\MySQL Server 8.0>cd bin

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump
Usage: mysqldump [OPTIONS] database [tables]
OR    mysqldump [OPTIONS] --databases [OPTIONS] DB1 [DB2 DB3...]
OR    mysqldump [OPTIONS] --all-databases [OPTIONS]
For more options, use mysqldump --help

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -uroot -p --databases jugos_ventas > c:\sql_dba\jugos_ventas_full.sql
Enter password: ********

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -uroot -p --databases jugos_ventas --ignore-table jugos_ventas.facturas > c:\sql_dba\jugos_ventas_sin_facturas.sql 
# Para ignorar una tabla de la base de datos 
Enter password: ********
C:\Program Files\MySQL\MySQL Server 8.0\bin>
*/

/*-Back up con Workbench-*/
lock instance for backup;
# Luego vamos a administration - Data Export - seleccionamos la base de datos - Export to Self-Contained File - finalmente Start Export
# Nota: Tambien se puede exportar en una carpeta. En este caso se seleccionaria EXport to Dump Project Folder
unlock instance;

/*-Back up físico-*/
lock instance for backup;
# Copiamos la carpeta data y el archivo my.ini a una carpeta
unlock instance;
# Recomendable hacer el back up logico como fisico.

/*-Recuperando Back ups-*/
# Eliminamos jugos_ventas
create database jugos_ventas;
/*
C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -uroot -p < c:\sql_dba\jugos_ventas_full.sql
Enter password: *******
C:\Program Files\MySQL\MySQL Server 8.0\bin>
Listo

La otra forma es apagar el servicio de MySQl 8.0, copiar y pegar al directorio de MySQl 8.0
*/
/*-------------------------------------------------------------------*/
-- Lo que aprendimos:

-- A realizar el backup lógico a través de mysqldump.
-- A realizar el backup físico copiando toda la estructura de datos en otro directorio.
-- A recuperar el backup usando MySQL a través del símbolo del sistema o copiando de nuevo la estructura de archivos.