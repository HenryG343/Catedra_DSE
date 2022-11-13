use master
create database mersa
use mersa
create table tipo_usuarios(
id_tipo int identity primary key not null,
nombre_tipo varchar(50) not null --Nombre del tipo de usurio
--Administrador
--Empleado
)
insert into tipo_usuarios([nombre_tipo]) values('Administrador'),('Empleado')

create table usuarios_adm(
id_usuario int identity(1,1) primary key not null,
dui varchar(9) unique,
id_tipo int not null foreign key references tipo_usuarios(id_tipo),
nombre varchar(100) not null,
apellidos varchar(100) not null,
contra varchar(8),
)
create table usuarios_trans(
id_transportista int identity(1,1) primary key not null,
dui varchar(9) not null,
nombre varchar(100) not null,
apellidos varchar(100) not null,
placa varchar(10) unique,
)

create table bol(
id_bol int identity(1,1) primary key, --Numero de la serie del registro
fecha date not null, --Fecha en la que se hace el movimiento
tipo_movimiento varchar(25), --Registra si es de Entrada o Salida
id_transportista int not null foreign key references usuarios_trans(id_transportista), --ID del transportista
chofer varchar(250) not null, --Nombre completo del chofer, porque este varia y no se registra en usuarios
nro_documento int not null,--Se va a recuperar del ultimo registro del sistema anterior
placas varchar(10) not null,
zona varchar(50) not null, --Central, Oriente, Occidente, Desecho, Traslados, Chalatenango, Postmix
especial varchar(2) not null, --Registra Si es especial o No
)

create table detalle_bol(
id int identity(1,1) primary key, --Numero de la serie del detalle
id_bol int not null foreign key references bol(id_bol) on delete cascade on update cascade,
modelo varchar(25) not null, --Se guarda en un dataset 
linea varchar(10) not null, --Se guarda en un dataset
serie varchar(25) not null, --Se guarda en un dataset
activo varchar(15) not null, --Codigo de barra escaneado
emo int, --auto incrementable de la programacion
ficha varchar(8), --Se guarda en un dataset
emo_pepsi varchar(10) --Digitado por el usuario
)

create table series_escaneadas(
id_serie int identity(1,1) primary key not null,
id_usuario int not null,
serie varchar(255) not null,
placa varchar(10) not null,
)

create table registros(
emo int,
nro_documento int,
id_bol_reporte int,
)

--DATA DE PRUEBA----------------------------------------------------------------------------------------------------------------/
--Usuarios de prueba para el login
insert into usuarios_adm (dui, id_tipo,nombre,apellidos,contra) values (123456789,1,'Henry','Gutierrez','123'),(123456788,2,'Wilfredo','Acosta','123')
--Usuarios de prueba para la aplicacion movil
insert into usuarios_trans (dui,nombre,apellidos,placa) values(1234578,'Juan','Perez','P-102-253'),(12434578,'Juan','Perez','P-104-253'),(123578,'Carlos','Perez','P-202-253')
insert into registros values(12345,2512,1)
--DATA DE PRUEBA----------------------------------------------------------------------------------------------------------------/

--Consulta Series de SALIDA SAC
select	a.id_serie AS SERIE,
	a.ID_ACTIVO as ACTIVO,
	ISNULL(A.ID_FICHA, ' ') as FICHA,
	B.DESCRIPCION AS MODELO,
	B.LINEA AS LINEA
 from tbl_ACTIVOS a inner join
	tbl_MODELOS b on
	a.id_MODELO = b.id_MODELO where a.id_negocio in ('47223','73600','47233','47215','47231','55269','55830','68090','80247')


--Consulta Series de ENTRADA SAC
select	a.id_serie AS SERIE,
	a.ID_ACTIVO as ACTIVO,
	ISNULL(A.ID_FICHA, ' ') as FICHA,
	B.DESCRIPCION AS MODELO,
	B.LINEA AS LINEA
 from tbl_ACTIVOS a inner join
	tbl_MODELOS b on
	a.id_MODELO = b.id_MODELO where a.id_negocio not in ('47223','73600','47233','47215','47231','55269','55830','68090','80247')