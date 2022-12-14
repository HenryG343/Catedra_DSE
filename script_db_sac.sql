USE [master]
GO
/****** Object:  Database [db_sac]    Script Date: 12/11/2022 18:32:05 ******/
CREATE DATABASE [db_sac]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'db_mersa_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\db_sac.MDF' , SIZE = 1184384KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'db_mersa_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\db_sac_1.LDF' , SIZE = 768KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [db_sac] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [db_sac].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [db_sac] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [db_sac] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [db_sac] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [db_sac] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [db_sac] SET ARITHABORT OFF 
GO
ALTER DATABASE [db_sac] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [db_sac] SET AUTO_SHRINK ON 
GO
ALTER DATABASE [db_sac] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [db_sac] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [db_sac] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [db_sac] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [db_sac] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [db_sac] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [db_sac] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [db_sac] SET  DISABLE_BROKER 
GO
ALTER DATABASE [db_sac] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [db_sac] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [db_sac] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [db_sac] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [db_sac] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [db_sac] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [db_sac] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [db_sac] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [db_sac] SET  MULTI_USER 
GO
ALTER DATABASE [db_sac] SET PAGE_VERIFY NONE  
GO
ALTER DATABASE [db_sac] SET DB_CHAINING OFF 
GO
ALTER DATABASE [db_sac] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [db_sac] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [db_sac] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [db_sac] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'db_sac', N'ON'
GO
ALTER DATABASE [db_sac] SET QUERY_STORE = OFF
GO
USE [db_sac]
GO
/****** Object:  User [user]    Script Date: 12/11/2022 18:32:05 ******/
CREATE USER [user] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[cadena_sin_cero_izquierda]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[cadena_sin_cero_izquierda]
(
@cadena varchar(20)
)
RETURNS varchar(20)
AS
BEGIN
	
	
		declare @longitud int = len(@cadena)
		declare @contador int=1

		declare @letra varchar(1)
		declare @pos_last_cero int =0
		declare @SALIR  BIT =0
		declare @cadena_sin_cero varchar(20)

WHILE (@contador <=@longitud and @SALIR=0)
BEGIN
		set @letra=SUBSTRING(@cadena,@contador,1)
		if @letra='0'
			begin
				 SET @pos_last_cero=@contador
			end
		ELSE
			set @SALIR=1

		set @contador=@contador+1
END

if @contador=@longitud
	set @cadena_sin_cero=''
else
	set @cadena_sin_cero=SUBSTRING(@cadena,@pos_last_cero+1,20 )
	
	return @cadena_sin_cero
	
	
	
END
GO
/****** Object:  UserDefinedFunction [dbo].[Date]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Date](@Year int, @Month int, @Day int)
-- returns a datetime value for the specified year, month and day
-- Thank you to Michael Valentine Jones for this formula (see comments).
returns datetime
as
    begin
    return 	   dateadd(day, @Day-1, dateadd(month, @Month-1, dateadd(year, (@Year-1900),0))) 
    --dateadd(month,((@Year-1900)*12)+@Month-1,@Day-1)
	


    end
GO
/****** Object:  UserDefinedFunction [dbo].[DateMaximun]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
create FUNCTION [dbo].[DateMaximun]
(
	@fecha datetime
)
RETURNS datetime
AS
BEGIN
	
	RETURN dbo.datetime(year(@fecha),month(@fecha),day(@fecha),23,59,59)

END
GO
/****** Object:  UserDefinedFunction [dbo].[DateTime]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[DateTime](@Year int, @Month int, @Day int, @Hour int, @Minute int, @Second int)
-- returns a dateTime value for the date and time specified.
returns datetime
as
    begin
    return dbo.Date(@Year,@Month,@Day) + dbo.Time(@Hour, @Minute,@Second)
    end
GO
/****** Object:  UserDefinedFunction [dbo].[funcion_inventario]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  FUNCTION [dbo].[funcion_inventario]
(
)
RETURNS 
@consulta table(FechaRealizado datetime,actividad varchar(50),Sio varchar(50),serie varchar(50),Ficha varchar(50) ,Modelo varchar(50),	  Activo varchar (50), ID_NEGOCIO int,linea varchar(50),
nombre varchar(50),	departamento varchar(50),	zona_dep varchar(50), viejo int,id_tipo_trabajo int,fechaOT datetime)

AS
BEGIN
	-- Fill the table variable with the rows for your result set



	DECLARE @FECHA_LIMITE DATE='20130430'










	
insert into @consulta 	
select 
	c.fecha_orden_traslado		as FechaRealizado,
	'' AS actividad,
	b.id_alterno  as Sio,
	rtrim (c.id_serie)	as Serie,
	c.id_ficha	as Ficha,
	d.descripcion as Modelo,	
	c.id_activo	as Activo, c.ID_NEGOCIO,
	d.linea,b.nombre,	tbl_departamentos.nombre as departamento,
	tbl_departamentos.zona as zona_dep,c.viejo,tbl_orden_trabajo.id_tipo_trabajo, tbl_orden_trabajo.fecha fechaOT
	
from tbl_activos c inner join
	tbl_negocios b on
	c.id_negocio = b.id_negocio inner join
	tbl_modelos d on
	c.id_modelo = d.id_modelo 
	left join tbl_ubicaciones on b.id_ubicacion=tbl_ubicaciones.id_ubicacion
	left join tbl_departamentos on b.id_departamento=tbl_departamentos.id_departamento
	left join tbl_municipios on b.id_municipio=tbl_municipios.id_municipio
	LEFT JOIN tbl_orden_trabajo On c.id_orden_trabajo=tbl_orden_trabajo.id_orden_trabajo
	
where c.ID_NEGOCIO in( select id_negocio from negocios_consulta where activo=1) and viejo<>1

--'86724','50598','51754','55830','47231','47233','47229','47215','47213','47221','47223','69709','68090','68755','68777','76616','73600','76616','80247','86723','86769')  and viejo<>1
--AND C.ID_SERIE='130115152'

--and c.fecha_orden_traslado  between    '01-05-2013 00:00:00' and '31-12-2040 23:59:59'-- and 
order by b.id_alterno




--update @consulta set actividad='EN TRANCITO' WHERE ID_NEGOCIO=50598 AND viejo<>1
--update @consulta set actividad='BAJA DESECHO MERSA FISICO' WHERE ID_NEGOCIO=51754 AND viejo<>1 and FechaRealizado >@FECHA_LIMITE
--update @consulta set actividad='DISPONIBLE' where id_negocio IN(47231,55830,68090) AND  VIEJO<>1
--update @consulta set actividad='DISPONIBLE EVENTOS' where id_negocio IN(86769) AND  VIEJO<>1
--update @consulta set actividad=  'RECEPCION' WHERE id_negocio IN(47229,47213,47221,46992,68755,68777,69709,76616,86724,      47229,	  68755,	  86723, 47221,      47229,      68755,      86724) AND VIEJO<>1 AND FechaRealizado>@FECHA_LIMITE 
--UPDATE @consulta SET actividad='EQ NUEVO'  WHERE id_negocio IN(47233,47215,47223,73600)  

update @consulta set actividad= (select top(1) info from negocios_consulta where negocios_consulta.id_negocio= [@consulta].id_negocio)



--update @consulta set actividad=  'SEMIDISPONIBLE'  WHERE id_negocio=47230 AND VIEJO<>1 AND FechaRealizado>@FECHA_LIMITE 


--update @consulta set actividad='SEMIDISPONIBLE' WHERE id_tipo_trabajo=14  AND datepart(Year,getdate())=2015 
--update @consulta set actividad=  (case when left(serie,2)='16'  then 'EQ NUEVO' else 'DISPONIBLE' end ) , Ficha =(case when left(serie,2)='16'  then 'EQ NEW' else FICHA end )  WHERE  id_negocio=55269 AND VIEJO<>1 AND FechaRealizado>'20130430'


--SELECT fecha,'RECEPCION' est,sio,negocio,negocio,serie,ficha,modelo,envio,activo,ot_coment,ZONA_DEP FROM pepsi WHERE pepsi.id_negocio IN(47229,47213,47221,46992,68755,68777,69709,76616) AND PEPSI.VIEJO=1 AND fecha>CTOD('30/04/2013') ORDER BY fecha INTO CURSOR taller_rece_1


--select * from @consulta






	
	RETURN 
END
GO
/****** Object:  UserDefinedFunction [dbo].[reporte_movimientos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[reporte_movimientos]
(
	@desde datetime,@hasta datetime
)
RETURNS 
@consulta TABLE 
(
Distribuidora varchar(50),
	Sede varchar(2),
	EMO_EWO int,	
	FechaRealizado datetime,
	Sio varchar(50),
	 Negocio varchar(50),
	Direccion varchar(50),
	Modelo varchar(50),	
	Serie char(20),
	Ficha varchar(25),	
	 Activo varchar(25),
	actividad varchar(50),
	id_opcion_trabajo int,
	Tipo_mov varchar(50),
	total numeric(18,2),
	id_tipo_mov int
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	







	


insert into @consulta

select v.descripcion as Distribuidora,
	v.id_alterno as Sede,
	a.id_orden_traslado as EMO_EWO,	
	h.fecha		as FechaRealizado,
	b.id_alterno  as Sio,
	b.nombre 	as Negocio,
	b.direccion	as Direccion,
	d.descripcion as Modelo,	
	a.id_serie	as Serie,
	a.id_ficha	as Ficha,	
	c.id_activo	as Activo,
	'' AS actividad,
	a.id_opcion_trabajo,
	g.descripcion as Tipo_mov,
	a.valor AS total,a.id_tipo_movimiento
	
from tbl_movimientos a 
LEFT join 	tbl_negocios b on	a.id_negocio = b.id_negocio 
LEFT join	tbl_activos c on
	a.id_serie = c.id_serie LEFT join
	tbl_modelos d on
	c.id_modelo = d.id_modelo left join
	tbl_opciones_trabajo e on
	a.id_opcion_trabajo= e.id_opcion_trabajo  LEFT join
	tbl_tipos f on
	c.id_tipo = f.id_tipo LEFT join
	tbl_tipos_movimiento g on
	a.id_tipo_movimiento = g.id_tipo_movimiento LEFT join
	tbl_traslados h on
	a.id_orden_traslado = h.id_orden_traslado LEFT join
	tbl_marcas i on
	c.id_marca = i.id_marca LEFT join
	tbl_detalle_ingresos j on
	a.id_serie = j.id_serie LEFT join
	tbl_ubicaciones z		on 
             	a.id_ubicacion = z.id_ubicacion LEFT join
	tbl_ubicaciones y on
		z.id_ubicacion_maestra 	= y.id_ubicacion LEFT join
	tbl_ubicaciones v on
		y.id_ubicacion_maestra = v.id_ubicacion LEFT join
	tbl_ubicaciones s on
		v.id_ubicacion_maestra = s.id_ubicacion LEFT join
	tbl_ubicaciones q on
		s.id_ubicacion_maestra = q.id_ubicacion
where a.id_opcion_trabajo in('500')
and	h.fecha between  '01-05-2022 00:00:00' and '31-05-2022 23:59:59' 
--and a.id_ubicacion like('01%')
and	a.id_tipo_movimiento in('1')
  --and	h.id_personal not in('1304','1334')

UNION ALL
-- RETIROS
--DETALLE DE RETIROS DE EQUIPOS
select v.descripcion as Distribuidora,
	v.id_alterno as Sede,
	a.id_orden_traslado as EMO_EWO,	
	h.fecha		as FechaRealizado,
	b.id_alterno  as Sio,
	b.nombre 	as Negocio,
	b.direccion	as Direccion,
	d.descripcion as Modelo,	
	a.id_serie	as Serie,
	a.id_ficha	as Ficha,	
	c.id_activo	as Activo,
	'' AS actividad,
	a.id_opcion_trabajo,
	g.descripcion as Tipo_mov,
	a.valor AS total,a.id_tipo_movimiento
	
from tbl_movimientos a LEFT join
	tbl_negocios b on
	a.id_negocio = b.id_negocio LEFT join
	tbl_activos c on
	a.id_serie = c.id_serie LEFT join
	tbl_modelos d on
	c.id_modelo = d.id_modelo left join
	tbl_opciones_trabajo e on
	a.id_opcion_trabajo= e.id_opcion_trabajo  LEFT join
	tbl_tipos f on
	c.id_tipo = f.id_tipo LEFT join
	tbl_tipos_movimiento g on
	a.id_tipo_movimiento = g.id_tipo_movimiento LEFT join
	tbl_traslados h on
	a.id_orden_traslado = h.id_orden_traslado LEFT join
	tbl_marcas i on
	c.id_marca = i.id_marca LEFT join
	tbl_detalle_ingresos j on
	a.id_serie = j.id_serie LEFT join
	tbl_ubicaciones z		on 
             	b.id_ubicacion = z.id_ubicacion LEFT join
	tbl_ubicaciones y on
		z.id_ubicacion_maestra 	= y.id_ubicacion LEFT join
	tbl_ubicaciones v on
		y.id_ubicacion_maestra = v.id_ubicacion LEFT join
	tbl_ubicaciones s on
		v.id_ubicacion_maestra = s.id_ubicacion LEFT join
	tbl_ubicaciones q on
		s.id_ubicacion_maestra = q.id_ubicacion
where a.id_opcion_trabajo in('500')
and	h.fecha between   '01-05-2022 00:00:00' and '31-05-2022 23:59:59' 
--and b.id_ubicacion like('01%')
and	a.id_tipo_movimiento in('4')
--and	h.id_personal not in('1304','1334')







update @consulta set serie=dbo.cadena_sin_cero_izquierda(serie)


























	RETURN 
END
GO
/****** Object:  UserDefinedFunction [dbo].[Time]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Time](@Hour int, @Minute int, @Second int)
-- Returns a datetime value for the specified time at the "base" date (1/1/1900)
-- Many thanks to MVJ for providing this formula (see comments). 
returns datetime
as
    begin
    return dateadd(ss,(@Hour*3600)+(@Minute*60)+@Second,0)
    end
GO
/****** Object:  Table [dbo].[ABRAHVA]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ABRAHVA](
	[id_negocio] [int] NULL,
	[SIO] [nvarchar](255) NULL,
	[Negocio] [nvarchar](255) NULL,
	[Direccion] [nvarchar](255) NULL,
	[Ruta] [nvarchar](255) NULL,
	[Serie] [nvarchar](255) NULL,
	[Ficha] [nvarchar](255) NULL,
	[Modelo] [nvarchar](255) NULL,
	[Contacto] [nvarchar](255) NULL,
	[Logotipo] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[borrar]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[borrar](
	[id_serie] [char](20) NOT NULL,
	[id_ingreso] [int] NOT NULL,
	[id_negocio] [int] NOT NULL,
	[id_movimiento] [int] NULL,
	[cantidad] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cierre_detalle]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cierre_detalle](
	[pk_cierre_detalle] [int] IDENTITY(1,1) NOT NULL,
	[pk_cierre_main] [int] NULL,
	[esta_en_sac] [bit] NULL,
	[esta_en_xls] [bit] NULL,
	[Comentario] [varchar](500) NULL,
	[id_tipo_movimiento_sac] [int] NULL,
	[id_tipo_movimiento_xls] [int] NULL,
	[id_serie] [char](20) NULL,
 CONSTRAINT [PK_cierre_detalle] PRIMARY KEY CLUSTERED 
(
	[pk_cierre_detalle] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cierre_main]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cierre_main](
	[pk_cierre_main] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [date] NULL,
	[describecierre] [varchar](50) NULL,
	[desde] [date] NULL,
	[hasta] [date] NULL,
 CONSTRAINT [PK_cierre_main] PRIMARY KEY CLUSTERED 
(
	[pk_cierre_main] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[estanenbodega]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[estanenbodega](
	[seriesac] [nvarchar](255) NULL,
	[SERIE] [nvarchar](255) NULL,
	[MODELO] [nvarchar](255) NULL,
	[envio] [nvarchar](255) NULL,
	[comodato] [nvarchar](255) NULL,
	[tipo] [nvarchar](255) NULL,
	[marca] [nvarchar](255) NULL,
	[caracteres] [float] NULL,
	[ceros] [nvarchar](255) NULL,
	[estapdv] [nvarchar](255) NULL,
	[estabodega] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fechas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fechas](
	[EMO] [nvarchar](255) NULL,
	[FECHA] [smalldatetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NEGOCBC]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NEGOCBC](
	[AGENCIA] [float] NULL,
	[EMPRESA] [float] NULL,
	[NEGO] [float] NULL,
	[ALTERNO] [nvarchar](255) NULL,
	[NEGOCIO] [nvarchar](255) NULL,
	[DIRECC] [nvarchar](255) NULL,
	[ZON] [nvarchar](255) NULL,
	[DEP] [float] NULL,
	[MUNI] [float] NULL,
	[UBICACIÓN] [nvarchar](255) NULL,
	[CLASIFICACION] [float] NULL,
	[ETAPA] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[negocios_consulta]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[negocios_consulta](
	[id_negocio_consulta] [int] IDENTITY(1,1) NOT NULL,
	[id_negocio] [int] NULL,
	[activo] [bit] NULL,
	[info] [varchar](50) NULL,
 CONSTRAINT [PK_negocios_consulta] PRIMARY KEY CLUSTERED 
(
	[id_negocio_consulta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nocoincidesap]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nocoincidesap](
	[seriesac] [nvarchar](255) NULL,
	[SERIE_NUM] [float] NULL,
	[Region] [nvarchar](255) NULL,
	[BODEGA FISICA] [nvarchar](255) NULL,
	[AGENCIA] [nvarchar](255) NULL,
	[CET] [nvarchar](255) NULL,
	[RUTA DE VENTAS] [float] NULL,
	[CODIGO CLIENTE] [float] NULL,
	[ID] [float] NULL,
	[CODIGO CLIENTE1] [float] NULL,
	[CLIENTE] [nvarchar](255) NULL,
	[DIRECCION CLIENTE] [nvarchar](255) NULL,
	[SERIE] [nvarchar](255) NULL,
	[MODELO] [nvarchar](255) NULL,
	[ENVIO DE COMPRA] [float] NULL,
	[COMODATO DE PRESTAMO DE EQUIPO] [nvarchar](255) NULL,
	[TIPO DE EQUIPO] [nvarchar](255) NULL,
	[MARCA] [nvarchar](255) NULL,
	[caracteres_SERIE] [float] NULL,
	[AGREGAR_CEROS] [nvarchar](255) NULL,
	[Esta en db_sac_PDV] [nvarchar](255) NULL,
	[Estaba en Bodegas] [nvarchar](255) NULL,
	[Fecha_Ing_Bod] [nvarchar](255) NULL,
	[Estaba en Cuarentena] [nvarchar](255) NULL,
	[Compara x Sio] [float] NULL,
	[Valida los Sios] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nocoincidesapbruto]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nocoincidesapbruto](
	[seriesac] [nvarchar](255) NULL,
	[Serie] [nvarchar](255) NULL,
	[Query] [nvarchar](255) NULL,
	[Sede] [nvarchar](255) NULL,
	[Region] [nvarchar](255) NULL,
	[Distribuidora] [nvarchar](255) NULL,
	[Supervisor] [nvarchar](255) NULL,
	[Ruta] [nvarchar](255) NULL,
	[Sio] [float] NULL,
	[Negocio] [nvarchar](255) NULL,
	[Direccion] [ntext] NULL,
	[Departamento] [nvarchar](255) NULL,
	[Municipio] [nvarchar](255) NULL,
	[Modelo] [nvarchar](255) NULL,
	[Ficha] [nvarchar](255) NULL,
	[TipoEquipo] [nvarchar](255) NULL,
	[Marca] [nvarchar](255) NULL,
	[Visitado MP] [float] NULL,
	[Fecha VisitaMP] [nvarchar](255) NULL,
	[EWO] [float] NULL,
	[Comodato] [float] NULL,
	[comodatoVerificado] [float] NULL,
	[Pepsi-Brahva] [nvarchar](255) NULL,
	[Tiene Comodato] [nvarchar](255) NULL,
	[Eq# Pendiente Depurar] [nvarchar](255) NULL,
	[15800 vrs# 7000] [nvarchar](255) NULL,
	[tine_ehl] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[opciones_SV300418]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[opciones_SV300418](
	[id_agencia] [int] NULL,
	[id_empresa] [int] NULL,
	[id_opcion_trabajo] [int] NULL,
	[id_tipo_opcion_trabajo] [int] NULL,
	[descripcion] [char](60) NULL,
	[id_unidad_medida] [char](3) NULL,
	[valor_unitario] [decimal](18, 2) NULL,
	[saldo_inicial] [decimal](18, 2) NULL,
	[servicio] [int] NULL,
	[trasladado] [int] NULL,
	[fecha_traslado] [smalldatetime] NULL,
	[existencia] [int] NULL,
	[categoria] [int] NULL,
	[detalle] [char](50) NULL,
	[codigo_peach] [nvarchar](50) NULL,
	[nivel] [int] NULL,
	[cantidad_n1] [decimal](18, 2) NULL,
	[cantidad_n2] [decimal](18, 2) NULL,
	[total_n1] [decimal](18, 2) NULL,
	[total_n2] [decimal](18, 2) NULL,
	[valor_u_coniva] [decimal](18, 2) NULL,
	[total_n1_coniva] [decimal](18, 2) NULL,
	[total_n2_coniva] [decimal](18, 2) NULL,
	[actividad] [char](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sal]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sal](
	[id_descripcion] [nvarchar](255) NULL,
	[valor_unitario] [money] NULL,
	[id_opcion_trabajo] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_acciones_correctivo]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_acciones_correctivo](
	[codigo_visita] [int] NULL,
	[etapa] [int] NULL,
	[codigo_servicio] [int] NULL,
	[cantidad] [int] NULL,
	[numero_serie] [nvarchar](20) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_ACT]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_ACT](
	[SERIE] [nvarchar](255) NULL,
	[ACTIVO] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_activos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_activos](
	[id_agencia] [int] NOT NULL,
	[id_serie] [char](20) NOT NULL,
	[id_ficha] [char](20) NULL,
	[id_sio] [char](20) NULL,
	[id_fabricante] [int] NOT NULL,
	[id_tipo] [tinyint] NOT NULL,
	[id_modelo] [tinyint] NOT NULL,
	[id_marca] [tinyint] NOT NULL,
	[id_logotipo] [tinyint] NOT NULL,
	[foto] [image] NULL,
	[estado] [int] NOT NULL,
	[no_contrato] [char](30) NULL,
	[fabricado] [int] NULL,
	[fecha_alta] [datetime] NULL,
	[tiene_imagen] [int] NOT NULL,
	[id_negocio] [int] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[id_orden_traslado] [int] NOT NULL,
	[fecha_orden_traslado] [datetime] NULL,
	[viejo] [int] NOT NULL,
	[visitado] [int] NOT NULL,
	[id_orden_trabajo] [int] NOT NULL,
	[hora] [char](5) NULL,
	[dia] [int] NOT NULL,
	[fecha_visita] [datetime] NULL,
	[vuelta] [int] NULL,
	[id_problema] [int] NOT NULL,
	[id_activo] [char](20) NULL,
	[instalacion] [char](2) NULL,
	[fecha_instalacion] [datetime] NULL,
	[etiqueta] [char](2) NULL,
 CONSTRAINT [PK_tbl_activos] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_serie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_agencias]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_agencias](
	[id_agencia] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[direccion] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_agencias] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_apariencia]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_apariencia](
	[id_apariencia] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](25) NOT NULL,
	[de] [int] NOT NULL,
	[hasta] [int] NOT NULL,
	[color] [int] NOT NULL,
 CONSTRAINT [PK_tbl_apariencia] PRIMARY KEY CLUSTERED 
(
	[id_apariencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_areas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_areas](
	[id_empresa] [int] NOT NULL,
	[id_area] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [char](25) NULL,
	[id_personal] [int] NOT NULL,
 CONSTRAINT [PK_tbl_areas] PRIMARY KEY NONCLUSTERED 
(
	[id_empresa] ASC,
	[id_area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_bitacora_correccion]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_bitacora_correccion](
	[id_serie] [char](20) NOT NULL,
	[no_documento] [char](25) NOT NULL,
	[id_usuario] [char](20) NOT NULL,
	[fecha] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_calidad]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_calidad](
	[id_calidad] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [char](30) NOT NULL,
 CONSTRAINT [PK_tbl_calidad] PRIMARY KEY NONCLUSTERED 
(
	[id_calidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_categorias]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_categorias](
	[categoria] [int] NOT NULL,
	[descripcion] [char](25) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_clasificacion_negocios]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_clasificacion_negocios](
	[id_clasificacion_negocio] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_tbl_clasificacion_negocios] PRIMARY KEY NONCLUSTERED 
(
	[id_clasificacion_negocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_clasificacion_trabajos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_clasificacion_trabajos](
	[id_clasificacion] [smallint] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_clasificacion_trabajos] PRIMARY KEY NONCLUSTERED 
(
	[id_clasificacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_codigos_razon]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_codigos_razon](
	[id_codigo] [char](15) NOT NULL,
	[descripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_tbl_codigos_razon] PRIMARY KEY CLUSTERED 
(
	[id_codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_consultas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_consultas](
	[id_consulta] [int] NOT NULL,
	[id_proyecto] [char](40) NOT NULL,
	[descripcion] [varchar](100) NULL,
	[texto] [varchar](8000) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_correctivos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_correctivos](
	[correlativo] [int] NULL,
	[categoria] [int] NULL,
	[codigo] [int] NULL,
	[descripcion] [varchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_correlativo_ewo]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_correlativo_ewo](
	[id_ewo] [int] IDENTITY(500001,1) NOT NULL,
	[id_serie] [char](25) NULL,
	[fecha_impresion] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_datos_postmix]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_datos_postmix](
	[id_empresa] [int] NOT NULL,
	[id_orden] [int] NOT NULL,
	[brix] [varchar](50) NULL,
	[aprobado] [varchar](50) NULL,
	[temperatura] [varchar](50) NULL,
	[presion] [varchar](50) NULL,
	[carbonatacion] [varchar](50) NULL,
	[apariencia] [varchar](50) NULL,
	[calidad] [varchar](50) NULL,
	[revisar_regulador] [varchar](50) NULL,
	[ajuste_superior] [varchar](50) NULL,
	[ajuste_inferior] [varchar](50) NULL,
	[ajuste_unico] [varchar](50) NULL,
	[revisar_tiempo] [varchar](50) NULL,
	[revisar_deposito] [varchar](50) NULL,
	[purgar] [varchar](50) NULL,
	[revisar_etiquetas] [varchar](50) NULL,
	[limpiar_boquillas] [varchar](50) NULL,
	[revisar_filtro] [varchar](50) NULL,
	[revisar_fugas] [varchar](50) NULL,
	[revisar_fugas_co2] [varchar](50) NULL,
	[revisar_fugas_jarabe] [varchar](50) NULL,
	[limpiar_condesa] [varchar](50) NULL,
	[limpiar_drenaje] [varchar](50) NULL,
	[limpiar_cuerpo] [varchar](50) NULL,
	[revisar_vida] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_datos_postmix] PRIMARY KEY CLUSTERED 
(
	[id_empresa] ASC,
	[id_orden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_departamentos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_departamentos](
	[id_departamento] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [nvarchar](255) NULL,
	[suspendido] [int] NULL,
	[id_pais] [char](5) NOT NULL,
	[ZONA] [varchar](25) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_detalle_areas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_detalle_areas](
	[id_empresa] [int] NOT NULL,
	[id_area] [int] NOT NULL,
	[id_negocio] [int] NOT NULL,
	[nombre] [char](80) NULL,
	[fecha] [datetime] NOT NULL,
	[id_etapa] [int] NOT NULL,
	[descripcion] [char](80) NULL,
	[dia_trabajo] [int] NOT NULL,
	[traslado_visor] [int] NOT NULL,
	[visitado] [int] NOT NULL,
	[orden] [int] NOT NULL,
 CONSTRAINT [PK_tbl_detalle_areas] PRIMARY KEY NONCLUSTERED 
(
	[id_empresa] ASC,
	[id_area] ASC,
	[id_negocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_detalle_ingreso_items]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_detalle_ingreso_items](
	[id_empresa] [int] NOT NULL,
	[id_ingreso_item] [int] NOT NULL,
	[id_agencia] [int] NOT NULL,
	[id_opcion_trabajo] [int] NOT NULL,
	[descripcion] [varchar](60) NOT NULL,
	[cantidad] [int] NOT NULL,
	[costo] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_tbl_detalle_ingreso_items] PRIMARY KEY NONCLUSTERED 
(
	[id_empresa] ASC,
	[id_ingreso_item] ASC,
	[id_agencia] ASC,
	[id_opcion_trabajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_detalle_ingresos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_detalle_ingresos](
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_ingreso] [int] NOT NULL,
	[id_serie] [char](20) NOT NULL,
	[id_ficha] [char](20) NULL,
	[id_sio] [char](20) NULL,
	[no_contrato] [char](30) NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[fabricado] [int] NOT NULL,
	[no_documento] [char](25) NULL,
	[fecha] [datetime] NULL,
	[id_tipo] [int] NULL,
	[id_modelo] [int] NULL,
	[id_marca] [int] NULL,
	[id_logotipo] [int] NULL,
 CONSTRAINT [PK_tbl_detalle_ingresos] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_empresa] ASC,
	[id_ingreso] ASC,
	[id_serie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_detalle_ingresos_bitacora]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_detalle_ingresos_bitacora](
	[id_bitacora] [int] NOT NULL,
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_ingreso] [int] NOT NULL,
	[id_serie] [char](20) NOT NULL,
	[id_ficha] [char](20) NULL,
	[id_sio] [char](20) NULL,
	[no_contrato] [char](30) NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[fabricado] [int] NOT NULL,
	[no_documento] [char](25) NULL,
	[fecha] [datetime] NULL,
	[id_tipo] [int] NULL,
	[id_modelo] [int] NULL,
	[id_marca] [int] NULL,
	[id_logotipo] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_detalle_orden_trabajo]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_detalle_orden_trabajo](
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_orden_trabajo] [int] NOT NULL,
	[orden] [int] NULL,
	[id_opcion_trabajo] [int] NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[id_unidad_medida] [char](3) NULL,
	[descripcion] [char](60) NOT NULL,
	[cantidad] [decimal](18, 2) NOT NULL,
	[valor_unitario] [decimal](18, 2) NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[primera_linea] [int] NOT NULL,
	[nohoja] [char](50) NULL,
	[total] [decimal](18, 2) NOT NULL,
	[id_razon] [char](15) NULL,
 CONSTRAINT [PK_tbl_detalle_orden_trabajo] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_empresa] ASC,
	[id_orden_trabajo] ASC,
	[id_opcion_trabajo] ASC,
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_detalle_presupuesto]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_detalle_presupuesto](
	[id_presupuesto] [int] NULL,
	[id_serie_pre] [varchar](50) NULL,
	[id_ficha_pre] [char](10) NULL,
	[id_opcion_trabajo] [char](10) NOT NULL,
	[descripcion] [char](50) NOT NULL,
	[valor_unitario] [decimal](18, 2) NOT NULL,
	[cantidad] [int] NOT NULL,
	[total] [decimal](18, 2) NOT NULL,
	[id_modelo] [char](25) NULL,
	[id_orden_trabajo] [int] NULL,
	[fecha] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_documentos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_documentos](
	[id_documento] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [char](30) NOT NULL,
 CONSTRAINT [PK_tbl_documentos] PRIMARY KEY NONCLUSTERED 
(
	[id_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_empresas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_empresas](
	[id_empresa] [tinyint] IDENTITY(1,1) NOT NULL,
	[razon_social] [char](60) NOT NULL,
	[direccion] [char](5000) NOT NULL,
	[telefonos] [char](25) NOT NULL,
	[fax] [char](25) NOT NULL,
	[nit] [char](15) NOT NULL,
	[representante_legal] [char](60) NOT NULL,
	[nit_representante_legal] [char](15) NOT NULL,
	[inicio_periodo] [char](10) NOT NULL,
	[iva] [decimal](8, 2) NOT NULL,
	[id_exportador] [char](3) NOT NULL,
	[id_moneda] [char](3) NOT NULL,
	[logotipo] [varchar](50) NOT NULL,
	[id_region] [int] NOT NULL,
	[id_agencia] [int] NOT NULL,
 CONSTRAINT [PK_tbl_empresas] PRIMARY KEY NONCLUSTERED 
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_equipo]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_equipo](
	[id_equipo] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [char](30) NOT NULL,
 CONSTRAINT [PK_tbl_equipos] PRIMARY KEY NONCLUSTERED 
(
	[id_equipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_equipo_tecnico]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_equipo_tecnico](
	[id_empresa] [int] NOT NULL,
	[id_personal] [int] NOT NULL,
	[id_equipo] [int] NOT NULL,
	[descripcion] [varchar](80) NOT NULL,
	[cantidad] [int] NOT NULL,
	[fecha] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_etapas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_etapas](
	[id_etapa] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [char](20) NULL,
	[no_meses] [int] NOT NULL,
	[dias] [int] NOT NULL,
 CONSTRAINT [PK_tbl_etapas] PRIMARY KEY NONCLUSTERED 
(
	[id_etapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_fabricantes]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_fabricantes](
	[id_fabricante] [int] NOT NULL,
	[nombre] [char](50) NOT NULL,
	[nombre_corto] [char](20) NULL,
	[direccion] [varchar](80) NOT NULL,
	[nit] [char](20) NULL,
	[telefono] [char](20) NULL,
	[fax] [char](20) NULL,
	[e_mail] [varchar](60) NULL,
	[contacto] [varchar](50) NULL,
	[id_pais] [int] NULL,
	[id_departamento] [int] NULL,
	[id_municipio] [int] NULL,
 CONSTRAINT [PK_tbl_fabricantes] PRIMARY KEY NONCLUSTERED 
(
	[id_fabricante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_familia_bodega]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_familia_bodega](
	[id_familia_bodega] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_familia_bodega] PRIMARY KEY NONCLUSTERED 
(
	[id_familia_bodega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_filtros]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_filtros](
	[id_consulta] [int] NOT NULL,
	[id_usuario] [char](30) NOT NULL,
	[grupo] [char](1) NULL,
	[campo] [char](30) NOT NULL,
	[operador1] [char](10) NULL,
	[criterio1] [char](10) NULL,
	[conector1] [char](10) NULL,
	[operador2] [char](10) NULL,
	[criterio2] [char](10) NULL,
	[conector2] [char](10) NULL,
	[operador3] [char](10) NULL,
	[criterio3] [char](10) NULL,
	[conector3] [char](10) NULL,
	[operador4] [char](10) NULL,
	[criterio4] [char](10) NULL,
	[conector4] [char](10) NULL,
	[operador5] [char](10) NULL,
	[criterio5] [char](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_firmas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_firmas](
	[codigo_visita] [int] NOT NULL,
	[calidad_servicio] [smallint] NULL,
	[firma] [image] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_fotos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_fotos](
	[numero_serie] [char](20) NOT NULL,
	[foto] [image] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_galeria_fotos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_galeria_fotos](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_orden_trabajo] [int] NOT NULL,
	[observaciones] [varchar](100) NULL,
	[foto] [image] NULL,
	[fecha] [datetime] NOT NULL,
	[archivo] [char](50) NULL,
	[usuario] [char](30) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_grupo_servicio]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_grupo_servicio](
	[id_grupo_servicio] [int] NULL,
	[descripcion] [nvarchar](60) NULL,
	[suspendido] [smallint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ingreso_items]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ingreso_items](
	[id_empresa] [int] NOT NULL,
	[id_ingreso_item] [int] IDENTITY(1,1) NOT NULL,
	[id_agencia] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[id_usuario] [char](20) NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
 CONSTRAINT [PK_tbl_ingreso_items] PRIMARY KEY NONCLUSTERED 
(
	[id_empresa] ASC,
	[id_ingreso_item] ASC,
	[id_agencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ingresos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ingresos](
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_ingreso] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[id_motivo] [int] NOT NULL,
	[id_documento] [int] NOT NULL,
	[no_documento] [char](25) NOT NULL,
	[id_transportista] [int] NULL,
	[id_personal] [int] NULL,
	[id_fabricante] [int] NOT NULL,
	[id_tipo] [int] NOT NULL,
	[id_marca] [int] NOT NULL,
	[id_modelo] [int] NOT NULL,
	[id_logotipo] [int] NULL,
	[id_estado] [smallint] NOT NULL,
	[id_negocio] [int] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[id_usuario] [char](30) NULL,
 CONSTRAINT [PK_tbl_ingresos] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_empresa] ASC,
	[id_ingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ingresos_bitacora]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ingresos_bitacora](
	[id_bitacora] [int] NOT NULL,
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_ingreso] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[id_motivo] [int] NOT NULL,
	[id_documento] [int] NOT NULL,
	[no_documento] [char](25) NOT NULL,
	[id_transportista] [int] NULL,
	[id_personal] [int] NULL,
	[id_fabricante] [int] NOT NULL,
	[id_tipo] [int] NOT NULL,
	[id_marca] [int] NOT NULL,
	[id_modelo] [int] NOT NULL,
	[id_logotipo] [int] NULL,
	[id_estado] [smallint] NOT NULL,
	[id_negocio] [int] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[fecha_bitacora] [datetime] NOT NULL,
	[id_usuario] [char](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_instalaciones]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_instalaciones](
	[id_agencia] [float] NULL,
	[id_empresa] [float] NULL,
	[id_opcion_trabajo] [float] NULL,
	[id_tipo_opcion_trabajo] [float] NULL,
	[descripcion] [nvarchar](255) NULL,
	[id_unidad_medida] [nvarchar](255) NULL,
	[valor_unitario] [float] NULL,
	[saldo_inicial] [float] NULL,
	[servicio] [float] NULL,
	[trasladado] [float] NULL,
	[fecha_traslado] [datetime] NULL,
	[existencia] [float] NULL,
	[categoria] [float] NULL,
	[detalle] [float] NULL,
	[codigo_peach] [float] NULL,
	[nivel] [float] NULL,
	[cantidad_n1] [float] NULL,
	[cantidad_n2] [float] NULL,
	[total_n1] [float] NULL,
	[total_n2] [float] NULL,
	[valor_u_coniva] [float] NULL,
	[total_n1_coniva] [float] NULL,
	[total_n2_con_iva] [float] NULL,
	[actividad] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_logotipos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_logotipos](
	[id_agencia] [int] NOT NULL,
	[id_logotipo] [int] NOT NULL,
	[descripcion] [char](30) NOT NULL,
	[suspendido] [smallint] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
 CONSTRAINT [PK_tbl_logotipos] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_logotipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_marcadores]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_marcadores](
	[pregunta] [int] NOT NULL,
	[descripcion] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_marcas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_marcas](
	[id_agencia] [int] NOT NULL,
	[id_marca] [int] NOT NULL,
	[descripcion] [char](30) NOT NULL,
	[suspendido] [smallint] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
 CONSTRAINT [PK_tbl_marcas] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_marca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_menu_de_items]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_menu_de_items](
	[id_proyecto] [char](40) NOT NULL,
	[id_grupo] [char](20) NOT NULL,
	[id_item] [char](60) NOT NULL,
	[caption] [char](60) NOT NULL,
	[texto] [char](60) NOT NULL,
	[llave] [char](60) NOT NULL,
	[imagen] [char](20) NOT NULL,
	[numero] [tinyint] NOT NULL,
	[id_indice] [int] NOT NULL,
	[hint] [char](200) NOT NULL,
	[distribuida] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_menu_de_opciones]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_menu_de_opciones](
	[id_proyecto] [char](40) NOT NULL,
	[id_grupo] [char](20) NOT NULL,
	[llave] [char](20) NULL,
	[caption] [char](20) NULL,
	[numero] [tinyint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_menu_de_proyectos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_menu_de_proyectos](
	[id_proyecto] [char](40) NOT NULL,
	[descripcion] [char](60) NULL,
	[observaciones] [varchar](200) NULL,
	[fecha_ultima_modificacion] [smalldatetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_menu_de_usuario]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_menu_de_usuario](
	[id_usuario] [char](20) NOT NULL,
	[id_proyecto] [char](40) NOT NULL,
	[id_grupo] [char](20) NOT NULL,
	[id_item] [char](60) NOT NULL,
	[estado] [int] NOT NULL,
	[indice] [int] IDENTITY(1,1) NOT NULL,
	[en_barra] [tinyint] NOT NULL,
	[id_empresa] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_modelos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_modelos](
	[id_agencia] [int] NOT NULL,
	[id_modelo] [int] NOT NULL,
	[descripcion] [char](30) NOT NULL,
	[costo] [decimal](18, 2) NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[linea] [char](10) NULL,
 CONSTRAINT [PK_tbl_modelos] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_modelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_modifica_serie]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_modifica_serie](
	[serie_anterior] [char](20) NOT NULL,
	[serie] [char](20) NOT NULL,
	[fabricado] [int] NOT NULL,
	[ficha] [char](20) NULL,
	[id_usuario] [char](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_monedas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_monedas](
	[id_agencia] [int] NOT NULL,
	[id_moneda] [char](3) NOT NULL,
	[descripcion] [char](30) NOT NULL,
	[descrip_plural] [char](30) NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
 CONSTRAINT [PK_tbl_monedas] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_moneda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_motivos_ingresos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_motivos_ingresos](
	[id_motivo] [tinyint] NULL,
	[descripcion] [nvarchar](30) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_movimientos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_movimientos](
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_movimiento] [int] NOT NULL,
	[id_serie] [char](20) NOT NULL,
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[serie_especial] [char](10) NULL,
	[id_ficha] [char](20) NULL,
	[fecha] [datetime] NOT NULL,
	[id_ubicacion] [char](25) NOT NULL,
	[id_negocio] [int] NOT NULL,
	[id_personal] [int] NULL,
	[observaciones] [varchar](100) NULL,
	[fecha_salida] [datetime] NULL,
	[id_usuario] [char](20) NULL,
	[id_ingreso] [int] NOT NULL,
	[estado] [int] NOT NULL,
	[id_orden_traslado] [int] NOT NULL,
	[no_contrato] [char](30) NULL,
	[id_negocio_anterior] [int] NOT NULL,
	[negocio] [varchar](100) NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[valor] [decimal](18, 2) NOT NULL,
	[id_opcion_trabajo] [int] NOT NULL,
	[id_tipo_movimiento] [char](5) NOT NULL,
	[viejo] [int] NOT NULL,
 CONSTRAINT [PK_tbl_movimientos] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_empresa] ASC,
	[id_movimiento] ASC,
	[id_serie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_municipios]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_municipios](
	[id_municipio] [int] NOT NULL,
	[nombre] [char](60) NOT NULL,
	[id_departamento] [int] NOT NULL,
	[id_pais] [char](10) NULL,
 CONSTRAINT [PK_tbl_municipios] PRIMARY KEY NONCLUSTERED 
(
	[id_municipio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_negocios]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_negocios](
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_negocio] [int] NOT NULL,
	[id_alterno] [char](15) NULL,
	[nombre] [char](60) NOT NULL,
	[nit] [char](25) NOT NULL,
	[direccion] [char](500) NULL,
	[calle_avenida] [char](100) NULL,
	[casa] [char](20) NULL,
	[zona] [char](10) NULL,
	[entorno] [char](75) NULL,
	[id_departamento] [int] NULL,
	[id_municipio] [int] NULL,
	[municipio] [char](30) NULL,
	[departamento] [char](30) NULL,
	[pais] [char](30) NULL,
	[e_mail] [varchar](35) NULL,
	[fecha_creacion] [datetime] NOT NULL,
	[contacto] [char](75) NULL,
	[suspendido] [int] NOT NULL,
	[id_tipo_negocio] [int] NOT NULL,
	[id_ubicacion] [char](20) NOT NULL,
	[id_clasificacion_negocio] [int] NOT NULL,
	[id_etapa] [int] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[latitud_grad] [decimal](20, 12) NOT NULL,
	[latitud_min] [decimal](20, 12) NOT NULL,
	[latitud_seg] [decimal](20, 12) NOT NULL,
	[longitud_grad] [decimal](20, 12) NOT NULL,
	[longitud_min] [decimal](20, 12) NOT NULL,
	[longitud_seg] [decimal](20, 12) NOT NULL,
	[foto] [image] NULL,
	[archivo] [varchar](50) NULL,
	[venta_mensual] [int] NOT NULL,
	[telefono] [char](10) NOT NULL,
	[id_sector] [char](10) NOT NULL,
	[id_pais] [char](5) NOT NULL,
	[visitado] [int] NOT NULL,
	[id_orden_trabajo] [int] NOT NULL,
	[hora] [char](5) NOT NULL,
	[dia] [int] NOT NULL,
	[fecha_visita] [datetime] NULL,
 CONSTRAINT [PK_tbl_negocios] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_empresa] ASC,
	[id_negocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_negocios_visitados]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_negocios_visitados](
	[id_empresa] [int] NOT NULL,
	[id_negocio] [int] NOT NULL,
	[id_orden_trabajo] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[hora_inicio] [char](5) NOT NULL,
	[hora_final] [char](5) NOT NULL,
	[dia] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_numeracion]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_numeracion](
	[id_numeracion] [int] NOT NULL,
	[correlativo] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_numeracion_sac]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_numeracion_sac](
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_documento] [int] NOT NULL,
	[descripcion] [varchar](25) NULL,
	[proximo_numero] [int] NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
 CONSTRAINT [PK_tbl_numeracion_sac] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_empresa] ASC,
	[id_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_numeros_serie]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_numeros_serie](
	[codigo_visita] [int] NULL,
	[numero_serie] [char](18) NULL,
	[numero_referencia] [char](20) NULL,
	[grabado] [datetime] NULL,
	[actualizado] [int] NOT NULL,
	[actualizada_orden] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_opciones_trabajo]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_opciones_trabajo](
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_opcion_trabajo] [int] NOT NULL,
	[id_tipo_opcion_trabajo] [int] NOT NULL,
	[descripcion] [char](100) NOT NULL,
	[id_unidad_medida] [char](3) NULL,
	[valor_unitario] [float] NOT NULL,
	[saldo_inicial] [decimal](18, 0) NOT NULL,
	[servicio] [int] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[existencia] [int] NOT NULL,
	[categoria] [int] NOT NULL,
	[detalle] [char](50) NULL,
	[codigo_peach] [nvarchar](50) NULL,
	[nivel] [int] NULL,
	[cantidad_n1] [decimal](18, 2) NULL,
	[cantidad_n2] [decimal](18, 2) NULL,
	[total_n1] [decimal](18, 2) NULL,
	[total_n2] [decimal](18, 2) NULL,
	[valor_u_coniva] [decimal](18, 2) NULL,
	[total_n1_coniva] [decimal](18, 2) NULL,
	[total_n2_con_iva] [decimal](18, 2) NULL,
	[actividad] [char](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_orden_trabajo]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_orden_trabajo](
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_orden_trabajo] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[id_personal] [int] NOT NULL,
	[id_ficha] [char](20) NOT NULL,
	[id_serie] [char](20) NOT NULL,
	[id_sio] [char](20) NULL,
	[serie_orden] [char](20) NULL,
	[id_negocio] [int] NOT NULL,
	[id_ubicacion] [char](20) NOT NULL,
	[dia_trabajo] [int] NOT NULL,
	[hora_inicio] [char](10) NULL,
	[hora_final] [char](10) NULL,
	[firma] [image] NULL,
	[foto] [image] NULL,
	[id_calidad] [int] NOT NULL,
	[observaciones] [varchar](100) NULL,
	[total] [decimal](18, 2) NOT NULL,
	[id_tipo_trabajo] [int] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[id_sector] [char](15) NULL,
	[id_region] [char](15) NULL,
	[estado] [int] NOT NULL,
	[con_llamada] [int] NOT NULL,
	[aplico_correctivo] [int] NOT NULL,
	[archivo] [varchar](50) NULL,
	[nohoja] [char](50) NULL,
	[ya_utilizada] [int] NOT NULL,
	[foraneo] [int] NOT NULL,
	[id_problema] [int] NOT NULL,
	[fecha_operacion] [datetime] NOT NULL,
	[id_usuario] [char](20) NOT NULL,
	[fecha_llamada] [datetime] NOT NULL,
	[horas_llamada] [tinyint] NULL,
	[horas_arribo] [tinyint] NULL,
	[fecha_termino] [datetime] NOT NULL,
	[horas_termino] [tinyint] NULL,
	[horas_acumuladas] [decimal](10, 2) NOT NULL,
	[temperatura] [decimal](8, 2) NOT NULL,
	[apariencia] [int] NULL,
	[calificacion] [tinyint] NOT NULL,
	[id_temperatura] [int] NULL,
	[id_apariencia] [int] NULL,
	[fines_semana] [tinyint] NOT NULL,
	[numero_ss] [char](50) NULL,
	[tipo_ss] [char](20) NULL,
	[fecha_contactocli] [datetime] NULL,
 CONSTRAINT [PK_tbl_orden_servicio] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_empresa] ASC,
	[id_orden_trabajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_paises]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_paises](
	[id_pais] [char](5) NOT NULL,
	[descripcion] [char](30) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_personal]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_personal](
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_personal] [int] NOT NULL,
	[id_tipo_personal] [int] NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[identificacion] [char](25) NOT NULL,
	[no_licencia] [varchar](20) NULL,
	[no_pasaporte] [varchar](40) NULL,
	[telefono] [char](25) NULL,
	[id_pais] [int] NULL,
	[suspendido] [int] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[id_alterno] [varchar](20) NULL,
	[vuelta] [int] NOT NULL,
 CONSTRAINT [PK_tbl_personal] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_empresa] ASC,
	[id_personal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_preguntas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_preguntas](
	[correlativo] [int] IDENTITY(1,1) NOT NULL,
	[pregunta] [smallint] NOT NULL,
	[descripcion] [varchar](60) NOT NULL,
	[inicio] [decimal](18, 2) NOT NULL,
	[final] [decimal](18, 2) NOT NULL,
	[carita] [smallint] NOT NULL,
 CONSTRAINT [PK_tbl_preguntas] PRIMARY KEY CLUSTERED 
(
	[pregunta] ASC,
	[inicio] ASC,
	[final] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_presupuesto]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_presupuesto](
	[id_presupuesto] [int] IDENTITY(1,1) NOT NULL,
	[id_serie_pre] [varchar](50) NULL,
	[id_ficha_pre] [varchar](50) NULL,
	[total] [decimal](18, 0) NOT NULL,
	[fecha] [datetime] NULL,
	[id_orden_trabajo] [int] NULL,
	[id_modelo] [char](25) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_preventivo]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_preventivo](
	[correlativo] [int] NOT NULL,
	[categoria] [smallint] NULL,
	[descripcion] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_problemas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_problemas](
	[id_empresa] [int] NOT NULL,
	[id_problema] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_regiones]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_regiones](
	[id_empresa] [int] NOT NULL,
	[id_region] [char](10) NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_regiones] PRIMARY KEY NONCLUSTERED 
(
	[id_empresa] ASC,
	[id_region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_reporte_pepsi]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_reporte_pepsi](
	[grupo] [smallint] NOT NULL,
	[pregunta] [smallint] NULL,
	[descripcion] [varchar](60) NULL,
	[carita] [smallint] NULL,
	[porcentaje] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_retiros]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_retiros](
	[id_orden_traslado] [char](20) NULL,
	[id_serie] [char](20) NULL,
	[id_negocio_anterior] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_rutas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rutas](
	[id_ruta] [char](25) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sectores]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sectores](
	[id_empresa] [int] NOT NULL,
	[id_sector] [char](10) NOT NULL,
	[id_region] [char](10) NOT NULL,
	[descripcion] [varchar](50) NULL,
	[id_tecnico] [int] NOT NULL,
 CONSTRAINT [PK_tbl_sectores] PRIMARY KEY NONCLUSTERED 
(
	[id_empresa] ASC,
	[id_sector] ASC,
	[id_region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sectores_por_tecnico]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sectores_por_tecnico](
	[id_empresa] [int] NOT NULL,
	[id_tecnico] [int] NOT NULL,
	[id_sector] [char](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_series]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_series](
	[Serie] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sesiones]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sesiones](
	[id_usuario] [char](20) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[activa] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_status_equipos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_status_equipos](
	[id_status_equipo] [int] NULL,
	[descripcion] [nvarchar](60) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_temp_fecha]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_temp_fecha](
	[orden] [float] NULL,
	[fecha] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_temperatura]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_temperatura](
	[id_temperatura] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](200) NOT NULL,
	[valor_inicial] [decimal](8, 2) NOT NULL,
	[valor_final] [decimal](8, 2) NOT NULL,
 CONSTRAINT [PK_tbl_temperatura] PRIMARY KEY CLUSTERED 
(
	[id_temperatura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tiempos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tiempos](
	[codigo_visita] [int] NULL,
	[numero_serie] [nvarchar](50) NULL,
	[Tipo] [int] NULL,
	[Etapa] [int] NULL,
	[Anio] [int] NULL,
	[Mes] [int] NULL,
	[Dia] [int] NULL,
	[Hora] [int] NULL,
	[Minuto] [int] NULL,
	[Segundo] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipo_personal]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tipo_personal](
	[id_tipo_personal] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [varchar](30) NOT NULL,
 CONSTRAINT [PK_tbl_tipo_personal] PRIMARY KEY NONCLUSTERED 
(
	[id_tipo_personal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipobodega]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tipobodega](
	[id_tipobodega] [int] IDENTITY(1,1) NOT NULL,
	[describetipobodega] [varchar](50) NULL,
 CONSTRAINT [PK_tipobodega] PRIMARY KEY CLUSTERED 
(
	[id_tipobodega] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tipos](
	[id_agencia] [int] NOT NULL,
	[id_tipo] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [char](25) NOT NULL,
	[suspendido] [smallint] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
 CONSTRAINT [PK_tbl_tipos] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipos_movimiento]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tipos_movimiento](
	[id_tipo_movimiento] [char](5) NOT NULL,
	[descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_tbl_tipos_movimiento] PRIMARY KEY CLUSTERED 
(
	[id_tipo_movimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipos_negocios]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tipos_negocios](
	[id_agencia] [int] NOT NULL,
	[id_tipo_negocio] [int] NOT NULL,
	[id_alterno] [char](20) NULL,
	[descripcion] [char](40) NOT NULL,
	[suspendido] [int] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
 CONSTRAINT [PK_tbl_tipos_negocios] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_tipo_negocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipos_opcion_trabajo]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tipos_opcion_trabajo](
	[id_tipo_opcion_trabajo] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [char](35) NOT NULL,
	[servicio] [int] NOT NULL,
	[trasladado] [int] NOT NULL,
	[valor] [decimal](18, 2) NULL,
	[id_clasficacion] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipos_propietarios]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tipos_propietarios](
	[id_tipo_propietario] [int] NULL,
	[descripcion] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipos_solicitud]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tipos_solicitud](
	[id_tipo_ss] [int] NULL,
	[grupo] [char](20) NULL,
	[descripcion] [char](15) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tipos_trabajo]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tipos_trabajo](
	[id_tipo_trabajo] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [char](35) NOT NULL,
	[servicio] [int] NOT NULL,
 CONSTRAINT [PK_tbl_tipos_trabajo] PRIMARY KEY NONCLUSTERED 
(
	[id_tipo_trabajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tmp_050118]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tmp_050118](
	[id_agencia] [int] NULL,
	[id_empresa] [int] NULL,
	[id_opcion_trabajo] [int] NULL,
	[id_tipo_opcion_trabajo] [int] NULL,
	[descripcion] [char](60) NULL,
	[id_unidad_medida] [char](3) NULL,
	[valor_unitario] [decimal](18, 0) NULL,
	[saldo_inicial] [decimal](18, 0) NULL,
	[servicio] [int] NULL,
	[traslado] [int] NULL,
	[fecha_traslado] [datetime] NULL,
	[existencia] [int] NULL,
	[categoria] [int] NULL,
	[detalle] [int] NULL,
	[codigo_peach] [nvarchar](50) NULL,
	[nivel] [int] NULL,
	[cantidad_n1] [decimal](18, 0) NULL,
	[cantidad_n2] [decimal](18, 0) NULL,
	[total_n1] [decimal](18, 0) NULL,
	[total_n2] [decimal](18, 0) NULL,
	[valor_u_coniva] [decimal](18, 0) NULL,
	[total_n1_coniva] [decimal](18, 0) NULL,
	[total_n2_con_iva] [decimal](18, 0) NULL,
	[actividad] [char](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tmp_actividades$]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tmp_actividades$](
	[id_opcion_trabajo] [float] NULL,
	[Actividad] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tmp_bols16931700]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tmp_bols16931700](
	[id_serie] [nvarchar](255) NULL,
	[destino] [nvarchar](255) NULL,
	[bol] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tmp_categorias2018]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tmp_categorias2018](
	[descripcion] [nvarchar](255) NULL,
	[categoria] [nvarchar](255) NULL,
	[id_categoria] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tmp_freund]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tmp_freund](
	[id_serie] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tmp_opciones_sv]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tmp_opciones_sv](
	[id_agencia] [int] NULL,
	[id_empresa] [int] NULL,
	[id_opcion_trabajo] [int] NULL,
	[id_tipo_opcion_trabajo] [int] NULL,
	[descripcion] [char](80) NULL,
	[id_unidad_medida] [char](10) NULL,
	[valor_unitario] [decimal](18, 2) NULL,
	[saldo_inicial] [int] NULL,
	[servicio] [int] NULL,
	[trasladado] [int] NULL,
	[fecha_traslado] [datetime] NULL,
	[existencia] [int] NULL,
	[categoria] [int] NULL,
	[detalle] [char](53) NULL,
	[codigo_peach] [char](50) NULL,
	[nivel] [int] NULL,
	[cantidad_n1] [decimal](18, 2) NULL,
	[cantidad_n2] [decimal](18, 2) NULL,
	[total_n1] [decimal](18, 2) NULL,
	[total_n2] [decimal](18, 2) NULL,
	[valor_u_coniva] [decimal](18, 2) NULL,
	[total_n1_coniva] [decimal](18, 2) NULL,
	[total_n2_coniva] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tmp_opciones_sv0401]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tmp_opciones_sv0401](
	[id_agencia] [int] NULL,
	[id_empresa] [int] NULL,
	[id_opcion_trabajo] [int] NULL,
	[id_tipo_opcion_trabajo] [int] NULL,
	[descripcion] [char](60) NULL,
	[id_unidad_medida] [char](3) NULL,
	[valor_unitario] [decimal](18, 2) NULL,
	[saldo_inicial] [decimal](18, 2) NULL,
	[servicio] [int] NULL,
	[trasladado] [int] NULL,
	[fecha_traslado] [datetime] NULL,
	[existencia] [int] NULL,
	[categoria] [int] NULL,
	[detalle] [int] NULL,
	[codigo_peach] [nvarchar](50) NULL,
	[nivel] [int] NULL,
	[cantidad_n1] [decimal](18, 2) NULL,
	[cantidad_n2] [decimal](18, 2) NULL,
	[total_n1] [decimal](18, 2) NULL,
	[total_n2] [decimal](18, 2) NULL,
	[valor_u_coniva] [decimal](18, 2) NULL,
	[total_n1_coniva] [decimal](18, 2) NULL,
	[total_n2_coniva] [decimal](18, 2) NULL,
	[actividad] [char](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tmp_opcionesnuevassv]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tmp_opcionesnuevassv](
	[id_agencia] [int] NULL,
	[id_empresa] [int] NULL,
	[id_opcion_trabajo] [int] NULL,
	[id_tipo_opcion_trabajo] [int] NULL,
	[descripcion] [char](60) NULL,
	[id_unidad_medida] [char](3) NULL,
	[valor_unitario] [decimal](18, 2) NULL,
	[saldo_inicial] [decimal](18, 2) NULL,
	[servicio] [int] NULL,
	[trasladado] [int] NULL,
	[fecha_traslado] [datetime] NULL,
	[existencia] [int] NULL,
	[categoria] [int] NULL,
	[detalle] [char](50) NULL,
	[codigo_peach] [nvarchar](50) NULL,
	[nivel] [int] NULL,
	[cantidad_n1] [decimal](18, 2) NULL,
	[cantidad_n2] [decimal](18, 2) NULL,
	[total_n1] [decimal](18, 2) NULL,
	[total_n2] [decimal](18, 2) NULL,
	[valor_u_coniva] [decimal](18, 2) NULL,
	[total_n1_coniva] [decimal](18, 2) NULL,
	[total_n2_coniva] [decimal](18, 2) NULL,
	[actividad] [char](80) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_tmp_retiros2014]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_tmp_retiros2014](
	[ID_NEGOCIO] [float] NULL,
	[REGION] [nvarchar](255) NULL,
	[DISTRIBUIDORA] [nvarchar](255) NULL,
	[SUPERVISOR] [nvarchar](255) NULL,
	[RUTA] [nvarchar](255) NULL,
	[SIO] [float] NULL,
	[NEGOCIO] [nvarchar](255) NULL,
	[DIRECCION] [ntext] NULL,
	[TIPO_TRABAJO] [nvarchar](255) NULL,
	[TIPO_MOV] [nvarchar](255) NULL,
	[EMO_EWO] [float] NULL,
	[FECHAREALIZADO] [smalldatetime] NULL,
	[MODELO] [nvarchar](255) NULL,
	[SERIE] [nvarchar](255) NULL,
	[FICHA] [nvarchar](255) NULL,
	[ACTIVO] [float] NULL,
	[TIPOEQUIPO] [nvarchar](255) NULL,
	[MARCA] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TBL_TMP070319]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_TMP070319](
	[id_agencia] [float] NULL,
	[id_empresa] [float] NULL,
	[id_opcion_trabajo] [float] NULL,
	[id_tipo_opcion_trabajo] [float] NULL,
	[descripcion] [nvarchar](255) NULL,
	[id_unidad_medida] [nvarchar](255) NULL,
	[valor_unitario] [float] NULL,
	[saldo_inicial] [float] NULL,
	[servicio] [float] NULL,
	[trasladado] [float] NULL,
	[fecha_traslado] [datetime] NULL,
	[existencia] [float] NULL,
	[categoria] [float] NULL,
	[detalle] [float] NULL,
	[codigo_peach] [float] NULL,
	[nivel] [float] NULL,
	[cantidad_n1] [float] NULL,
	[cantidad_n2] [float] NULL,
	[total_n1] [float] NULL,
	[total_n2] [float] NULL,
	[valor_u_coniva] [float] NULL,
	[total_n1_coniva] [float] NULL,
	[total_n2_con_iva] [float] NULL,
	[actividad] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_transportistas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_transportistas](
	[id_agencia] [int] NOT NULL,
	[id_transportista] [int] NOT NULL,
	[razon_social] [varchar](100) NULL,
	[nit] [varchar](50) NULL,
	[numero_calle_avenida] [varchar](50) NULL,
	[nombre_calle_avenida] [varchar](50) NULL,
	[numero_casa] [varchar](50) NULL,
	[apto] [varchar](50) NULL,
	[zona] [varchar](50) NULL,
	[apto_postal] [varchar](50) NULL,
	[colonia_barrio] [varchar](50) NULL,
	[id_pais] [int] NULL,
	[id_departamento] [int] NULL,
	[id_municipio] [int] NULL,
	[e_mail] [varchar](50) NULL,
	[porcentaje_retencion] [int] NULL,
	[fecha_creacion] [smalldatetime] NULL,
	[contacto] [varchar](50) NULL,
	[suspendido] [int] NULL,
	[codigo_exportador] [varchar](50) NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
 CONSTRAINT [PK_tbl_transportistas] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_transportista] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_traslado_respaldos]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_traslado_respaldos](
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_orden_traslado] [int] NOT NULL,
	[id_negocio_anterior] [int] NOT NULL,
	[id_negocio] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[serie_orden] [char](10) NULL,
	[id_personal] [int] NOT NULL,
	[id_usuario] [char](20) NOT NULL,
	[estado] [int] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[comprometido] [smallint] NULL,
	[completo] [varchar](50) NULL,
	[necesita_partes] [varchar](50) NULL,
	[necesita_ayuda] [varchar](50) NULL,
	[no_listo] [varchar](50) NULL,
	[cerrado] [varchar](50) NULL,
	[otros] [varchar](50) NULL,
	[fecha_contacto] [datetime] NULL,
	[fecha_requerida] [datetime] NULL,
	[fecha_programada] [datetime] NULL,
	[tiempo_acumulado] [smallint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_traslados]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_traslados](
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_orden_traslado] [int] NOT NULL,
	[id_negocio_anterior] [int] NOT NULL,
	[id_negocio] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[serie_orden] [char](10) NULL,
	[id_personal] [int] NOT NULL,
	[id_usuario] [char](20) NOT NULL,
	[estado] [int] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[comprometido] [smallint] NULL,
	[completo] [varchar](50) NULL,
	[necesita_partes] [varchar](50) NULL,
	[necesita_ayuda] [varchar](50) NULL,
	[no_listo] [varchar](50) NULL,
	[cerrado] [varchar](50) NULL,
	[otros] [varchar](50) NULL,
	[fecha_contacto] [datetime] NULL,
	[fecha_requerida] [datetime] NULL,
	[fecha_programada] [datetime] NULL,
	[tiempo_acumulado] [smallint] NULL,
 CONSTRAINT [PK_tbl_traslados] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_empresa] ASC,
	[id_orden_traslado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_traslados_bueno]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_traslados_bueno](
	[id_agencia] [int] NOT NULL,
	[id_empresa] [int] NOT NULL,
	[id_orden_traslado] [int] NOT NULL,
	[id_negocio_anterior] [int] NOT NULL,
	[id_negocio] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[serie_orden] [char](10) NULL,
	[id_personal] [int] NOT NULL,
	[id_usuario] [char](20) NOT NULL,
	[estado] [int] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
	[comprometido] [smallint] NULL,
	[completo] [varchar](50) NULL,
	[necesita_partes] [varchar](50) NULL,
	[necesita_ayuda] [varchar](50) NULL,
	[no_listo] [varchar](50) NULL,
	[cerrado] [varchar](50) NULL,
	[otros] [varchar](50) NULL,
	[fecha_contacto] [datetime] NULL,
	[fecha_requerida] [datetime] NULL,
	[fecha_programada] [datetime] NULL,
	[tiempo_acumulado] [smallint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ubicaciones]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ubicaciones](
	[id_agencia] [int] NOT NULL,
	[id_ubicacion] [char](20) NOT NULL,
	[id_ubicacion_maestra] [char](20) NULL,
	[id_alterno] [char](20) NULL,
	[descripcion] [char](50) NOT NULL,
	[tipo] [int] NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
 CONSTRAINT [PK_tbl_ubicaciones] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_ubicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ubicaciones_permiso]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ubicaciones_permiso](
	[id_empresa] [int] NOT NULL,
	[id_usuario] [char](20) NOT NULL,
	[id_ubicacion] [char](20) NOT NULL,
	[id_ubicacion_maestra] [char](20) NOT NULL,
 CONSTRAINT [PK_tbl_ubicaciones_permiso] PRIMARY KEY NONCLUSTERED 
(
	[id_empresa] ASC,
	[id_usuario] ASC,
	[id_ubicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_unidad_medida]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_unidad_medida](
	[id_agencia] [int] NOT NULL,
	[id_unidad_medida] [char](3) NOT NULL,
	[descripcion] [char](25) NOT NULL,
	[trasladado] [int] NOT NULL,
	[fecha_traslado] [datetime] NULL,
 CONSTRAINT [PK_tbl_unidad_medida] PRIMARY KEY NONCLUSTERED 
(
	[id_agencia] ASC,
	[id_unidad_medida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_usuarios]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_usuarios](
	[id_usuario] [char](20) NOT NULL,
	[descripcion] [char](60) NOT NULL,
	[tipo_usuario] [tinyint] NOT NULL,
	[cuenta_correo] [char](60) NOT NULL,
	[clave] [char](10) NOT NULL,
	[id_empleado] [char](15) NOT NULL,
	[con_outlook] [int] NOT NULL,
	[id_gerencia] [int] NOT NULL,
	[colorFondo] [int] NOT NULL,
	[colorobjetos] [int] NOT NULL,
	[colorfont] [int] NOT NULL,
	[estiloweb] [int] NOT NULL,
	[aplicar] [int] NOT NULL,
	[puede_editar] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_visitas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_visitas](
	[codigo] [int] NOT NULL,
	[nombre] [char](50) NULL,
	[direccion] [char](50) NULL,
	[contacto] [char](50) NULL,
	[visitado] [smallint] NOT NULL,
	[anio] [smallint] NULL,
	[mes] [int] NULL,
	[dia] [int] NULL,
	[hora] [int] NULL,
	[minuto] [int] NULL,
	[comentarios] [char](200) NULL,
	[usuario] [char](10) NOT NULL,
	[negocios_actualizados] [int] NOT NULL,
	[ordenes_actualizadas] [int] NOT NULL,
	[visitas_actualizadas] [int] NOT NULL,
	[id_negocio] [int] NOT NULL,
	[id_tecnico] [int] NOT NULL,
 CONSTRAINT [PK_tbl_visitas] PRIMARY KEY NONCLUSTERED 
(
	[codigo] ASC,
	[usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_visitas_sac]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_visitas_sac](
	[id_empresa] [int] NOT NULL,
	[id_visita] [int] IDENTITY(1,1) NOT NULL,
	[orden_salida] [int] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[id_negocio] [int] NOT NULL,
	[id_ubicacion] [char](20) NOT NULL,
	[id_personal] [int] NOT NULL,
	[pendiente] [int] NOT NULL,
	[no_etapa] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_vueltas]    Script Date: 12/11/2022 18:32:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_vueltas](
	[id_empresa] [int] NOT NULL,
	[id_personal] [int] NOT NULL,
	[vuelta] [int] NOT NULL,
	[fecha_inicial] [datetime] NOT NULL,
	[fecha_final] [datetime] NULL,
	[id_usuario] [char](20) NOT NULL,
 CONSTRAINT [PK_tbl_vuelta] PRIMARY KEY NONCLUSTERED 
(
	[id_empresa] ASC,
	[id_personal] ASC,
	[vuelta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [Fabricante]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Fabricante] ON [dbo].[tbl_activos]
(
	[id_fabricante] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Logotipo]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Logotipo] ON [dbo].[tbl_activos]
(
	[id_logotipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Marca]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Marca] ON [dbo].[tbl_activos]
(
	[id_marca] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Modelo]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Modelo] ON [dbo].[tbl_activos]
(
	[id_modelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Serie]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Serie] ON [dbo].[tbl_activos]
(
	[id_serie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Tipo_Activo]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Tipo_Activo] ON [dbo].[tbl_activos]
(
	[id_tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Orden]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Orden] ON [dbo].[tbl_datos_postmix]
(
	[id_orden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Agencia]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Agencia] ON [dbo].[tbl_detalle_ingresos]
(
	[id_agencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Empresa]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Empresa] ON [dbo].[tbl_detalle_ingresos]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ficha]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Ficha] ON [dbo].[tbl_detalle_ingresos]
(
	[id_ficha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Ingreso]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Ingreso] ON [dbo].[tbl_detalle_ingresos]
(
	[id_ingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Serie]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Serie] ON [dbo].[tbl_detalle_ingresos]
(
	[id_serie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Agencia]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Agencia] ON [dbo].[tbl_detalle_orden_trabajo]
(
	[id_agencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Empresa]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Empresa] ON [dbo].[tbl_detalle_orden_trabajo]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Opcion Trabajo]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Opcion Trabajo] ON [dbo].[tbl_detalle_orden_trabajo]
(
	[id_opcion_trabajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Orden Trabajo]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Orden Trabajo] ON [dbo].[tbl_detalle_orden_trabajo]
(
	[id_orden_trabajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [correlativo]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [correlativo] ON [dbo].[tbl_galeria_fotos]
(
	[correlativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Empresa]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Empresa] ON [dbo].[tbl_galeria_fotos]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Orden]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Orden] ON [dbo].[tbl_galeria_fotos]
(
	[id_orden_trabajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Agencia]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Agencia] ON [dbo].[tbl_ingresos]
(
	[id_agencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Documento]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Documento] ON [dbo].[tbl_ingresos]
(
	[id_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Empresa]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Empresa] ON [dbo].[tbl_ingresos]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Fecha]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Fecha] ON [dbo].[tbl_ingresos]
(
	[fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Ingreso]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Ingreso] ON [dbo].[tbl_ingresos]
(
	[id_ingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Logotipo]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Logotipo] ON [dbo].[tbl_ingresos]
(
	[id_logotipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Marca]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Marca] ON [dbo].[tbl_ingresos]
(
	[id_modelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Modelo]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Modelo] ON [dbo].[tbl_ingresos]
(
	[id_modelo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Motivo]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Motivo] ON [dbo].[tbl_ingresos]
(
	[id_motivo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Negocio]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Negocio] ON [dbo].[tbl_ingresos]
(
	[id_negocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Tipo_Activo]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Tipo_Activo] ON [dbo].[tbl_ingresos]
(
	[id_tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Transportista]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Transportista] ON [dbo].[tbl_ingresos]
(
	[id_transportista] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Agencia]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Agencia] ON [dbo].[tbl_movimientos]
(
	[id_agencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Empresa]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Empresa] ON [dbo].[tbl_movimientos]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Fecha]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Fecha] ON [dbo].[tbl_movimientos]
(
	[fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Ingreso]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Ingreso] ON [dbo].[tbl_movimientos]
(
	[id_ingreso] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Movimiento]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Movimiento] ON [dbo].[tbl_movimientos]
(
	[id_movimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Negocio]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Negocio] ON [dbo].[tbl_movimientos]
(
	[id_negocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Negocio Anterior]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Negocio Anterior] ON [dbo].[tbl_movimientos]
(
	[id_negocio_anterior] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Orden Traslado]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Orden Traslado] ON [dbo].[tbl_movimientos]
(
	[id_orden_traslado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Personal]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Personal] ON [dbo].[tbl_movimientos]
(
	[id_personal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Serie]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Serie] ON [dbo].[tbl_movimientos]
(
	[id_serie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ubicacion]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Ubicacion] ON [dbo].[tbl_movimientos]
(
	[id_ubicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Usuario]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Usuario] ON [dbo].[tbl_movimientos]
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Agencia]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Agencia] ON [dbo].[tbl_negocios]
(
	[id_agencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Clasificacion]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Clasificacion] ON [dbo].[tbl_negocios]
(
	[id_clasificacion_negocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Depto]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Depto] ON [dbo].[tbl_negocios]
(
	[id_departamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Empresa]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Empresa] ON [dbo].[tbl_negocios]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Etapa]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Etapa] ON [dbo].[tbl_negocios]
(
	[id_etapa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Municipio]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Municipio] ON [dbo].[tbl_negocios]
(
	[id_municipio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Nombre]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Nombre] ON [dbo].[tbl_negocios]
(
	[nombre] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Tipo_Negocio]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Tipo_Negocio] ON [dbo].[tbl_negocios]
(
	[id_tipo_negocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ubicacion]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Ubicacion] ON [dbo].[tbl_negocios]
(
	[id_ubicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Agencia]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Agencia] ON [dbo].[tbl_orden_trabajo]
(
	[id_agencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Empresa]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Empresa] ON [dbo].[tbl_orden_trabajo]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Fecha]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Fecha] ON [dbo].[tbl_orden_trabajo]
(
	[fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Negocio]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Negocio] ON [dbo].[tbl_orden_trabajo]
(
	[id_negocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Orden Trabajo]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Orden Trabajo] ON [dbo].[tbl_orden_trabajo]
(
	[id_orden_trabajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Personal]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Personal] ON [dbo].[tbl_orden_trabajo]
(
	[id_personal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Serie]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Serie] ON [dbo].[tbl_orden_trabajo]
(
	[id_serie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Tipo Trabajo]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Tipo Trabajo] ON [dbo].[tbl_orden_trabajo]
(
	[id_tipo_trabajo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ubicacion]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Ubicacion] ON [dbo].[tbl_orden_trabajo]
(
	[id_ubicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Final]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Final] ON [dbo].[tbl_preguntas]
(
	[final] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Inicio]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Inicio] ON [dbo].[tbl_preguntas]
(
	[inicio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Pregunta]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Pregunta] ON [dbo].[tbl_preguntas]
(
	[pregunta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Empresa]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Empresa] ON [dbo].[tbl_regiones]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Region]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Region] ON [dbo].[tbl_regiones]
(
	[id_region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Empresa]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Empresa] ON [dbo].[tbl_sectores]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Region]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Region] ON [dbo].[tbl_sectores]
(
	[id_region] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Sector]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Sector] ON [dbo].[tbl_sectores]
(
	[id_sector] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Agencia]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Agencia] ON [dbo].[tbl_tipos_negocios]
(
	[id_agencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Tipo Negocio]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Tipo Negocio] ON [dbo].[tbl_tipos_negocios]
(
	[id_tipo_negocio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Agencia]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Agencia] ON [dbo].[tbl_ubicaciones]
(
	[id_agencia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ubicacion]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Ubicacion] ON [dbo].[tbl_ubicaciones]
(
	[id_ubicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [Empresa]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Empresa] ON [dbo].[tbl_ubicaciones_permiso]
(
	[id_empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ubicacion]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Ubicacion] ON [dbo].[tbl_ubicaciones_permiso]
(
	[id_ubicacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Ubicacion Maestra]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Ubicacion Maestra] ON [dbo].[tbl_ubicaciones_permiso]
(
	[id_ubicacion_maestra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Usuario]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Usuario] ON [dbo].[tbl_ubicaciones_permiso]
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Personal]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Personal] ON [dbo].[tbl_usuarios]
(
	[id_empleado] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Usuario]    Script Date: 12/11/2022 18:32:05 ******/
CREATE NONCLUSTERED INDEX [Usuario] ON [dbo].[tbl_usuarios]
(
	[id_usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cierre_detalle] ADD  CONSTRAINT [DF_cierre_detalle_esta_en_sac]  DEFAULT ((0)) FOR [esta_en_sac]
GO
ALTER TABLE [dbo].[cierre_detalle] ADD  CONSTRAINT [DF_cierre_detalle_esta_en_xls]  DEFAULT ((0)) FOR [esta_en_xls]
GO
ALTER TABLE [dbo].[sal] ADD  CONSTRAINT [DF_sal_valor_unitario]  DEFAULT (0.00) FOR [valor_unitario]
GO
ALTER TABLE [dbo].[tbl_activos] ADD  CONSTRAINT [DF_tbl_activos_estado]  DEFAULT (0) FOR [estado]
GO
ALTER TABLE [dbo].[tbl_activos] ADD  CONSTRAINT [DF_tbl_activos_tiene_imagen]  DEFAULT (0) FOR [tiene_imagen]
GO
ALTER TABLE [dbo].[tbl_activos] ADD  CONSTRAINT [DF_tbl_activos_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_activos] ADD  CONSTRAINT [DF_tbl_activos_id_orden_traslado]  DEFAULT (0) FOR [id_orden_traslado]
GO
ALTER TABLE [dbo].[tbl_activos] ADD  CONSTRAINT [DF_tbl_activos_viejo]  DEFAULT (0) FOR [viejo]
GO
ALTER TABLE [dbo].[tbl_activos] ADD  CONSTRAINT [DF__tbl_activ__visit__41AE9EFA]  DEFAULT (0) FOR [visitado]
GO
ALTER TABLE [dbo].[tbl_activos] ADD  CONSTRAINT [DF__tbl_activ__id_or__42A2C333]  DEFAULT (0) FOR [id_orden_trabajo]
GO
ALTER TABLE [dbo].[tbl_activos] ADD  CONSTRAINT [DF__tbl_activo__hora__4396E76C]  DEFAULT (' ') FOR [hora]
GO
ALTER TABLE [dbo].[tbl_activos] ADD  CONSTRAINT [DF__tbl_activos__dia__448B0BA5]  DEFAULT (360) FOR [dia]
GO
ALTER TABLE [dbo].[tbl_activos] ADD  CONSTRAINT [DF_tbl_activos_vuelta]  DEFAULT (1) FOR [vuelta]
GO
ALTER TABLE [dbo].[tbl_activos] ADD  CONSTRAINT [DF__tbl_activ__id_pr__58920452]  DEFAULT (0) FOR [id_problema]
GO
ALTER TABLE [dbo].[tbl_apariencia] ADD  CONSTRAINT [DF_tbl_apariencia_de]  DEFAULT (0) FOR [de]
GO
ALTER TABLE [dbo].[tbl_apariencia] ADD  CONSTRAINT [DF_tbl_apariencia_a]  DEFAULT (0) FOR [hasta]
GO
ALTER TABLE [dbo].[tbl_apariencia] ADD  CONSTRAINT [DF_tbl_apariencia_color]  DEFAULT (0) FOR [color]
GO
ALTER TABLE [dbo].[tbl_categorias] ADD  CONSTRAINT [DF_tbl_categorias_categoria]  DEFAULT (1) FOR [categoria]
GO
ALTER TABLE [dbo].[tbl_correlativo_ewo] ADD  CONSTRAINT [DF_tbl_correlativo_ewo_fecha_impresion]  DEFAULT (getdate()) FOR [fecha_impresion]
GO
ALTER TABLE [dbo].[tbl_departamentos] ADD  CONSTRAINT [DF__tbl_depar__id_pa__241E3C13]  DEFAULT ('503') FOR [id_pais]
GO
ALTER TABLE [dbo].[tbl_detalle_areas] ADD  CONSTRAINT [DF_tbl_detalle_areas_fecha]  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[tbl_detalle_areas] ADD  CONSTRAINT [DF_tbl_detalle_areas_dia_trabajo]  DEFAULT (0) FOR [dia_trabajo]
GO
ALTER TABLE [dbo].[tbl_detalle_areas] ADD  CONSTRAINT [DF_tbl_detalle_areas_traslado_visor]  DEFAULT (0) FOR [traslado_visor]
GO
ALTER TABLE [dbo].[tbl_detalle_areas] ADD  CONSTRAINT [DF_tbl_detalle_areas_visitado]  DEFAULT (0) FOR [visitado]
GO
ALTER TABLE [dbo].[tbl_detalle_areas] ADD  CONSTRAINT [DF_tbl_detalle_areas_orden]  DEFAULT (1) FOR [orden]
GO
ALTER TABLE [dbo].[tbl_detalle_ingreso_items] ADD  CONSTRAINT [DF_tbl_detalle_ingreso_items_costo]  DEFAULT (0.00) FOR [costo]
GO
ALTER TABLE [dbo].[tbl_detalle_ingresos] ADD  CONSTRAINT [DF_tbl_detalle_ingresos_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_detalle_ingresos] ADD  CONSTRAINT [DF_tbl_detalle_ingresos_fabricado]  DEFAULT (0) FOR [fabricado]
GO
ALTER TABLE [dbo].[tbl_detalle_orden_trabajo] ADD  CONSTRAINT [DF_tbl_detalle_orden_trabajo_cantidad]  DEFAULT (1) FOR [cantidad]
GO
ALTER TABLE [dbo].[tbl_detalle_orden_trabajo] ADD  CONSTRAINT [DF_tbl_detalle_orden_trabajo_valor_unitario]  DEFAULT (0.00) FOR [valor_unitario]
GO
ALTER TABLE [dbo].[tbl_detalle_orden_trabajo] ADD  CONSTRAINT [DF_tbl_detalle_orden_trabajo_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_detalle_orden_trabajo] ADD  CONSTRAINT [DF_tbl_detalle_orden_trabajo_primera_linea]  DEFAULT (0) FOR [primera_linea]
GO
ALTER TABLE [dbo].[tbl_detalle_orden_trabajo] ADD  CONSTRAINT [DF__tbl_detal__total__110B679F]  DEFAULT (0.00) FOR [total]
GO
ALTER TABLE [dbo].[tbl_detalle_presupuesto] ADD  CONSTRAINT [DF_tbl_detalle_presupuesto_valor_unitario]  DEFAULT (0.00) FOR [valor_unitario]
GO
ALTER TABLE [dbo].[tbl_detalle_presupuesto] ADD  CONSTRAINT [DF_tbl_detalle_presupuesto_cantidad]  DEFAULT (1) FOR [cantidad]
GO
ALTER TABLE [dbo].[tbl_detalle_presupuesto] ADD  CONSTRAINT [DF_tbl_detalle_presupuesto_total]  DEFAULT (0.00) FOR [total]
GO
ALTER TABLE [dbo].[tbl_empresas] ADD  CONSTRAINT [DF_tbl_empresas_direccion]  DEFAULT (' ') FOR [direccion]
GO
ALTER TABLE [dbo].[tbl_empresas] ADD  CONSTRAINT [DF_tbl_empresas_telefonos]  DEFAULT (' ') FOR [telefonos]
GO
ALTER TABLE [dbo].[tbl_empresas] ADD  CONSTRAINT [DF_tbl_empresas_fax]  DEFAULT (' ') FOR [fax]
GO
ALTER TABLE [dbo].[tbl_empresas] ADD  CONSTRAINT [DF_tbl_empresas_nit]  DEFAULT ('C/F') FOR [nit]
GO
ALTER TABLE [dbo].[tbl_empresas] ADD  CONSTRAINT [DF_tbl_empresas_representante_legal]  DEFAULT (' ') FOR [representante_legal]
GO
ALTER TABLE [dbo].[tbl_empresas] ADD  CONSTRAINT [DF_tbl_empresas_nit_representante_legal]  DEFAULT (' ') FOR [nit_representante_legal]
GO
ALTER TABLE [dbo].[tbl_empresas] ADD  CONSTRAINT [DF_tbl_empresas_inicio_periodo]  DEFAULT (' ') FOR [inicio_periodo]
GO
ALTER TABLE [dbo].[tbl_empresas] ADD  CONSTRAINT [DF_tbl_empresas_iva]  DEFAULT (0.00) FOR [iva]
GO
ALTER TABLE [dbo].[tbl_empresas] ADD  CONSTRAINT [DF_tbl_empresas_id_exportador]  DEFAULT (' ') FOR [id_exportador]
GO
ALTER TABLE [dbo].[tbl_empresas] ADD  CONSTRAINT [DF_tbl_empresas_id_moneda]  DEFAULT ('QTG') FOR [id_moneda]
GO
ALTER TABLE [dbo].[tbl_empresas] ADD  CONSTRAINT [DF_tbl_empresas_logotipo]  DEFAULT (' ') FOR [logotipo]
GO
ALTER TABLE [dbo].[tbl_empresas] ADD  CONSTRAINT [DF_tbl_empresas_id_region]  DEFAULT (1) FOR [id_region]
GO
ALTER TABLE [dbo].[tbl_empresas] ADD  CONSTRAINT [DF_tbl_empresas_id_agencia]  DEFAULT (1) FOR [id_agencia]
GO
ALTER TABLE [dbo].[tbl_equipo_tecnico] ADD  CONSTRAINT [DF_tbl_equipo_tecnico_cantidad]  DEFAULT (1) FOR [cantidad]
GO
ALTER TABLE [dbo].[tbl_equipo_tecnico] ADD  CONSTRAINT [DF_tbl_equipo_tecnico_fecha]  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[tbl_etapas] ADD  CONSTRAINT [DF_tbl_etapas_no_meses]  DEFAULT (3) FOR [no_meses]
GO
ALTER TABLE [dbo].[tbl_etapas] ADD  CONSTRAINT [DF__tbl_etapas__dias__10174366]  DEFAULT (30) FOR [dias]
GO
ALTER TABLE [dbo].[tbl_galeria_fotos] ADD  CONSTRAINT [DF_tbl_galeria_fotos_fecha]  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[tbl_ingreso_items] ADD  CONSTRAINT [DF_tbl_ingreso_items_fecha]  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[tbl_ingreso_items] ADD  CONSTRAINT [DF_tbl_ingreso_items_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_ingresos] ADD  CONSTRAINT [DF_tbl_ingresos_fecha]  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[tbl_ingresos] ADD  CONSTRAINT [DF_tbl_ingresos_id_estado]  DEFAULT (0) FOR [id_estado]
GO
ALTER TABLE [dbo].[tbl_ingresos] ADD  CONSTRAINT [DF_tbl_ingresos_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_logotipos] ADD  CONSTRAINT [DF_tbl_logotipos_suspendido]  DEFAULT (0) FOR [suspendido]
GO
ALTER TABLE [dbo].[tbl_logotipos] ADD  CONSTRAINT [DF_tbl_logotipos_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_marcas] ADD  CONSTRAINT [DF_tbl_marcas_suspendido]  DEFAULT (0) FOR [suspendido]
GO
ALTER TABLE [dbo].[tbl_marcas] ADD  CONSTRAINT [DF_tbl_marcas_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_menu_de_items] ADD  CONSTRAINT [DF_tbl_menu_de_items_caption]  DEFAULT (' ') FOR [caption]
GO
ALTER TABLE [dbo].[tbl_menu_de_items] ADD  CONSTRAINT [DF_tbl_menu_de_items_texto]  DEFAULT (' ') FOR [texto]
GO
ALTER TABLE [dbo].[tbl_menu_de_items] ADD  CONSTRAINT [DF_tbl_menu_de_items_imagen]  DEFAULT (0) FOR [imagen]
GO
ALTER TABLE [dbo].[tbl_menu_de_items] ADD  CONSTRAINT [DF_tbl_menu_de_items_numero]  DEFAULT (1) FOR [numero]
GO
ALTER TABLE [dbo].[tbl_menu_de_items] ADD  CONSTRAINT [DF_tbl_menu_de_items_hint]  DEFAULT (' ') FOR [hint]
GO
ALTER TABLE [dbo].[tbl_menu_de_items] ADD  CONSTRAINT [DF_tbl_menu_de_items_distribuida]  DEFAULT (0) FOR [distribuida]
GO
ALTER TABLE [dbo].[tbl_menu_de_opciones] ADD  CONSTRAINT [DF_tbl_menu_de_opciones_correlativo]  DEFAULT (1) FOR [numero]
GO
ALTER TABLE [dbo].[tbl_menu_de_usuario] ADD  CONSTRAINT [DF_tbl_menu_de_usuario_estado]  DEFAULT (0) FOR [estado]
GO
ALTER TABLE [dbo].[tbl_menu_de_usuario] ADD  CONSTRAINT [DF_tbl_menu_de_usuario_en_barra]  DEFAULT (0) FOR [en_barra]
GO
ALTER TABLE [dbo].[tbl_menu_de_usuario] ADD  CONSTRAINT [DF_tbl_menu_de_usuario_id_empresa]  DEFAULT (1) FOR [id_empresa]
GO
ALTER TABLE [dbo].[tbl_modelos] ADD  CONSTRAINT [DF_tbl_modelos_suspendido]  DEFAULT (0.00) FOR [costo]
GO
ALTER TABLE [dbo].[tbl_modelos] ADD  CONSTRAINT [DF_tbl_modelos_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_modelos] ADD  CONSTRAINT [DF_tbl_modelos_lineas]  DEFAULT ('PEPSI') FOR [linea]
GO
ALTER TABLE [dbo].[tbl_monedas] ADD  CONSTRAINT [DF_tbl_monedas_traladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_movimientos] ADD  CONSTRAINT [DF_tbl_movimientos_fecha_ingreso]  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[tbl_movimientos] ADD  CONSTRAINT [DF_tbl_movimientos_id_ingreso]  DEFAULT (0) FOR [id_ingreso]
GO
ALTER TABLE [dbo].[tbl_movimientos] ADD  CONSTRAINT [DF_tbl_movimientos_estado]  DEFAULT (0) FOR [estado]
GO
ALTER TABLE [dbo].[tbl_movimientos] ADD  CONSTRAINT [DF_tbl_movimientos_id_orden_traslado]  DEFAULT (0) FOR [id_orden_traslado]
GO
ALTER TABLE [dbo].[tbl_movimientos] ADD  CONSTRAINT [DF_tbl_movimientos_id_negocio_anterior]  DEFAULT (0) FOR [id_negocio_anterior]
GO
ALTER TABLE [dbo].[tbl_movimientos] ADD  CONSTRAINT [DF_tbl_movimientos_negocio]  DEFAULT (0) FOR [negocio]
GO
ALTER TABLE [dbo].[tbl_movimientos] ADD  CONSTRAINT [DF_tbl_movimientos_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_movimientos] ADD  CONSTRAINT [DF_tbl_movimientos_valor]  DEFAULT (0.00) FOR [valor]
GO
ALTER TABLE [dbo].[tbl_movimientos] ADD  CONSTRAINT [DF_tbl_movimientos_id_opcion_trabajo]  DEFAULT (0) FOR [id_opcion_trabajo]
GO
ALTER TABLE [dbo].[tbl_movimientos] ADD  CONSTRAINT [DF_tbl_movimientos_id_tipo_movimiento]  DEFAULT (1) FOR [id_tipo_movimiento]
GO
ALTER TABLE [dbo].[tbl_movimientos] ADD  CONSTRAINT [DF_tbl_movimientos_viejo]  DEFAULT (0) FOR [viejo]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF_tbl_negocios_fecha_creacion]  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF_tbl_negocios_suspendido]  DEFAULT (0) FOR [suspendido]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF_tbl_negocios_id_etapa]  DEFAULT (3) FOR [id_etapa]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF_tbl_negocios_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF_tbl_negocios_latitud_grad]  DEFAULT (0) FOR [latitud_grad]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF_tbl_negocios_latitud_min]  DEFAULT (0) FOR [latitud_min]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF_tbl_negocios_latitud_seg]  DEFAULT (0) FOR [latitud_seg]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF_tbl_negocios_longitud_grad]  DEFAULT (0) FOR [longitud_grad]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF_tbl_negocios_longitud_min]  DEFAULT (0) FOR [longitud_min]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF_tbl_negocios_longitud_seg]  DEFAULT (0) FOR [longitud_seg]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF_tbl_negocios_venta_mensual]  DEFAULT (0) FOR [venta_mensual]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF__tbl_negoc__telef__0E2EFAF4]  DEFAULT (' ') FOR [telefono]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF__tbl_negoc__id_se__0F231F2D]  DEFAULT ('1') FOR [id_sector]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF__tbl_negoc__id_pa__1A94D1D9]  DEFAULT ('503') FOR [id_pais]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF__tbl_negoc__visit__1B88F612]  DEFAULT (0) FOR [visitado]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF__tbl_negoc__id_or__1C7D1A4B]  DEFAULT (0) FOR [id_orden_trabajo]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF__tbl_negoci__hora__1D713E84]  DEFAULT (' ') FOR [hora]
GO
ALTER TABLE [dbo].[tbl_negocios] ADD  CONSTRAINT [DF__tbl_negocio__dia__1E6562BD]  DEFAULT (360) FOR [dia]
GO
ALTER TABLE [dbo].[tbl_numeros_serie] ADD  CONSTRAINT [DF_tbl_numeros_serie_actualizado]  DEFAULT (0) FOR [actualizado]
GO
ALTER TABLE [dbo].[tbl_numeros_serie] ADD  CONSTRAINT [DF_tbl_numeros_serie_actualizada_orden]  DEFAULT (0) FOR [actualizada_orden]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF_tbl_orden_servicio_fecha]  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF_tbl_orden_servicio_id_calidad]  DEFAULT (0) FOR [id_calidad]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF_tbl_orden_servicio_total]  DEFAULT (0.00) FOR [total]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF_tbl_orden_trabajo_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF_tbl_orden_trabajo_estado]  DEFAULT (0) FOR [estado]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF_tbl_orden_trabajo_con_llamada]  DEFAULT (0) FOR [con_llamada]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF_tbl_orden_trabajo_aplico_correctivo]  DEFAULT (0) FOR [aplico_correctivo]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF_tbl_orden_trabajo_ya_utilizada]  DEFAULT (0) FOR [ya_utilizada]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF_tbl_orden_trabajo_foraneo]  DEFAULT (0) FOR [foraneo]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF__tbl_orden__id_pr__5986288B]  DEFAULT (0) FOR [id_problema]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF_tbl_orden_trabajo_fecha_operacion]  DEFAULT (getdate()) FOR [fecha_operacion]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF__tbl_orden__fecha__190C7C1A]  DEFAULT (getdate()) FOR [fecha_llamada]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF__tbl_orden__fecha__1A00A053]  DEFAULT (getdate()) FOR [fecha_termino]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF__tbl_orden__horas__1AF4C48C]  DEFAULT (0) FOR [horas_acumuladas]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF__tbl_orden__tempe__1BE8E8C5]  DEFAULT (0) FOR [temperatura]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF__tbl_orden__calif__1CDD0CFE]  DEFAULT (0) FOR [calificacion]
GO
ALTER TABLE [dbo].[tbl_orden_trabajo] ADD  CONSTRAINT [DF__tbl_orden__fines__1DD13137]  DEFAULT (0) FOR [fines_semana]
GO
ALTER TABLE [dbo].[tbl_personal] ADD  CONSTRAINT [DF_tbl_personal_suspendido]  DEFAULT (0) FOR [suspendido]
GO
ALTER TABLE [dbo].[tbl_personal] ADD  CONSTRAINT [DF_tbl_personal_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_personal] ADD  CONSTRAINT [DF_tbl_personal_vuelta]  DEFAULT (1) FOR [vuelta]
GO
ALTER TABLE [dbo].[tbl_preguntas] ADD  CONSTRAINT [DF_tbl_preguntas_inicio]  DEFAULT (0.00) FOR [inicio]
GO
ALTER TABLE [dbo].[tbl_preguntas] ADD  CONSTRAINT [DF_tbl_preguntas_final]  DEFAULT (100) FOR [final]
GO
ALTER TABLE [dbo].[tbl_preguntas] ADD  CONSTRAINT [DF_tbl_preguntas_carita]  DEFAULT (1) FOR [carita]
GO
ALTER TABLE [dbo].[tbl_presupuesto] ADD  CONSTRAINT [DF_tbl_presupuesto_total]  DEFAULT (0.00) FOR [total]
GO
ALTER TABLE [dbo].[tbl_reporte_pepsi] ADD  CONSTRAINT [DF_tbl_reporte_pepsi_grupo]  DEFAULT (1) FOR [grupo]
GO
ALTER TABLE [dbo].[tbl_sectores] ADD  CONSTRAINT [DF__tbl_secto__id_te__26068485]  DEFAULT (101) FOR [id_tecnico]
GO
ALTER TABLE [dbo].[tbl_temperatura] ADD  CONSTRAINT [DF_tbl_temperatura_valor]  DEFAULT (0.00) FOR [valor_inicial]
GO
ALTER TABLE [dbo].[tbl_temperatura] ADD  CONSTRAINT [DF_tbl_temperatura_valor_final]  DEFAULT (0.00) FOR [valor_final]
GO
ALTER TABLE [dbo].[tbl_tiempos] ADD  CONSTRAINT [DF_tbl_tiempos_codigo_visita]  DEFAULT (0) FOR [codigo_visita]
GO
ALTER TABLE [dbo].[tbl_tiempos] ADD  CONSTRAINT [DF_tbl_tiempos_Tipo]  DEFAULT (0) FOR [Tipo]
GO
ALTER TABLE [dbo].[tbl_tiempos] ADD  CONSTRAINT [DF_tbl_tiempos_Etapa]  DEFAULT (0) FOR [Etapa]
GO
ALTER TABLE [dbo].[tbl_tiempos] ADD  CONSTRAINT [DF_tbl_tiempos_Anio]  DEFAULT (0) FOR [Anio]
GO
ALTER TABLE [dbo].[tbl_tiempos] ADD  CONSTRAINT [DF_tbl_tiempos_Mes]  DEFAULT (0) FOR [Mes]
GO
ALTER TABLE [dbo].[tbl_tiempos] ADD  CONSTRAINT [DF_tbl_tiempos_Dia]  DEFAULT (0) FOR [Dia]
GO
ALTER TABLE [dbo].[tbl_tiempos] ADD  CONSTRAINT [DF_tbl_tiempos_Hora]  DEFAULT (0) FOR [Hora]
GO
ALTER TABLE [dbo].[tbl_tiempos] ADD  CONSTRAINT [DF_tbl_tiempos_Minuto]  DEFAULT (0) FOR [Minuto]
GO
ALTER TABLE [dbo].[tbl_tiempos] ADD  CONSTRAINT [DF_tbl_tiempos_Segundo]  DEFAULT (0) FOR [Segundo]
GO
ALTER TABLE [dbo].[tbl_tipos] ADD  CONSTRAINT [DF_tbl_tipos_suspendido]  DEFAULT (0) FOR [suspendido]
GO
ALTER TABLE [dbo].[tbl_tipos] ADD  CONSTRAINT [DF_tbl_tipos_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_tipos_negocios] ADD  CONSTRAINT [DF_tbl_tipos_negocios_suspendido]  DEFAULT (0) FOR [suspendido]
GO
ALTER TABLE [dbo].[tbl_tipos_negocios] ADD  CONSTRAINT [DF_tbl_tipos_negocios_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_tipos_opcion_trabajo] ADD  CONSTRAINT [DF_tbl_tipos_opcion_trabajo_servicio]  DEFAULT (0) FOR [servicio]
GO
ALTER TABLE [dbo].[tbl_tipos_opcion_trabajo] ADD  CONSTRAINT [DF_tbl_tipos_opcion_trabajo_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_tipos_opcion_trabajo] ADD  CONSTRAINT [DF_tbl_tipos_opcion_trabajo_valor]  DEFAULT (0.00) FOR [valor]
GO
ALTER TABLE [dbo].[tbl_tipos_opcion_trabajo] ADD  CONSTRAINT [DF__tbl_tipos__id_cl__66E023A9]  DEFAULT (1) FOR [id_clasficacion]
GO
ALTER TABLE [dbo].[tbl_tipos_trabajo] ADD  CONSTRAINT [DF_tbl_tipos_trabajo_servicio]  DEFAULT (0) FOR [servicio]
GO
ALTER TABLE [dbo].[tbl_transportistas] ADD  CONSTRAINT [DF_tbl_transportistas_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_traslados] ADD  CONSTRAINT [DF_tbl_traslados_id_negocio_anterior]  DEFAULT (0) FOR [id_negocio_anterior]
GO
ALTER TABLE [dbo].[tbl_traslados] ADD  CONSTRAINT [DF_tbl_traslados_id_negocio]  DEFAULT (0) FOR [id_negocio]
GO
ALTER TABLE [dbo].[tbl_traslados] ADD  CONSTRAINT [DF_tbl_traslados_fecha]  DEFAULT (getdate()) FOR [fecha]
GO
ALTER TABLE [dbo].[tbl_traslados] ADD  CONSTRAINT [DF_tbl_traslados_estado]  DEFAULT (0) FOR [estado]
GO
ALTER TABLE [dbo].[tbl_traslados] ADD  CONSTRAINT [DF_tbl_traslados_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_traslados] ADD  DEFAULT (0) FOR [comprometido]
GO
ALTER TABLE [dbo].[tbl_traslados] ADD  DEFAULT (getdate()) FOR [fecha_requerida]
GO
ALTER TABLE [dbo].[tbl_traslados] ADD  DEFAULT (0) FOR [tiempo_acumulado]
GO
ALTER TABLE [dbo].[tbl_ubicaciones] ADD  CONSTRAINT [DF_tbl_ubicaciones_tipo]  DEFAULT (0) FOR [tipo]
GO
ALTER TABLE [dbo].[tbl_ubicaciones] ADD  CONSTRAINT [DF_tbl_ubicaciones_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_unidad_medida] ADD  CONSTRAINT [DF_tbl_unidad_medida_trasladado]  DEFAULT (0) FOR [trasladado]
GO
ALTER TABLE [dbo].[tbl_usuarios] ADD  CONSTRAINT [DF_tbl_usuarios_descripcion]  DEFAULT (' ') FOR [descripcion]
GO
ALTER TABLE [dbo].[tbl_usuarios] ADD  CONSTRAINT [DF_tbl_usuarios_tipo_usuario]  DEFAULT (9) FOR [tipo_usuario]
GO
ALTER TABLE [dbo].[tbl_usuarios] ADD  CONSTRAINT [DF_tbl_usuarios_cuenta_correo]  DEFAULT (' ') FOR [cuenta_correo]
GO
ALTER TABLE [dbo].[tbl_usuarios] ADD  CONSTRAINT [DF_tbl_usuarios_clave]  DEFAULT ('1234') FOR [clave]
GO
ALTER TABLE [dbo].[tbl_usuarios] ADD  CONSTRAINT [DF_tbl_usuarios_id_empleado]  DEFAULT (' ') FOR [id_empleado]
GO
ALTER TABLE [dbo].[tbl_usuarios] ADD  CONSTRAINT [DF_tbl_usuarios_con_outlook]  DEFAULT (1) FOR [con_outlook]
GO
ALTER TABLE [dbo].[tbl_usuarios] ADD  CONSTRAINT [DF_tbl_usuarios_id_gerencia]  DEFAULT (0) FOR [id_gerencia]
GO
ALTER TABLE [dbo].[tbl_usuarios] ADD  CONSTRAINT [DF_tbl_usuarios_colorFondo]  DEFAULT (12639424) FOR [colorFondo]
GO
ALTER TABLE [dbo].[tbl_usuarios] ADD  CONSTRAINT [DF_tbl_usuarios_colorobjetos]  DEFAULT (12639424) FOR [colorobjetos]
GO
ALTER TABLE [dbo].[tbl_usuarios] ADD  CONSTRAINT [DF_tbl_usuarios_colorfont]  DEFAULT (0) FOR [colorfont]
GO
ALTER TABLE [dbo].[tbl_usuarios] ADD  CONSTRAINT [DF_tbl_usuarios_estiloweb]  DEFAULT (0) FOR [estiloweb]
GO
ALTER TABLE [dbo].[tbl_usuarios] ADD  CONSTRAINT [DF_tbl_usuarios_aplicar]  DEFAULT (1) FOR [aplicar]
GO
ALTER TABLE [dbo].[tbl_usuarios] ADD  CONSTRAINT [DF_tbl_usuarios_puede_editar]  DEFAULT (0) FOR [puede_editar]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_codigo]  DEFAULT (0) FOR [codigo]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_visitado]  DEFAULT (0) FOR [visitado]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_anio]  DEFAULT (0) FOR [anio]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_mes]  DEFAULT (0) FOR [mes]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_dia]  DEFAULT (0) FOR [dia]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_hora]  DEFAULT (0) FOR [hora]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_minuto]  DEFAULT (0) FOR [minuto]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_comentarios]  DEFAULT ('Sin Comentarios') FOR [comentarios]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_usuario]  DEFAULT (0) FOR [usuario]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_negocios_actualizados]  DEFAULT (0) FOR [negocios_actualizados]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_ordenes_actualizadas]  DEFAULT (0) FOR [ordenes_actualizadas]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_visitas_actualizadas]  DEFAULT (0) FOR [visitas_actualizadas]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_id_negocio]  DEFAULT (0) FOR [id_negocio]
GO
ALTER TABLE [dbo].[tbl_visitas] ADD  CONSTRAINT [DF_tbl_visitas_id_tecnico]  DEFAULT (0) FOR [id_tecnico]
GO
ALTER TABLE [dbo].[cierre_detalle]  WITH CHECK ADD  CONSTRAINT [FK_cierre_detalle_cierre_main] FOREIGN KEY([pk_cierre_main])
REFERENCES [dbo].[cierre_main] ([pk_cierre_main])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[cierre_detalle] CHECK CONSTRAINT [FK_cierre_detalle_cierre_main]
GO
ALTER TABLE [dbo].[tbl_activos]  WITH NOCHECK ADD  CONSTRAINT [FK_tbl_activos_tbl_fabricantes] FOREIGN KEY([id_fabricante])
REFERENCES [dbo].[tbl_fabricantes] ([id_fabricante])
GO
ALTER TABLE [dbo].[tbl_activos] CHECK CONSTRAINT [FK_tbl_activos_tbl_fabricantes]
GO
ALTER TABLE [dbo].[tbl_ingresos]  WITH CHECK ADD  CONSTRAINT [FK_tbl_ingresos_tbl_fabricantes] FOREIGN KEY([id_fabricante])
REFERENCES [dbo].[tbl_fabricantes] ([id_fabricante])
GO
ALTER TABLE [dbo].[tbl_ingresos] CHECK CONSTRAINT [FK_tbl_ingresos_tbl_fabricantes]
GO
/****** Object:  StoredProcedure [dbo].[borrar_cierre_detalle]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[borrar_cierre_detalle]
@pk_cierre_main int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    delete from cierre_detalle where pk_cierre_main=@pk_cierre_main
	
END
GO
/****** Object:  StoredProcedure [dbo].[cargar_serie_invividual]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[cargar_serie_invividual] 
	@pk_cierre_main int, @id_serie char(20),@id_tipomovimiento int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
set @id_serie=dbo.cadena_sin_cero_izquierda(@id_serie)

    -- Insert statements for procedure here
	insert into cierre_detalle(pk_cierre_main,id_serie,id_tipo_movimiento_xls,esta_en_xls)values(@pk_cierre_main , @id_serie ,@id_tipomovimiento,1)
END
GO
/****** Object:  StoredProcedure [dbo].[comparar_sac_con_xls]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[comparar_sac_con_xls]
	@pk_cierre_main int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
declare @hasta datetime 
declare @desde datetime 

declare @consulta TABLE (Distribuidora varchar(50),	Sede varchar(2),	EMO_EWO int,		FechaRealizado datetime,	Sio varchar(50),	 Negocio varchar(50),	Direccion varchar(50),	Modelo varchar(50),		Serie char(20),	Ficha varchar(25),		 Activo varchar(25),	actividad varchar(50),	id_opcion_trabajo int,	Tipo_mov varchar(50),	total numeric(18,2),id_tipo_mov int)



select @desde=desde,@hasta=hasta from cierre_main where cierre_main.pk_cierre_main=@pk_cierre_main
set @hasta=dbo.DateMaximun(@hasta)


insert into @consulta select * from dbo.reporte_movimientos( @desde,@hasta)

update cierre_detalle set esta_en_sac=1,COMENTARIO='Solo en Hoja Compartida' where pk_cierre_main=@pk_cierre_main 
and id_serie in (select id_serie from @consulta where [@consulta].Serie=cierre_detalle.id_serie )


update cierre_detalle set id_tipo_movimiento_sac=(select top 1 id_tipo_mov from @consulta where [@consulta].Serie=cierre_detalle.id_serie ),Comentario='Correcto en Hoja Comparatida y SAC'
where pk_cierre_main=@pk_cierre_main and esta_en_sac=1



insert into cierre_detalle(pk_cierre_main, id_serie, esta_en_sac,id_tipo_movimiento_sac,comentario) 
select @pk_cierre_main ,Serie ,1, id_tipo_mov ,'SAC PERO NO EN HOJACOMPARTIDA' from @consulta where not Serie in (select id_serie from cierre_detalle where cierre_detalle.pk_cierre_main=@pk_cierre_main )
update cierre_detalle set COmentario='Solo Hoja Compartida' where pk_cierre_main=@pk_cierre_main and esta_en_sac=0 and esta_en_xls=1

    
END
GO
/****** Object:  StoredProcedure [dbo].[Inventario_local]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Inventario_local]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
	
	
	
	
	
	
/*	
	
	
	
	
	
	
	DECLARE @FECHA_LIMITE DATE='20130430'
declare @consulta table(FechaRealizado datetime,actividad varchar(50),Sio varchar(50),serie varchar(50),Ficha varchar(50) ,Modelo varchar(50),	  Activo varchar (50), ID_NEGOCIO int,linea varchar(50),
nombre varchar(50),	departamento varchar(50),	zona_dep varchar(50), viejo int,id_tipo_trabajo int,fechaOT datetime)
	
insert into @consulta 	
select 
	c.fecha_orden_traslado		as FechaRealizado,
	'' AS actividad,
	b.id_alterno  as Sio,
	rtrim (c.id_serie)	as Serie,
	c.id_ficha	as Ficha,
	d.descripcion as Modelo,	
	c.id_activo	as Activo, c.ID_NEGOCIO,
	d.linea,b.nombre,	tbl_departamentos.nombre as departamento,
	tbl_departamentos.zona as zona_dep,c.viejo,tbl_orden_trabajo.id_tipo_trabajo, tbl_orden_trabajo.fecha fechaOT
	
from tbl_activos c inner join
	tbl_negocios b on
	c.id_negocio = b.id_negocio inner join
	tbl_modelos d on
	c.id_modelo = d.id_modelo 
	left join tbl_ubicaciones on b.id_ubicacion=tbl_ubicaciones.id_ubicacion
	left join tbl_departamentos on b.id_departamento=tbl_departamentos.id_departamento
	left join tbl_municipios on b.id_municipio=tbl_municipios.id_municipio
	LEFT JOIN tbl_orden_trabajo On c.id_orden_trabajo=tbl_orden_trabajo.id_orden_trabajo
	
where c.ID_NEGOCIO in('86724','50598','51754','55830','47231','47233','47229','47215','47213','47221','47223','69709','68090','68755','68777','76616','73600','76616','80247','86723')  and viejo<>1
--AND C.ID_SERIE='130115152'

--and c.fecha_orden_traslado  between    '01-05-2013 00:00:00' and '31-12-2040 23:59:59'-- and 
order by b.id_alterno
update @consulta set actividad='EN TRANCITO' WHERE ID_NEGOCIO=50598 AND viejo<>1

update @consulta set actividad='BAJA DESECHO MERSA FISICO' WHERE ID_NEGOCIO=51754 AND viejo<>1 and FechaRealizado >@FECHA_LIMITE
update @consulta set actividad='DISPONIBLE' where id_negocio IN(47231,55830,68090) AND  VIEJO<>1
update @consulta set actividad='SEMIDISPONIBLE' WHERE id_tipo_trabajo=14  AND datepart(Year,getdate())=2015 
update @consulta set actividad=  (case when left(serie,2)='16'  then 'EQ NUEVO' else 'DISPONIBLE' end ) , Ficha =(case when left(serie,2)='16'  then 'EQ NEW' else FICHA end )  WHERE  id_negocio=55269 AND VIEJO<>1 AND FechaRealizado>'20130430'
update @consulta set actividad=  'SEMIDISPONIBLE'  WHERE id_negocio=47230 AND VIEJO<>1 AND FechaRealizado>@FECHA_LIMITE 
update @consulta set actividad=  'RECEPCION' WHERE id_negocio IN(47229,47213,47221,46992,68755,68777,69709,76616,86724,      47229,	  68755,	  86723, 47221,      47229,      68755,      86724) AND VIEJO<>1 AND FechaRealizado>@FECHA_LIMITE 
UPDATE @consulta SET actividad='EQ NUEVO'  WHERE id_negocio IN(47233,47215,47223,73600)  

--SELECT fecha,'RECEPCION' est,sio,negocio,negocio,serie,ficha,modelo,envio,activo,ot_coment,ZONA_DEP FROM pepsi WHERE pepsi.id_negocio IN(47229,47213,47221,46992,68755,68777,69709,76616) AND PEPSI.VIEJO=1 AND fecha>CTOD('30/04/2013') ORDER BY fecha INTO CURSOR taller_rece_1


select * from @consulta

*/
SELECT * from dbo.funcion_inventario()
END
GO
/****** Object:  StoredProcedure [dbo].[pa_abrir_sesion]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_abrir_sesion] @usuario char(20) AS

Declare @sesiones int

Set nocount on

Select	@sesiones=count(*)
From	tbl_sesiones
Where	id_usuario=@usuario	and
	activa=1

If @sesiones<=0 
  Begin

  Insert into	tbl_sesiones
  Select		@usuario as id_usuario,
		getdate()  as fecha,
		1	   as activa
end

Set nocount off

Select	@sesiones as Sesiones


GO
/****** Object:  StoredProcedure [dbo].[pa_actualiza_descripcion_pregunta]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_actualiza_descripcion_pregunta] @pregunta int, @descripcion char(50) AS

update	tbl_preguntas
set	descripcion	=	@descripcion
where	pregunta	=	@pregunta
GO
/****** Object:  StoredProcedure [dbo].[pa_actualiza_sector_negocio]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_actualiza_sector_negocio] @empresa int, @negocio int, @sector int AS

UPDATE	tbl_negocios
SET		id_sector=@sector
WHERE	id_empresa=@empresa	and
		id_negocio=@negocio
GO
/****** Object:  StoredProcedure [dbo].[pa_actualiza_vista]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_actualiza_vista] @empresa int, @negocio int AS
update	 tbl_detalle_areas
set	visitado=1
where	id_negocio=@negocio and
	id_empresa=@empresa



GO
/****** Object:  StoredProcedure [dbo].[pa_actualizar_activo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_actualizar_activo] @serie char(20),@negocio int, @contrato char(30), @ficha char(20), @sio char(20), @Orden int, @fecha_Orden datetime  AS
UPDATE 	tbl_activos
SET		id_negocio=@negocio,
		no_contrato=@contrato,
		id_ficha=@ficha,
		id_sio=@sio,
		id_orden_traslado=@orden,
		fecha_orden_traslado=@fecha_orden
WHERE 	id_serie = @serie



/*CREATE PROCEDURE pa_actualizar_activo @serie char(20),@negocio int, @contrato char(30), @ficha char(20), @sio char(20)  AS
UPDATE 	tbl_activos
SET		id_negocio=@negocio,
		no_contrato=@contrato,
		id_ficha=@ficha,
		id_sio=@sio
WHERE 	id_serie = @serie
*/

GO
/****** Object:  StoredProcedure [dbo].[pa_actualizar_correctivo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_actualizar_correctivo]
	@descripcion char(50),
	@codigo int,
	@categoria int

AS

Declare @correl int,
	@Existe int

select 	@correl=(max(correlativo))+1
From	tbl_correctivo

Select	@Existe=count(*)
From	tbl_correctivo
Where	codigo=@codigo

If @Existe>0
begin
Update tbl_correctivo
set	categoria=@categoria,
	descripcion=@descripcion
Where	codigo=@codigo
end
else
begin
Insert into tbl_correctivo
SELECT	@correl		as correlativo,
	@categoria 	as categoria,
	@codigo		as codigo,
	@descripcion	as descripcion
end


GO
/****** Object:  StoredProcedure [dbo].[pa_actualizar_ficha]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_actualizar_ficha] @serie char(20), @ficha char(20), @fabricado int  AS
UPDATE 	tbl_activos
SET		id_ficha=@ficha,
		fabricado=@fabricado
WHERE 	id_serie = @serie
GO
/****** Object:  StoredProcedure [dbo].[pa_actualizar_foto_negocio]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_actualizar_foto_negocio] @Correlativo int AS

Declare @empresa int,
	@negocio int

--AVERIGUANDO EL NEGOCIO DE LA FOTOGRAFIA
Select	@negocio=isnull(b.id_negocio,0),
	@empresa=isnull(a.id_empresa,0)
From	tbl_galeria_fotos	a	inner join
	tbl_orden_trabajo	b	on
	  a.id_empresa=b.id_empresa	and
	  a.id_orden_trabajo=b.id_orden_trabajo

If @negocio>0
begin
--ACTUALIZANDO LA IMAGEN Y EL ARCHIVO
UPDATE	tbl_negocios
SET	tbl_negocios.foto=c.foto,
	tbl_negocios.archivo=c.archivo
From	tbl_negocios		a	inner join
	tbl_orden_trabajo	b	on
	  a.id_empresa=b.id_empresa	and
	  a.id_negocio=b.id_negocio	inner join
	tbl_galeria_fotos	c	on
	  b.id_empresa=c.id_empresa	and
	  b.id_orden_trabajo=c.id_orden_trabajo
Where	a.id_negocio=@negocio	and
	a.id_empresa=@empresa
end
GO
/****** Object:  StoredProcedure [dbo].[pa_actualizar_orden_ya_utilizada]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_actualizar_orden_ya_utilizada] @nohoja char(50), @valor decimal(18,2) AS

declare @orden int

set nocount on

select	top 1 @orden=isnull(id_orden_trabajo,0)
from	db_sac..tbl_orden_trabajo
where	nohoja=@nohoja and
	total=@valor and
	ya_utilizada=0

If @orden>0 
  begin
  update 	db_sac..tbl_orden_trabajo
  set 		ya_utilizada=1
  where		id_orden_trabajo=@orden
end

set nocount off

select	isnull(@orden,0) as Orden
GO
/****** Object:  StoredProcedure [dbo].[pa_actualizar_problema_activo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_actualizar_problema_activo] @serie char(30), @problema int AS

UPDATE	tbl_activos
SET		id_problema	=	@problema
WHERE	id_serie		=	@serie
GO
/****** Object:  StoredProcedure [dbo].[pa_actualizar_serie]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_actualizar_serie] @serie char(30) AS


GO
/****** Object:  StoredProcedure [dbo].[pa_actualizar_total_orden_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_actualizar_total_orden_trabajo] @empresa int, @orden int AS
set nocount on
declare @total decimal(18,2)
select 	@total=sum(cantidad*valor_unitario)
from	tbl_detalle_orden_trabajo
where	id_empresa=@empresa and
	id_orden_trabajo=@orden

update 	tbl_orden_trabajo
set	total=@total
where 	id_empresa=@empresa and
	id_orden_trabajo=@orden

set nocount off

select 	@total as Gran_Total




GO
/****** Object:  StoredProcedure [dbo].[pa_agencias]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_agencias] AS
select	*
from	tbl_agencias


GO
/****** Object:  StoredProcedure [dbo].[pa_agregar_nuevas_op_usuario]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_agregar_nuevas_op_usuario] @usuario char(20) AS
SET NOCOUNT ON
/*INSERTANDO LAS OPCIONES NUEVAS A TODOS LOS USUARIOS
  EN ESTADO = 0*/
INSERT tbl_menu_de_usuario
select 	@usuario as id_usuario,
	a.id_proyecto,
	a.id_grupo,	
	a.id_item,
	0 as estado,
	0 as en_barra,
	c.id_empresa
from	tbl_menu_de_items a, tbl_empresas c
order by b.id_usuario,a.id_proyecto,a.id_grupo,a.id_item

SET NOCOUNT OFF

SELECT 0 AS REGISTROS



GO
/****** Object:  StoredProcedure [dbo].[pa_agregar_nuevas_opciones]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_agregar_nuevas_opciones] AS
SET NOCOUNT ON
/*INSERTANDO LAS OPCIONES NUEVAS A TODOS LOS USUARIOS
  EN ESTADO = 0*/
INSERT tbl_menu_de_usuario
select 	b.id_usuario,
	a.id_proyecto,
	a.id_grupo,	
	a.id_item,
	0 as estado,
	0 as en_barra,
	c.id_empresa
from	tbl_menu_de_items a, tbl_usuarios b, tbl_empresas c
where	a.distribuida=0
order by b.id_usuario,a.id_proyecto,a.id_grupo,a.id_item

/*ACTUALIZANDO LAS OPCIONES NUEVAS EN EL MENU DE ITEMS*/
UPDATE tbl_menu_de_items
set distribuida = 1
where distribuida=0

SET NOCOUNT OFF

SELECT 0 AS REGISTROS


GO
/****** Object:  StoredProcedure [dbo].[pa_agregar_todas_opciones]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_agregar_todas_opciones] @empresa int AS

/*INSERTANDO LAS OPCIONES NUEVAS A TODOS LOS USUARIOS*/
INSERT tbl_menu_de_usuario
select 	b.id_usuario,
	a.id_proyecto,
	a.id_grupo,	
	a.id_item,
	-1 as estado,
	0 as en_barra,
	@empresa as id_empresa
from	tbl_menu_de_items a, tbl_usuarios b 
order by b.id_usuario,a.id_proyecto,a.id_grupo,a.id_item



GO
/****** Object:  StoredProcedure [dbo].[pa_areas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_areas] @empresa int AS
select	*
from	tbl_areas
where	id_empresa=@empresa
order by id_area



GO
/****** Object:  StoredProcedure [dbo].[pa_asp_orden_ubicacion]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_asp_orden_ubicacion] @MMColParam varchar(20) AS

Select 	a.fecha 		as 	'Fecha Orden Trabajo',
	d.descripcion 		as 	'Descripcion Trabajo',
	a.id_orden_trabajo,
	a.numero_ss		as 	'solicitud',
	b.nombre 		as 	'Nombre de Negocio',
	b.direccion 		as 	'Direccion Negocio',
	a.id_sio 		as 	'No. Sio',
	a.Total 		as 	'Total',
	c.nombre 		as 	'Nombre Tecnico',
	e.id_serie		as	'serie',
	e.id_ficha		as	'ficha',
	e.id_activo		as	'activo',
	e.fabricado		as	'ano',
	w.pais,
	w.region,
	w.distribuidora,
	w.supervisor,
	w.descripcion		as 'ruta'
from 	tbl_orden_trabajo 	a	inner join 
	tbl_negocios 		b 	on
	a.id_negocio = b.id_negocio 	inner join
	tbl_personal 		c 	on
	a.id_personal = c.id_personal 	inner join
	tbl_tipos_opcion_trabajo d 	on
	a.id_tipo_trabajo = d.id_tipo_opcion_trabajo inner join
	tbl_activos 		e 	on
	a.id_serie = e.id_serie
inner join (  
(select	z.id_alterno as 'ruta',
	z.id_ubicacion,
	z.descripcion,
	z.id_ubicacion_maestra as id_ubicacion_supervisor,
	y.descripcion as supervisor,
	y.id_ubicacion_maestra as id_ubicacion_distribuidora,
	v.descripcion as distribuidora,
	v.id_ubicacion_maestra as id_ubicacion_region,
	s.descripcion as region,
	s.id_ubicacion_maestra as id_ubicacion_pais,
	q.descripcion as pais
from	tbl_ubicaciones z inner join
	(
              select	x.id_ubicacion,
	   	x.id_ubicacion_maestra,
		x.descripcion
             from	tbl_ubicaciones x
	) y on 
             	z.id_ubicacion_maestra=y.id_ubicacion inner join
	(
              select	u.id_ubicacion,
	   	u.id_ubicacion_maestra,
		u.descripcion
             from	tbl_ubicaciones u
	) v on 
             	y.id_ubicacion_maestra=v.id_ubicacion inner join
	(
              select	t.id_ubicacion,
	   	t.id_ubicacion_maestra,
		t.descripcion
             from	tbl_ubicaciones t
	) s on 
             	v.id_ubicacion_maestra=s.id_ubicacion inner join
	(
              select	r.id_ubicacion,
	   	r.id_ubicacion_maestra,
		r.descripcion
             from	tbl_ubicaciones r
	) q on 
             	s.id_ubicacion_maestra=q.id_ubicacion))w on
w.id_ubicacion = b.id_ubicacion
where a.id_serie = @MMColParam union all
select 
	k.fecha 			as 	'Fecha Traslado',
	f.descripcion			as	'Descripcion Trabajo',
	a.id_orden_traslado,
	h.descripcion			as	'solicitud',
	g.nombre			as	'Nombre de Negocio',
	g.direccion			as	'Direccion Negocio',
	g.id_alterno			as	'No. Sio',
	a.valor				as	'Total',
	i.nombre			as	'Nombre Tecnico',
	j.id_serie			as	'serie',
	j.id_ficha			as	'ficha',
	j.id_activo			as	'activo',
	j.fabricado			as	'ano',
	w.pais,
	w.region,
	w.distribuidora,
	w.supervisor,
	w.descripcion			as	'ruta'
from 	tbl_movimientos 	a 			inner join
	tbl_opciones_trabajo 	f 			on
	a.id_opcion_trabajo = f.id_opcion_trabajo 	inner join
	tbl_negocios		g			on
	a.id_negocio =	g.id_negocio			inner join
	tbl_tipos_movimiento	h			on
	a.id_tipo_movimiento = h.id_tipo_movimiento	inner join
	tbl_personal		i			on
	a.id_personal = i.id_personal			inner join
	tbl_activos 		j			on
	a.id_serie 	=	j.id_serie 		inner join
	tbl_traslados		k			on
	a.id_orden_traslado = k.id_orden_traslado
inner join (  
(select	z.id_alterno as 'ruta',
	z.id_ubicacion,
	z.descripcion,
	z.id_ubicacion_maestra as id_ubicacion_supervisor,
	y.descripcion as supervisor,
	y.id_ubicacion_maestra as id_ubicacion_distribuidora,
	v.descripcion as distribuidora,
	v.id_ubicacion_maestra as id_ubicacion_region,
	s.descripcion as region,
	s.id_ubicacion_maestra as id_ubicacion_pais,
	q.descripcion as pais
from	tbl_ubicaciones z inner join
	(
              select	x.id_ubicacion,
	   	x.id_ubicacion_maestra,
		x.descripcion
             from	tbl_ubicaciones x
	) y on 
             	z.id_ubicacion_maestra=y.id_ubicacion inner join
	(
              select	u.id_ubicacion,
	   	u.id_ubicacion_maestra,
		u.descripcion
             from	tbl_ubicaciones u
	) v on 
             	y.id_ubicacion_maestra=v.id_ubicacion inner join
	(
              select	t.id_ubicacion,
	   	t.id_ubicacion_maestra,
		t.descripcion
             from	tbl_ubicaciones t
	) s on 
             	v.id_ubicacion_maestra=s.id_ubicacion inner join
	(
              select	r.id_ubicacion,
	   	r.id_ubicacion_maestra,
		r.descripcion
             from	tbl_ubicaciones r
	) q on 
             	s.id_ubicacion_maestra=q.id_ubicacion))w on
w.id_ubicacion = g.id_ubicacion

where a.id_serie = @MMColParam and not a.id_orden_traslado = 0 
order by a.fecha desc
GO
/****** Object:  StoredProcedure [dbo].[pa_averiguar_vuelta]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_averiguar_vuelta] @empresa int AS

Select	Top 1 vuelta
From	tbl_vueltas
Where	id_empresa=@empresa
GO
/****** Object:  StoredProcedure [dbo].[pa_borrar_filtros]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_borrar_filtros]

@consulta int, 
@usuario char(30)

AS

Delete	tbl_filtros
Where	id_consulta=@consulta 	and
	id_usuario=@usuario


GO
/****** Object:  StoredProcedure [dbo].[pa_borrar_ingreso]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_borrar_ingreso] @ingreso int, @empresa int AS
declare @traslados int

set nocount on
select @traslados=0
if @traslados<=0
begin
delete 
from	tbl_detalle_ingresos
where	id_ingreso=@ingreso and
	id_empresa=@empresa

delete 
from	tbl_ingresos
where	id_ingreso=@ingreso and
	id_empresa=@empresa
end
set nocount off

select @traslados as traslados


GO
/****** Object:  StoredProcedure [dbo].[pa_borrar_permisos_ubicacion]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_borrar_permisos_ubicacion]
	@empresa int,
	@usuario char(20) AS
Delete tbl_ubicaciones_permiso
where	id_empresa=@empresa and
	id_usuario=@usuario




GO
/****** Object:  StoredProcedure [dbo].[pa_borrar_visitas_realizadas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_borrar_visitas_realizadas] AS

delete
from	tbl_numeros_serie
where	actualizado=1	or
	actualizada_orden=1

delete
from	tbl_tiempos
where 	numero_serie IN
	(Select	numero_serie From tbl_numeros_serie 	b 
	 Where	b.actualizado		=	1		or
		b.actualizada_orden	=	1)

delete
from	tbl_visitas
where	negocios_actualizados=1	or
	ordenes_actualizadas=1
GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_apariencia]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_buscar_apariencia] @calificacion int AS

Select	a.id_apariencia	as Codigo,
	a.descripcion	as Apariencia,
	a.color		as Color
From	tbl_apariencia 	a
Where	@calificacion between a.de and a.hasta
GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_contrato]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_buscar_contrato] @contrato char(30) AS
select	id_serie,
	id_ingreso
from	tbl_detalle_ingresos
where	no_contrato=@contrato



GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_equipo_ficha]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_buscar_equipo_ficha] @empresa int, @ficha char(20) AS
Select TOP 1	a.correlativo,
		a.fecha,
		a.id_serie,
		a.id_ingreso,
		a.serie_especial 		as id_sio,
		b.id_negocio,
		isnull(c.nombre,'') 	as nombre,
		c.id_ubicacion,
		c.direccion,
		c.id_sector
FROM		tbl_movimientos 		a 	inner join
		tbl_activos		b	on
	  	  b.id_ficha=a.id_ficha		left join
		tbl_negocios 		c 	on 
		  b.id_negocio=c.id_negocio	
	
WHERE	a.id_ficha=@ficha and
		a.id_empresa=@empresa

ORDER BY	a.CORRELATIVO DESC

GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_equipo_serie]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_buscar_equipo_serie] @empresa int, @serie char(20) AS
Select TOP 1	a.correlativo,
		a.fecha,
		a.id_ficha,
		a.id_ingreso,
		a.serie_especial 		as id_sio,
		b.id_negocio,
		isnull(c.nombre,'') 	as nombre,
		c.id_ubicacion,
		c.direccion,
		c.id_sector

FROM		tbl_movimientos 		a 	inner join
		tbl_activos		b	on
	  	  b.id_serie=a.id_serie		left join
		tbl_negocios 		c 	on 
		  b.id_negocio=c.id_negocio	
	
WHERE	a.id_serie=@serie and
		a.id_empresa=@empresa

ORDER BY	a.CORRELATIVO DESC

GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_ficha]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_buscar_ficha] @ficha char(20) AS
select	id_serie,
	id_sio
from	tbl_activos
where	id_ficha=@ficha







GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_ficha_ubicacion]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_buscar_ficha_ubicacion] @empresa int,@ficha char(20) AS
select	*
from	tbl_movimientos
where	id_ficha=@ficha and
	id_empresa=@empresa



GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_ingreso]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_buscar_ingreso] @tipo int, @documento char(20) AS

Select	count(*) as Registros
From	tbl_ingresos
Where	id_documento=@tipo	and
	no_documento=@documento

GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_negocios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_buscar_negocios] @empresa int, @agencia int, @tipo int, @condicion varchar(200) AS

set nocount on

CREATE TABLE #Negocios
(
   	Codigo 		int,
	Sio 		char(20),
	Nombre 	char(100),
	Direccion 	varchar(300),
	Ruta		char(25),
	DescRuta 	char(100)
)


if @tipo=1
begin
INSERT INTO #Negocios
select	a.id_negocio	as	Codigo,
	a.id_alterno	as	Sio,
	a.nombre	as	Nombre,
	a.direccion	as 	Direccion,
	b.id_alterno	as	Ruta,
	b.descripcion	as 	DescRuta
from	tbl_negocios	a	left join
	tbl_ubicaciones	b	on
	  a.id_ubicacion=b.id_ubicacion
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.id_negocio	=	@condicion
end

if @tipo=2
begin
INSERT INTO #Negocios
select	a.id_negocio	as	Codigo,
	a.id_alterno	as	Sio,
	a.nombre		as	Nombre,
	a.direccion	as 	Direccion,
	b.id_alterno	as	Ruta,
	b.descripcion	as 	DescRuta
from	tbl_negocios	a	left join
	tbl_ubicaciones	b	on
	  a.id_ubicacion=b.id_ubicacion
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.nombre		like	'%'+rtrim(ltrim(@condicion))+'%'
end

if @tipo=3
begin
INSERT INTO #Negocios
select	a.id_negocio	as	Codigo,
	a.id_alterno	as	Sio,
	a.nombre		as	Nombre,
	a.direccion	as 	Direccion,
	b.id_alterno	as	Ruta,
	b.descripcion	as 	DescRuta
from	tbl_negocios	a	left join
	tbl_ubicaciones	b	on
	  a.id_ubicacion=b.id_ubicacion
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.direccion	like	'%'+rtrim(ltrim(@condicion))+'%'
end

if @tipo=4
begin
INSERT INTO #Negocios
select	a.id_negocio	as	Codigo,
	a.id_alterno	as	Sio,
	a.nombre		as	Nombre,
	a.direccion	as 	Direccion,
	b.id_alterno	as	Ruta,
	b.descripcion	as 	DescRuta
from	tbl_negocios	a	left join
	tbl_ubicaciones	b	on
	  a.id_ubicacion=b.id_ubicacion
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.id_alterno	like	'%'+rtrim(ltrim(@condicion))+'%'
end

if @tipo=5
begin
INSERT INTO #Negocios
select	a.id_negocio	as	Codigo,
	a.id_alterno	as	Sio,
	a.nombre		as	Nombre,
	a.direccion	as 	Direccion,
	b.id_alterno	as	Ruta,
	b.descripcion	as 	DescRuta
from	tbl_negocios	a	left join
	tbl_ubicaciones	b	on
	  a.id_ubicacion=b.id_ubicacion
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.id_tipo_negocio	=	@condicion
end

set nocount off

select	*
from	#Negocios
GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_presupuesto]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_buscar_presupuesto] @presupuesto int AS

select a.*,
	b.fecha
from tbl_detalle_presupuesto a inner join
	tbl_presupuesto b on
	a.id_presupuesto = b.id_presupuesto
where a. id_presupuesto = @presupuesto
GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_sector]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_buscar_sector] @empresa int, @sector char(10) AS

Select	a.descripcion	as 	Sector,
	b.id_region	as	id_region,
	b.descripcion	as	Region
From	tbl_sectores 	a	inner join
	tbl_regiones	b	on
	  a.id_empresa=b.id_empresa	and
	  a.id_region=b.id_region
Where	a.id_empresa	=	@empresa	and
	a.id_sector	=	@sector

GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_serie]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_buscar_serie] @serie char(25) AS
set nocount on

declare @negocio int
declare @ficha char(20)
declare @sio char(20)

Select 	@negocio 	= id_negocio,
	@ficha		= id_ficha,
	@sio		= id_sio
From 	tbl_activos
Where	id_serie=@serie

set nocount off

Select	id_serie,
	@ficha 			as id_ficha,
	@sio 			as id_sio,
	b.id_ingreso	 	as id_ingreso,
	isnull(@negocio,0) 	as 'id_negocio',
	b.no_documento	as no_documento
from	tbl_detalle_ingresos 	a	inner join
	tbl_ingresos		b	on
	    a.id_ingreso		=	b.id_ingreso and
	    a.id_agencia		=	b.id_agencia
where	id_serie=@serie
GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_serie_pre]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_buscar_serie_pre] @serie char (50) AS

select id_presupuesto
from tbl_detalle_presupuesto
where id_serie_pre = @serie
group by id_presupuesto
GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_sio]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_buscar_sio] @sio char(20) AS
select	id_serie,
	id_ficha
from	tbl_activos
where	id_sio=@sio

GO
/****** Object:  StoredProcedure [dbo].[pa_buscar_traslado]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_buscar_traslado] @empresa int,@traslado int AS
select	fecha
from	tbl_traslados
where	id_orden_traslado=@traslado and
	id_empresa=@empresa



GO
/****** Object:  StoredProcedure [dbo].[pa_calidad]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_calidad] AS
select	*
from	tbl_calidad


GO
/****** Object:  StoredProcedure [dbo].[pa_cambiar_ficha]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_cambiar_ficha] @ficha char(30),@ficha_anterior char(30) AS

--CAMBIANDO LA TABLA DE MOVIMIENTOS

Update	tbl_movimientos
Set	id_ficha	=	@ficha
Where	id_ficha	=	@ficha_anterior

--CAMBIANDO LA TABLA DE ACTIVOS

Update	tbl_activos
Set	id_ficha	=	@ficha
Where	id_ficha	=	@ficha_anterior

--CAMBIANDO LA TABLA DE detalle ingresos

Update	tbl_detalle_ingresos
Set	id_ficha	=	@ficha
Where	id_ficha	=	@ficha_anterior

--CAMBIANDO LA TABLA DE orden trabajo

Update	tbl_orden_trabajo
Set	id_ficha	=	@ficha
Where	id_ficha	=	@ficha_anterior

GO
/****** Object:  StoredProcedure [dbo].[pa_cambiar_serie]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_cambiar_serie] @serie char(30),
	@serie_anterior char(30) AS

--CAMBIANDO LA TABLA DE MOVIMIENTOS

Update	tbl_movimientos
Set	id_serie	=	@serie
Where	id_serie	=	@serie_anterior

--CAMBIANDO LA TABLA DE ACTIVOS

Update	tbl_activos
Set	id_serie	=	@serie
Where	id_serie	=	@serie_anterior

--CAMBIANDO LA TABLA DE detalle ingresos

Update	tbl_detalle_ingresos
Set	id_serie	=	@serie
Where	id_serie	=	@serie_anterior

--CAMBIANDO LA TABLA DE orden trabajo

Update	tbl_orden_trabajo
Set	id_serie	=	@serie
Where	id_serie	=	@serie_anterior



GO
/****** Object:  StoredProcedure [dbo].[pa_cambiar_sio]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_cambiar_sio] @sio char(30),@sio_anterior char(30) AS

--CAMBIANDO LA TABLA DE MOVIMIENTOS

Update	tbl_movimientos
Set	serie_especial	=	@sio
Where	serie_especial	=	@sio_anterior

--CAMBIANDO LA TABLA DE ACTIVOS

Update	tbl_activos
Set	id_sio	=	@sio
Where	id_sio	=	@sio_anterior

--CAMBIANDO LA TABLA DE detalle ingresos

Update	tbl_detalle_ingresos
Set	id_sio	=	@sio
Where	id_sio	=	@sio_anterior

--CAMBIANDO LA TABLA DE orden trabajo

Update	tbl_orden_trabajo
Set	id_sio	=	@sio
Where	id_sio	=	@sio_anterior



GO
/****** Object:  StoredProcedure [dbo].[pa_cambiar_vuelta]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_cambiar_vuelta]
	@tipo		int,
	@empresa	int,
	@tecnico	int,
	@vuelta	int

AS

--SI EL CAMBIO DE VUELTA ES TOTAL
If @tipo=1
begin
  Update	tbl_activos
  Set	visitado		=	0,
	id_orden_trabajo	=	0,
	vuelta			=	@vuelta
  From	tbl_activos				

end

--SI EL CAMBIO DE VUELTA ES POR TECNICO
If @tipo=2
begin
  Update	tbl_activos
  Set	visitado		=	0,
	id_orden_trabajo	=	0,
	vuelta		=	vuelta+1
  From	tbl_activos				a	inner join
	tbl_negocios				b	on
  	  a.id_negocio	=	b.id_negocio	and
	  b.id_empresa	=	@empresa		inner join
	tbl_sectores				c	on
	  b.id_empresa	=	c.id_empresa	and
	  b.id_sector	=	c.id_sector	
  Where	b.id_empresa	=	@empresa	and
	c.id_tecnico	=	@tecnico
end


--SI EL CAMBIO DE VUELTA ES POR TECNICO PERO ASIGNANDO UNA VUELTA ESTABLECIDA
If @tipo=3
begin
  Update	tbl_activos
  Set	visitado		=	0,
	id_orden_trabajo	=	0,
	vuelta		=	@vuelta
  From	tbl_activos				a	inner join
	tbl_negocios				b	on
  	  a.id_negocio	=	b.id_negocio	and
	  b.id_empresa	=	@empresa		inner join
	tbl_sectores				c	on
	  b.id_empresa	=	c.id_empresa	and
	  b.id_sector	=	c.id_sector	
  Where	b.id_empresa	=	@empresa	and
	c.id_tecnico	=	@tecnico
end
GO
/****** Object:  StoredProcedure [dbo].[pa_categorias]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_categorias] AS

Select	*
From	tbl_categorias
GO
/****** Object:  StoredProcedure [dbo].[pa_cerrar_sesion]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_cerrar_sesion] @usuario char(20) AS

Update		tbl_sesiones
Set		activa		= 0
Where		id_usuario 	= @usuario and
		activa		= 1

GO
/****** Object:  StoredProcedure [dbo].[pa_clasificacion_negocios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_clasificacion_negocios] AS
select	*
from	tbl_clasificacion_negocios


GO
/****** Object:  StoredProcedure [dbo].[pa_codigos_razon]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_codigos_razon] AS

Select	*
From	tbl_codigos_razon
GO
/****** Object:  StoredProcedure [dbo].[pa_consulta]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_consulta] @tipo int, @empresa int, @condicion varchar(3000) AS

Declare @Texto_Query varchar(8000),
	@Texto_Query1 varchar(8000),
	@Texto_Query2 varchar(8000),
	@Texto_Query3 varchar(8000)

If @Condicion is null
  Set @Condicion=''

If @tipo=0 
begin
Select	'' 				as Serie,
	0 				as No_Movimiento,
	0 				as Correlativo,
	''	 			as Sio,
	'' 				as Ficha,
	getdate() 			as Fecha,
	0 				as Codigo_Negocio,
	'' 				as Negocio,
	0 				as Piloto_Tecnico,
	''				as Nombre,
	0				as Ingreso,
	0				as Orden_Traslado,
	''				as Ubicacion_Ruta,
	''				as Ruta,
	''				as Ubicacion_Supervisor,
	''				as Supervisor,
	'' 				as Ubicacion_Distribuidora,
	'' 				as Distribuidora,
	'' 				as Ubicacion_Region,
	'' 				as Region,
	'' 				as Ubicacion_Pais,
	'' 				as Pais,
	0				as id_marca,
	'' 				as Marca,
	0				as id_fabricante,
	'' 				as Fabricante,
	0				as id_modelo,
	'' 				as Modelo,
	0				as id_logotipo,
	'' 				as Logotipo,
	0				as id_tipo,
	'' 				as TipoEquipo,
	'' 				as NoContrato,
	0				as Agencia,
	''				as TipoNegocio,
	0				as CodTipoNegocio,
	0 				as id_negocio,
	0				as Latitud_Grad,
	0				as Latitud_Min,
	0				as Latitud_Seg,
	0				as Longitud_Grad,
	0				as Longitud_Min,
	0				as Longitud_Seg,
	''				as Direccion
end

else

begin

set nocount on

Set @Texto_Query1=
'Select	a.id_serie 				as Serie,
	a.id_movimiento 				as No_Movimiento,
	a.correlativo 				as Correlativo,
	c.id_alterno	 			as Sio,
	a.id_ficha 				as Ficha,
	isnull(n.fecha,a.fecha) 			as Fecha,
	a.id_negocio 				as Codigo_Negocio,
	c.nombre 				as Negocio,
	a.id_personal 				as Piloto_Tecnico,
	d.nombre				as Nombre,
	a.id_ingreso 				as Ingreso,
	a.id_orden_traslado 			as Orden_Traslado,
	a.id_ubicacion 				as Ubicacion_Ruta,
	e.descripcion 				as Ruta,
	isnull(f.id_ubicacion_supervisor,space(1)) 		as Ubicacion_Supervisor,
	isnull(f.supervisor,space(1)) 			as Supervisor,
	isnull(f.id_ubicacion_distribuidora,space(1)) 	as Ubicacion_Distribuidora,
	isnull(f.distribuidora,space(1)) 			as Distribuidora,
	isnull(f.id_ubicacion_region,space(1)) 		as Ubicacion_Region,
	isnull(f.region,space(1)) 				as Region,
	isnull(f.id_ubicacion_pais,space(1)) 		as Ubicacion_Pais,
	isnull(f.pais,space(1)) 				as Pais,
	h.id_marca				as id_marca,
	i.descripcion 				as Marca,
	h.id_fabricante				as id_fabricante,
	j.nombre 				as Fabricante,
	h.id_modelo				as id_modelo,
	k.descripcion 				as Modelo,
	h.id_logotipo				as id_logotipo,
	l.descripcion 				as Logotipo,
	h.id_tipo				as id_tipo,
	m.descripcion 				as TipoEquipo,
	a.no_contrato 				as NoContrato,
	g.id_agencia				as Agencia,
	isnull(x.descripcion,space(1))		as TipoNegocio,
	isnull(c.id_tipo_negocio,999)			as CodTipoNegocio,
	a.id_negocio,
	c.latitud_grad	as Latitud_Grad,
	c.latitud_min	as Latitud_Min,
	c.latitud_seg	as Latitud_Seg,
	c.longitud_grad	as Longitud_Grad,
	c.longitud_min	as Longitud_Min,
	c.longitud_seg	as Longitud_Seg,
	c.direccion	as			Direccion
From	tbl_movimientos 		a  			inner join
	tbl_negocios 		c 	on 
	    a.id_negocio		=	c.id_negocio 	left join
	tbl_tipos_negocios	x	on
	    x.id_tipo_negocio	=	c.id_tipo_negocio inner join
	tbl_personal 		d 	on 
	    a.id_personal		=	d.id_personal 	inner join
	tbl_ubicaciones 		e 	on 
	    a.id_ubicacion	=	e.id_ubicacion 	inner join
	tbl_detalle_ingresos 	g 	on 
	    g.id_serie		=	a.id_serie 	inner join
	tbl_ingresos 		h 	on 
	    h.id_ingreso		=	g.id_ingreso 	and
	    h.id_agencia		=	g.id_agencia	left join
	tbl_marcas 		i 	on 
	    h.id_marca		=	i.id_marca 	left join
	tbl_fabricantes 		j 	on 
	    j.id_fabricante		=	h.id_fabricante 	left join
	tbl_modelos 		k 	on 
	    k.id_modelo		=	h.id_modelo 	left join
	tbl_logotipos 		l 	on 
	    l.id_logotipo		=	h.id_logotipo 	left join
	tbl_tipos 		m 	on 
	    m.id_tipo		=	h.id_tipo left join
	tbl_traslados 		n 	on 
	    n.id_orden_traslado	=	a.id_orden_traslado

--REVISION DE PERMISOS POR UBICACION

left join
	(
(select	z.id_ubicacion,
	z.descripcion,
	z.id_ubicacion_maestra 	as id_ubicacion_supervisor,
	y.descripcion 		as supervisor,
	y.id_ubicacion_maestra 	as id_ubicacion_distribuidora,
	v.descripcion 		as distribuidora,
	v.id_ubicacion_maestra 	as id_ubicacion_region,
	s.descripcion 		as region,
	s.id_ubicacion_maestra 	as id_ubicacion_pais,
	q.descripcion 		as pais
from	tbl_ubicaciones 		z 	inner join
	(
              select	x.id_ubicacion,
	   	x.id_ubicacion_maestra,
		x.descripcion
             from	tbl_ubicaciones x
	) y on 
             	z.id_ubicacion_maestra	=	y.id_ubicacion inner join    --NIVEL DE SUPERVISOR DE LA RUTA
	(
              select	u.id_ubicacion,
	   	u.id_ubicacion_maestra,
		u.descripcion
             from	tbl_ubicaciones u
	) v on 
             	y.id_ubicacion_maestra	=	v.id_ubicacion inner join    --NIVEL DE EMBOTELLADORA DEL SUPERVISOR
	(
              select	t.id_ubicacion,
	   	t.id_ubicacion_maestra,
		t.descripcion
             from	tbl_ubicaciones t
	) s on 
             	v.id_ubicacion_maestra	=	s.id_ubicacion inner join    --NIVEL DE REGION DE LA EMBOTELLADORA
	(
              select	r.id_ubicacion,
	   	r.id_ubicacion_maestra,
		r.descripcion
             from	tbl_ubicaciones r
	) 	q 	on 
             	s.id_ubicacion_maestra	=	q.id_ubicacion)      --NIVEL DE PAIS DE LA REGION
	) 	f 	on f.id_ubicacion	=	a.id_ubicacion


where	a.id_empresa	=	'+cast(@empresa as char(5))

Set @Texto_Query2=' order by a.id_serie,a.correlativo'


Set @Texto_Query=
	ltrim(rtrim(@Texto_Query1))+' '+
	ltrim(rtrim(@Condicion))+' '+
	ltrim(rtrim(@Texto_Query2))

set nocount off

--select @Texto_Query as Query

Exec(@texto_Query)
end

GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_detalle_ordenes_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_consulta_detalle_ordenes_trabajo] @tipo int, @empresa int, @usuario 
char(20), @condicion varchar(8000), @condicion2 varchar(8000) AS

Declare @imagen varbinary(16),
	@UMD char(3),
	@Traslado char(20),
	@Texto_Query varchar(8000),
	@Texto_Query1 varchar(8000),
	@Texto_Query2 varchar(8000),
	@Texto_Query3 varchar(8000)

Set	@UMD = 'PZ'
Set	@Traslado='Traslado'

If @Condicion is null
  Set @Condicion=''

If @Condicion2 is null
  Set @Condicion2=''

If @tipo=0
begin
Select	0	as id_opcion_trabajo,
	''	as descripcion,
	''	as id_unidad_medida,
	0.00	as cantidad,
	0.00	as valor_unitario,
	0	as id_empresa,
	0	as id_orden_trabajo,
	getdate() as fecha,
	0	as id_negocio,
	''	as nomnegocio,
	''	as id_ubicacion,
	''	as nomubicacion,
	0	as id_personal,
	''	as nombre,
	''	as id_ubicacion_supervisor,
	''	as supervisor,
	''	as id_ubicacion_distribuidora,
	''	as distribuidora,
	''	as id_ubicacion_region,
	''	as region,
	''	as id_ubicacion_pais,
	''	as pais,
	0.00 	as Total,
	0	as "Agencia",
	''	as "Cod_Tecnico",
	''	as id_sector,
	''	as id_region,
	0	as "Cod_Tipo_Trabajo",
	''	as "Tipo-Trabajo",
	''	as Alterno,
	''	as Serie,
	''	as Direccion,
	0.00	as Latitud_Grad,
	0.00	as Latitud_Min,
	0.00	as Latitud_Seg,
	0.00	as Longitud_Grad,
	0.00	as Longitud_Min,
	0.00	as Longitud_Seg,
	''	as Ficha,
	''	as "Serie-Orden",
	0	as "Dia-Trabajo",
	''	as "Hora-Inicio",
	''	as "Hora-Final",
	0	as Estado,
	0	as "Cod-Calidad",
	''	as "Observaciones",
	''	as Calidad,
	''	as "Region-Orden",
	''	as Sector,
	0	as "Cod-Tipo-Negocio",
	''	as "Tipo-Negocio",
	''	as "Cod-Tipo-Movimiento",
	''	as "Tipo-Movimiento",
	0	as primera_linea,
	'NO'	as "Con-Llamada",
	'NO'	as "Aplico-Correctivo",
	0	as "Foto",
	'NO'	as "Foraneo"
end

else

begin

set nocount on

Set @Texto_Query1=
'Select	a.id_opcion_trabajo, a.descripcion, 
a.id_unidad_medida,a.cantidad,	a.valor_unitario,	a.id_empresa,a.id_orden_trabajo,	b.fecha,
	b.id_negocio,c.nombre as nomnegocio,b.id_ubicacion,e.descripcion as 
nomubicacion,b.id_personal,d.nombre,f.id_ubicacion_supervisor,
	f.supervisor,f.id_ubicacion_distribuidora,f.distribuidora,f.id_ubicacion_region,f.region,f.id_ubicacion_pais,f.pais,
	(a.cantidad*a.valor_unitario)  as Total,a.id_agencia  as 
"Agencia",d.id_alterno  as "Cod_Tecnico",b.id_sector,	b.id_region,
	isnull(p.id_tipo_opcion_trabajo,0)	as 
"Cod_Tipo_Trabajo",	isnull(p.descripcion,SPACE(1)) as 
"Tipo-Trabajo",	c.id_alterno as Alterno,
	b.id_serie as Serie, c.direccion  as Direccion, c.latitud_grad  as 
Latitud_Grad, c.latitud_min  as Latitud_Min, c.latitud_seg  as Latitud_Seg,
	c.longitud_grad	as Longitud_Grad,c.longitud_min	as Longitud_Min, 
c.longitud_seg	as Longitud_Seg,b.id_ficha as Ficha,
	b.serie_orden as "Serie-Orden",b.dia_trabajo as "Dia-Trabajo", 
b.hora_inicio	as "Hora-Inicio",	b.hora_final as "Hora-Final",
	b.estado as Estado, b.id_calidad	as "Cod-Calidad", b.observaciones as 
"Observaciones", q.descripcion	as Calidad,
	r.descripcion	as "Region-Orden", s.descripcion as Sector, c.id_tipo_negocio 
as "Cod-Tipo-Negocio", t.descripcion as "Tipo-Negocio",
	space(1) as "Cod-Tipo-Movimiento", space(1) as "Tipo-Movimiento", 
a.primera_linea,
	CASE WHEN b.con_llamada=1 THEN ''SI'' ELSE ''NO'' END	as "Con-Llamada",
	CASE WHEN b.aplico_correctivo=1 THEN ''SI'' ELSE ''NO'' END	as 
"Aplico-Correctivo",
	CASE WHEN (Select count(*) from tbl_galeria_fotos galeria where galeria.id_empresa=b.id_empresa and galeria.id_orden_trabajo=b.id_orden_trabajo)>0 THEN 1 ELSE 0 END	as "Foto"  ,
	CASE WHEN b.foraneo=1 THEN ''SI'' ELSE ''NO'' END		as "Foraneo"
from	tbl_detalle_orden_trabajo 	a 				inner join
	tbl_orden_trabajo  b 	on
	    a.id_orden_trabajo = b.id_orden_trabajo  and   a.id_agencia = 
b.id_agencia inner join
	tbl_negocios 	c 	on
	    b.id_negocio	=	c.id_negocio 	 	and
	    b.id_empresa	=	c.id_empresa	inner join
	tbl_personal 	d 	on
	    b.id_personal	=	d.id_personal 		inner join
	tbl_ubicaciones 	e 	on
	    b.id_ubicacion	=	e.id_ubicacion 		inner join
	tbl_opciones_trabajo	op	on
	   a.id_opcion_trabajo	=	op.id_opcion_trabajo	inner join
	tbl_tipos_opcion_trabajo	p	on    p.id_tipo_opcion_trabajo 
=	op.id_tipo_opcion_trabajo 	inner join
	tbl_calidad	q	on
	   q.id_calidad	=	b.id_calidad		left join
	tbl_regiones	r	on
	   r.id_region = b.id_region and   r.id_empresa = a.id_empresa left join
	tbl_sectores	s	on
	   s.id_sector = b.id_sector and   s.id_empresa = a.id_empresa and  s.id_region = r.id_region	inner join
	tbl_tipos_negocios 	t 	on
	  c.id_tipo_negocio = t.id_tipo_negocio and  t.id_agencia	= b.id_agencia	inner join tbl_ubicaciones_permiso o on
	    b.id_ubicacion = o.id_ubicacion and   o.id_empresa= '+cast(@empresa as 
char(5))+'  and   o.id_usuario = '+ltrim(rtrim (@usuario))+'  left join
	((select	z.id_ubicacion,z.descripcion, z.id_ubicacion_maestra as id_ubicacion_supervisor,	y.descripcion as supervisor,y.id_ubicacion_maestra 
as id_ubicacion_distribuidora,v.descripcion as distribuidora,v.id_ubicacion_maestra as id_ubicacion_region,s.descripcion as region,s.id_ubicacion_maestra as id_ubicacion_pais,q.descripcion as pais
from	tbl_ubicaciones z inner join
	(select	x.id_ubicacion, 	x.id_ubicacion_maestra,	x.descripcion
             from	tbl_ubicaciones x ) y on
             	z.id_ubicacion_maestra=y.id_ubicacion inner join
	(select	u.id_ubicacion,  	u.id_ubicacion_maestra,	u.descripcion
             from	tbl_ubicaciones u ) v on
             	y.id_ubicacion_maestra=v.id_ubicacion inner join
	(select	t.id_ubicacion,   	t.id_ubicacion_maestra,	t.descripcion
             from	tbl_ubicaciones t ) s on
             	v.id_ubicacion_maestra=s.id_ubicacion inner join
	(select	r.id_ubicacion,   	r.id_ubicacion_maestra,	r.descripcion
             from	tbl_ubicaciones r
	) q on   s.id_ubicacion_maestra=q.id_ubicacion)) f on 
f.id_ubicacion=b.id_ubicacion Where   a.id_empresa= '+cast(@empresa as char(5))+' '+ltrim(rtrim(@Condicion))+'
UNION ALL
Select	a.id_opcion_trabajo,
	''Traslado'' as descripcion,
	c.id_alterno	 as id_unidad_medida,
	1	as cantidad,
	a.valor	as valor_unitario,
	a.id_empresa,
	a.id_orden_traslado	as id_orden_trabajo,
	l.fecha,	a.id_negocio,	c.nombre 	as nomnegocio,	a.id_ubicacion,	e.descripcion 	as nomubicacion,
	a.id_personal,	d.nombre,	f.id_ubicacion_supervisor,	f.supervisor,	f.id_ubicacion_distribuidora,
	f.distribuidora,	f.id_ubicacion_region,	f.region,	f.id_ubicacion_pais,	f.pais,	a.valor 		as total,
	a.id_agencia	as "Agencia",	d.id_alterno	as "Cod_Tecnico",	space(1)	as id_sector,
	space(1)	as id_region,	0		as "Cod_Tipo_Trabajo",	''TRASLADOS''	as "Tipo-Trabajo",
	c.id_alterno	as Alterno,	a.id_serie	as Serie,	c.direccion	as Direccion,
	c.latitud_grad	as Latitud_Grad,	c.latitud_min	as Latitud_Min,	c.latitud_seg	as Latitud_Seg,
	c.longitud_grad	as Longitud_Grad,	c.longitud_min	as Longitud_Min,	c.longitud_seg	as Longitud_Seg,
	a.id_ficha	as Ficha,	space(1)	as "Serie-Orden",	0 as "Dia-Trabajo",
	space(1)	as "Hora-Inicio",	space(1)	as "Hora-Final",	0 as Estado,
	0 as "Cod-Calidad",	a.observaciones	 as "Observaciones",	space(1) as Calidad,
	space(1) as "Region-Orden",	space(1) as Sector,	c.id_tipo_negocio as "Cod-Tipo-Negocio",
	t.descripcion 	as "Tipo-Negocio",	isnull(a.id_tipo_movimiento,0)	as "Cod-Tipo-Movimiento",
	isnull(k.descripcion,space(1))	as "Tipo-Movimiento",	1 as primera_linea,	''NO''	as "Con-Llamada",
	''NO''	as "Aplico-Correctivo",	0	as "Foto"  ,	''NO''	as "Foraneo"
From	tbl_movimientos 	a	inner join
	tbl_negocios 	c 	on
	    a.id_negocio	=	c.id_negocio 	and a.id_empresa = c.id_empresa inner join
	tbl_personal 	d 	on 
	    a.id_personal	=	d.id_personal  	and
	    a.id_empresa	=	d.id_empresa 	    inner join
	tbl_ubicaciones 	e 	on
	    a.id_ubicacion =	e.id_ubicacion 		inner join
	tbl_ubicaciones_permiso 	o 	on
	    a.id_ubicacion =	o.id_ubicacion	and
   	    o.id_empresa= '+cast(@empresa as char(5))+'  and  o.id_usuario	= '+ltrim(rtrim (@usuario))+' left join
	tbl_tipos_opcion_trabajo	p	on
	    p.id_tipo_opcion_trabajo	=	-999		inner join
	tbl_tipos_negocios 	t 	on
	  c.id_tipo_negocio	=	t.id_tipo_negocio	and  t.id_agencia	=	a.id_agencia		left join
	tbl_opciones_trabajo	u	on
	  a.id_opcion_trabajo	=	u.id_opcion_trabajo	left join
	tbl_tipos_movimiento	k	on
	  a.id_tipo_movimiento	=	k.id_tipo_movimiento	inner join
	tbl_traslados	l	on
	  l.id_empresa	=	a.id_empresa    and  l.id_orden_traslado	=	a.id_orden_traslado
left join
	((select	z.id_ubicacion,
	z.descripcion,
	z.id_ubicacion_maestra as id_ubicacion_supervisor,
	y.descripcion as supervisor,
	y.id_ubicacion_maestra as id_ubicacion_distribuidora,
	v.descripcion as distribuidora,
	v.id_ubicacion_maestra as id_ubicacion_region,
	s.descripcion as region,
	s.id_ubicacion_maestra as id_ubicacion_pais,
	q.descripcion as pais
from	tbl_ubicaciones z inner join
	(select	x.id_ubicacion,  	x.id_ubicacion_maestra,	x.descripcion
             from	tbl_ubicaciones x ) y on
             	z.id_ubicacion_maestra=y.id_ubicacion inner join
	(select	u.id_ubicacion,  	u.id_ubicacion_maestra,	u.descripcion
             from	tbl_ubicaciones u ) v on
             	y.id_ubicacion_maestra=v.id_ubicacion inner join
	(select	t.id_ubicacion,   	t.id_ubicacion_maestra,	t.descripcion
             from	tbl_ubicaciones t ) s on
             	v.id_ubicacion_maestra=s.id_ubicacion inner join
	(select	r.id_ubicacion,   	r.id_ubicacion_maestra,	r.descripcion
             from	tbl_ubicaciones r ) q on
             	s.id_ubicacion_maestra=q.id_ubicacion)) f on 
f.id_ubicacion=a.id_ubicacion
Where	a.id_orden_traslado > 0 and a.id_empresa  = '+cast(@empresa as char(5))+'  '+ltrim(rtrim(@Condicion2))

Set @Texto_Query2=''

Set @Texto_Query=
	ltrim(rtrim(@Texto_Query1))+' '+
	ltrim(rtrim(@Texto_Query2))

set nocount off

--select @Texto_Query as Query

Exec(@texto_Query)
End





GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_equipos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_consulta_equipos] @empresa int AS
select	a.id_serie 	as Serie,
	a.id_ficha 	as Ficha,
	i.id_alterno 	as Sio,
	b.id_modelo 	as CodigoModelo,
	c.descripcion 	as Modelo,
	b.id_marca 	as CodigoMarca,
	d.descripcion 	as Marca,
	b.id_tipo 	as CodigoTipo,
	e.descripcion 	as TipoEquipo,
	b.id_logotipo 	as CodigoLogotipo,
	f.descripcion 	as Logotipo,
	b.id_fabricante 	as CodigoFabricante,
	g.nombre 	as Fabricante,
	a.id_ingreso 	as Ingreso,
	b.fecha 		as Fecha,
	h.id_negocio,
	i.nombre,
	i.id_ubicacion,
	h.no_contrato,
	a.id_agencia ,
	b.no_documento as 'No-Docto',
	i.latitud_grad	as Latitud_Grad,
	i.latitud_min	as Latitud_Min,
	i.latitud_seg	as Latitud_Seg,
	i.longitud_grad	as Longitud_Grad,
	i.longitud_min	as Longitud_Min,
	i.longitud_seg	as Longitud_Seg
from	tbl_detalle_ingresos 	a 			inner join
	tbl_ingresos		b 	on 
	    a.id_ingreso		=	b.id_ingreso 	and
	    a.id_agencia		=	b.id_agencia	inner join
	tbl_modelos 		c 	on 
	    b.id_modelo		=	c.id_modelo 	inner join
	tbl_marcas 		d 	on 
	    b.id_marca		=	d.id_marca 	inner join
	tbl_tipos 		e 	on 
	    b.id_tipo		=	e.id_tipo 	inner join
	tbl_logotipos 		f 	on 
	    b.id_logotipo		=	f.id_logotipo 	inner join
	tbl_fabricantes 		g 	on 
	    b.id_fabricante	=	g.id_fabricante 	inner join
	tbl_activos 		h 	on 
	    a.id_serie 		=	h.id_serie 	inner join
	tbl_negocios 		i 	on 
	    h.id_negocio		=	i.id_negocio
where	a.id_empresa=@empresa











GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_equipos_gen]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_consulta_equipos_gen] @tipo int,@empresa int, @condicion varchar(8000) AS

Declare @Texto_Query varchar(8000),
	@Texto_Query1 varchar(8000),
	@Texto_Query2 varchar(8000),
	@Texto_Query3 varchar(8000)

If @Condicion is null
  Set @Condicion=''

If @tipo=0 
begin
Select	''	as Serie,
	'' 	as Ficha,
	'' 	as Sio,
	0 	as CodigoModelo,
	'' 	as Modelo,
	0 	as CodigoMarca,
	'' 	as Marca,
	0 	as CodigoTipo,
	'' 	as TipoEquipo,
	0 	as CodigoLogotipo,
	'' 	as Logotipo,
	0 	as CodigoFabricante,
	'' 	as Fabricante,
	0 	as Ingreso,
	getdate() as Fecha,
	0 	as id_negocio,
	'' 	as nombre,
	''	as id_ubicacion,
	''	as no_contrato,
	0	as id_agencia ,
	''	as No_Docto,
	0.00	as Latitud_Grad,
	0.00	as Latitud_Min,
	0.00	as Latitud_Seg,
	0.00	as Longitud_Grad,
	0.00	as Longitud_Min,
	0.00	as Longitud_Seg,
	space(50) as Direccion
end

else

begin

set nocount on

Set @Texto_Query1=
'select	a.id_serie 	as Serie,
	a.id_ficha 	as Ficha,
	i.id_alterno 	as Sio,
	a.id_modelo 	as CodigoModelo,
	c.descripcion 	as Modelo,
	b.id_marca 	as CodigoMarca,
	d.descripcion 	as Marca,
	b.id_tipo 	as CodigoTipo,
	e.descripcion 	as TipoEquipo,
	b.id_logotipo 	as CodigoLogotipo,
	f.descripcion 	as Logotipo,
	b.id_fabricante 	as CodigoFabricante,
	g.nombre 	as Fabricante,
	b.id_ingreso 	as Ingreso,
	b.fecha 		as Fecha,
	a.id_negocio,
	i.nombre,
	i.id_ubicacion,
	a.no_contrato,
	a.id_agencia ,
	b.no_documento as No_Docto,
	i.latitud_grad	as Latitud_Grad,
	i.latitud_min	as Latitud_Min,
	i.latitud_seg	as Latitud_Seg,
	i.longitud_grad	as Longitud_Grad,
	i.longitud_min	as Longitud_Min,
	i.longitud_seg	as Longitud_Seg,
	i.direccion 	as Direccion
from	tbl_activos	 	a 			inner join
	tbl_detalle_ingresos	k			on
	  a.id_serie		=	k.id_serie	inner join
	tbl_ingresos		b 	on 
	    k.id_ingreso		=	b.id_ingreso 	and
	    a.id_agencia		=	b.id_agencia	inner join
	tbl_modelos 		c 	on 
	    a.id_modelo		=	c.id_modelo 	and
	    a.id_agencia		=	c.id_agencia	inner join
	tbl_marcas 		d 	on 
	    b.id_marca		=	d.id_marca 	and
	    a.id_agencia		=	d.id_agencia	inner join
	tbl_tipos 		e 	on 
	    b.id_tipo		=	e.id_tipo 	and
	    a.id_agencia		=	e.id_agencia	inner join
	tbl_logotipos 		f 	on 
	    b.id_logotipo		=	f.id_logotipo 	and
	    a.id_agencia		=	f.id_agencia	inner join
	tbl_fabricantes 		g 	on 
	    b.id_fabricante	=	g.id_fabricante 	inner join
	tbl_negocios 		i 	on 
	    a.id_negocio		=	i.id_negocio and
	    k.id_empresa	=	i.id_empresa 
where	k.id_empresa='+cast(@empresa as char(5))

Set @Texto_Query2=' '


Set @Texto_Query=
	ltrim(rtrim(@Texto_Query1))+' '+
	ltrim(rtrim(@Condicion))+' '+
	ltrim(rtrim(@Texto_Query2))

set nocount off

--select @Texto_Query as Query

Exec(@texto_Query)
end

GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_fotos_servicios_gen]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_consulta_fotos_servicios_gen] @tipo int, @empresa int, @usuario char(20), @condicion varchar(8000) , @condicion2 varchar(8000) AS

Declare @imagen varbinary(16),
	@UMD char(3),
	@Traslado char(20),
	@Texto_Query varchar(8000),
	@Texto_Query1 varchar(8000),
	@Texto_Query2 varchar(8000),
	@Texto_Query3 varchar(8000)

Set	@UMD = 'PZ'
Set	@Traslado='Traslado'

If @Condicion is null
  Set @Condicion=''

If @tipo=0 
begin
Select	0			as	'Orden-Trabajo',
	getdate()		as 	'Fecha',
	space(300) 		as 	'Observaciones',
	cast(@imagen as image)	as	'Foto',
	space(100)		as	'archivo'
end

else

begin

set nocount on

Set @Texto_Query1=
'Select	a.id_orden_trabajo		as "Orden-Trabajo",
	b.fecha				as "Fecha",
	b.observaciones			as "Observaciones",
	b.foto				as "Foto" ,
	b.archivo
from	tbl_detalle_orden_trabajo 	a 				inner join
	tbl_orden_trabajo 		b 	on 
	    a.id_orden_trabajo		=	b.id_orden_trabajo 	and
	    a.id_agencia			=	b.id_agencia 		
Where   a.id_empresa= '+cast(@empresa as char(5))+' '+ 
	ltrim(rtrim(@Condicion))+' 

UNION ALL

Select	a.id_orden_trabajo		as "Orden-Trabajo",
	a.fecha				as "Fecha",
	a.observaciones			as "Observaciones",
	a.foto				as "Foto" ,
	a.archivo
from	tbl_galeria_fotos			a				inner join
	tbl_orden_trabajo 		b 	on 
	    a.id_orden_trabajo		=	b.id_orden_trabajo  
Where   a.id_empresa= '+cast(@empresa as char(5))+' '+
	ltrim(rtrim(@Condicion2))

Set @Texto_Query2=''


Set @Texto_Query=
	ltrim(rtrim(@Texto_Query1))+' '+
	ltrim(rtrim(@Texto_Query2))

set nocount off

--select @Texto_Query as Query

Exec(@texto_Query)
End
GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_generica]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_consulta_generica]
	@tipo		int,
	@consulta	int,
	@condicion	varchar(8000),
	@empresa	int,
	@usuario	char(30)

	AS

--@TIPO DEFINE SI LA CONSULTA DEVUELVE SOLO LA ESTRUCTURA (0) O LOS DATOS (1)
--@CONSULTA ES EL CODIGO DE CONSULTA QUE SE DESEA RECUPERAR
--@TEXTO_FINAL ES LA CONDICION QUE SE LE DESEA APLICAR A LA CONSULTA YA PROCESADA
--@EMPRESA ES EL CODIGO DE EMPRESA PARA LA CONSULTA
--@USUARIO ES EL USUARIO QUE GENERA LA CONSULTA

set nocount on

--@TEXTO_INICIAL
Declare	@texto_inicial 	char(100),
	@texto 		varchar(8000),
	@texto_SQL	varchar(8000)

If @tipo=0
  begin
  set @texto_inicial='Select TOP 0'
  end
 else
  begin
  set @texto_inicial='Select'
  end

Select 	@texto =
    	ltrim(rtrim(@texto_inicial))+' '+
	ltrim(rtrim(texto))
From	tbl_consultas
Where	id_consulta=@consulta

Set @texto_SQL=
	'Select 	*
	from ('+
	@texto+
	') z '+
	ltrim(rtrim(@condicion))

set nocount off

Exec(@texto_SQL)



GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_historial_movimientos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_consulta_historial_movimientos] @empresa int AS

Select	a.id_serie 				as Serie,
	a.id_movimiento 				as No_Movimiento,
	a.correlativo 				as Correlativo,
	c.id_alterno	 			as Sio,
	a.id_ficha 				as Ficha,
	isnull(n.fecha,a.fecha) 			as Fecha,
	a.id_negocio 				as Codigo_Negocio,
	c.nombre 				as Negocio,
	a.id_personal 				as Piloto_Tecnico,
	d.nombre				as Nombre,
	a.id_ingreso 				as Ingreso,
	a.id_orden_traslado 			as Orden_Traslado,
	a.id_ubicacion 				as Ubicacion_Ruta,
	e.descripcion 				as Ruta,
	isnull(f.id_ubicacion_supervisor,'') 		as Ubicacion_Supervisor,
	isnull(f.supervisor,'') 			as Supervisor,
	isnull(f.id_ubicacion_distribuidora,'') 	as Ubicacion_Distribuidora,
	isnull(f.distribuidora,'') 			as Distribuidora,
	isnull(f.id_ubicacion_region,'') 		as Ubicacion_Region,
	isnull(f.region,'') 				as Region,
	isnull(f.id_ubicacion_pais,'') 		as Ubicacion_Pais,
	isnull(f.pais,'') 				as Pais,
	h.id_marca				as id_marca,
	i.descripcion 				as Marca,
	h.id_fabricante				as id_fabricante,
	j.nombre 				as Fabricante,
	h.id_modelo				as id_modelo,
	k.descripcion 				as Modelo,
	h.id_logotipo				as id_logotipo,
	l.descripcion 				as Logotipo,
	h.id_tipo				as id_tipo,
	m.descripcion 				as TipoEquipo,
	a.no_contrato 				as NoContrato,
	g.id_agencia				as Agencia,
	isnull(x.descripcion,'No Definido')		as TipoNegocio,
	isnull(c.id_tipo_negocio,999)			as CodTipoNegocio,
	a.id_negocio,
	c.latitud_grad	as Latitud_Grad,
	c.latitud_min	as Latitud_Min,
	c.latitud_seg	as Latitud_Seg,
	c.longitud_grad	as Longitud_Grad,
	c.longitud_min	as Longitud_Min,
	c.longitud_seg	as Longitud_Seg,
	c.direccion	as			Direccion
From	tbl_movimientos 		a  			inner join
	tbl_negocios 		c 	on 
	    a.id_negocio		=	c.id_negocio 	left join
	tbl_tipos_negocios	x	on
	    x.id_tipo_negocio	=	c.id_tipo_negocio inner join
	tbl_personal 		d 	on 
	    a.id_personal		=	d.id_personal 	inner join
	tbl_ubicaciones 		e 	on 
	    a.id_ubicacion	=	e.id_ubicacion 	inner join
	tbl_detalle_ingresos 	g 	on 
	    g.id_serie		=	a.id_serie 	inner join
	tbl_ingresos 		h 	on 
	    h.id_ingreso		=	g.id_ingreso 	and
	    h.id_agencia		=	g.id_agencia	left join
	tbl_marcas 		i 	on 
	    h.id_marca		=	i.id_marca 	left join
	tbl_fabricantes 		j 	on 
	    j.id_fabricante		=	h.id_fabricante 	left join
	tbl_modelos 		k 	on 
	    k.id_modelo		=	h.id_modelo 	left join
	tbl_logotipos 		l 	on 
	    l.id_logotipo		=	h.id_logotipo 	left join
	tbl_tipos 		m 	on 
	    m.id_tipo		=	h.id_tipo left join
	tbl_traslados 		n 	on 
	    n.id_orden_traslado	=	a.id_orden_traslado

--REVISION DE PERMISOS POR UBICACION

left join
	(
(select	z.id_ubicacion,
	z.descripcion,
	z.id_ubicacion_maestra 	as id_ubicacion_supervisor,
	y.descripcion 		as supervisor,
	y.id_ubicacion_maestra 	as id_ubicacion_distribuidora,
	v.descripcion 		as distribuidora,
	v.id_ubicacion_maestra 	as id_ubicacion_region,
	s.descripcion 		as region,
	s.id_ubicacion_maestra 	as id_ubicacion_pais,
	q.descripcion 		as pais
from	tbl_ubicaciones 		z 	inner join
	(
              select	x.id_ubicacion,
	   	x.id_ubicacion_maestra,
		x.descripcion
             from	tbl_ubicaciones x
	) y on 
             	z.id_ubicacion_maestra	=	y.id_ubicacion inner join    --NIVEL DE SUPERVISOR DE LA RUTA
	(
              select	u.id_ubicacion,
	   	u.id_ubicacion_maestra,
		u.descripcion
             from	tbl_ubicaciones u
	) v on 
             	y.id_ubicacion_maestra	=	v.id_ubicacion inner join    --NIVEL DE EMBOTELLADORA DEL SUPERVISOR
	(
              select	t.id_ubicacion,
	   	t.id_ubicacion_maestra,
		t.descripcion
             from	tbl_ubicaciones t
	) s on 
             	v.id_ubicacion_maestra	=	s.id_ubicacion inner join    --NIVEL DE REGION DE LA EMBOTELLADORA
	(
              select	r.id_ubicacion,
	   	r.id_ubicacion_maestra,
		r.descripcion
             from	tbl_ubicaciones r
	) 	q 	on 
             	s.id_ubicacion_maestra	=	q.id_ubicacion)      --NIVEL DE PAIS DE LA REGION
	) 	f 	on f.id_ubicacion	=	a.id_ubicacion


where	a.id_empresa	=	@empresa
order by a.id_serie,
	a.correlativo

GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_historial_movimientos_gen]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_consulta_historial_movimientos_gen] @tipo int, @empresa int, @condicion varchar(3000) AS

Declare @Texto_Query varchar(8000),
	@Texto_Query1 varchar(8000),
	@Texto_Query2 varchar(8000),
	@Texto_Query3 varchar(8000)

If @Condicion is null
  Set @Condicion=''

If @tipo=0 
begin
Select	'' 				as Serie,
	0 				as No_Movimiento,
	0 				as Correlativo,
	''	 			as Sio,
	'' 				as Ficha,
	getdate() 			as Fecha,
	0 				as Codigo_Negocio,
	'' 				as Negocio,
	0 				as Piloto_Tecnico,
	''				as Nombre,
	0				as Ingreso,
	0				as Orden_Traslado,
	''				as Ubicacion_Ruta,
	''				as Ruta,
	''				as Ubicacion_Supervisor,
	''				as Supervisor,
	'' 				as Ubicacion_Distribuidora,
	'' 				as Distribuidora,
	'' 				as Ubicacion_Region,
	'' 				as Region,
	'' 				as Ubicacion_Pais,
	'' 				as Pais,
	0				as id_marca,
	'' 				as Marca,
	0				as id_fabricante,
	'' 				as Fabricante,
	0				as id_modelo,
	'' 				as Modelo,
	0				as id_logotipo,
	'' 				as Logotipo,
	0				as id_tipo,
	'' 				as TipoEquipo,
	'' 				as NoContrato,
	0				as Agencia,
	''				as TipoNegocio,
	0				as CodTipoNegocio,
	0 				as id_negocio,
	0.00				as Latitud_Grad,
	0.00				as Latitud_Min,
	0.00				as Latitud_Seg,
	0.00				as Longitud_Grad,
	0.00				as Longitud_Min,
	0.00				as Longitud_Seg,
	''				as Direccion
end

else

begin

set nocount on

Set @Texto_Query1=
'Select	a.id_serie 				as Serie,
	a.id_movimiento 				as No_Movimiento,
	a.correlativo 				as Correlativo,
	c.id_alterno	 			as Sio,
	a.id_ficha 				as Ficha,
	isnull(n.fecha,a.fecha) 			as Fecha,
	a.id_negocio 				as Codigo_Negocio,
	c.nombre 				as Negocio,
	a.id_personal 				as Piloto_Tecnico,
	d.nombre				as Nombre,
	a.id_ingreso 				as Ingreso,
	a.id_orden_traslado 			as Orden_Traslado,
	a.id_ubicacion 				as Ubicacion_Ruta,
	e.descripcion 				as Ruta,
	isnull(f.id_ubicacion_supervisor,space(1)) 		as Ubicacion_Supervisor,
	isnull(f.supervisor,space(1)) 			as Supervisor,
	isnull(f.id_ubicacion_distribuidora,space(1)) 	as Ubicacion_Distribuidora,
	isnull(f.distribuidora,space(1)) 			as Distribuidora,
	isnull(f.id_ubicacion_region,space(1)) 		as Ubicacion_Region,
	isnull(f.region,space(1)) 				as Region,
	isnull(f.id_ubicacion_pais,space(1)) 		as Ubicacion_Pais,
	isnull(f.pais,space(1)) 				as Pais,
	h.id_marca				as id_marca,
	i.descripcion 				as Marca,
	h.id_fabricante				as id_fabricante,
	j.nombre 				as Fabricante,
	h.id_modelo				as id_modelo,
	k.descripcion 				as Modelo,
	h.id_logotipo				as id_logotipo,
	l.descripcion 				as Logotipo,
	h.id_tipo				as id_tipo,
	m.descripcion 				as TipoEquipo,
	a.no_contrato 				as NoContrato,
	a.id_agencia				as Agencia,
	isnull(x.descripcion,space(1))		as TipoNegocio,
	isnull(c.id_tipo_negocio,999)			as CodTipoNegocio,
	a.id_negocio,
	c.latitud_grad	as Latitud_Grad,
	c.latitud_min	as Latitud_Min,
	c.latitud_seg	as Latitud_Seg,
	c.longitud_grad	as Longitud_Grad,
	c.longitud_min	as Longitud_Min,
	c.longitud_seg	as Longitud_Seg,
	c.direccion	as			Direccion
From	tbl_movimientos 		a  			inner join
	tbl_negocios 		c 	on 
	    a.id_negocio		=	c.id_negocio 	left join
	tbl_tipos_negocios	x	on
	    x.id_tipo_negocio	=	c.id_tipo_negocio and
	    a.id_agencia		=	x.id_agencia	inner join
	tbl_personal 		d 	on 
	    a.id_personal		=	d.id_personal 	inner join
	tbl_ubicaciones 		e 	on 
	    a.id_ubicacion	=	e.id_ubicacion 	inner join
	tbl_activos		h	on
	    a.id_serie		=	h.id_serie	left join
	tbl_marcas 		i 	on 
	    h.id_marca		=	i.id_marca 	 and
	    a.id_agencia		=	i.id_agencia	left join
	tbl_fabricantes 		j 	on 
	    j.id_fabricante		=	h.id_fabricante 	left join
	tbl_modelos 		k 	on 
	    k.id_modelo		=	h.id_modelo 	 and
	    a.id_agencia		=	k.id_agencia	left join
	tbl_logotipos 		l 	on 
	    l.id_logotipo		=	h.id_logotipo 	 and
	    a.id_agencia		=	l.id_agencia	left join
	tbl_tipos 		m 	on 
	    m.id_tipo		=	h.id_tipo 	 and
	    a.id_agencia		=	m.id_agencia	left join
	tbl_traslados 		n 	on 
	    n.id_orden_traslado	=	a.id_orden_traslado 
--REVISION DE LOS NIVELES POR UBICACION 
left join
	(
(select	z.id_ubicacion,
	z.descripcion,
	z.id_ubicacion_maestra 	as id_ubicacion_supervisor,
	y.descripcion 		as supervisor,
	y.id_ubicacion_maestra 	as id_ubicacion_distribuidora,
	v.descripcion 		as distribuidora,
	v.id_ubicacion_maestra 	as id_ubicacion_region,
	s.descripcion 		as region,
	s.id_ubicacion_maestra 	as id_ubicacion_pais,
	q.descripcion 		as pais
from	tbl_ubicaciones 		z 	inner join
	(
              select	x.id_ubicacion,
	   	x.id_ubicacion_maestra,
		x.descripcion
             from	tbl_ubicaciones x
	) y on 
             	z.id_ubicacion_maestra	=	y.id_ubicacion inner join    --NIVEL DE SUPERVISOR DE LA RUTA
	(
              select	u.id_ubicacion,
	   	u.id_ubicacion_maestra,
		u.descripcion
             from	tbl_ubicaciones u
	) v on 
             	y.id_ubicacion_maestra	=	v.id_ubicacion inner join    --NIVEL DE EMBOTELLADORA DEL SUPERVISOR
	(
              select	t.id_ubicacion,
	   	t.id_ubicacion_maestra,
		t.descripcion
             from	tbl_ubicaciones t
	) s on 
             	v.id_ubicacion_maestra	=	s.id_ubicacion inner join    --NIVEL DE REGION DE LA EMBOTELLADORA
	(
              select	r.id_ubicacion,
	   	r.id_ubicacion_maestra,
		r.descripcion
             from	tbl_ubicaciones r
	) 	q 	on 
             	s.id_ubicacion_maestra	=	q.id_ubicacion)      --NIVEL DE PAIS DE LA REGION
	) 	f 	on f.id_ubicacion	=	a.id_ubicacion


where	a.id_empresa	=	'+cast(@empresa as char(5))

Set @Texto_Query2=' order by a.id_serie,a.correlativo'


Set @Texto_Query=
	ltrim(rtrim(@Texto_Query1))+' '+
	ltrim(rtrim(@Condicion))+' '+
	ltrim(rtrim(@Texto_Query2))

set nocount off

--select @Texto_Query as Query

Exec(@texto_Query)
end
GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_historica_series]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_consulta_historica_series] @empresa int, @serie_inicial char(30), @serie_final char(30) AS

Select	x.Tipo_Docto,
	x.Documento,
	x.Tipo_Cargo,
	x.No_Cargo,
	x.Serie,
	s.id_alterno as Ficha,
	x.Fecha,
	x.Cantidad,
	x.UMD,
	x.Valor,
	x.Valor_Total,
	x.Codigo_Negocio,
	x.Codigo_Negocio_Anterior,
	x.Piloto_Tecnico,
	x.Ubicacion_Ruta,
	x.NoContrato,
	x.Descripcion,
	x.Agencia,
	x.Sio,
	y.id_negocio	as  'Negocio_Actual',
	s.nombre	as  'Nombre_Negocio_Actual',
	y.id_tipo		as  'Cod_Tipo_Equipo',
	u.descripcion	as  'Tipo_Equipo',
	y.id_modelo	as  'Cod_Modelo',
	w.descripcion	as  'Modelo',
	y.id_logotipo	as  'Cod_Logotipo',
	v.descripcion	as  'Logotipo',
	y.id_marca	as  'Cod_Marca',
	t.descripcion	as  'Marca',
	s.direccion	as Direccion,
	r.id_alterno	as Ruta
From
(Select	'TRASLADOS'				as 'Tipo_Docto',
	a.id_orden_traslado 			as 'Documento',
	'Traslado'				as 'Tipo_Cargo',
	a.id_movimiento				as 'No_Cargo',
	a.id_serie 				as 'Serie',
	a.id_ficha 				as 'Ficha',
	cast(cast(a.fecha as char(11)) as datetime)		as 'Fecha',
	1					as 'Cantidad',
	'PZ'					as 'UMD',
	a.valor					as 'Valor',
	a.valor					as 'Valor_Total',
	a.id_negocio 				as 'Codigo_Negocio',
	a.id_negocio_anterior			as 'Codigo_Negocio_Anterior',
	a.id_personal 				as 'Piloto_Tecnico',
	a.id_ubicacion 				as 'Ubicacion_Ruta',
	a.no_contrato 				as 'NoContrato',
	isnull(a.observaciones,'')		as 'Descripcion',
	a.id_agencia				as 'Agencia',
	a.serie_especial					as 'Sio'
From	tbl_movimientos 		a  			
Where	a.id_empresa		=	@empresa	and
	a.id_orden_traslado	>	0		and
	a.id_serie		between	@serie_inicial 	and @serie_final	
UNION
Select	'MANT-CORRECTIVO'			as 'Tipo_Docto',
	b.id_orden_trabajo 			as 'Documento',
	'Opcion_Trabajo'			as 'Tipo_Cargo',
	b.id_opcion_trabajo			as 'No_Cargo',
	c.id_serie 				as 'Serie',
	c.id_ficha 				as 'Ficha',
	cast(cast(c.fecha as char(11)) as datetime)		as 'Fecha',
	b.cantidad				as 'Cantidad',
	b.id_unidad_medida			as 'UMD',
	b.valor_unitario			as 'Valor',
	(b.cantidad*b.valor_unitario)		as 'Valor_Total',
	c.id_negocio 				as 'Codigo_Negocio',
	0					as 'Codigo_Negocio_Anterior',
	c.id_personal 				as 'Piloto_Tecnico',
	c.id_ubicacion 				as 'Ubicacion_Ruta',
	''	 				as 'NoContrato',
	b.descripcion				as 'Descripcion',
	b.id_agencia				as 'Agencia',
	c.id_sio					as 'Sio'
From	tbl_detalle_orden_trabajo 		b  	inner join
	tbl_orden_trabajo			c	on
	  b.id_empresa		=	c.id_empresa	and
	  b.id_orden_trabajo	=	c.id_orden_trabajo
Where	b.id_empresa		=	@empresa	and
	c.id_tipo_trabajo	=	1		and
	c.id_serie		between	@serie_inicial 	and @serie_final	
UNION
Select	'MANT-PREVENTIVO'			as 'Tipo_Docto',
	b.id_orden_trabajo 			as 'Documento',
	'Opcion_Trabajo'			as 'Tipo_Cargo',
	b.id_opcion_trabajo			as 'No_Cargo',
	c.id_serie 				as 'Serie',
	c.id_ficha 				as 'Ficha',
	cast(cast(c.fecha as char(11)) as datetime)		as 'Fecha',
	b.cantidad				as 'Cantidad',
	b.id_unidad_medida			as 'UMD',
	b.valor_unitario			as 'Valor',
	(b.cantidad*b.valor_unitario)		as 'Valor_Total',
	c.id_negocio 				as 'Codigo_Negocio',
	0					as 'Codigo_Negocio_Anterior',
	c.id_personal 				as 'Piloto_Tecnico',
	c.id_ubicacion 				as 'Ubicacion_Ruta',
	''	 				as 'NoContrato',
	b.descripcion				as 'Descripcion',
	b.id_agencia				as 'Agencia',
	c.id_sio					as 'Sio'
From	tbl_detalle_orden_trabajo 		b  	inner join
	tbl_orden_trabajo			c	on
	  b.id_empresa		=	c.id_empresa	and
	  b.id_orden_trabajo	=	c.id_orden_trabajo
Where	b.id_empresa		=	@empresa	and
	c.id_tipo_trabajo	=	2		and
	c.id_serie		between	@serie_inicial 	and @serie_final	) 	x 	
	inner join
	tbl_activos								y 	on
	  x.serie	=	y.id_serie						inner join
	tbl_modelos								w	on
	  w.id_modelo	=	y.id_modelo						inner join
	tbl_logotipos								v	on
	  v.id_logotipo	=	y.id_logotipo						inner join
	tbl_tipos								u	on
	  u.id_tipo	=	y.id_tipo						inner join
	tbl_marcas								t	on
	  t.id_marca	=	y.id_marca						inner join
	tbl_negocios								s	on

	  s.id_negocio	=	y.id_negocio	and
	  s.id_empresa	=	@empresa					inner join
	tbl_ubicaciones								r	on
	  r.id_ubicacion	=	x.Ubicacion_Ruta
order by 	x.serie,
		x.tipo_docto desc,
		x.fecha




GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_ingresos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_consulta_ingresos] @empresa int AS
Select	a.id_ingreso 		as 'Ingreso',
	b.fecha 			as 'Fecha',
	b.id_documento 		as 'Tipo-Docto',
	c.descripcion 		as 'Docto',
	b.no_documento 	as 'No-Docto',
	a.id_serie 		as 'Serie',
	b.id_modelo 		as 'Cod-Modelo',
	d.descripcion 		as 'Modelo',
	b.id_marca 		as 'Cod-Marca',
	e.descripcion 		as 'Marca',
	b.id_negocio 		as 'Cod-Negocio',
	f.nombre 		as 'Negocio',
	f.id_tipo_negocio 	as 'Cod-Tipo-Negocio',
	g.descripcion 		as 'Tipo-Negocio',
	a.id_ficha 		as 'Ficha',
	f.id_alterno		as 'Sio',
	a.id_agencia		as 'Agencia',
	b.id_negocio,
	f.latitud_grad	as Latitud_Grad,
	f.latitud_min	as Latitud_Min,
	f.latitud_seg	as Latitud_Seg,
	f.longitud_grad	as Longitud_Grad,
	f.longitud_min	as Longitud_Min,
	f.longitud_seg	as Longitud_Seg
From	tbl_detalle_ingresos 	a 	inner join
	tbl_ingresos 		b 	on
	  a.id_ingreso		=	b.id_ingreso 	and 
	  a.id_empresa		=	b.id_empresa 	and
	  a.id_agencia		=	b.id_agencia	inner join
	tbl_documentos 		c 	on
	  b.id_documento	=	c.id_documento inner join
	tbl_modelos 		d 	on
	  d.id_modelo		=	b.id_modelo 	inner join
	tbl_marcas 		e 	on
	  e.id_marca		=	b.id_marca 	inner join
	tbl_negocios 		f 	on
	  f.id_negocio		=	b.id_negocio  	and 
	  f.id_empresa		=	b.id_empresa 	inner join
	tbl_tipos_negocios 	g 	on
	  g.id_tipo_negocio	=	f.id_tipo_negocio
where	a.id_empresa=@empresa










GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_ingresos_gen]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_consulta_ingresos_gen] @tipo int, @empresa int, @condicion varchar(8000) AS

Declare @Texto_Query varchar(8000),
	@Texto_Query1 varchar(8000),
	@Texto_Query2 varchar(8000),
	@Texto_Query3 varchar(8000)

If @Condicion is null
  Set @Condicion=''

If @tipo=0 
begin
Select	0 		as 'Ingreso',
	getdate()	as 'Fecha',
	0 		as 'Tipo-Docto',
	'' 		as 'Docto',
	'' 		as 'No-Docto',
	'' 		as 'Serie',
	0 		as 'Cod-Modelo',
	'' 		as 'Modelo',
	0 		as 'Cod-Marca',
	'' 		as 'Marca',
	0 		as 'Cod-Negocio',
	'' 		as 'Negocio',
	0 		as 'Cod-Tipo-Negocio',
	'' 		as 'Tipo-Negocio',
	'' 		as 'Ficha',
	''		as 'Sio',
	0		as 'Agencia',
	0 		as id_negocio,
	0.00		as Latitud_Grad,
	0.00		as Latitud_Min,
	0.00		as Latitud_Seg,
	0.00		as Longitud_Grad,
	0.00		as Longitud_Min,
	0.00		as Longitud_Seg
end

else

begin

set nocount on

Set @Texto_Query1=
'Select	a.id_ingreso 		as "Ingreso",
	b.fecha 			as "Fecha",
	b.id_documento 		as "Tipo-Docto",
	c.descripcion 		as "Docto",
	b.no_documento 	as "No-Docto",
	a.id_serie 		as "Serie",
	h.id_modelo 		as "Cod-Modelo",
	d.descripcion 		as "Modelo",
	h.id_marca 		as "Cod-Marca",
	e.descripcion 		as "Marca",
	h.id_negocio 		as "Cod-Negocio",
	f.nombre 		as "Negocio",
	f.id_tipo_negocio 	as "Cod-Tipo-Negocio",
	g.descripcion 		as "Tipo-Negocio",
	a.id_ficha 		as "Ficha",
	f.id_alterno		as "Sio",
	a.id_agencia		as "Agencia",
	h.id_negocio,
	f.latitud_grad		as Latitud_Grad,
	f.latitud_min		as Latitud_Min,
	f.latitud_seg		as Latitud_Seg,
	f.longitud_grad		as Longitud_Grad,
	f.longitud_min		as Longitud_Min,
	f.longitud_seg		as Longitud_Seg
From	tbl_detalle_ingresos 	a 	inner join
	tbl_ingresos 		b 	on
	  a.id_ingreso		=	b.id_ingreso 	and 
	  a.id_empresa		=	b.id_empresa 	and
	  a.id_agencia		=	b.id_agencia	inner join
	tbl_documentos 		c 	on
	  b.id_documento	=	c.id_documento inner join
	tbl_activos		h	on
	  a.id_serie		=	h.id_serie	inner join
	tbl_modelos 		d 	on
	  d.id_modelo		=	h.id_modelo 	 and
	    a.id_agencia		=	d.id_agencia	inner join
	tbl_marcas 		e 	on
	  e.id_marca		=	h.id_marca 	 and
	    a.id_agencia		=	e.id_agencia	inner join
	tbl_negocios 		f 	on
	  f.id_negocio		=	h.id_negocio  	and 
	  f.id_empresa		=	b.id_empresa 	inner join
	tbl_tipos_negocios 	g 	on
	  g.id_tipo_negocio	=	f.id_tipo_negocio  and
	    a.id_agencia		=	g.id_agencia	
where	a.id_empresa= '+cast(@empresa as char(5))

Set @Texto_Query2=' '


Set @Texto_Query=
	ltrim(rtrim(@Texto_Query1))+' '+
	ltrim(rtrim(@Condicion))+' '+
	ltrim(rtrim(@Texto_Query2))

set nocount off

--select @Texto_Query as Query

Exec(@texto_Query)
end
GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_movimientos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_consulta_movimientos] @empresa int, @serie char(20) AS
select	*
from	tbl_movimientos
where	id_empresa=@empresa and
	id_serie=@serie


GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_negocios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_consulta_negocios] @empresa int, @usuario Char(20) AS
select  	a.id_negocio,
	isnull(a.id_alterno,'') as id_alterno,
	a.nombre,
	a.nit,
	a.direccion,
	a.contacto,
	a.suspendido,
	a.id_tipo_negocio,
	b.descripcion as nomtipo,
	a.id_ubicacion,
	e.descripcion as nomubicacion,
	a.id_clasificacion_negocio,
	c.descripcion as nomclasificacion,
	f.id_ubicacion_supervisor,
	f.supervisor,
	f.id_ubicacion_distribuidora,
	f.distribuidora,
	f.id_ubicacion_region,
	f.region,
	f.id_ubicacion_pais,
	f.pais,
	a.id_agencia,
	isnull(d.id_serie,'') as id_serie,
	isnull(d.id_ficha,'') as id_ficha,
	isnull(d.id_sio,'') as id_sio,
	isnull(d.id_tipo,0)	as  'Cod_Tipo_Equipo',
	isnull(u.descripcion,'')	as  'Tipo_Equipo',
	isnull(d.id_modelo,0)	as  'Cod_Modelo',
	isnull(w.descripcion,'')	as  'Modelo',
	isnull(d.id_logotipo,0)	as  'Cod_Logotipo',
	isnull(v.descripcion,'')	as  'Logotipo',
	isnull(d.id_marca,0)	as  'Cod_Marca',
	isnull(t.descripcion,'')	as  'Marca',
	case when d.id_serie is null then 0 else 1 end as 'Es_Equipo',
	d.id_orden_traslado	as 'Ord-Traslado',
	d.fecha_orden_traslado	as 'Fecha-Orden-Traslado',
	a.latitud_grad	as Latitud_Grad,
	a.latitud_min	as Latitud_Min,
	a.latitud_seg	as Latitud_Seg,
	a.longitud_grad	as Longitud_Grad,
	a.longitud_min	as Longitud_Min,
	a.longitud_seg	as Longitud_Seg,
	a.foto		as Foto,
	a.archivo
from	tbl_negocios 			a 	left join
	tbl_activos			d	on
	  a.id_negocio	=	d.id_negocio	inner join
	tbl_tipos_negocios 		b 	on 
	  a.id_tipo_negocio=b.id_tipo_negocio 	inner join
	tbl_clasificacion_negocios 	c 	on 
	  a.id_clasificacion_negocio=c.id_clasificacion_negocio inner join
	tbl_ubicaciones 			e 	on 
	  a.id_ubicacion=e.id_ubicacion 		inner join
	tbl_ubicaciones_permiso 		o 	on 
	  a.id_ubicacion=o.id_ubicacion		left join
	tbl_modelos								w	on
	  w.id_modelo	=	d.id_modelo						left join
	tbl_logotipos								v	on
	  v.id_logotipo	=	d.id_logotipo						left join
	tbl_tipos								u	on
	  u.id_tipo	=	d.id_tipo						left join
	tbl_marcas								t	on
	  t.id_marca	=	d.id_marca
left join
	(
(select	z.id_ubicacion,
	z.descripcion,
	z.id_ubicacion_maestra as id_ubicacion_supervisor,
	y.descripcion as supervisor,
	y.id_ubicacion_maestra as id_ubicacion_distribuidora,
	v.descripcion as distribuidora,
	v.id_ubicacion_maestra as id_ubicacion_region,
	s.descripcion as region,
	s.id_ubicacion_maestra as id_ubicacion_pais,
	q.descripcion as pais
from	tbl_ubicaciones z inner join
	(
              select	x.id_ubicacion,
	   	x.id_ubicacion_maestra,
		x.descripcion
             from	tbl_ubicaciones x
	) y on 
             	z.id_ubicacion_maestra=y.id_ubicacion inner join
	(
              select	u.id_ubicacion,
	   	u.id_ubicacion_maestra,
		u.descripcion
             from	tbl_ubicaciones u
	) v on 
             	y.id_ubicacion_maestra=v.id_ubicacion inner join
	(
              select	t.id_ubicacion,
	   	t.id_ubicacion_maestra,
		t.descripcion
             from	tbl_ubicaciones t
	) s on 
             	v.id_ubicacion_maestra=s.id_ubicacion inner join
	(
              select	r.id_ubicacion,
	   	r.id_ubicacion_maestra,
		r.descripcion
             from	tbl_ubicaciones r
	) q on 
             	s.id_ubicacion_maestra=q.id_ubicacion)
	) f on f.id_ubicacion=a.id_ubicacion
where	a.id_empresa=@empresa and o.id_usuario=@usuario






GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_negocios_gen]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_consulta_negocios_gen] @tipo int, @empresa int, @usuario Char(20), @condicion varchar(8000) AS

Declare @Texto_Query varchar(8000),
	@Texto_Query1 varchar(8000),
	@Texto_Query2 varchar(8000),
	@Texto_Query3 varchar(8000),
	@imagen varbinary(16)

If @Condicion is null
  Set @Condicion=''

If @tipo=0 
begin
Select  	0	as id_negocio,
	'' 	as id_alterno,
	'' 	as nombre,
	'' 	as nit,
	'' 	as direccion,
	'' 	as contacto,
	0 	as suspendido,
	0 	as id_tipo_negocio,
	'' 	as nomtipo,
	'' 	as id_ubicacion,
	'' 	as nomubicacion,
	0 	as id_clasificacion_negocio,
	'' 	as nomclasificacion,
	'' 	as id_ubicacion_supervisor,
	'' 	as supervisor,
	'' 	as id_ubicacion_distribuidora,
	'' 	as distribuidora,
	'' 	as id_ubicacion_region,
	'' 	as region,
	'' 	as id_ubicacion_pais,
	'' 	as pais,
	0	as id_agencia,
	'' 	as id_serie,
	'' 	as id_ficha,
	'' 	as id_sio,
	0	as  'Cod_Tipo_Equipo',
	''	as  'Tipo_Equipo',
	0	as  'Cod_Modelo',
	''	as  'Modelo',
	0	as  'Cod_Logotipo',
	''	as  'Logotipo',
	0	as  'Cod_Marca',
	''	as  'Marca',
	0 	as 'Es_Equipo',
	0	as 'Ord-Traslado',
	getdate() as 'Fecha-Orden-Traslado',
	0.00	as Latitud_Grad,
	0.00	as Latitud_Min,
	0.00	as Latitud_Seg,
	0.00	as Longitud_Grad,
	0.00	as Longitud_Min,
	0.00	as Longitud_Seg,
	'' 	as archivo,
	''	as 'Ruta-Alterno',
	0	as 'Foto',
	0	as 'Venta-Mensual',
	0	as Visitado,
	0	as 'Orden-Trabajo',
	getdate() as 'Fecha-Visita',
	space(100) as Observaciones,
	space(20) as Contrato
end

else

begin

set nocount on

Set @Texto_Query1=
'select  	a.id_negocio,
	isnull(a.id_alterno,space(1)) as id_alterno,
	a.nombre,
	a.nit,
	a.direccion,
	a.contacto,
	a.suspendido,
	a.id_tipo_negocio,
	b.descripcion as nomtipo,
	a.id_ubicacion,
	e.descripcion as nomubicacion,
	a.id_clasificacion_negocio,
	c.descripcion as nomclasificacion,
	f.id_ubicacion_supervisor,
	f.supervisor,
	f.id_ubicacion_distribuidora,
	f.distribuidora,
	f.id_ubicacion_region,
	f.region,
	f.id_ubicacion_pais,
	f.pais,
	a.id_agencia,
	isnull(d.id_serie,space(1)) as id_serie,
	isnull(d.id_ficha,space(1)) as id_ficha,
	isnull(d.id_sio,space(1)) as id_sio,
	isnull(d.id_tipo,0)	as  Cod_Tipo_Equipo,
	isnull(u.descripcion,space(1))	as  Tipo_Equipo,
	isnull(d.id_modelo,0)	as  Cod_Modelo,
	isnull(w.descripcion,space(1))	as  Modelo,
	isnull(d.id_logotipo,0)	as  Cod_Logotipo,
	isnull(v.descripcion,space(1))	as  Logotipo,
	isnull(d.id_marca,0)	as  Cod_Marca,
	isnull(t.descripcion,space(1))	as  Marca,
	case when d.id_serie is null then 0 else 1 end as Es_Equipo,
	d.id_orden_traslado	as "Ord-Traslado",
	d.fecha_orden_traslado	as "Fecha-Orden-Traslado",
	a.latitud_grad	as Latitud_Grad,
	a.latitud_min	as Latitud_Min,
	a.latitud_seg	as Latitud_Seg,
	a.longitud_grad	as Longitud_Grad,
	a.longitud_min	as Longitud_Min,
	a.longitud_seg	as Longitud_Seg,
	a.archivo,
	e.id_alterno	as "Ruta-Alterno",
	CASE WHEN a.foto is null THEN 0 ELSE 1 END					as "Foto"  ,
	a.venta_mensual as "Venta-Mensual" ,
	d.visitado	as Visitado,
	d.id_orden_trabajo	as "Orden-Trabajo",
	d.fecha_visita as "Fecha-Visita" ,
	s.descripcion as Observaciones,
	d.no_contrato as Contrato
from	tbl_negocios 			a 	left join
	tbl_activos			d	on
	  a.id_negocio	=	d.id_negocio	inner join
	tbl_tipos_negocios 		b 	on 
	  a.id_tipo_negocio=b.id_tipo_negocio 	and
	  a.id_agencia	=	b.id_agencia  	inner join
	tbl_clasificacion_negocios 	c 	on 
	  a.id_clasificacion_negocio=c.id_clasificacion_negocio inner join
	tbl_ubicaciones 			e 	on 
	  a.id_ubicacion=e.id_ubicacion 		inner join
	tbl_ubicaciones_permiso 		o 	on 
	  a.id_ubicacion=o.id_ubicacion		and
	  o.id_empresa=a.id_empresa		 left join
	tbl_modelos								w	on
	  w.id_modelo	=	d.id_modelo	and
	  a.id_agencia	=	w.id_agencia  	left join
	tbl_logotipos								v	on
	  v.id_logotipo	=	d.id_logotipo	and
	  a.id_agencia	=	v.id_agencia  						left join
	tbl_tipos								u	on
	  u.id_tipo	=	d.id_tipo	and
	  a.id_agencia	=	u.id_agencia  						left join
	tbl_marcas								t	on
	  t.id_marca	=	d.id_marca	and
	  a.id_agencia	=	t.id_agencia  	left join
	tbl_problemas	s	on
	  s.id_problema   = d.id_problema 
left join
	(
(select	z.id_ubicacion,
	z.descripcion,
	z.id_ubicacion_maestra as id_ubicacion_supervisor,
	y.descripcion as supervisor,
	y.id_ubicacion_maestra as id_ubicacion_distribuidora,
	v.descripcion as distribuidora,
	v.id_ubicacion_maestra as id_ubicacion_region,
	s.descripcion as region,
	s.id_ubicacion_maestra as id_ubicacion_pais,
	q.descripcion as pais
from	tbl_ubicaciones z inner join
	(
              select	x.id_ubicacion,
	   	x.id_ubicacion_maestra,
		x.descripcion
             from	tbl_ubicaciones x
	) y on 
             	z.id_ubicacion_maestra=y.id_ubicacion inner join
	(
              select	u.id_ubicacion,
	   	u.id_ubicacion_maestra,
		u.descripcion
             from	tbl_ubicaciones u
	) v on 
             	y.id_ubicacion_maestra=v.id_ubicacion inner join
	(
              select	t.id_ubicacion,
	   	t.id_ubicacion_maestra,
		t.descripcion
             from	tbl_ubicaciones t
	) s on 
             	v.id_ubicacion_maestra=s.id_ubicacion inner join
	(
              select	r.id_ubicacion,
	   	r.id_ubicacion_maestra,
		r.descripcion
             from	tbl_ubicaciones r
	) q on 
             	s.id_ubicacion_maestra=q.id_ubicacion)
	) f on f.id_ubicacion=a.id_ubicacion
where	a.id_empresa = '+cast(@empresa as char(5))+' and o.id_usuario = '+@usuario

Set @Texto_Query2=''


Set @Texto_Query=
	ltrim(rtrim(@Texto_Query1))+' '+
	ltrim(rtrim(@Condicion))+' '+
	ltrim(rtrim(@Texto_Query2))

set nocount off

Exec(@texto_Query)
end




GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_ordenes_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_consulta_ordenes_trabajo]

@tipo int, 
@empresa int, 
@usuario char(20), 
@condicion varchar(8000), 
@condicion2 varchar(8000) 

AS

Declare @imagen varbinary(16),
	@UMD char(3),
	@Traslado char(20),
	@Texto_Query varchar(8000),
	@Texto_Query1 varchar(8000),
	@Texto_Query2 varchar(8000),
	@Texto_Query3 varchar(8000)

Set	@UMD = 'PZ'
Set	@Traslado='Traslado'

If @Condicion is null
  Set @Condicion=''

If @Condicion2 is null
  Set @Condicion2=''

If @tipo=0
begin
Select	0	as id_opcion_trabajo,
	''	as descripcion,
	''	as id_unidad_medida,
	0.00	as cantidad,
	0.00	as valor_unitario,
	0	as id_empresa,
	0	as id_orden_trabajo,
	getdate() as fecha,
	0	as id_negocio,
	''	as nomnegocio,
	''	as id_ubicacion,
	''	as nomubicacion,
	0	as id_personal,
	''	as nombre,
	''	as id_ubicacion_supervisor,
	''	as supervisor,
	''	as id_ubicacion_distribuidora,
	''	as distribuidora,
	''	as id_ubicacion_region,
	''	as region,
	''	as id_ubicacion_pais,
	''	as pais,
	0.00 	as Total,
	0	as "Agencia",
	''	as "Cod_Tecnico",
	''	as id_sector,
	''	as id_region,
	0	as "Cod_Tipo_Trabajo",
	''	as "Tipo-Trabajo",
	''	as Alterno,
	''	as Serie,
	''	as Direccion,
	0.00	as Latitud_Grad,
	0.00	as Latitud_Min,
	0.00	as Latitud_Seg,
	0.00	as Longitud_Grad,
	0.00	as Longitud_Min,
	0.00	as Longitud_Seg,
	''	as Ficha,
	''	as "Serie-Orden",
	0	as "Dia-Trabajo",
	''	as "Hora-Inicio",
	''	as "Hora-Final",
	0	as Estado,
	0	as "Cod-Calidad",
	''	as "Observaciones",
	''	as Calidad,
	''	as "Region-Orden",
	''	as Sector,
	0	as "Cod-Tipo-Negocio",
	''	as "Tipo-Negocio",
	''	as "Cod-Tipo-Movimiento",
	''	as "Tipo-Movimiento",
	0	as primera_linea,
	'NO'	as "Con-Llamada",
	'NO'	as "Aplico-Correctivo",
	0	as "Foto",
	'NO'	as "Foraneo",
	0 	as "Cod-Problema",
	space(100) as Problema
end

else

begin

set nocount on

Set @Texto_Query1=
'Select	b.id_tipo_trabajo as id_opcion_trabajo, p.descripcion, 
space(1) as id_unidad_medida,1.00 as cantidad,	0.00 as valor_unitario,	b.id_empresa,b.id_orden_trabajo,	b.fecha,
	b.id_negocio,c.nombre as nomnegocio,b.id_ubicacion,e.descripcion as 
nomubicacion,b.id_personal,d.nombre,f.id_ubicacion_supervisor,
	f.supervisor,f.id_ubicacion_distribuidora,f.distribuidora,f.id_ubicacion_region,f.region,f.id_ubicacion_pais,f.pais,
	b.total  as Total,b.id_agencia  as 
"Agencia",d.id_alterno  as "Cod_Tecnico",b.id_sector,	b.id_region,
	isnull(p.id_tipo_opcion_trabajo,0)	as 
"Cod_Tipo_Trabajo",	isnull(p.descripcion,SPACE(1)) as 
"Tipo-Trabajo",	c.id_alterno as Alterno,
	b.id_serie as Serie, c.direccion  as Direccion, c.latitud_grad  as 
Latitud_Grad, c.latitud_min  as Latitud_Min, c.latitud_seg  as Latitud_Seg,
	c.longitud_grad	as Longitud_Grad,c.longitud_min	as Longitud_Min, 
c.longitud_seg	as Longitud_Seg,b.id_ficha as Ficha,
	b.serie_orden as "Serie-Orden",b.dia_trabajo as "Dia-Trabajo", 
b.hora_inicio	as "Hora-Inicio",	b.hora_final as "Hora-Final",
	b.estado as Estado, b.id_calidad	as "Cod-Calidad", b.observaciones as 
"Observaciones", q.descripcion	as Calidad,
	r.descripcion	as "Region-Orden", s.descripcion as Sector, c.id_tipo_negocio 
as "Cod-Tipo-Negocio", t.descripcion as "Tipo-Negocio",
	space(1) as "Cod-Tipo-Movimiento", space(1) as "Tipo-Movimiento", 
1 as primera_linea,
	CASE WHEN b.con_llamada=1 THEN ''SI'' ELSE ''NO'' END	as "Con-Llamada",
	CASE WHEN b.aplico_correctivo=1 THEN ''SI'' ELSE ''NO'' END	as 
"Aplico-Correctivo",
	CASE WHEN (Select count(*) from tbl_galeria_fotos galeria where galeria.id_empresa=b.id_empresa and galeria.id_orden_trabajo=b.id_orden_trabajo)>0 THEN 1 ELSE 0 END	as "Foto"  ,
	CASE WHEN b.foraneo=1 THEN ''SI'' ELSE ''NO'' END		as "Foraneo",
	b.id_problema as "Cod-Problema",
	u.descripcion as Problema
from	tbl_orden_trabajo  b 		 inner join
	tbl_negocios 	c 	on
	    b.id_negocio	=	c.id_negocio 	 	and
	    b.id_empresa	=	c.id_empresa	inner join
	tbl_personal 	d 	on
	    b.id_personal	=	d.id_personal 		inner join
	tbl_ubicaciones 	e 	on
	    b.id_ubicacion	=	e.id_ubicacion 		inner join
	tbl_tipos_opcion_trabajo	p	on
	    p.id_tipo_opcion_trabajo 
=	b.id_tipo_trabajo 	inner join
	tbl_calidad	q	on
	   q.id_calidad	=	b.id_calidad		left join
	tbl_regiones	r	on
	   r.id_region = b.id_region and   r.id_empresa = b.id_empresa left join
	tbl_sectores	s	on
	   s.id_sector = b.id_sector and   s.id_empresa = b.id_empresa and  
s.id_region = r.id_region	inner join
	tbl_tipos_negocios 	t 	on
	  c.id_tipo_negocio = t.id_tipo_negocio and  t.id_agencia	= 
b.id_agencia	inner join
	tbl_ubicaciones_permiso 		o 	on
	    b.id_ubicacion = o.id_ubicacion and   o.id_empresa= '+cast(@empresa as 
char(5))+'  and   o.id_usuario = '+ltrim(rtrim (@usuario))+'  left join
	tbl_problemas			u	on
	  b.id_problema = u.id_problema	left join
	((select	z.id_ubicacion,z.descripcion, z.id_ubicacion_maestra as id_ubicacion_supervisor,	y.descripcion as supervisor,y.id_ubicacion_maestra 
as id_ubicacion_distribuidora,v.descripcion as distribuidora,v.id_ubicacion_maestra as id_ubicacion_region,s.descripcion as region,s.id_ubicacion_maestra as id_ubicacion_pais,q.descripcion as pais
from	tbl_ubicaciones z inner join
	(select	x.id_ubicacion, 	x.id_ubicacion_maestra,	x.descripcion
             from	tbl_ubicaciones x ) y on
             	z.id_ubicacion_maestra=y.id_ubicacion inner join
	(select	u.id_ubicacion,  	u.id_ubicacion_maestra,	u.descripcion
             from	tbl_ubicaciones u ) v on
             	y.id_ubicacion_maestra=v.id_ubicacion inner join
	(select	t.id_ubicacion,   	t.id_ubicacion_maestra,	t.descripcion
             from	tbl_ubicaciones t ) s on
             	v.id_ubicacion_maestra=s.id_ubicacion inner join
	(select	r.id_ubicacion,   	r.id_ubicacion_maestra,	r.descripcion
             from	tbl_ubicaciones r
	) q on   s.id_ubicacion_maestra=q.id_ubicacion)) f on 
f.id_ubicacion=b.id_ubicacion
Where   b.id_empresa= '+cast(@empresa as char(5))+' '+
	ltrim(rtrim(@Condicion))
+'
UNION ALL
Select	a.id_opcion_trabajo,
	''Traslado'' as descripcion,
	c.id_alterno	 as id_unidad_medida,
	1	as cantidad,
	a.valor	as valor_unitario,
	a.id_empresa,
	a.id_orden_traslado	as id_orden_trabajo,
	l.fecha,
	a.id_negocio,
	c.nombre 	as nomnegocio,
	a.id_ubicacion,
	e.descripcion 	as nomubicacion,
	a.id_personal,
	d.nombre,
	f.id_ubicacion_supervisor,
	f.supervisor,
	f.id_ubicacion_distribuidora,
	f.distribuidora,
	f.id_ubicacion_region,
	f.region,
	f.id_ubicacion_pais,
	f.pais,
	a.valor 		as total,
	a.id_agencia	as "Agencia",
	d.id_alterno	as "Cod_Tecnico",
	space(1)	as id_sector,
	space(1)	as id_region,
	0		as "Cod_Tipo_Trabajo",
	''TRASLADOS''	as "Tipo-Trabajo",
	c.id_alterno	as Alterno,
	a.id_serie	as Serie,
	c.direccion	as Direccion,
	c.latitud_grad	as Latitud_Grad,
	c.latitud_min	as Latitud_Min,
	c.latitud_seg	as Latitud_Seg,
	c.longitud_grad	as Longitud_Grad,
	c.longitud_min	as Longitud_Min,
	c.longitud_seg	as Longitud_Seg,
	a.id_ficha	as Ficha,
	space(1)	as "Serie-Orden",
	0 as "Dia-Trabajo",
	space(1)	as "Hora-Inicio",
	space(1)	as "Hora-Final",
	0 as Estado,
	0 as "Cod-Calidad",
	a.observaciones	 as "Observaciones",
	space(1) as Calidad,
	space(1) as "Region-Orden",
	space(1) as Sector,
	c.id_tipo_negocio as "Cod-Tipo-Negocio",
	t.descripcion 	as "Tipo-Negocio",
	isnull(a.id_tipo_movimiento,0)	as "Cod-Tipo-Movimiento",
	isnull(k.descripcion,space(1))	as "Tipo-Movimiento",
	1 as primera_linea,
	''NO''	as "Con-Llamada",
	''NO''	as "Aplico-Correctivo",
	0	as "Foto"  ,
	''NO''	as "Foraneo",
	0 	as "Cod-Problema",
	space(10) as Problema
From	tbl_movimientos 	a	inner join
	tbl_negocios 	c 	on
	    a.id_negocio	=	c.id_negocio 	and a.id_empresa=c.id_empresa inner join
	tbl_personal 	d 	on 
	    a.id_personal	=	d.id_personal  	and
	    a.id_empresa	=	d.id_empresa 	    inner join
	tbl_ubicaciones 	e 	on
	    a.id_ubicacion =	e.id_ubicacion 		inner join
	tbl_ubicaciones_permiso 	o 	on
	    a.id_ubicacion =	o.id_ubicacion	and
   	    o.id_empresa= '+cast(@empresa as char(5))+'  and
	    o.id_usuario	=	'+ltrim(rtrim (@usuario))+' left join
	tbl_tipos_opcion_trabajo	p	on
	    p.id_tipo_opcion_trabajo	=	-999		inner join
	tbl_tipos_negocios 	t 	on
	  c.id_tipo_negocio	=	t.id_tipo_negocio	and
	  t.id_agencia	=	a.id_agencia		left join
	tbl_opciones_trabajo	u	on
	  a.id_opcion_trabajo	=	u.id_opcion_trabajo	left join
	tbl_tipos_movimiento	k	on
	  a.id_tipo_movimiento	=	k.id_tipo_movimiento	inner join
	tbl_traslados	l	on
	  l.id_empresa	=	a.id_empresa    and
	  l.id_orden_traslado	=	a.id_orden_traslado
left join
	((select	z.id_ubicacion,
	z.descripcion,
	z.id_ubicacion_maestra as id_ubicacion_supervisor,
	y.descripcion as supervisor,
	y.id_ubicacion_maestra as id_ubicacion_distribuidora,
	v.descripcion as distribuidora,
	v.id_ubicacion_maestra as id_ubicacion_region,
	s.descripcion as region,
	s.id_ubicacion_maestra as id_ubicacion_pais,
	q.descripcion as pais
from	tbl_ubicaciones z inner join
	(select	x.id_ubicacion,  	x.id_ubicacion_maestra,	x.descripcion
             from	tbl_ubicaciones x ) y on
             	z.id_ubicacion_maestra=y.id_ubicacion inner join
	(select	u.id_ubicacion,  	u.id_ubicacion_maestra,	u.descripcion
             from	tbl_ubicaciones u ) v on
             	y.id_ubicacion_maestra=v.id_ubicacion inner join
	(select	t.id_ubicacion,   	t.id_ubicacion_maestra,	t.descripcion
             from	tbl_ubicaciones t ) s on
             	v.id_ubicacion_maestra=s.id_ubicacion inner join
	(select	r.id_ubicacion,   	r.id_ubicacion_maestra,	r.descripcion
             from	tbl_ubicaciones r ) q on
             	s.id_ubicacion_maestra=q.id_ubicacion)) f on 
f.id_ubicacion=a.id_ubicacion
Where	a.id_orden_traslado > 0 and
	a.id_empresa  =	'+cast(@empresa as char(5))+'  '+ltrim(rtrim(@Condicion2))

Set @Texto_Query2=''

Set @Texto_Query=
	ltrim(rtrim(@Texto_Query1))+' '+
	ltrim(rtrim(@Texto_Query2))

set nocount off

--select @Texto_Query as Query

Exec(@texto_Query)
End


GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_servicios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_consulta_servicios] @empresa int, @usuario char(20) AS
select	a.id_opcion_trabajo,
	a.descripcion,
	a.id_unidad_medida,
	a.cantidad,
	a.valor_unitario,
	a.id_empresa,
	a.id_orden_trabajo,
	b.fecha,
	b.id_negocio,
	c.nombre 			as nomnegocio,
	b.id_ubicacion,
	e.descripcion 			as nomubicacion,
	b.id_personal,
	d.nombre,
	f.id_ubicacion_supervisor,
	f.supervisor,
	f.id_ubicacion_distribuidora,
	f.distribuidora,
	f.id_ubicacion_region,
	f.region,
	f.id_ubicacion_pais,
	f.pais,
	b.firma,
	b.foto,
	(a.cantidad*a.valor_unitario) 	as total,
	a.id_agencia			as 'Agencia',
	d.id_alterno			as 'Cod_Tecnico',
	b.id_sector,
	b.id_region,
	isnull(b.id_tipo_trabajo,0)		as 'Cod_Tipo_Trabajo',
	isnull(p.descripcion,'')		as 'Tipo-Trabajo',
	c.id_alterno			as Alterno,
	b.id_serie			as Serie,
	c.direccion			as Direccion,
	c.latitud_grad			as Latitud_Grad,
	c.latitud_min			as Latitud_Min,
	c.latitud_seg			as Latitud_Seg,
	c.longitud_grad			as Longitud_Grad,
	c.longitud_min			as Longitud_Min,
	c.longitud_seg			as Longitud_Seg,
	c.foto				as Foto_Negocio,
	c.archivo,
	b.foto				as Foto_Equipo,
	b.id_ficha			as Ficha
from	tbl_detalle_orden_trabajo 	a 				inner join
	tbl_orden_trabajo 		b 	on 
	    a.id_orden_trabajo		=	b.id_orden_trabajo 	and
	    a.id_agencia			=	b.id_agencia			inner join
	tbl_negocios 			c 	on 
	    b.id_negocio			=	c.id_negocio 		inner join
	tbl_personal 			d 	on 
	    b.id_personal			=	d.id_personal 		inner join
	tbl_ubicaciones 			e 	on 	
	    b.id_ubicacion		=	e.id_ubicacion 		inner join
	tbl_ubicaciones_permiso 		o 	on 
	    b.id_ubicacion		=	o.id_ubicacion		left join
	tbl_tipos_trabajo			p	on
	    p.id_tipo_trabajo		=	b.id_tipo_trabajo
left join
	(
(select	z.id_ubicacion,
	z.descripcion,
	z.id_ubicacion_maestra as id_ubicacion_supervisor,
	y.descripcion as supervisor,
	y.id_ubicacion_maestra as id_ubicacion_distribuidora,
	v.descripcion as distribuidora,
	v.id_ubicacion_maestra as id_ubicacion_region,
	s.descripcion as region,
	s.id_ubicacion_maestra as id_ubicacion_pais,
	q.descripcion as pais
from	tbl_ubicaciones z inner join
	(
              select	x.id_ubicacion,
	   	x.id_ubicacion_maestra,
		x.descripcion
             from	tbl_ubicaciones x
	) y on 
             	z.id_ubicacion_maestra=y.id_ubicacion inner join
	(
              select	u.id_ubicacion,
	   	u.id_ubicacion_maestra,
		u.descripcion
             from	tbl_ubicaciones u
	) v on 
             	y.id_ubicacion_maestra=v.id_ubicacion inner join
	(
              select	t.id_ubicacion,
	   	t.id_ubicacion_maestra,
		t.descripcion
             from	tbl_ubicaciones t
	) s on 
             	v.id_ubicacion_maestra=s.id_ubicacion inner join
	(
              select	r.id_ubicacion,
	   	r.id_ubicacion_maestra,
		r.descripcion
             from	tbl_ubicaciones r
	) q on 
             	s.id_ubicacion_maestra=q.id_ubicacion)
	) f on f.id_ubicacion=b.id_ubicacion
Where   a.id_empresa=@empresa and o.id_usuario=@usuario

GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_servicios_gen]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_consulta_servicios_gen] @tipo int, @empresa int, @usuario 
char(20), @condicion varchar(8000), @condicion2 varchar(8000) AS

Declare @imagen varbinary(16),
	@UMD char(3),
	@Traslado char(20),
	@Texto_Query varchar(8000),
	@Texto_Query1 varchar(8000),
	@Texto_Query2 varchar(8000),
	@Texto_Query3 varchar(8000)

Set	@UMD = 'PZ'
Set	@Traslado='Traslado'

If @Condicion is null
  Set @Condicion=''

If @Condicion2 is null
  Set @Condicion2=''

If @tipo=0
begin
Select	0	as id_opcion_trabajo,
	''	as descripcion,
	''	as id_unidad_medida,
	0.00	as cantidad,
	0.00	as valor_unitario,
	0	as id_empresa,
	0	as id_orden_trabajo,
	getdate() as fecha,
	0	as id_negocio,
	''	as nomnegocio,
	''	as id_ubicacion,
	''	as nomubicacion,
	0	as id_personal,
	''	as nombre,
	''	as id_ubicacion_supervisor,
	''	as supervisor,
	''	as id_ubicacion_distribuidora,
	''	as distribuidora,
	''	as id_ubicacion_region,
	''	as region,
	''	as id_ubicacion_pais,
	''	as pais,
	0.00 	as Total,
	0	as "Agencia",
	''	as "Cod_Tecnico",
	''	as id_sector,
	''	as id_region,
	0	as "Cod_Tipo_Trabajo",
	''	as "Tipo-Trabajo",
	''	as Alterno,
	''	as Serie,
	''	as Direccion,
	0.00	as Latitud_Grad,
	0.00	as Latitud_Min,
	0.00	as Latitud_Seg,
	0.00	as Longitud_Grad,
	0.00	as Longitud_Min,
	0.00	as Longitud_Seg,
	''	as Ficha,
	0	as "Dia-Trabajo",
	''	as "Hora-Inicio",
	''	as "Hora-Final",
	0	as Estado,
	0	as "Cod-Calidad",
	''	as "Observaciones",
	''	as Calidad,
	''	as "Region-Orden",
	''	as Sector,
	0	as "Cod-Tipo-Negocio",
	''	as "Tipo-Negocio",
	''	as "Cod-Tipo-Movimiento",
	''	as "Tipo-Movimiento",
	0	as "Foto",
	0 	as "Cod-Clasificacion",
	space(100) as "Clasificacion",
	0	as "Cod-Modelo",
	space(35) as "Modelo",
	space(20)  as "Alterno-Ubicacion"
end

else

begin

set nocount on

Set @Texto_Query1=
'Select	a.id_opcion_trabajo, a.descripcion, a.id_unidad_medida,a.cantidad,	a.valor_unitario,	a.id_empresa,a.id_orden_trabajo,	b.fecha,b.id_negocio,c.nombre as nomnegocio,b.id_ubicacion,e.descripcion as nomubicacion,b.id_personal,d.nombre,f.id_ubicacion_supervisor, f.supervisor,f.id_ubicacion_distribuidora,f.distribuidora,f.id_ubicacion_region,f.region,f.id_ubicacion_pais,f.pais,
(a.cantidad*a.valor_unitario)  as Total,a.id_agencia  as "Agencia",d.id_alterno  as "Cod_Tecnico",b.id_sector,	b.id_region,isnull(p.id_tipo_opcion_trabajo,0)	as "Cod_Tipo_Trabajo",	isnull(p.descripcion,SPACE(1)) as "Tipo-Trabajo",	c.id_alterno as Alterno,
b.id_serie as Serie, c.direccion  as Direccion, c.latitud_grad  as Latitud_Grad, c.latitud_min  as Latitud_Min, c.latitud_seg  as Latitud_Seg,c.longitud_grad	as Longitud_Grad,c.longitud_min	as Longitud_Min, c.longitud_seg	as Longitud_Seg,b.id_ficha as Ficha,b.dia_trabajo as "Dia-Trabajo", 
b.hora_inicio	as "Hora-Inicio",	b.hora_final as "Hora-Final",b.estado as Estado, b.id_calidad	as "Cod-Calidad", b.observaciones as "Observaciones", q.descripcion	as Calidad, r.descripcion	as "Region-Orden", s.descripcion as Sector, c.id_tipo_negocio 
as "Cod-Tipo-Negocio", t.descripcion as "Tipo-Negocio",space(1) as "Cod-Tipo-Movimiento", space(1) as "Tipo-Movimiento", CASE WHEN (Select count(*) from tbl_galeria_fotos galeria where galeria.id_empresa=b.id_empresa and galeria.id_orden_trabajo=b.id_orden_trabajo)>0 THEN 1 ELSE 0 END	as "Foto"  ,
p.id_clasficacion as "Cod-Clasificacion", clas.descripcion as "Clasificacion", act.id_modelo as "Cod-Modelo", mod.descripcion as "Modelo",e.id_alterno as "Alterno-Ubicacion"
from	tbl_orden_trabajo 	b left join	tbl_detalle_orden_trabajo  a on a.id_orden_trabajo = b.id_orden_trabajo  and   a.id_agencia = b.id_agencia inner join
	tbl_negocios 	c 	on	    b.id_negocio	=	c.id_negocio and  b.id_empresa	= c.id_empresa	inner join
	tbl_personal 	d 	on	    b.id_personal	=	d.id_personal inner join
	tbl_ubicaciones 	e 	on	    b.id_ubicacion	=	e.id_ubicacion 		left join
	tbl_opciones_trabajo	op	on	   a.id_opcion_trabajo	=	op.id_opcion_trabajo	inner join
	tbl_tipos_opcion_trabajo	p	on    p.id_tipo_opcion_trabajo =	b.id_tipo_trabajo 	inner join
	tbl_calidad	q	on	   q.id_calidad	=	b.id_calidad		left join
	tbl_regiones	r	on	   r.id_region = b.id_region and   r.id_empresa = b.id_empresa left join
	tbl_sectores	s	on	   s.id_sector = b.id_sector and   s.id_empresa = b.id_empresa and  s.id_region = r.id_region	inner join
	tbl_activos	act on  act.id_serie=b.id_serie inner join	tbl_modelos	mod  on mod.id_modelo=act.id_modelo and mod.id_agencia=b.id_agencia inner join
	tbl_clasificacion_trabajos clas on p.id_clasficacion=clas.id_clasificacion inner join	tbl_tipos_negocios 	t 	on
	  c.id_tipo_negocio = t.id_tipo_negocio and  t.id_agencia	= b.id_agencia	inner join tbl_ubicaciones_permiso o on
	    b.id_ubicacion = o.id_ubicacion and   o.id_empresa= '+cast(@empresa as char(5))+'  and   o.id_usuario = '+ltrim(rtrim (@usuario))+'  left join
	((select	z.id_ubicacion,z.descripcion, z.id_ubicacion_maestra as id_ubicacion_supervisor,	y.descripcion as supervisor,y.id_ubicacion_maestra 
as id_ubicacion_distribuidora,v.descripcion as distribuidora,v.id_ubicacion_maestra as id_ubicacion_region,s.descripcion as region,s.id_ubicacion_maestra as id_ubicacion_pais,q.descripcion as pais
from	tbl_ubicaciones z inner join
	(select	x.id_ubicacion, 	x.id_ubicacion_maestra,	x.descripcion
             from	tbl_ubicaciones x ) y on z.id_ubicacion_maestra=y.id_ubicacion inner join (select	u.id_ubicacion,  	u.id_ubicacion_maestra,	u.descripcion
             from	tbl_ubicaciones u ) v on  	y.id_ubicacion_maestra=v.id_ubicacion inner join (select	t.id_ubicacion,   	t.id_ubicacion_maestra,	t.descripcion
             from	tbl_ubicaciones t ) s on  	v.id_ubicacion_maestra=s.id_ubicacion inner join (select	r.id_ubicacion,   	r.id_ubicacion_maestra,	r.descripcion
             from	tbl_ubicaciones r) q on   s.id_ubicacion_maestra=q.id_ubicacion)) f on f.id_ubicacion=b.id_ubicacion Where   b.id_empresa= '+cast(@empresa as char(5))+' '+ltrim(rtrim(@Condicion))+'
UNION ALL
Select	a.id_opcion_trabajo,''Traslado'' as descripcion,c.id_alterno	 as id_unidad_medida,1 as cantidad,	a.valor	as valor_unitario,a.id_empresa, a.id_orden_traslado as id_orden_trabajo,
	l.fecha,	a.id_negocio,	c.nombre 	as nomnegocio,	a.id_ubicacion,	e.descripcion 	as nomubicacion,a.id_personal,	d.nombre,	f.id_ubicacion_supervisor,	f.supervisor,	f.id_ubicacion_distribuidora,
	f.distribuidora,	f.id_ubicacion_region,	f.region,	f.id_ubicacion_pais,	f.pais,	a.valor 		as total,	a.id_agencia	as "Agencia",	d.id_alterno	as "Cod_Tecnico",	space(1)	as id_sector,
	space(1)	as id_region,	0		as "Cod_Tipo_Trabajo",	''TRASLADOS''	as "Tipo-Trabajo",	c.id_alterno	as Alterno,	a.id_serie	as Serie,	c.direccion	as Direccion,
	c.latitud_grad	as Latitud_Grad,	c.latitud_min	as Latitud_Min,	c.latitud_seg	as Latitud_Seg,	c.longitud_grad	as Longitud_Grad,	c.longitud_min	as Longitud_Min,	c.longitud_seg	as Longitud_Seg,
	a.id_ficha	as Ficha,	0 as "Dia-Trabajo", space(1) as "Hora-Inicio",	space(1) as "Hora-Final",	0 as Estado,	0 as "Cod-Calidad",	a.observaciones	 as "Observaciones", space(1) as Calidad, space(1) as "Region-Orden",	space(1) as Sector,	c.id_tipo_negocio as "Cod-Tipo-Negocio",
	t.descripcion 	as "Tipo-Negocio",	isnull(a.id_tipo_movimiento,0)	as "Cod-Tipo-Movimiento", isnull(k.descripcion,space(1))	as "Tipo-Movimiento",0	as "Foto"  ,p.id_clasficacion as "Cod-Clasificacion",clas.descripcion as "Clasificacion",
	act.id_modelo as "Cod-Modelo", mod.descripcion as "Modelo",e.id_alterno  as "Alterno-Ubicacion"
From	tbl_movimientos 	a	inner join	tbl_negocios 	c 	on
	    a.id_negocio	=	c.id_negocio 	and a.id_empresa = c.id_empresa inner join
	tbl_personal 	d on    a.id_personal	=d.id_personal and a.id_empresa	= d.id_empresa inner join
	tbl_ubicaciones 	e on   a.id_ubicacion =e.id_ubicacion 	inner join
	tbl_ubicaciones_permiso 	o on    a.id_ubicacion =	o.id_ubicacion and o.id_empresa= '+cast(@empresa as char(5))+'  and  o.id_usuario	= '+ltrim(rtrim (@usuario))+' left join
	tbl_tipos_opcion_trabajo	p on    p.id_tipo_opcion_trabajo	=	0		inner join
	tbl_tipos_negocios 	t on  c.id_tipo_negocio	= t.id_tipo_negocio and  t.id_agencia = a.id_agencia left join
	tbl_opciones_trabajo	u on  a.id_opcion_trabajo = u.id_opcion_trabajo	left join	tbl_tipos_movimiento	k on  a.id_tipo_movimiento = k.id_tipo_movimiento	inner join
	tbl_clasificacion_trabajos clas on p.id_clasficacion=clas.id_clasificacion inner join	tbl_activos act on  act.id_serie=a.id_serie inner join tbl_modelos mod  on mod.id_modelo=act.id_modelo and mod.id_agencia=a.id_agencia inner join
	tbl_traslados	l on  l.id_empresa = a.id_empresa    and  l.id_orden_traslado = a.id_orden_traslado
left join
	((select	z.id_ubicacion,	z.descripcion,z.id_ubicacion_maestra as id_ubicacion_supervisor,y.descripcion as supervisor,
	y.id_ubicacion_maestra as id_ubicacion_distribuidora,v.descripcion as distribuidora,	v.id_ubicacion_maestra as id_ubicacion_region,s.descripcion as region,
	s.id_ubicacion_maestra as id_ubicacion_pais,q.descripcion as pais
from	tbl_ubicaciones z inner join
	(select	x.id_ubicacion,  	x.id_ubicacion_maestra,	x.descripcion from tbl_ubicaciones x ) y on  	z.id_ubicacion_maestra=y.id_ubicacion inner join
	(select	u.id_ubicacion,  	u.id_ubicacion_maestra,	u.descripcion  from tbl_ubicaciones u ) v on 	y.id_ubicacion_maestra=v.id_ubicacion inner join
	(select	t.id_ubicacion,   	t.id_ubicacion_maestra,	t.descripcion from tbl_ubicaciones t ) s on   	v.id_ubicacion_maestra=s.id_ubicacion inner join
	(select	r.id_ubicacion,   	r.id_ubicacion_maestra,	r.descripcion from tbl_ubicaciones r ) q on   	s.id_ubicacion_maestra=q.id_ubicacion)) f on 
             f.id_ubicacion=a.id_ubicacion Where a.id_orden_traslado > 0 and a.id_empresa  = '+cast(@empresa as char(5))+'  '+ltrim(rtrim(@Condicion2))

Set @Texto_Query2=''

Set @Texto_Query=
	ltrim(rtrim(@Texto_Query1))+' '+
	ltrim(rtrim(@Texto_Query2))

set nocount off

--select @Texto_Query as Query

Exec(@texto_Query)
End
GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_total_de_servicios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_consulta_total_de_servicios]

@tipo int, 
@empresa int, 
@usuario char(20), 
@condicion varchar(8000), 
@condicion2 varchar(8000) 

AS

/*Declare
@tipo int, 
@empresa int, 
@usuario char(20), 
@condicion varchar(8000), 
@condicion2 varchar(8000) 

Set @tipo=1
Set @empresa=1
Set @usuario='''ogomez'''
Set @condicion=''
Set @condicion2=''*/

Declare @imagen varbinary(16),
	@UMD char(3),
	@Traslado char(20),
	@Texto_Query varchar(8000),
	@Texto_Query1 varchar(8000),
	@Texto_Query2 varchar(8000),
	@Texto_Query3 varchar(8000)

Set	@UMD = 'PZ'
Set	@Traslado='Traslado'

If @Condicion is null
  Set @Condicion=''

If @Condicion2 is null
  Set @Condicion2=''

If @tipo=0
begin
Select	0	as id_opcion_trabajo,
	''	as descripcion,
	''	as id_unidad_medida,
	0.00	as cantidad,
	0.00	as valor_unitario,
	0	as id_empresa,
	0	as id_orden_trabajo,
	getdate() as fecha,
	0	as id_negocio,
	''	as nomnegocio,
	''	as id_ubicacion,
	''	as nomubicacion,
	0	as id_personal,
	''	as nombre,
	''	as id_ubicacion_supervisor,
	''	as supervisor,
	''	as id_ubicacion_distribuidora,
	''	as distribuidora,
	''	as id_ubicacion_region,
	''	as region,
	''	as id_ubicacion_pais,
	''	as pais,
	0.00 	as Total,
	0	as "Agencia",
	''	as "Cod_Tecnico",
	''	as id_sector,
	''	as id_region,
	0	as "Cod_Tipo_Trabajo",
	''	as "Tipo-Trabajo",
	''	as Alterno,
	''	as Serie,
	''	as Direccion,
	0.00	as Latitud_Grad,
	0.00	as Latitud_Min,
	0.00	as Latitud_Seg,
	0.00	as Longitud_Grad,
	0.00	as Longitud_Min,
	0.00	as Longitud_Seg,
	''	as Ficha,
	''	as "Serie-Orden",
	0	as "Dia-Trabajo",
	''	as "Hora-Inicio",
	''	as "Hora-Final",
	0	as Estado,
	0	as "Cod-Calidad",
	''	as "Observaciones",
	''	as Calidad,
	''	as "Region-Orden",
	''	as Sector,
	0	as "Cod-Tipo-Negocio",
	''	as "Tipo-Negocio",
	''	as "Cod-Tipo-Movimiento",
	''	as "Tipo-Movimiento",
	0	as "Foto",
	0 	as "Cod-Problema",
	space(100) as "Problema",
	0 	as "Cod-Clasificacion",
	space(100) as "Clasificacion",
	0	as "Cod-Modelo",
	space(35) as "Modelo",
	space(20)  as "Alterno-Ubicacion"
end

else

begin

set nocount on

Set @Texto_Query1=
'Select	b.id_tipo_trabajo as id_opcion_trabajo, p.descripcion,space(1) as id_unidad_medida,1.00 as cantidad,	0.00 as valor_unitario,	b.id_empresa,b.id_orden_trabajo,	b.fecha,
b.id_negocio,c.nombre as nomnegocio,b.id_ubicacion,e.descripcion as nomubicacion,b.id_personal,d.nombre,f.id_ubicacion_supervisor,
f.supervisor,f.id_ubicacion_distribuidora,f.distribuidora,f.id_ubicacion_region,f.region,f.id_ubicacion_pais,f.pais,b.total  as Total,b.id_agencia  as "Agencia",d.id_alterno  as "Cod_Tecnico",b.id_sector,	b.id_region,isnull(p.id_tipo_opcion_trabajo,0) as 
"Cod_Tipo_Trabajo",	isnull(p.descripcion,SPACE(1)) as "Tipo-Trabajo",	c.id_alterno as Alterno,b.id_serie as Serie, c.direccion  as Direccion, c.latitud_grad  as Latitud_Grad, c.latitud_min  as Latitud_Min, c.latitud_seg  as Latitud_Seg,
c.longitud_grad	as Longitud_Grad,c.longitud_min	as Longitud_Min, c.longitud_seg	as Longitud_Seg,b.id_ficha as Ficha,b.serie_orden as "Serie-Orden",b.dia_trabajo as "Dia-Trabajo", b.hora_inicio	as "Hora-Inicio",	b.hora_final as "Hora-Final",
b.estado as Estado, b.id_calidad	as "Cod-Calidad", b.observaciones as "Observaciones", q.descripcion	as Calidad,r.descripcion	as "Region-Orden", s.descripcion as Sector, c.id_tipo_negocio as "Cod-Tipo-Negocio", t.descripcion as "Tipo-Negocio",
space(1) as "Cod-Tipo-Movimiento", space(1) as "Tipo-Movimiento", CASE WHEN (Select count(*) from tbl_galeria_fotos galeria where galeria.id_empresa=b.id_empresa and galeria.id_orden_trabajo=b.id_orden_trabajo)>0 THEN 1 ELSE 0 END	as "Foto"  ,
b.id_problema as "Cod-Problema",u.descripcion as Problema,p.id_clasficacion as "Cod-Clasificacion",clas.descripcion as "Clasificacion", act.id_modelo as "Cod-Modelo", mod.descripcion as "Modelo",e.id_alterno as "Alterno-Ubicacion"
from	tbl_orden_trabajo  b inner join tbl_negocios c on    b.id_negocio = c.id_negocio and b.id_empresa	= c.id_empresa	inner join tbl_personal d on b.id_personal	= d.id_personal 	inner join tbl_ubicaciones e on b.id_ubicacion = e.id_ubicacion inner join tbl_activos act on  act.id_serie=b.id_serie inner join tbl_modelos mod  on mod.id_modelo=act.id_modelo and mod.id_agencia=b.id_agencia inner join
	tbl_tipos_opcion_trabajo	p on    p.id_tipo_opcion_trabajo =	b.id_tipo_trabajo inner join tbl_calidad q on   q.id_calidad	= b.id_calidad	left join	tbl_regiones	r on   r.id_region = b.id_region and   r.id_empresa = b.id_empresa left join tbl_sectores	s on
	   s.id_sector = b.id_sector and   s.id_empresa = b.id_empresa and s.id_region = r.id_region	inner join tbl_clasificacion_trabajos clas on p.id_clasficacion=clas.id_clasificacion inner join	tbl_tipos_negocios t on  c.id_tipo_negocio = t.id_tipo_negocio and  t.id_agencia = b.id_agencia inner join tbl_ubicaciones_permiso o on  b.id_ubicacion = o.id_ubicacion and   o.id_empresa= '+cast(@empresa as char(5))+'  and   o.id_usuario = '+ltrim(rtrim (@usuario))+'  left join	tbl_problemas			u	on
	  b.id_problema = u.id_problema	left join	((select	z.id_ubicacion,z.descripcion, z.id_ubicacion_maestra as id_ubicacion_supervisor,	y.descripcion as supervisor,y.id_ubicacion_maestra as id_ubicacion_distribuidora,v.descripcion as distribuidora,v.id_ubicacion_maestra as id_ubicacion_region,s.descripcion as region,s.id_ubicacion_maestra as id_ubicacion_pais,q.descripcion as pais
from	tbl_ubicaciones z inner join	(select	x.id_ubicacion, 	x.id_ubicacion_maestra,	x.descripcion     from	tbl_ubicaciones x ) y on             	z.id_ubicacion_maestra=y.id_ubicacion inner join	(select	u.id_ubicacion,  	u.id_ubicacion_maestra,	u.descripcion
             from	tbl_ubicaciones u ) v on             	y.id_ubicacion_maestra=v.id_ubicacion inner join	(select	t.id_ubicacion,   	t.id_ubicacion_maestra,	t.descripcion         from	tbl_ubicaciones t ) s on             	v.id_ubicacion_maestra=s.id_ubicacion inner join	(select	r.id_ubicacion,   	r.id_ubicacion_maestra,	r.descripcion
             from	tbl_ubicaciones r	) q on   s.id_ubicacion_maestra=q.id_ubicacion)) f on f.id_ubicacion=b.id_ubicacion Where   b.id_empresa= '+cast(@empresa as char(5))+' '+ltrim(rtrim(@Condicion))+' 
UNION ALL
Select	a.id_opcion_trabajo,''Traslado'' as descripcion,c.id_alterno  as id_unidad_medida,1 as cantidad,a.valor	as valor_unitario,a.id_empresa,	a.id_orden_traslado as id_orden_trabajo,
	l.fecha,a.id_negocio,c.nombre 	as nomnegocio,a.id_ubicacion,e.descripcion as nomubicacion,a.id_personal,d.nombre,f.id_ubicacion_supervisor,f.supervisor,f.id_ubicacion_distribuidora,
	f.distribuidora,f.id_ubicacion_region,f.region,f.id_ubicacion_pais,f.pais,a.valor as total,a.id_agencia as "Agencia",d.id_alterno as "Cod_Tecnico",space(1) as id_sector,space(1)	as id_region,
	0 as "Cod_Tipo_Trabajo",''TRASLADOS'' as "Tipo-Trabajo",c.id_alterno	as Alterno,a.id_serie	as Serie,c.direccion as Direccion,c.latitud_grad	as Latitud_Grad,c.latitud_min as Latitud_Min,
	c.latitud_seg	as Latitud_Seg,	c.longitud_grad	as Longitud_Grad,c.longitud_min	as Longitud_Min,c.longitud_seg	as Longitud_Seg,a.id_ficha as Ficha,space(1) as "Serie-Orden",
	0 as "Dia-Trabajo",space(1)	as "Hora-Inicio",space(1) as "Hora-Final",0 as Estado, 0 as "Cod-Calidad",a.observaciones	 as "Observaciones",space(1) as Calidad,
	space(1) as "Region-Orden",space(1) as Sector,c.id_tipo_negocio as "Cod-Tipo-Negocio",t.descripcion 	as "Tipo-Negocio",isnull(a.id_tipo_movimiento,0) as "Cod-Tipo-Movimiento",
	isnull(k.descripcion,space(1))	as "Tipo-Movimiento",0	as "Foto"  ,0 	as "Cod-Problema",space(10) as Problema,p.id_clasficacion as "Cod-Clasificacion",clas.descripcion as "Clasificacion",
	act.id_modelo as "Cod-Modelo", mod.descripcion as "Modelo",e.id_alterno  as "Alterno-Ubicacion"
From	tbl_movimientos 	a	inner join	tbl_negocios c on   a.id_negocio = c.id_negocio and a.id_empresa=c.id_empresa inner join
	tbl_personal d on a.id_personal = d.id_personal  and a.id_empresa = d.id_empresa inner join
	tbl_activos act on  act.id_serie=a.id_serie inner join tbl_modelos mod  on mod.id_modelo=act.id_modelo and mod.id_agencia=a.id_agencia inner join
	tbl_ubicaciones	e on	    a.id_ubicacion = e.id_ubicacion inner join
	tbl_ubicaciones_permiso o on        a.id_ubicacion = o.id_ubicacion	and o.id_empresa= '+cast(@empresa as char(5))+'  and o.id_usuario = '+ltrim(rtrim (@usuario))+' left join
	tbl_tipos_opcion_trabajo	p	on	    p.id_tipo_opcion_trabajo = 0 inner join	tbl_tipos_negocios t on	  c.id_tipo_negocio	=	t.id_tipo_negocio	and	  t.id_agencia	= a.id_agencia	left join	tbl_opciones_trabajo	u	on	  a.id_opcion_trabajo	= u.id_opcion_trabajo	left join
	tbl_tipos_movimiento k	on	  a.id_tipo_movimiento	= k.id_tipo_movimiento	inner join	tbl_clasificacion_trabajos clas on p.id_clasficacion=clas.id_clasificacion inner join
	tbl_traslados l on   l.id_empresa = a.id_empresa and  l.id_orden_traslado = a.id_orden_traslado left join ((select z.id_ubicacion,z.descripcion,z.id_ubicacion_maestra as id_ubicacion_supervisor,
	y.descripcion as supervisor,y.id_ubicacion_maestra as id_ubicacion_distribuidora,v.descripcion as distribuidora,v.id_ubicacion_maestra as id_ubicacion_region,s.descripcion as region,s.id_ubicacion_maestra as id_ubicacion_pais,	q.descripcion as pais
from	tbl_ubicaciones z inner join (select x.id_ubicacion,	x.id_ubicacion_maestra,	x.descripcion   from	tbl_ubicaciones x ) y on z.id_ubicacion_maestra=y.id_ubicacion inner join
	(select	u.id_ubicacion,  u.id_ubicacion_maestra,u.descripcion from	 tbl_ubicaciones u ) v on y.id_ubicacion_maestra=v.id_ubicacion inner join
	(select	t.id_ubicacion,	t.id_ubicacion_maestra,	t.descripcion from tbl_ubicaciones t ) s on v.id_ubicacion_maestra=s.id_ubicacion inner join
	(select	r.id_ubicacion,  r.id_ubicacion_maestra,	r.descripcion from tbl_ubicaciones r ) q on s.id_ubicacion_maestra=q.id_ubicacion)) f on f.id_ubicacion=a.id_ubicacion 
 Where a.id_orden_traslado > 0 and a.id_empresa  =	'+cast(@empresa as char(5))+'  '+ltrim(rtrim(@Condicion2))

Set @Texto_Query2=''

Set @Texto_Query=
	ltrim(rtrim(@Texto_Query1))+' '+
	ltrim(rtrim(@Texto_Query2))

set nocount off

--select @Texto_Query as Query

Exec(@texto_Query)
End
GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_ubicacion_equipos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_consulta_ubicacion_equipos] @empresa int AS

Select	c.no_documento	as	'Docto',
	d.descripcion		as	'Tipo_Docto',
	a.id_serie		as 	'Serie',
	isnull(a.id_ficha,'')	as 	'Ficha',
	isnull(a.id_sio,'')		as 	'Sio',
	a.id_fabricante		as 	'Cod_Fabricante',
	a.id_tipo		as 	'Cod_Tipo',
	u.descripcion		as  	'Tipo_Equipo',
	a.id_modelo		as 	'Cod_Modelo',
	w.descripcion		as  	'Modelo',
	a.id_marca		as 	'Cod_Marca',
	t.descripcion		as  	'Marca',
	a.id_logotipo		as 	'Cod_Logotipo',
	v.descripcion		as  	'Logotipo',
	a.no_contrato		as 	'No_Contrato',
	a.id_negocio		as 	'Cod_Negocio_Actual',
	s.nombre		as  	'Nombre_Negocio_Actual',
	a.id_agencia		as 	'Agencia',
	a.id_negocio,
	s.latitud_grad	as Latitud_Grad,
	s.latitud_min	as Latitud_Min,
	s.latitud_seg	as Latitud_Seg,
	s.longitud_grad	as Longitud_Grad,
	s.longitud_min	as Longitud_Min,
	s.longitud_seg	as Longitud_Seg
From	tbl_activos 				a	inner join
	tbl_detalle_ingresos			b	on
	  a.id_serie	=	b.id_serie		inner join
	tbl_ingresos				c	on
	  b.id_ingreso	=	c.id_ingreso	and
	  b.id_empresa	=	c.id_empresa		inner join
	tbl_documentos				d	on
	  d.id_documento=	c.id_documento		inner join
	tbl_modelos				w	on
	  w.id_modelo	=	a.id_modelo		inner join
	tbl_logotipos				v	on
	  v.id_logotipo	=	a.id_logotipo		inner join
	tbl_tipos				u	on
	  u.id_tipo	=	a.id_tipo		inner join
	tbl_marcas				t	on
	  t.id_marca	=	a.id_marca		inner join
	tbl_negocios				s	on
	  s.id_negocio	=	a.id_negocio	and
	  s.id_empresa	=	@empresa

GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_ubicacion_equipos_gen]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_consulta_ubicacion_equipos_gen] @tipo int, @empresa int, @condicion varchar(8000) AS

Declare @Texto_Query varchar(8000),
	@Texto_Query1 varchar(8000),
	@Texto_Query2 varchar(8000),
	@Texto_Query3 varchar(8000)

If @Condicion is null
  Set @Condicion=''

If @tipo=0 
begin
Select	''	as	'Docto',
	''	as	'Tipo_Docto',
	''	as 	'Serie',
	''	as 	'Ficha',
	''	as 	'Sio',
	0	as 	'Cod_Fabricante',
	0	as 	'Cod_Tipo',
	''	as  	'Tipo_Equipo',
	0	as 	'Cod_Modelo',
	''	as  	'Modelo',
	0	as 	'Cod_Marca',
	''	as  	'Marca',
	0	as 	'Cod_Logotipo',
	''	as  	'Logotipo',
	'' 	as 	'No_Contrato',
	0	as 	'Cod_Negocio_Actual',
	''	as  	'Nombre_Negocio_Actual',
	0	as 	'Agencia',
	0	as id_negocio,
	0.00	as Latitud_Grad,
	0.00	as Latitud_Min,
	0.00	as Latitud_Seg,
	0.00	as Longitud_Grad,
	0.00	as Longitud_Min,
	0.00	as Longitud_Seg,
	0	as Ingreso
end

else

begin

set nocount on

Set @Texto_Query1=
'Select	c.no_documento	as	"Docto",
	d.descripcion		as	"Tipo_Docto",
	a.id_serie		as 	"Serie",
	isnull(a.id_ficha,space(1)) as 	"Ficha",
	isnull(s.id_alterno,space(1))	as 	"Sio",
	a.id_fabricante		as 	"Cod_Fabricante",
	a.id_tipo		as 	"Cod_Tipo",
	u.descripcion		as  	"Tipo_Equipo",
	a.id_modelo		as 	"Cod_Modelo",
	w.descripcion		as  	"Modelo",
	a.id_marca		as 	"Cod_Marca",
	t.descripcion		as  	"Marca",
	a.id_logotipo		as 	"Cod_Logotipo",
	v.descripcion		as  	"Logotipo",
	a.no_contrato		as 	"No_Contrato",
	a.id_negocio		as 	"Cod_Negocio_Actual",
	s.nombre		as  	"Nombre_Negocio_Actual",
	a.id_agencia		as 	"Agencia",
	a.id_negocio,
	s.latitud_grad		as Latitud_Grad,
	s.latitud_min		as Latitud_Min,
	s.latitud_seg		as Latitud_Seg,
	s.longitud_grad		as Longitud_Grad,
	s.longitud_min		as Longitud_Min,
	s.longitud_seg		as Longitud_Seg,
	c.id_ingreso		as Ingreso
From	tbl_activos 				a	inner join
	tbl_movimientos				b	on
	  a.id_serie	=	b.id_serie	and
	  b.id_ingreso>0					inner join
	tbl_ingresos				c	on
	  b.id_ingreso	=	c.id_ingreso	and
	  b.id_empresa	=	c.id_empresa		inner join
	tbl_documentos				d	on
	  d.id_documento=	c.id_documento		inner join
	tbl_modelos				w	on
	  w.id_modelo	=	a.id_modelo		 and
	    a.id_agencia	=	w.id_agencia	inner join
	tbl_logotipos				v	on
	  v.id_logotipo	=	a.id_logotipo		 and
	    a.id_agencia	=	v.id_agencia	inner join
	tbl_tipos				u	on
	  u.id_tipo	=	a.id_tipo		 and
	    a.id_agencia	=	u.id_agencia	inner join
	tbl_marcas				t	on
	  t.id_marca	=	a.id_marca		 and
	    a.id_agencia	=	t.id_agencia	inner join
	tbl_negocios				s	on
	  s.id_negocio	=	a.id_negocio	and
	  s.id_empresa	=	 '+cast(@empresa as char(5))

Set @Texto_Query2=''


Set @Texto_Query=
	ltrim(rtrim(@Texto_Query1))+' '+
	ltrim(rtrim(@Condicion))+' '+
	ltrim(rtrim(@Texto_Query2))

set nocount off

--select @Texto_Query as Query

Exec(@texto_Query)
end
GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_visitas_negocio]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_consulta_visitas_negocio] @empresa int, @negocio int AS

Declare @tecnico 	int,
	@sector 	char(10)

SET NOCOUNT ON

--AVERIGUANDO EL SECTOR DEL NEGOCIO
Select	@sector	=	isnull(id_sector,0)
From	tbl_negocios
Where	id_empresa	=	@empresa	and
	id_negocio	=	@negocio

--AVERIGUANDO EL TECNICO DEL SECTOR
Select	@tecnico	=	isnull(id_tecnico,0)
From	tbl_sectores_por_tecnico
Where	id_empresa	=	@empresa	and
	id_sector	=	@sector

SET NOCOUNT OFF

Select	a.id_negocio	as Codigo,
	a.nombre	as Nombre,
	a.direccion	as Direccion,
	Case When a.Visitado=0
	 	Then 	'NO'
		Else	'SI'
	End		as Visitado,
	a.id_orden_trabajo	as 'Orden-Trabajo',
	a.hora		as Hora,
	a.dia		as Dia
From	tbl_negocios			a	inner join
	tbl_sectores_por_tecnico		b	on
	  a.id_empresa	=b.id_empresa	and
	  a.id_sector	=b.id_sector		
Where	a.id_empresa	=	@empresa	and
	b.id_tecnico	=	@tecnico
Order by 	a.dia,
		a.hora


GO
/****** Object:  StoredProcedure [dbo].[pa_consulta_visitas_tecnico]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_consulta_visitas_tecnico]  @empresa int, @tecnico int AS

Select	z.id_serie		as 'Serie',
	z.id_modelo		as 'Cod-Modelo',
	y.descripcion		as 'Modelo',
	a.id_negocio		as 'Codigo',
	a.id_alterno		as 'Cod-Alterno',
	a.nombre		as 'Nombre',
	a.direccion		as 'Direccion',
	a.contacto		as 'Contacto',
	(Case When 
 	  z.Visitado=0
	  Then 	'NO'
	  Else	'SI'
	End)			as 'Visitado',
	z.id_orden_trabajo	as 'Orden-Trabajo',
	z.dia			as 'Dia',
	z.hora			as 'Hora',
	a.id_sector		as 'Cod-Sector',
	b.descripcion		as 'Sector',
	b.id_tecnico		as 'Cod-Tecnico',
	c.id_alterno		as 'Alterno-Tecnico',
	c.nombre		as 'Tecnico',
	b.id_region		as 'Cod-Region',
	e.descripcion		as 'Region',
	a.id_ubicacion		as 'Cod-Ubicacion',
	d.descripcion		as 'Ruta',
	d.id_alterno		as 'Cod-Ruta',
	z.vuelta			as 'Vuelta',
	f.descripcion		as 'Problema'
From	tbl_activos			z	inner join
	tbl_modelos			y	on
	  z.id_modelo	=y.id_modelo	and
	  z.id_agencia	=y.id_agencia		inner join
	tbl_negocios			a	on
	  z.id_negocio	=a.id_negocio	and
	  a.id_empresa	=@empresa		inner join
	tbl_sectores			b	on
	  a.id_empresa	=b.id_empresa	and
	  a.id_sector	=b.id_sector		inner join
	tbl_personal			c	on
	  b.id_empresa	=c.id_empresa	and
	  b.id_tecnico	=c.id_personal		left join
	tbl_ubicaciones			d	on
	  a.id_ubicacion=d.id_ubicacion		inner join
	tbl_regiones			e	on
	  b.id_empresa	=e.id_empresa	and
	  b.id_region	=e.id_region		left join
	tbl_problemas			f	on
	  z.id_problema	=	f.id_problema
Where	a.id_empresa	=	@empresa	and
	b.id_tecnico	=	@tecnico
Order by 	a.dia,
		a.hora
GO
/****** Object:  StoredProcedure [dbo].[pa_corregir_envio_negativo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_corregir_envio_negativo]

	@serie 	char(20),
	@envio	char(20),
	@usuario char(20)

AS

Declare	@existe 		int,
	@ingreso 		int,
	@completo		int,
	@ingreso_actual 	int

--AVERIGUANDO EL # DE INGRESO ACTUAL
Select	@ingreso_actual=id_ingreso
From	tbl_ingresos
Where	no_documento	=@envio

If @ingreso_actual is null 
Begin
Set @ingreso_actual=0
end

--VERIFICANDO SI EXISTE EL # DE SERIE Y SI ESTA CON -1 EN EL NO_DOCUMENTO
SELECT	distinct 
	@existe		=	isnull(id_empresa,0),
	@ingreso	=	isnull(id_ingreso,0)
FROM	tbl_detalle_ingresos
Where	id_serie=@serie	and
	no_documento=-1

If @existe is null
begin
Set @existe=0
end

--SI EXISTE EL EQUIPO ENTONCES SE PROCEDE A CAMBIARLE EL NUMERO DE ENVIO
If @existe>0
  begin
  --ACTUALIZANDO EL # DEL ENVIO
  UPDATE	tbl_detalle_ingresos
  SET		no_documento=@envio,
		id_ingreso=@ingreso_actual
  Where		id_serie=@serie	and
		no_documento=-1

  UPDATE	tbl_movimientos
  SET		id_ingreso=@ingreso_actual
  Where		id_serie=@serie	and
		id_ingreso>0

  --CHEQUEANDO SI YA FUERON CORREGIDOS TODOS LOS EQUIPOS QUE INGRESARON CON ESE ENVIO
  SELECT  	@completo=count(*)
  FROM		tbl_detalle_ingresos
  WHERE		id_ingreso=@ingreso	and
		no_documento=-1

  --SI YA ESTAN CORREGIDOS TODOS LOS EQUIPOS DEL ENVIO SE PROCEDE A CAMBIARLE EL # A LA CABECERA
/*  If @completo=0
    begin
    UPDATE 	tbl_ingresos
    SET		no_documento=@envio
    WHERE	id_ingreso=@ingreso
  end*/

  insert into tbl_bitacora_correccion
	Select	@serie 		as id_serie,
		@envio 	as no_documento,
		@usuario	as id_usuario,
		getdate()	as fecha

end

--SE DEVUELVE SI EXISTE EL EQUIPO INDICADO
SELECT	@existe as Existe
GO
/****** Object:  StoredProcedure [dbo].[pa_datos_empleado]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_datos_empleado] @usuario char(20) as
select	a.id_usuario,
	a.descripcion as 'nombre',
	a.id_usuario as id_personal,
	isnull(a.cuenta_correo,'') as cuenta_correo,
	id_gerencia as id_area,
	1 as id_departamento,
	a.con_outlook,
	a.colorfondo,
	a.colorobjetos,
	a.colorfont,
	a.estiloweb,
	a.aplicar

from	tbl_usuarios a 
where	a.id_usuario=@usuario
GO
/****** Object:  StoredProcedure [dbo].[pa_datos_opciones_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_datos_opciones_trabajo] @empresa int, @agencia int AS
select	*
from	tbl_opciones_trabajo
where	id_empresa	=	@empresa and
	id_agencia	=	@agencia


GO
/****** Object:  StoredProcedure [dbo].[pa_datos_personal]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_datos_personal] @empresa int, @agencia int AS
select	*
from	tbl_personal a 
where	a.id_empresa	=	@empresa and
	a.id_agencia	=	@agencia






GO
/****** Object:  StoredProcedure [dbo].[pa_datos_postmix]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_datos_postmix] @empresa int,@orden int AS

Select	*
from	tbl_datos_postmix
where	id_empresa=@empresa	and
	id_orden=@orden
GO
/****** Object:  StoredProcedure [dbo].[pa_datos_transportistas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_datos_transportistas] AS
select	*
from	tbl_transportistas


GO
/****** Object:  StoredProcedure [dbo].[pa_datos_ubicaciones]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_datos_ubicaciones] AS
select	a.*
from	tbl_ubicaciones a 
order by a.id_ubicacion_maestra,a.id_ubicacion


GO
/****** Object:  StoredProcedure [dbo].[pa_departamentos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[pa_departamentos] @pais char(5) = 503 AS  

Select	*
From	tbl_departamentos
Where	id_pais=@pais


GO
/****** Object:  StoredProcedure [dbo].[pa_detalle_areas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_detalle_areas] @empresa int, @area int AS
select	*
from	tbl_detalle_areas
where	id_empresa=@empresa and
	id_area=@area


GO
/****** Object:  StoredProcedure [dbo].[pa_detalle_ingreso_items]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_detalle_ingreso_items] @empresa int, @agencia int , @ingreso int AS

Select	*
From	tbl_detalle_ingreso_items
Where	id_empresa=@empresa	and
	id_agencia=@agencia	and
	id_ingreso_item=@ingreso

GO
/****** Object:  StoredProcedure [dbo].[pa_detalle_ingresos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_detalle_ingresos] @empresa int, @ingreso int, @agencia int AS
select	*
from	tbl_detalle_ingresos
where	id_empresa	=	@empresa 	and
	id_agencia	=	@agencia 	and
	id_ingreso	=	@ingreso
order by id_serie



GO
/****** Object:  StoredProcedure [dbo].[pa_detalle_movimientos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_detalle_movimientos] @empresa int, @traslado int, @agencia int AS
select	*
from	tbl_movimientos
where	id_empresa		=	@empresa 		and
	id_orden_traslado	=	@traslado 		and
	id_agencia		=	@agencia




GO
/****** Object:  StoredProcedure [dbo].[pa_detalle_orden_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_detalle_orden_trabajo] @empresa int, @orden int,@agencia int AS
select	*
from	tbl_detalle_orden_trabajo
where	id_empresa	=	@empresa 	and
	id_orden_trabajo=	@orden		and
	id_agencia	=	@agencia



GO
/****** Object:  StoredProcedure [dbo].[pa_detalle_presupuesto]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_detalle_presupuesto] AS

select *
from tbl_detalle_presupuesto
where id_opcion_trabajo ='1x1yx'
GO
/****** Object:  StoredProcedure [dbo].[pa_detalle_presupuesto_enc]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_detalle_presupuesto_enc] AS


select *
from tbl_presupuesto
where id_serie_pre= '1xh5jh'
GO
/****** Object:  StoredProcedure [dbo].[pa_editar_traslado]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[pa_editar_traslado] @serie char(30), @nueva_serie char(30) AS

Update	tbl_movimientos
Set	id_serie=@nueva_serie
Where	id_serie=@serie

Update	tbl_orden_trabajo
Set	id_serie=@nueva_serie
Where	id_serie=@serie

Update	tbl_activos
Set	id_serie=@nueva_serie
Where	id_serie=@serie


Update	tbl_detalle_ingresos
Set	id_serie=@nueva_serie
Where	id_serie=@serie





GO
/****** Object:  StoredProcedure [dbo].[pa_ehl]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_ehl] @id_serie varchar (50)AS


select a.id_serie,
	a.id_ficha,
	b.id_orden_trabajo,
	a.fabricado,
	h.fecha as 'fechaa',
	c.id_modelo,
	g..fabricado,
	c.descripcion,
	b.fecha,
	d.nombre,
	d.direccion,
	b.id_sio,
	g.no_contrato,
	f.descripcion
from tbl_activos a inner join
	tbl_orden_trabajo b on
	a.id_serie = b.id_serie inner join
	tbl_modelos c on
	a.id_modelo = c.id_modelo inner join
	tbl_negocios d on
	b.id_negocio = d.id_negocio inner join
	tbl_detalle_ingresos e on
	a.id_serie = e.id_serie inner join
	tbl_tipos_opcion_trabajo f on
	b.id_tipo_trabajo = f.id_tipo_opcion_trabajo inner join
	tbl_detalle_ingresos g on
	a.id_serie = g.id_serie inner join
	tbl_ingresos h on
	g.id_ingreso = h.id_ingreso
where a.id_serie = '000120395'
order by b.fecha asc
GO
/****** Object:  StoredProcedure [dbo].[pa_empresas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_empresas] AS

BEGIN

	SELECT * FROM tbl_empresas

END


GO
/****** Object:  StoredProcedure [dbo].[pa_enviar_datos_visor]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_enviar_datos_visor] @tecnico int, @dia_trabajo int, @alterno char(30) AS
declare @registros int
set nocount on
/*CONTANDO CUANTAS VISITAS SE INSERTARAN*/
Select	@registros=count(*)
from	tbl_detalle_areas 	a 	inner join
	tbl_areas 		b 	on 		
	   a.id_area=b.id_area 		and 
	   a.id_empresa=b.id_empresa 	inner join
	tbl_negocios 		c 	on 
	   a.id_negocio=c.id_negocio
where	a.visitado=0 			and
	a.traslado_visor=0 		and
	a.dia_trabajo=@dia_trabajo 	and
	b.id_personal=@tecnico

If @registros>0
begin
/*INSERTANDO LAS NUEVAS VISITAS DEL TECNICO*/
Insert into tbl_visitas
select	a.id_negocio 			as codigo,
	cast(a.nombre 	as char(50)) 	as nombre,
	cast(c.direccion 	as char(50)) 	as direccion,
	isnull(c.contacto,'') 		as contacto,
	0 		as visitado,
	year(getdate())	as anio,
	month(getdate())	as mes,
	day(getdate())	as dia,
	'1' 		as hora,
	'1' 		as minuto,
	' ' 		as comentarios,
	@alterno 	as usuario,
	0 		as negocios_actualizados,
	0 		as ordenes_actualizadas,
	0 		as visitas_actualizadas,
	a.id_negocio,
	@tecnico	as id_tecnico
from	tbl_detalle_areas 	a 	inner join
	tbl_areas 		b 	on 
	    a.id_area=b.id_area 	and 
	    a.id_empresa=b.id_empresa 	inner join
	tbl_negocios 		c 	on 
	    a.id_negocio=c.id_negocio
where	a.visitado=0 			and
	a.traslado_visor=0 		and
	a.dia_trabajo=@dia_trabajo 	and
	b.id_personal=@tecnico
order by a.orden
--order by b.id_personal,a.dia_trabajo

--INSERTANDO LOS TIEMPOS
Insert into tbl_tiempos
select	
	a.codigo 	as codigo_visita,
	id_serie 		as numero_serie,
	0		as tipo,
	b.id_etapa	as etapa,
	null 		as anio,
	null 		as mes,
	null 		as dia,
	null 		as hora,
	null 		as minuto,
	null		as segundo

from	tbl_visitas 		a	inner join
	tbl_negocios 		b 	on 
	    a.id_negocio=b.id_negocio	left join
	tbl_activos		c	on
	    b.id_negocio=c.id_negocio
where	a.visitado	=0 			and
	a.usuario	=@alterno

--INSERTANDO NUMEROS SERIE

Insert into tbl_numeros_serie
Select	
	a.codigo 	as codigo_visita,
	c.id_serie 	as numero_serie,
	c.id_serie 	as numero_referencia,
	0		as grabado,
	0		as actualizado,
	0		as actualizada_orden
From	tbl_visitas 		a	inner join
	tbl_negocios 		b 	on 
	    a.id_negocio=b.id_negocio	left join
	tbl_activos		c	on
	    b.id_negocio=c.id_negocio
Where	a.visitado	=0 			and
	a.usuario	=@alterno


/*ACTUALIZANDO LAS VISITAS YA TRASLADADAS*/
update 	tbl_detalle_areas
set	traslado_visor=1
from	tbl_areas 	b
where	b.id_area=tbl_detalle_areas.id_area 		and
	b.id_empresa=tbl_detalle_areas.id_empresa 	and
	visitado=0 					and
	traslado_visor=0 				and
	dia_trabajo=@dia_trabajo 			and
	b.id_personal=@tecnico
set nocount off

end

select	@registros as Registros
GO
/****** Object:  StoredProcedure [dbo].[pa_equipo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_equipo] AS
select	*
from	tbl_equipo


GO
/****** Object:  StoredProcedure [dbo].[pa_equipo_tecnico]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_equipo_tecnico] @empresa int, @tecnico int AS
select	*
from	tbl_equipo_tecnico
where	id_empresa=@empresa and
	id_personal=@tecnico


GO
/****** Object:  StoredProcedure [dbo].[pa_equipos_ingresados]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_equipos_ingresados] @empresa int AS
select	*
from	tbl_detalle_ingresos
where	id_empresa=@empresa
order by id_serie



GO
/****** Object:  StoredProcedure [dbo].[pa_etapas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_etapas] AS
select	*
from	tbl_etapas


GO
/****** Object:  StoredProcedure [dbo].[pa_fabricantes]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_fabricantes] AS
select	*
from	tbl_fabricantes


GO
/****** Object:  StoredProcedure [dbo].[pa_filtros]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_filtros] @consulta int, @usuario char(30) AS
Select	*
From	tbl_filtros
Where	id_consulta=@consulta 	and
	id_usuario=@usuario


GO
/****** Object:  StoredProcedure [dbo].[pa_foto_negocio]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_foto_negocio] @empresa int, @agencia int, @negocio int AS

select	archivo,
	foto
from	tbl_negocios
where	id_negocio=@negocio	and
	id_empresa=@empresa	and
	id_agencia=@agencia
GO
/****** Object:  StoredProcedure [dbo].[pa_galeria_fotos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_galeria_fotos] @empresa int, @orden int AS

Select	*
From	tbl_galeria_fotos
Where	id_empresa	=	@empresa	and
	id_orden_trabajo=	@orden

GO
/****** Object:  StoredProcedure [dbo].[pa_grabar_filtro]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_grabar_filtro] 

@consulta int, 
@usuario char(30), 
@grupo char(1),
@campo char(30) ,
@operador1 char(10),
@conector1 char(10),
@criterio1 char(10),
@operador2 char(10),
@conector2 char(10),
@criterio2 char(10),
@operador3 char(10),
@conector3 char(10),
@criterio3 char(10),
@operador4 char(10),
@conector4 char(10),
@criterio4 char(10),
@operador5 char(10),
@criterio5 char(10)

AS

Insert into	tbl_filtros
	(
	id_consulta,
	id_usuario,
	grupo,
	campo,
	operador1,
	conector1,
	criterio1,
	operador2,
	conector2,
	criterio2,
	operador3,
	conector3,
	criterio3,
	operador4,
	conector4,
	criterio4,
	operador5,
	criterio5
	)
Values	
	(
	@consulta,
	@usuario,
	@grupo,
	@campo,
	@operador1,
	@conector1,
	@criterio1,
	@operador2,
	@conector2,
	@criterio2,
	@operador3,
	@conector3,
	@criterio3,
	@operador4,
	@conector4,
	@criterio4,
	@operador5,
	@criterio5
	)





GO
/****** Object:  StoredProcedure [dbo].[pa_grupos_por_usuario]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_grupos_por_usuario] @usuario char(20),@modulo char(20), @empresa int AS
select 	a.id_grupo,
	a.estado,
	a.id_proyecto
from 	tbl_menu_de_usuario a inner join
	tbl_menu_de_opciones b on b.id_grupo=a.id_grupo and b.id_proyecto=a.id_proyecto
where 	a.id_proyecto=@modulo and 
      	a.estado<>0  and  
       	a.id_usuario=@usuario and
	a.id_empresa=@empresa
group by a.id_grupo,
	a.estado,
	a.id_proyecto,
	b.numero
order by b.numero



GO
/****** Object:  StoredProcedure [dbo].[pa_ingreso_items]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_ingreso_items] @empresa int, @agencia int AS

Select	*
From	tbl_ingreso_items
Where	id_empresa=@empresa	and
	id_agencia=@agencia

GO
/****** Object:  StoredProcedure [dbo].[pa_ingresos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_ingresos] @empresa int AS
select	*
from	tbl_ingresos
where	id_empresa=@empresa
order by id_ingreso



GO
/****** Object:  StoredProcedure [dbo].[pa_insertar_activo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_insertar_activo] AS
select	*
from	tbl_activos
where	id_serie='-11111'




GO
/****** Object:  StoredProcedure [dbo].[pa_insertar_detalle_areas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_insertar_detalle_areas] AS
select	*
from	tbl_detalle_areas
where	id_empresa=-1


GO
/****** Object:  StoredProcedure [dbo].[pa_insertar_detalle_ingreso]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_insertar_detalle_ingreso] AS
select	*
from	tbl_detalle_ingresos
where	id_empresa=-1



GO
/****** Object:  StoredProcedure [dbo].[pa_insertar_ingreso]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_insertar_ingreso] AS
select	*
from	tbl_ingresos
where	id_empresa=-1


GO
/****** Object:  StoredProcedure [dbo].[pa_insertar_movimiento]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_insertar_movimiento]
	@empresa int,
	@movimiento int,
	@serie char(20),
	@serie_especial char(10),
	@ficha char(20),
	@fecha char(10),
	@ubicacion char(20),
	@personal int,
	@observaciones varchar(100),
	@fecha_salida char(10),
	@usuario char(20),
	@ingreso int,
	@negocio int,
	@no_contrato char(30),
	@agencia int
 AS

set dateformat dmy
INSERT INTO tbl_movimientos
	(id_empresa,
	id_movimiento,
	id_serie,
	serie_especial,
	id_ficha,
	fecha,
	id_ubicacion,
	id_personal,
	observaciones,
	fecha_salida,
	id_usuario,
	id_ingreso,
	id_orden_traslado,
	id_negocio,
	no_contrato,
	id_agencia) 
       VALUES 	       
	(@empresa,
	@movimiento,
	@serie,
	@serie_especial,
	@ficha,
	@fecha,
	@ubicacion,
	@personal,
	@observaciones,
	@fecha_salida,
	@usuario,
	@ingreso,
	0,
	@negocio,
	@no_contrato,
	@agencia)









GO
/****** Object:  StoredProcedure [dbo].[pa_insertar_negocio]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_insertar_negocio]
	@empresa int,
	@alterno char(20),
	@nombre char(80),
	@nit char(20),
	@direccion char(80),
	@email char(50),
	@fecha  char(10),
	@contacto char(30),
	@suspendido int,
	@tipo_negocio int,
	@ubicacion  char(20),
	@clasificacion int
 AS
INSERT INTO tbl_negocios
	(id_empresa,
	id_alterno,
	nombre,
	nit,
	direccion,
	e_mail,
	fecha_creacion,
	contacto,
	suspendido,
	id_tipo_negocio,
	id_ubicacion,
	id_clasificacion_negocio)
       VALUES 	       
	(@empresa,
	@alterno,
	@nombre,
	@nit,
	@direccion,
	@email,
	@fecha,
	@contacto,
	@suspendido,
	@tipo_negocio,
	@ubicacion,
	@clasificacion)


GO
/****** Object:  StoredProcedure [dbo].[pa_insertar_permiso_ubicacion]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_insertar_permiso_ubicacion]
	@empresa int,
	@usuario char(20),
	@ubicacion char(20),
	@maestra char(20) AS
INSERT INTO tbl_ubicaciones_permiso
	(id_empresa,
	id_usuario,
	id_ubicacion,
	id_ubicacion_maestra)
       VALUES 	       
	(@empresa,
	@usuario,
	@ubicacion,
	@maestra)





GO
/****** Object:  StoredProcedure [dbo].[pa_limpiar_visitas_enviadas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_limpiar_visitas_enviadas] @tecnico int AS

Declare @area int

Select	@area=id_area
From	tbl_areas	  
Where	id_personal=@tecnico

--Definiendo los negocios del tecnico para enviarlos nuevamente a la Visor
Update	tbl_detalle_areas
set	traslado_visor=0
Where	id_area = @area

--Borrando los datos visor enviados desde el Sac
delete
from	tbl_numeros_serie
where	codigo_visita IN
	(
	Select 	id_negocio
	From	tbl_detalle_areas
	Where	id_area=@area
	)

delete
from	tbl_tiempos
where	codigo_visita IN
	(
	Select 	id_negocio
	From	tbl_detalle_areas
	Where	id_area=@area
	)

delete
from	tbl_visitas
where	codigo IN
	(
	Select 	id_negocio
	From	tbl_detalle_areas
	Where	id_area=@area
	)

GO
/****** Object:  StoredProcedure [dbo].[pa_lista_areas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_lista_areas] @empresa int AS
select	a.id_empresa,
	a.id_area,
	a.descripcion,
	a.id_personal,
	b.nombre
from	tbl_areas a inner join
	tbl_personal b on a.id_personal=b.id_personal
where	a.id_empresa=@empresa
order by a.id_area



GO
/****** Object:  StoredProcedure [dbo].[pa_lista_consultas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_lista_consultas] @proyecto char(30),@usuario char(30) AS
Select	*
from	tbl_consultas
Where	id_proyecto=@proyecto


GO
/****** Object:  StoredProcedure [dbo].[pa_lista_detalle_ordenes_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_lista_detalle_ordenes_trabajo] AS

select	id_orden_trabajo,
	id_opcion_trabajo,
	valor_unitario,
	nohoja,
	orden
from	tbl_detalle_orden_trabajo
Where	descripcion='Mantenimiento Preventivo'
--WHERE     (nohoja = 'G2734')
order by id_orden_trabajo,
	id_opcion_trabajo
GO
/****** Object:  StoredProcedure [dbo].[pa_lista_logotipos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_lista_logotipos] AS
select	*
from	tbl_logotipos order by descripcion

GO
/****** Object:  StoredProcedure [dbo].[pa_lista_marcas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_lista_marcas] AS
select	*
from	tbl_marcas order by descripcion

GO
/****** Object:  StoredProcedure [dbo].[pa_lista_modelos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_lista_modelos] AS
select	*
from	tbl_modelos order by descripcion

GO
/****** Object:  StoredProcedure [dbo].[pa_lista_negocios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_lista_negocios] @empresa int AS

select	id_negocio,
	id_alterno,
	nombre,
	direccion,
	id_ubicacion
from	tbl_negocios
where	id_empresa=@empresa
order by nombre

GO
/****** Object:  StoredProcedure [dbo].[pa_lista_tecnicos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_lista_tecnicos] @empresa int AS

Select	a.*,
	b.fecha_inicial,
	b.fecha_final
From	tbl_personal		a		inner join
	tbl_vueltas		b		on
	  a.id_empresa	=	b.id_empresa	and
	  a.id_personal	=	b.id_personal	and
	  a.vuelta	=	b.vuelta
Where	a.id_tipo_personal	=	1		and
	a.id_empresa	=	@empresa

GO
/****** Object:  StoredProcedure [dbo].[pa_lista_transportistas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_lista_transportistas] AS
select	*
from	tbl_transportistas




GO
/****** Object:  StoredProcedure [dbo].[pa_lista_ubicaciones]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_lista_ubicaciones] @empresa int, @usuario char(20) AS

Select	a.id_ubicacion,
	a.id_ubicacion_maestra,
	a.descripcion,
	a.tipo,
	CASE WHEN (
	select 
	id_ubicacion
	from tbl_ubicaciones_permiso b
	where 	b.id_ubicacion=a.id_ubicacion and
		b.id_empresa=@empresa and
		b.id_usuario=@usuario
	) is null then 0 else 1 end  as Estado
from	tbl_ubicaciones a
order by a.id_ubicacion,a.id_ubicacion_maestra



GO
/****** Object:  StoredProcedure [dbo].[pa_lista_usuarios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_lista_usuarios] AS
select 	* 
from 	tbl_usuarios



GO
/****** Object:  StoredProcedure [dbo].[pa_login_pepsi]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_login_pepsi] @usuario char(20),@clave char(20) AS

SELECT     a.estado
FROM         tbl_menu_de_usuario		a	inner join
	      tbl_usuarios			b	on
	a.id_usuario = b.id_usuario
WHERE     (id_item 	= 'ConsultasPepsi')	and
	     b.id_usuario	=	@usuario	and
	     b.clave	=	@clave
GO
/****** Object:  StoredProcedure [dbo].[pa_logotipos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_logotipos] @agencia int AS
select	*
from	tbl_logotipos
where	id_agencia=@agencia



GO
/****** Object:  StoredProcedure [dbo].[pa_mant_municipios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_mant_municipios] AS

select	*
from	tbl_municipios
order by id_municipio


GO
/****** Object:  StoredProcedure [dbo].[pa_marcadores_pepsi]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_marcadores_pepsi]  AS

Select	*
from	tbl_marcadores
order by pregunta
GO
/****** Object:  StoredProcedure [dbo].[pa_marcar_negocio_visitado]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_marcar_negocio_visitado] @empresa int, @negocio int, @orden int, @fecha datetime, @hora_inicio char(5) , @hora_final char(5), @dia int AS

Declare @tecnico 	int,
	@sector 	char(10),
	@faltantes 	int,
	@fecha_visita	datetime,
	@serie		char(30),
	@hizopreventivo int

Set nocount on

Set @faltantes=999

--AVERIGUANDO SI SE HIZO PREVENTIVO PARA ACTUALIZAR LA VISITA
Select	@hizopreventivo=count(*)
From	tbl_detalle_orden_trabajo
Where	id_empresa=@empresa		and
	id_orden_trabajo=@orden	and
	id_opcion_trabajo=0

--AVERIGUANDO LA FECHA Y LA SERIE DE LA ORDEN
Select	@fecha_visita=fecha,
	@serie=id_serie
From	tbl_orden_trabajo
Where	id_empresa=@empresa	and
	id_orden_trabajo=@orden

--AVERIGUANDO EL SECTOR DEL NEGOCIO
Select	@sector	=	isnull(id_sector,0)
From	tbl_negocios
Where	id_empresa	=	@empresa	and
	id_negocio	=	@negocio

--AVERIGUANDO EL TECNICO DEL SECTOR
Select	@tecnico	=	isnull(id_tecnico,0)
From	tbl_sectores_por_tecnico
Where	id_empresa	=	@empresa	and
	id_sector	=	@sector

If @hizopreventivo>0
begin

--ACTUALIZANDO EL ACTIVO COMO VISITADO
 UPDATE	tbl_activos

  SET		visitado		=	1,
		id_orden_trabajo=	@orden,
		hora		=	@hora_inicio,
		dia		=	@dia,
		fecha_visita	=	@fecha_visita

  WHERE	id_serie		=	@serie

--AVERIGUANDO SI EXISTE ALGUN NEGOCIO DEL TECNICO QUE NO HAYA SIDO VISITADO
/*  Select	@faltantes	=	count(*)
  From	tbl_activos			a	inner join
	tbl_negocios			b	on
	  a.id_negocio	=	b.id_negocio	and
	  b.id_empresa	=	@empresa	inner join
	tbl_sectores_por_tecnico		c	on
	  b.id_empresa	=	c.id_empresa	and
	  b.id_sector	=	c.id_sector	
  Where	b.id_empresa	=	@empresa	and
	c.id_tecnico	=	@tecnico	and
	a.visitado	=	0*/

Set @faltantes=1

end

Set nocount off

Select 	@faltantes 	as Faltantes,
	@tecnico	as Tecnico
GO
/****** Object:  StoredProcedure [dbo].[pa_marcas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_marcas] @agencia int AS
select	*
from	tbl_marcas
where	id_agencia=@agencia



GO
/****** Object:  StoredProcedure [dbo].[pa_modelos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_modelos] @agencia int AS
select	*
from	tbl_modelos
where	id_agencia=@agencia


GO
/****** Object:  StoredProcedure [dbo].[pa_monedas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_monedas] AS
select	*
from	tbl_monedas


GO
/****** Object:  StoredProcedure [dbo].[pa_motivos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_motivos] AS
select	*
from	tbl_motivos_ingresos



GO
/****** Object:  StoredProcedure [dbo].[pa_movimientos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_movimientos] @empresa int AS
select	*
from	tbl_movimientos
where	id_empresa=@empresa


GO
/****** Object:  StoredProcedure [dbo].[pa_municipios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_municipios] @depto int AS

select	*
from	tbl_municipios
where	id_departamento=@depto
order by nombre

GO
/****** Object:  StoredProcedure [dbo].[pa_negocio_especifico]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_negocio_especifico] @empresa int, @negocio int AS

select	*
from	tbl_negocios
where	id_empresa=@empresa	and
	id_negocio=@negocio
GO
/****** Object:  StoredProcedure [dbo].[pa_negocios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_negocios] @empresa int,@agencia int  AS
select	*
from	tbl_negocios
where	id_empresa=@empresa and
	id_agencia=@agencia
order by id_negocio



GO
/****** Object:  StoredProcedure [dbo].[pa_negocios_disponibles]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_negocios_disponibles] @empresa int ,@negocio int AS
select	id_negocio,
	nombre,
	id_alterno,
	id_ubicacion,
	direccion
from	tbl_negocios
where	id_empresa=@empresa and
 	id_negocio<>@negocio
order by nombre
GO
/****** Object:  StoredProcedure [dbo].[pa_negocios_por_tipo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_negocios_por_tipo] @empresa int,@tipo int AS
select	*
from	tbl_negocios
where	id_tipo_negocio=@tipo and
	id_empresa=@empresa




GO
/****** Object:  StoredProcedure [dbo].[pa_nuevas_ordenes]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_nuevas_ordenes] AS
select	*
from	tbl_orden_trabajo
where	id_empresa=-1



GO
/****** Object:  StoredProcedure [dbo].[pa_nuevo_detalle_orden_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_nuevo_detalle_orden_trabajo] AS
select	*
from	tbl_detalle_orden_trabajo
where	id_empresa=-1


GO
/****** Object:  StoredProcedure [dbo].[pa_nuevos_negocios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_nuevos_negocios] AS
select	*
from	tbl_negocios
where	id_empresa=-1


GO
/****** Object:  StoredProcedure [dbo].[pa_opciones]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_opciones] @usuario char(20),@proyecto char(20),@empresa int AS
select 	a.*
from 	tbl_menu_de_usuario a inner join
	tbl_menu_de_items b on b.id_item=a.id_item and b.id_proyecto=a.id_proyecto
where   	a.id_proyecto=@proyecto and  
	a.id_usuario=@usuario and
 	a.id_empresa=@empresa
order by a.id_grupo,b.numero




GO
/****** Object:  StoredProcedure [dbo].[pa_opciones_por_usuario]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_opciones_por_usuario] @usuario char(20),@modulo char(20),@grupo char(20), @empresa int AS
select 	a.id_item,
	a.estado,
	b.caption,
             b.texto,
	b.llave,
	b.imagen,
	b.numero,
	b.id_indice,
	b.hint,
	a.en_barra
from 	tbl_menu_de_usuario a inner join
	tbl_menu_de_items b on b.id_item=a.id_item and b.id_proyecto=a.id_proyecto
where   a.estado<>0 and  
        	a.id_proyecto=@modulo and  
	a.id_usuario=@usuario and 
	a.id_grupo=@grupo and
	a.id_empresa=@empresa
order by b.numero


GO
/****** Object:  StoredProcedure [dbo].[pa_opciones_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_opciones_trabajo] @empresa int, @tipo int AS
select	*
from	tbl_opciones_trabajo
where	id_empresa=@empresa 	and
	servicio=@tipo 		
GO
/****** Object:  StoredProcedure [dbo].[pa_opciones_traslado]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_opciones_traslado] @empresa int AS
select	*
from	tbl_opciones_trabajo
where	id_empresa=@empresa and
	id_tipo_opcion_trabajo=0
GO
/****** Object:  StoredProcedure [dbo].[pa_opciones_usuario]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_opciones_usuario] @usuario char(20),@modulo char(20),@empresa int AS
select 	b.caption,
	a.en_barra
from 	tbl_menu_de_usuario a inner join
	tbl_menu_de_items b on b.id_item=a.id_item and b.id_proyecto=a.id_proyecto
where   a.estado<>0 and  
        	a.id_proyecto=@modulo and  
	a.id_usuario=@usuario and
 	a.id_empresa=@empresa
order by b.numero


GO
/****** Object:  StoredProcedure [dbo].[pa_orden_especifica]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_orden_especifica] @empresa int, @orden int AS
select	*
from	tbl_orden_trabajo
where	id_empresa=@empresa	and
	id_orden_trabajo=@orden
GO
/****** Object:  StoredProcedure [dbo].[pa_orden_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_orden_trabajo] @orden int  AS
select * 
from tbl_orden_trabajo
where id_orden_trabajo = @orden

GO
/****** Object:  StoredProcedure [dbo].[pa_ordenes_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_ordenes_trabajo] @empresa int AS
select	*
from	tbl_orden_trabajo
where	id_empresa=@empresa
ORDER BY ID_ORDEN_TRABAJO

GO
/****** Object:  StoredProcedure [dbo].[pa_paises]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_paises] AS

Select	*
from	tbl_paises

GO
/****** Object:  StoredProcedure [dbo].[pa_pegar_foto_negocio]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_pegar_foto_negocio] @empresa int, @negocio int AS

Select	archivo,foto
From	tbl_negocios
Where	id_empresa	=	@empresa	and
	id_negocio	=	@negocio
GO
/****** Object:  StoredProcedure [dbo].[pa_personal]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_personal] @empresa int, @tipo int AS
select	a.id_personal,
	a.id_tipo_personal,
	b.descripcion,
	a.nombre,
	a.id_alterno
from	tbl_personal a inner join
	tbl_tipo_personal b on a.id_tipo_personal=b.id_tipo_personal
where	a.id_tipo_personal=@tipo and 
	a.id_empresa=@empresa




GO
/****** Object:  StoredProcedure [dbo].[pa_preguntas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_preguntas] AS

Select	*
from	tbl_preguntas
order by pregunta
GO
/****** Object:  StoredProcedure [dbo].[pa_preventivo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_preventivo] AS

Select	*
From	tbl_preventivo
GO
/****** Object:  StoredProcedure [dbo].[pa_problemas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_problemas] @empresa int AS

Select	*
From	tbl_problemas


GO
/****** Object:  StoredProcedure [dbo].[pa_proxima_orden]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_proxima_orden] @empresa int ,@agencia int AS
declare @proximo int

  SET NOCOUNT ON

  select 	@proximo = max(id_orden_trabajo)+1
  from 	tbl_orden_trabajo
  where 	id_empresa=@empresa	and
	id_agencia=@agencia

 If @proximo is null 
  begin
  set @proximo=1
  end

  SET NOCOUNT OFF
  
SELECT @Proximo as Proximo
GO
/****** Object:  StoredProcedure [dbo].[pa_proximo_numero]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_proximo_numero] @documento int, @empresa int ,@agencia int AS

BEGIN

  SET NOCOUNT ON
  DECLARE @Proximo INT

  SELECT 	@Proximo = isnull(proximo_numero,0) 
  FROM 	tbl_numeracion_sac 
  WHERE 	id_documento = @documento 	AND 
		id_empresa = @empresa 	and 
		id_agencia=@agencia

  If @Proximo<=0 or @Proximo is null
    begin
    Insert into tbl_numeracion_sac
	select	@empresa 	as 	id_empresa,
		@documento	as	id_documento,
		@agencia 	as 	id_agencia,
		''		as	descripcion,
		1		as	proximo_numero,
		0		as	Trasladado,
		null		as	fecha_traslado
    SET @Proximo=1
    end
  else
    begin  
    UPDATE tbl_numeracion_sac SET proximo_numero = @Proximo + 1 WHERE id_documento = @documento AND id_empresa = @empresa and id_agencia=@agencia
    end

  SET NOCOUNT OFF
  SELECT @Proximo as Proximo

END








GO
/****** Object:  StoredProcedure [dbo].[pa_puede_editar]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_puede_editar]  @usuario char(30) ,@clave char(30)AS

select	puede_editar
from	tbl_usuarios
where	id_usuario=@usuario	and
	clave=@clave
GO
/****** Object:  StoredProcedure [dbo].[pa_puntos_geo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_puntos_geo] @empresa int, @negocio int AS

Select	latitud_grad,
	latitud_min,
	latitud_seg,
	longitud_grad,
	longitud_min,
	longitud_seg,
	foto
From	tbl_negocios
Where	id_empresa=@empresa	and
	id_negocio=@negocio
GO
/****** Object:  StoredProcedure [dbo].[pa_refrescar_modelo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_refrescar_modelo] @agencia int, @serie char(20) AS
Select 		a.id_modelo		as 'Cod-Modelo',
		b.descripcion		as Modelo

FROM		tbl_activos			a	inner join 
		tbl_modelos			b	on
		  b.id_agencia	=	@agencia	and
		  a.id_modelo	=	b.id_modelo
	
WHERE	a.id_serie=@serie
GO
/****** Object:  StoredProcedure [dbo].[pa_regiones]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_regiones] @empresa int AS
Select	*
From	tbl_regiones
Where	id_empresa=@empresa

GO
/****** Object:  StoredProcedure [dbo].[pa_reporte_pepsi]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_reporte_pepsi]

@fechai char(10),
@fechaf char(10),
@empresa int,
@agencia int,
@presupuesto decimal(18,2),
@dias_trab int,
@preventivos_dia int,
@plan_anual_inst decimal(18,2),
@inventario_partes int,
@costo_invent_equipo decimal(18,2),
@gasto_real decimal(18,2),
@Dias_Perdidos int,
@No_Lesiones int

AS 
SET ARITHABORT OFF 
SET ARITHIGNORE ON
SET DATEFORMAT MDY

set nocount on

Declare @Total_Buenas  	decimal(18,2)
Declare @Total_Ordenes 	decimal(18,2)
Declare @temp1 		int
Declare @temp2 		int
-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 1----------------------------------------------------
--Definicion del rango de temperatura considerada como buena
Set @temp1=4
Set @temp2=6
 
--Determinando el total de ordenes buenas segun la temperatura
Select	@Total_Buenas		=	count(*)
from	tbl_orden_trabajo	a
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.fecha		between	@fechai		and
					@fechaf		and
	a.temperatura	between	@temp1		and
					@temp2

--Calculando el total de ordenes de trabajo en el rango de fechas
Select	@Total_Ordenes		=	count(*)
from	tbl_orden_trabajo	a
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.fecha		between	@fechai		and
				@fechaf
--Declarando el porcentaje para el valor de la pregunta #1
Declare @porcentaje1 as Decimal(18,2)

If @Total_Ordenes>0
  begin
  Set @porcentaje1=((@Total_Buenas/@Total_Ordenes)*100)
  end
else
  begin
  Set @Porcentaje1=0
  end
 
-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 2----------------------------------------------------
Declare	@Total_apariencia decimal(18,2)

Declare @apa1 int
Declare @apa2 int

Set @apa1=0
Set @apa2=4

--Determinando el total de ordenes buenas segun la APARIENCIA
Select	@Total_apariencia	=	count(*)
from	tbl_orden_trabajo	a
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.fecha		between	@fechai		and
				@fechaf		and
	a.apariencia	between	@apa1		and
				@apa2

--Declarando el porcentaje para el valor de la pregunta #2
Declare @porcentaje2 as Decimal(18,2)

If @Total_Ordenes>0
  begin
  Set @porcentaje2=((1)-(@Total_apariencia/@Total_Ordenes))*100
  end
else
  begin
  Set @Porcentaje2=0
  end

-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 3----------------------------------------------------
Declare @Tiempo_Respuesta decimal(18,2)

--Determinando el total de tiempo de respuesta en hrs.
Select	@Tiempo_Respuesta	=	sum(DATEDIFF ( dd , a.fecha_llamada, a.fecha_termino )-(a.fines_semana*1.5))
from	tbl_orden_trabajo	a
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.fecha	between	@fechai		and
				@fechaf	


--Declarando el porcentaje para el valor de la pregunta #3
Declare @porcentaje3 as Decimal(18,2)

If @Total_Ordenes>0
  begin
  Set @porcentaje3=(@Tiempo_Respuesta/@Total_Ordenes)
  end
else
  begin
  Set @Porcentaje3=0
  end

-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 4----------------------------------------------------
Declare @primera_vez decimal(18,2)

--Determinando el total de ordenes por tipo
Select	@primera_vez	=	count(*)
from
(Select	a.id_serie
from	tbl_orden_trabajo	 a	
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.id_tipo_trabajo<>0			and
	a.id_tipo_trabajo<>-1			and
	a.id_tipo_trabajo<>10			and
	a.fecha	between	@fechai		and
				@fechaf		
group by a.id_serie) z

--Declarando el porcentaje para el valor de la pregunta #4
Declare @porcentaje4 as Decimal(18,2)

If @Total_Ordenes>0
  begin
  Set @porcentaje4=(@primera_vez/@Total_Ordenes)*100
  end
else
  begin
  Set @Porcentaje4=0
  end


-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 5----------------------------------------------------

Declare @preventivos decimal(18,2)

Select	@Preventivos	=	count(*)
from	tbl_orden_trabajo	 a	inner join
	tbl_tipos_opcion_trabajo b 	on
	  a.id_tipo_trabajo=b.id_tipo_opcion_trabajo
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.id_tipo_trabajo<>0			and
	a.id_tipo_trabajo<>-1			and
	a.id_tipo_trabajo<>10			and
	a.fecha	between	@fechai		and
				@fechaf		and
	b.servicio	=	1

--Declarando el porcentaje para el valor de la pregunta #5
Declare @porcentaje5 as Decimal(18,2)

If @preventivos_dia>0
  begin
  Set @porcentaje5=((@Preventivos/(@dias_trab*@preventivos_dia))*100)--donde 216 es la cte. para metro de preventivos
  end
else
  begin
  Set @Porcentaje5=0
  end


-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 6----------------------------------------------------

Declare @comprometido decimal(18,2)
Declare @total_traslados decimal(18,2)
Declare @entiempo1 decimal(18,2)
Declare @entiempo2 decimal(18,2)

set @entiempo1=0
set @entiempo2=72

Select	@comprometido	=	count(*)
from	tbl_traslados	 	a	
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	(a.fecha_requerida-a.fecha)>=@entiempo1	and
	(a.fecha_requerida-a.fecha)<=@entiempo2	and
	a.fecha		between	@fechai		and
				@fechaf	
Select	@total_traslados	=	count(*)
from	tbl_movimientos	 	a	
where	a.id_empresa	=	@empresa		and
	a.id_agencia	=	@agencia		and
	a.fecha		between	@fechai			and
					@fechaf			and
	id_opcion_trabajo IN('501', '503', '504') 	and --especificar unicamente los tipos de traslados con cobros

	a.id_orden_traslado<>0


--Declarando el porcentaje para el valor de la pregunta #6
Declare @porcentaje6 as Decimal(18,2)

If @total_traslados>0
  begin
  Set @porcentaje6=((@comprometido/@total_traslados)*100)
  end
else
  begin
  Set @Porcentaje6=0
  end


-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 8----------------------------------------------------

Declare @inventario decimal(18,2)

Select	@inventario	=	count(*)
from	tbl_activos	 	a	
where	a.id_agencia	=	@agencia	

--Declarando el porcentaje para el valor de la pregunta #8
Declare @porcentaje8 as Decimal(18,2)

If @total_traslados>0
  begin
  Set @porcentaje8=((@inventario/@plan_anual_inst)*(DATEDIFF ( dd , @fechai , @fechaf )))
  end
else
  begin
  Set @Porcentaje8=0
  end
  


-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 9----------------------------------------------------
Declare @Costo_Ordenes as Decimal(18,2)

--Calculando el costo total de ordenes de trabajo en el rango de fechas
Select	@Costo_Ordenes		=	sum(a.total)
from	tbl_orden_trabajo	a
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.fecha	between	@fechai		and
				@fechaf
--Declarando el porcentaje para el valor de la pregunta #9
Declare @porcentaje9 as Decimal(18,2)

/*If @Presup_Cantidad>0
  begin*/
  Set @porcentaje9=((@inventario_partes)*(DATEDIFF ( dd , @fechai , @fechaf ))) --en donde 1.05 es la division de costo de inventario al mes 
/*  end								  --de 200,000 dentro de 190,000 que es el costo presupuestado. segun incidencias del 2002
else
  begin
  Set @Porcentaje9=0
  end*/


-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 10----------------------------------------------------
Declare @costo_orden decimal(18,2)

--Calculando el total de ordenes de trabajo en el rango de fechas
Select	@costo_orden	=

(Select	sum(a.total)
from	tbl_orden_trabajo	a
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.fecha	between	@fechai		and
				@fechaf)
+
(Select	count(a.valor)
from	tbl_movimientos		a
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.fecha		between	@fechai		and
				@fechaf		and
	a.id_orden_traslado>0)

--Declarando el porcentaje para el valor de la pregunta #10
Declare @porcentaje10 as Decimal(18,2)

If @Total_Ordenes>0
  begin
  Set @porcentaje10=(@costo_invent_equipo/@inventario) --costo total invertido por equipo al mes a nivel metro 6383698.79/12 meses segun incidencias del 2002.
  end
else
  begin
  Set @Porcentaje10=0
  end


-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 11----------------------------------------------------
Declare @costo_presupuesto decimal(18,2)

--Calculando el total de ordenes de trabajo en el rango de fechas
Select	@costo_presupuesto	=

(Select	sum(a.total)
from	tbl_orden_trabajo	a
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.fecha	between	@fechai		and
				@fechaf)
+
(Select	count(a.valor)
from	tbl_movimientos		a
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.fecha		between	@fechai		and
				@fechaf		and
	a.id_orden_traslado>0)

--Declarando el porcentaje para el valor de la pregunta #11
Declare @porcentaje11 as Decimal(18,2)

If @presupuesto>0
  begin
  Set @porcentaje11=((@gasto_real)/12/@presupuesto)*100      --segun incidencia el presupuesto anual asciende a 1.600.000.00 
  end					                    --lo presupuestado asciende a 1.300.000.00/12 aprox  108300.
else
  begin
  Set @Porcentaje11=0
  end


-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 12----------------------------------------------------
Declare @servicios_mes decimal(18,2)

--Determinando el total de ordenes por rango
Select	@servicios_mes	=	count(*)
from	tbl_orden_trabajo	 a	
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.id_tipo_trabajo<>0			and
	a.id_tipo_trabajo<>-1			and
	a.id_tipo_trabajo<>10			and
	a.fecha	between	@fechai		and
				@fechaf		

--Declarando el porcentaje para el valor de la pregunta #12
Declare @porcentaje12 as Decimal(18,2)

If @dias_trab>0
  begin
  Set @porcentaje12=(@servicios_mes/@dias_trab)
  end
else
  begin
  Set @Porcentaje12=0
  end


-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 13----------------------------------------------------
--Declarando el porcentaje para el valor de la pregunta #13
Declare @porcentaje13 as Decimal(18,2)

If @dias_trab>0
  begin
  Set @porcentaje13=(@total_traslados/@dias_trab)
  end
else
  begin
  Set @Porcentaje13=0
  end



-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 14----------------------------------------------------
Declare @reparadas decimal(18,2)

Select	@reparadas	=	count(*)
from	tbl_orden_trabajo	a
where	a.id_empresa	=	@empresa	and
	a.id_agencia	=	@agencia	and
	a.fecha		between	@fechai		and
				@fechaf		and
	a.id_personal	IN('108', '412')  --Son los tecnicos que tienen que ver con el taller


--Declarando el porcentaje para el valor de la pregunta #14
Declare @porcentaje14 as Decimal(18,2)

If @dias_trab>0
  begin
  Set @porcentaje14=(@reparadas/@dias_trab)
  end
else
  begin
  Set @Porcentaje14=0
  end

-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 15------------------------------------
Declare @Porcentaje15  decimal(18,2)

Set	@Porcentaje15	=	( @Dias_Perdidos /   (@dias_trab*9.16666667) ) * 100000


-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------PREGUNTA # 16------------------------------------
Declare @Porcentaje16 decimal(18,2)

Set	@Porcentaje16	=	( @No_Lesiones /   (@dias_trab*9.16666667) ) * 100000


-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------- MOSTRANDO E INSERANDO LOS RESULTADOS----------------------------------------------------

truncate table tbl_reporte_pepsi

insert into tbl_reporte_pepsi
select	*
from
(select	2 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje1 	as porcentaje
from	tbl_preguntas
where	pregunta	=	1		and
	@porcentaje1	>=	inicio	 	and
	@porcentaje1 	<=	final
UNION ALL
select	2 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje2 	as porcentaje
from	tbl_preguntas
where	pregunta	=	2		and
	@porcentaje2	>=	inicio	 	and
	@porcentaje2 	<=	final
UNION ALL
select	4 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje3 	as porcentaje
from	tbl_preguntas
where	pregunta	=	3		and
	@porcentaje3	>=	inicio	 	and
	@porcentaje3 	<=	final
UNION ALL
select	4 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje4 	as porcentaje
from	tbl_preguntas
where	pregunta	=	4		and
	@porcentaje4	>=	inicio	 	and
	@porcentaje4 	<=	final
UNION ALL
select	4 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje5 	as porcentaje
from	tbl_preguntas
where	pregunta	=	5		and
	@porcentaje5	>=	inicio	 	and
	@porcentaje5 	<=	final
UNION ALL
select	3 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje6 	as porcentaje
from	tbl_preguntas
where	pregunta	=	6		and
	@porcentaje6	>=	inicio	 	and
	@porcentaje6 	<=	final
/*UNION ALL
select	3 as grupo,
	pregunta,
	descripcion,
	carita,
	0.00 	as porcentaje
from	tbl_preguntas
where	pregunta	=	7		*/
UNION ALL
select	6 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje8 	as porcentaje
from	tbl_preguntas
where	pregunta	=	8		and
	@porcentaje8	>=	inicio	 	and
	@porcentaje8 	<=	final
UNION ALL
select	6 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje9 	as porcentaje
from	tbl_preguntas
where	pregunta	=	9		and
	@porcentaje9	>=	inicio	 	and
	@porcentaje9 	<=	final
UNION ALL
select	6 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje10 	as porcentaje
from	tbl_preguntas
where	pregunta	=	10		and
	@porcentaje10	>=	inicio	 	and
	@porcentaje10 	<=	final
UNION ALL
select	6 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje11 	as porcentaje
from	tbl_preguntas
where	pregunta	=	11		and
	@porcentaje11	>=	inicio	 	and
	@porcentaje11 	<=	final
UNION ALL
select	5 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje12 	as porcentaje
from	tbl_preguntas
where	pregunta	=	12		and
	@porcentaje12	>=	inicio	 	and
	@porcentaje12 	<=	final) z
UNION ALL
select	5 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje13 	as porcentaje
from	tbl_preguntas
where	pregunta	=	13		and
	@porcentaje13	>=	inicio	 	and
	@porcentaje13 	<=	final
UNION ALL
select	5 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje14 	as porcentaje
from	tbl_preguntas
where	pregunta	=	14		and
	@porcentaje14	>=	inicio	 	and
	@porcentaje14 	<=	final
UNION ALL
select	1 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje15 	as porcentaje
from	tbl_preguntas
where	pregunta	=	15		and
	@porcentaje15	>=	inicio	 	and
	@porcentaje15 	<=	final
UNION ALL
select	1 as grupo,
	pregunta,
	descripcion,
	carita,
	@porcentaje16 	as porcentaje
from	tbl_preguntas
where	pregunta	=	16		and
	@porcentaje16	>=	inicio	 	and
	@porcentaje16 	<=	final

GO
/****** Object:  StoredProcedure [dbo].[pa_reporte_pepsico]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_reporte_pepsico] @grupo int AS 

select	*
from	tbl_reporte_pepsi
where	grupo=@grupo
order by pregunta
GO
/****** Object:  StoredProcedure [dbo].[pa_sectores]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_sectores] @empresa int AS
Select	*
From	tbl_sectores
Where	id_empresa=@empresa

GO
/****** Object:  StoredProcedure [dbo].[pa_sectores_region]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_sectores_region] @empresa int, @region char(30) AS
Select	*
From	tbl_sectores
Where	id_empresa	=	@empresa	and
	id_region	=	@region

GO
/****** Object:  StoredProcedure [dbo].[pa_serie]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_serie] @serie char(25)  AS     

select a.id_activo,
            a.id_ficha,
            a.id_serie,
            g.fabricado,
            d.nombre,
            c.descripcion,
            b.nombre as nombre_neg,
            b.id_alterno,
            b.direccion,
            b.zona,
            a.no_contrato,
            b.contacto,
            b.telefono,
            f.descripcion as 'Logotipo',
            e.descripcion as 'tipo',
            b.entorno,
            b.id_negocio,
            h.id_alterno as 'Ruta',
	b.id_sector
from tbl_activos a inner join
            tbl_negocios b on
            a.id_negocio = b.id_negocio inner join
            tbl_modelos c on
            a.id_modelo = c.id_modelo inner join
            tbl_fabricantes d on
            a.id_fabricante = d.id_fabricante inner join
            tbl_tipos e on
            a.id_tipo = e.id_tipo inner join
            tbl_logotipos f on
            a.id_logotipo = f.id_logotipo inner join
            tbl_detalle_ingresos g on
            a.id_serie = g.id_serie  inner join
            tbl_ubicaciones h on
            b.id_ubicacion = h.id_ubicacion
where a.id_serie = @serie
GO
/****** Object:  StoredProcedure [dbo].[pa_temperatura]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[pa_temperatura]  AS

Select	*
From	tbl_temperatura
GO
/****** Object:  StoredProcedure [dbo].[pa_tipos_activo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_tipos_activo] AS
select 	*
from	tbl_tipos
order by id_tipo


GO
/****** Object:  StoredProcedure [dbo].[pa_tipos_docto]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_tipos_docto] AS
select	*
from	tbl_documentos


GO
/****** Object:  StoredProcedure [dbo].[pa_tipos_equipo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_tipos_equipo] AS
select	*
from	tbl_tipos order by descripcion

GO
/****** Object:  StoredProcedure [dbo].[pa_tipos_movimiento]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[pa_tipos_movimiento] AS

select	*
from	tbl_tipos_movimiento
GO
/****** Object:  StoredProcedure [dbo].[pa_tipos_negocios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_tipos_negocios] @agencia int AS
select	*
from	tbl_tipos_negocios
where	id_agencia=@agencia


GO
/****** Object:  StoredProcedure [dbo].[pa_tipos_opcion_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_tipos_opcion_trabajo] AS
select	*
from	tbl_tipos_opcion_trabajo


GO
/****** Object:  StoredProcedure [dbo].[pa_tipos_personal]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_tipos_personal] AS
select	*
from	tbl_tipo_personal



GO
/****** Object:  StoredProcedure [dbo].[pa_tipos_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_tipos_trabajo] AS

select	id_tipo_opcion_trabajo as id_tipo_trabajo,
	descripcion,
	servicio
from	tbl_tipos_opcion_trabajo


GO
/****** Object:  StoredProcedure [dbo].[pa_transportistas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_transportistas] @agencia int AS
select	*
from	tbl_transportistas
where	id_agencia=@agencia


GO
/****** Object:  StoredProcedure [dbo].[pa_traslado_especifico]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_traslado_especifico] @empresa int , @traslado int AS
Select	*
from	tbl_traslados
where 	id_empresa=@empresa and
	id_orden_traslado=@traslado

GO
/****** Object:  StoredProcedure [dbo].[pa_traslados]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_traslados] @empresa int AS
select	*
from	tbl_traslados
where	id_empresa=@empresa


GO
/****** Object:  StoredProcedure [dbo].[pa_ubicaciones]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_ubicaciones] @usuario char(20) AS
select	a.*
from	tbl_ubicaciones a inner join
	tbl_ubicaciones_permiso o on a.id_ubicacion=o.id_ubicacion
where	o.id_usuario=@usuario and o.id_empresa=1
order by a.id_ubicacion_maestra,a.id_ubicacion





GO
/****** Object:  StoredProcedure [dbo].[pa_ubicaciones_por_nivel]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_ubicaciones_por_nivel] @nivel int AS

select	id_ubicacion		as	'Ubicacion',
	id_ubicacion_maestra	as	'Ubicacion-Maestra',
	id_alterno		as	'Cod-Alterno',
	descripcion		as	'Descripcion'
from	tbl_ubicaciones
where	len(id_ubicacion)=@nivel	
order by id_ubicacion,id_ubicacion_maestra



GO
/****** Object:  StoredProcedure [dbo].[pa_unidades_medida]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_unidades_medida] @agencia int AS
select	*
from	tbl_unidad_medida
where	id_agencia=@agencia


GO
/****** Object:  StoredProcedure [dbo].[pa_usuario]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pa_usuario] @Usuario char(20),@Clave Char(10) AS
select 	* 
from 	tbl_usuarios
where	id_usuario=@Usuario and
	clave=@Clave


GO
/****** Object:  StoredProcedure [dbo].[pa_validar_cambio_envio]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_validar_cambio_envio]
	@serie 	char(20),
	@envio	char(20)

AS

Declare	@modelo_anterior	int,
	@modelo_actual	int

Set nocount on
--AVERIGUANDO EL # DE INGRESO ACTUAL Y EL MODELO ANTERIOR
Select	@modelo_anterior=id_modelo
From	tbl_ingresos
Where	no_documento	=@envio and
	id_empresa	=1

--AVERIGUANDO EL MODELO DEL ACTIVO
Select	@modelo_actual=id_modelo
From	tbl_activos
Where	id_serie=@serie

Set nocount off

Select	CASE WHEN @modelo_anterior<>@modelo_actual THEN 0 ELSE 1 END AS MISMOMODELO
GO
/****** Object:  StoredProcedure [dbo].[pa_valor_preventivo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_valor_preventivo] AS

set nocount on

Declare @valor decimal(18,2)

Select 	@valor	=	valor
From	tbl_tipos_opcion_trabajo
Where	id_tipo_opcion_trabajo = 3

set nocount off

Select	isnull(@valor,0) as 'Valor'
GO
/****** Object:  StoredProcedure [dbo].[pa_valor_traslado]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pa_valor_traslado] AS

set nocount on

Declare @valor decimal(18,2)

Select 	@valor	=	valor
From	tbl_tipos_opcion_trabajo
Where	id_tipo_opcion_trabajo = 0

set nocount off

Select	isnull(@valor,0) as 'Valor'


GO
/****** Object:  StoredProcedure [dbo].[pa_verifica_equipo_visitado]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_verifica_equipo_visitado] @serie char(30) AS

Select	id_orden_trabajo as Orden,
	fecha_visita	 as Fecha
From	tbl_activos
Where	id_serie=@serie	and
	visitado=1
GO
/****** Object:  StoredProcedure [dbo].[pa_verificar_ficha]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_verificar_ficha] @empresa int, @ficha char(20) AS

Select 		b.id_serie,
		b.id_negocio,
		c.id_alterno 		as id_sio,
		isnull(c.nombre,'') 	as nombre,
		c.id_ubicacion,
		c.direccion,
		c.id_sector,
		d.id_alterno		as 'Cod-Ruta',
		d.descripcion		as Ruta,
		b.id_modelo		as 'Cod-Modelo',
		e.descripcion		as Modelo

FROM		tbl_activos			b	left join
		tbl_negocios 			c 	on 
		  b.id_negocio=c.id_negocio	and
		  c.id_empresa=@empresa		left join
		tbl_ubicaciones			d	on
		  c.id_ubicacion	=	d.id_ubicacion	inner join
		tbl_modelos			e	on
		  c.id_agencia	=	e.id_agencia	and
		  b.id_modelo	=	e.id_modelo
	
WHERE	b.id_ficha=@ficha
GO
/****** Object:  StoredProcedure [dbo].[pa_verificar_serie]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[pa_verificar_serie] @empresa int, @serie char(20) AS
Select 		b.id_ficha,
		b.id_negocio,
		c.id_alterno 		as id_sio,
		isnull(c.nombre,'') 	as nombre,
		c.id_ubicacion,
		c.direccion,
		c.id_sector,
		d.id_alterno		as 'Cod-Ruta',
		d.descripcion		as Ruta,
		b.id_modelo		as 'Cod-Modelo',
		e.descripcion		as Modelo

FROM		tbl_activos			b	left join
		tbl_negocios 			c 	on 
		  b.id_negocio=c.id_negocio	and
		  c.id_empresa=@empresa		left join
		tbl_ubicaciones			d	on
		  c.id_ubicacion	=	d.id_ubicacion	inner join
		tbl_modelos			e	on
		  c.id_agencia	=	e.id_agencia	and
		  b.id_modelo	=	e.id_modelo
	
WHERE	b.id_serie=@serie
GO
/****** Object:  StoredProcedure [dbo].[pat_activos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pat_activos] @tipo int AS
Select	*
from	tbl_activos
where 	trasladado	=	@tipo


GO
/****** Object:  StoredProcedure [dbo].[pat_detalle_ingresos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pat_detalle_ingresos] @tipo int AS
Select	*
from	tbl_detalle_ingresos
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_detalle_orden_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pat_detalle_orden_trabajo] @tipo int AS
Select	*
from	tbl_detalle_orden_trabajo
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_ingresos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pat_ingresos] @tipo int AS
Select	*
from	tbl_ingresos
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_logotipos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pat_logotipos] @tipo int AS
Select	*
from	tbl_logotipos
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_marcas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pat_marcas] @tipo int AS
Select	*
from	tbl_marcas
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_modelos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pat_modelos] @tipo int AS
Select	*
from	tbl_modelos
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_monedas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pat_monedas] @tipo int AS
Select	*
from	tbl_monedas
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_movimientos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pat_movimientos] @tipo int AS
Select	*
from	tbl_movimientos
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_negocios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pat_negocios] @tipo int AS
Select	*
from	tbl_negocios
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_opciones_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pat_opciones_trabajo] @tipo int AS
Select	*
from	tbl_opciones_trabajo
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_orden_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pat_orden_trabajo] @tipo int AS
Select	*
from	tbl_orden_trabajo
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_personal]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pat_personal] @tipo int AS
Select	*
from	tbl_personal
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_tipos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pat_tipos] @tipo int AS
Select	*
from	tbl_tipos
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_tipos_negocios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pat_tipos_negocios] @tipo int AS
Select	*
from	tbl_tipos_negocios
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_tipos_opcion_trabajo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pat_tipos_opcion_trabajo] @tipo int AS
Select	*
from	tbl_tipos_opcion_trabajo
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_transportistas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pat_transportistas] @tipo int AS
Select	*
from	tbl_transportistas
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_traslados]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pat_traslados] @tipo int AS
Select	*
from	tbl_traslados
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_ubicaciones]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pat_ubicaciones] @tipo int AS
Select	*
from	tbl_ubicaciones
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pat_unidad_medida]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pat_unidad_medida] @tipo int AS
Select	*
from	tbl_unidad_medida
where 	trasladado	=	@tipo



GO
/****** Object:  StoredProcedure [dbo].[pav_actualizar_activo]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[pav_actualizar_activo] @visita int, @serie char(20) AS
update	tbl_numeros_serie
set	actualizado=1
where	numero_serie=@serie and
	codigo_visita=@visita




GO
/****** Object:  StoredProcedure [dbo].[pav_actualizar_negocio]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[pav_actualizar_negocio] @visita int, @negocio int AS
update	tbl_visitas
set	negocios_actualizados=1,
	id_negocio=@negocio
where	codigo=@visita




GO
/****** Object:  StoredProcedure [dbo].[pav_actualizar_orden]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[pav_actualizar_orden] @visita int, @serie char(20) AS
update	tbl_numeros_serie
set	actualizada_orden=1
where	numero_serie=@serie and
	codigo_visita=@visita and
	actualizada_orden=0








GO
/****** Object:  StoredProcedure [dbo].[pav_actualizar_visitas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[pav_actualizar_visitas]  AS
update	tbl_visitas
set	visitas_actualizadas=1
where	visitas_actualizadas=0





GO
/****** Object:  StoredProcedure [dbo].[pav_detalle_ordenes]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[pav_detalle_ordenes]
@empresa int,
@serie char(20)
AS
set dateformat dmy
select	a.etapa,
	a.codigo_servicio as id_opcion_trabajo,
	b.descripcion,
	ISNULL(a.cantidad,0) as cantidad,
	isnull(c.valor_unitario,0) as valor_unitario,
	c.id_unidad_medida
from	tbl_acciones_correctivo a inner join
	tbl_correctivo b on a.codigo_servicio=codigo inner join
	tbl_opciones_trabajo c on b.codigo=c.id_opcion_trabajo
where	a.numero_serie=@serie and
	c.id_empresa=@empresa




GO
/****** Object:  StoredProcedure [dbo].[pav_insertar_visita]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[pav_insertar_visita]
	@empresa int,
	@orden int,
	@fecha char(20),
	@negocio int,
	@ubicacion char(20),
	@personal int,
	@pendiente int
AS
set dateformat dmy
declare 	@fecha_visita datetime
select	@fecha_visita=cast(@fecha as datetime)

INSERT INTO tbl_visitas_sac
	(id_empresa,
	orden_salida,
	fecha,
	id_negocio,
	id_ubicacion,
	id_personal,
	pendiente,
	no_etapa) 
       VALUES 	      
	(@empresa,
	@orden,
	@fecha,
	@negocio,
	@ubicacion,
	@personal,
	@pendiente,
	1) 




GO
/****** Object:  StoredProcedure [dbo].[pav_nuevas_ordenes]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[pav_nuevas_ordenes] AS
set dateformat dmy
select	b.id_negocio,
	d.id_serie,
	isnull(d.id_ficha,id_serie) as id_ficha,
	d.id_sio,
	d.id_sio 					as serie_orden,
	c.id_ubicacion,
	b.codigo,
	b.nombre,
	CASE WHEN b.anio=0 THEN GETDATE() ELSE cast (	cast(b.dia as char(2))+'-'+
		rtrim(cast(b.mes as char(2)))+'-'+
		cast(b.anio as char(4))+' '+
		cast(b.hora as char(2))+':'+
		cast(b.minuto as char(2)) 
	as datetime)  END				as fecha,
	(rtrim(cast(b.hora as char(2)))+':'+
	rtrim(cast(b.minuto as char(2)))+':00' ) 	as hora_inicio,
	(rtrim(cast(b.hora as char(2)))+':'+
	rtrim(cast(b.minuto as char(2)))+':00' ) 	as hora_final,
	b.comentarios 				as observaciones,
	c.id_alterno,
	c.id_tipo_negocio,
	c.id_clasificacion_negocio,
	isnull(e.calidad_servicio,4)		as id_calidad,
	e.firma,
	f.foto,
	g.id_personal				as id_tecnico
from	tbl_numeros_serie 	a 	inner join
	tbl_visitas 		b 	on 
	    a.codigo_visita=b.codigo 	inner join
	tbl_negocios 		c 	on 
	    b.id_negocio=c.id_negocio 	inner join
	tbl_detalle_ingresos 	d 	on 
	    d.id_serie=a.numero_serie 	left join
	tbl_firmas 		e 	on 
	    e.codigo_visita=b.codigo  	left join
	tbl_fotos 		f 	on 
	    f.numero_serie=a.numero_serie inner join
	tbl_personal		g	on
	   g.id_alterno=b.usuario
where	b.visitado=1 and a.actualizada_orden=0
order by codigo desc






GO
/****** Object:  StoredProcedure [dbo].[pav_nuevos_activos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[pav_nuevos_activos] AS
set dateformat dmy
select	b.id_negocio,
	cast(a.numero_serie as char(20)) as id_serie,
	cast(a.numero_referencia as char(20)) as id_sio,
	c.id_ubicacion,
	b.codigo,
	b.nombre,
	b.direccion,
	b.contacto,
	CASE WHEN b.anio=0 then getdate() else
	cast (
		cast(b.dia as char(2))+'-'+
		rtrim(cast(b.mes as char(2)))+'-'+
		cast(b.anio as char(4))+' '+
		cast(b.hora as char(2))+':'+
		cast(b.minuto as char(2)) 
	as datetime) END as fecha,
	b.comentarios,
	b.usuario,
	c.id_alterno,
	c.nit,
	c.id_tipo_negocio,
	c.id_clasificacion_negocio,
	b.id_tecnico
from	tbl_numeros_serie a inner join
	tbl_visitas b on a.codigo_visita=b.codigo inner join
	tbl_negocios c on b.id_negocio=c.id_negocio left join
	tbl_detalle_ingresos d on d.id_serie=a.numero_serie
where	b.visitado=1 and a.actualizado=0 and
	d.id_serie is null
order by codigo desc







GO
/****** Object:  StoredProcedure [dbo].[pav_nuevos_negocios]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pav_nuevos_negocios] AS
set dateformat dmy
select	a.codigo,
	a.nombre,
	a.direccion,
	a.contacto,
	a.visitado,
	case when a.anio=0 then getdate() else cast (
		cast(a.dia as char(2))+'-'+
		rtrim(cast(a.mes as char(2)))+'-'+
		cast(a.anio as char(4))+' '+
		cast(a.hora as char(2))+':'+
		cast(a.minuto as char(2)) 
	as datetime) end as fecha,
	a.anio,
	a.mes,
	a.dia,
	a.hora,
	a.minuto,
	a.comentarios,
	a.usuario,
	' ' as id_alterno,
	' ' as nit,
	0 as id_tipo_negocio,
	' ' as tiponegocio,
	' ' as id_ubicacion,
	' ' as nomubicacion,
	0 as id_clasificacion_negocio,
	' ' as clasificacion,
	a.id_tecnico
from	tbl_visitas a
where	negocios_actualizados=0 and
	id_negocio=0 and visitado=1
order by codigo desc


GO
/****** Object:  StoredProcedure [dbo].[pav_visitas]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[pav_visitas] AS
set dateformat dmy
select	a.id_negocio,
	a.visitado,
	CASE WHEN a.anio=0 THEN getdate() ELSE cast (
		cast(a.dia as char(2))+'-'+
		rtrim(cast(a.mes as char(2)))+'-'+
		cast(a.anio as char(4))+' '+
		cast(a.hora as char(2))+':'+
		cast(a.minuto as char(2)) 
	as datetime) END as fecha,
	a.anio,
	a.mes,
	a.dia,
	a.hora,
	a.minuto,
	a.comentarios,
	b.id_alterno,
	b.id_ubicacion,
	(case when a.usuario='NUEVO' then 0 else cast(a.usuario as int) end
	) as usuario,
	a.codigo,
	a.id_tecnico
from	tbl_visitas a inner join
	tbl_negocios b on a.id_negocio=b.id_negocio
where	a.visitas_actualizadas=0 and
	a.visitado=1
order by a.anio,a.mes,a.dia,a.hora,a.minuto,a.id_negocio








GO
/****** Object:  StoredProcedure [dbo].[SacSeriesWebService]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[SacSeriesWebService]
as
select	a.id_serie AS SERIE,
	a.ID_ACTIVO as ACTIVO,
	ISNULL(A.ID_FICHA, ' ') as FICHA,
	B.DESCRIPCION AS MODELO,
	B.LINEA AS LINEA
 from tbl_ACTIVOS a inner join
	tbl_MODELOS b on
	a.id_MODELO = b.id_MODELO where a.id_negocio in ('47223','73600','47233','47215','47231','55269','55830','68090','80247')
GO
/****** Object:  StoredProcedure [dbo].[sp_jerarquia]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_jerarquia] @IdUbicacion int
as begin
	
	SET NOCOUNT ON
	create table #rutas
	(
		id_ubicacion int,
		descripcion char(50)
	) 

	declare @IdUbicacionTemp int
	declare @IdUbicacionPadre int
	declare @descripcion char(50)

	Select @IdUbicacionTemp = @IdUbicacion

	while exists( select * from tbl_ubicaciones where id_ubicacion = @IdUbicacionTemp)
	begin
		select 	@IdUbicacionPadre = id_ubicacion, @IdUbicacionTemp = id_ubicacion_maestra, @Descripcion = descripcion 
			from tbl_ubicaciones
				where id_ubicacion = @IdUbicacionTemp

		insert into #rutas(id_ubicacion, descripcion) values (@IdUbicacionPadre, @Descripcion)
	end

	SET NOCOUNT OFF
	select * from #rutas
end



GO
/****** Object:  StoredProcedure [dbo].[sp_reorganizar_nuevos]    Script Date: 12/11/2022 18:32:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




/* Reasigna codigos validos a los visitas nuevas (visitas creadas en campo) */
CREATE procedure [dbo].[sp_reorganizar_nuevos]
as begin
	set nocount on

	declare @CodigoNuevo int
	declare @CodigoViejo int

	declare cr_nuevos cursor fast_forward for
		select codigo from tbl_visitas where codigo between -999 and 0
	
	open cr_nuevos 

	fetch next from cr_nuevos into @CodigoViejo

	while @@fetch_status = 0
	begin
		/* Obtener el proximo correlativo de visita nueva e */
		/* incrementar en uno el correlativo		    */
		select @CodigoNuevo = correlativo 
			from tbl_numeracion 
				where id_numeracion = 1
		
		update tbl_numeracion set correlativo = @CodigoNuevo - 1
			where id_numeracion = 1
					
		/* Actualizar Visita */			
		update tbl_visitas set codigo = @CodigoNuevo
			where codigo = @CodigoViejo

		/* Actualizar Firmas */
		update tbl_firmas set codigo_visita = @CodigoNuevo
			where codigo_visita = @CodigoViejo

		/* Actualizar Numeros de Serie*/
		update tbl_numeros_serie set codigo_visita = @CodigoNuevo
			where codigo_visita = @CodigoViejo
	
		/* Actualizar Tiempos */
		update tbl_tiempos set codigo_visita = @CodigoNuevo
			where codigo_visita = @CodigoViejo

		/* Actualizar Acciones de Correctivo */
		update tbl_acciones_correctivo set codigo_visita = @CodigoNuevo
			where codigo_visita = @CodigoViejo

		fetch next from cr_nuevos into @CodigoViejo
	end
	
	close cr_nuevos
	
	deallocate cr_nuevos

	set nocount off
	
end





GO
USE [master]
GO
ALTER DATABASE [db_sac] SET  READ_WRITE 
GO
