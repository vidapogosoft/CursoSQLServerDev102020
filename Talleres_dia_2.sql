

-----Extracciones de datos

---Base destino
select * from AppTienda..Productos

---Base origen
select * from musicallyapp..INV_PRODUCTO

---Elabora la sleeccion de campos
---aplicando exists, not exists
insert into AppTienda..Productos (NombreProducto, FechaRegistro, HoraRegistro, Estado, 
								 FechaModificacion, UsuarioRegistro)	
select 
NOMBRE, CONVERT(date, FECHA_ING) as FechaRegistro, CONVERT(time, FECHA_ING) as HoraRegistro,
CASE when ESTADO = 1 then  'A'
		else 'I' end as Estado
, NULL FechaModificacion , 'EXT' UsuarioRegistro
from musicallyapp..INV_PRODUCTO --dominio origen
where not exists ( select 1 from AppTienda..Productos 
					where NombreProducto = NOMBRE) --verifico en el dominio destino


select * from musicallyapp..Clientes where len(IdentificacionCliente) = 13

select * from AppTienda..Locales

insert into AppTienda..Locales (NombreLocal, FechaRegistro, HoraRegistro, UsuarioRegistro, 
								FechaModificacion, IdTipoNegocio)
select NombreCliente, CONVERT(date, GETDATE()), CONVERT(Time, GETDATE())
, 'EXT', GETDATE(), 1
from musicallyapp..Clientes where len(IdentificacionCliente) = 13
and NombreCliente not in (select NombreLocal from AppTienda..Locales where NombreLocal = NombreCliente )


---CONCAT
---SPACE
---COUNT
---group by

select * from AppTienda..Locales

select * from AppTienda..Locales where NombreLocal not in ('VPR')

select * from AppTienda..Locales where IdLocal not in (8)


select convert(varchar,IdLocal)+ ' ' + NombreLocal from AppTienda..Locales

select CONCAT(convert(varchar,IdLocal), space(1), '-', SPACE(1) ,NombreLocal) from AppTienda..Locales

select distinct NombreLocal from AppTienda..Locales

select NombreLocal from AppTienda..Locales
group by NombreLocal


---Combinaciones internas
----inner join
----registros que sean identicos

select a.NombreLocal, b.TipoNegocio from AppTienda..Locales a 
inner join AppTienda..TipoLocal b on b.IdTipoNegocio = a .IdTipoNegocio

---Count
---sum
---AVG

select b.TipoNegocio, count(*) from AppTienda..Locales a 
inner join AppTienda..TipoLocal b on b.IdTipoNegocio = a .IdTipoNegocio
group by b.TipoNegocio

select b.TipoNegocio, a.FechaRegistro,  count(*) from AppTienda..Locales a 
inner join AppTienda..TipoLocal b on b.IdTipoNegocio = a .IdTipoNegocio
group by b.TipoNegocio, a.FechaRegistro

select b.TipoNegocio, YEAR(a.FechaRegistro),  count(*) from AppTienda..Locales a 
inner join AppTienda..TipoLocal b on b.IdTipoNegocio = a .IdTipoNegocio
group by b.TipoNegocio, YEAR(a.FechaRegistro)

select YEAR(FechaRegistro),  count(*)  from AppTienda..Productos
group by YEAR(FechaRegistro)


select YEAR(FechaRegistro) as Anio, Month(FechaRegistro) as Mes, count(*) cuenta  from AppTienda..Productos
group by YEAR(FechaRegistro), Month(FechaRegistro)
order by YEAR(FechaRegistro), Month(FechaRegistro)

/*
select 
NOMBRE, CONVERT(date, FECHA_ING), CONVERT(time, FECHA_ING)
'A', NULL, 'EXT'
from musicallyapp..INV_PRODUCTO WHERE ESTADO  = 1
*/


----Tablas temporales
--tablas que se explotan en memoria @

declare @MiTablaTemporalMemoria table
(
	NombreLocal varchar(300)
)

insert into @MiTablaTemporalMemoria (NombreLocal)
select NombreLocal from AppTienda..Locales
group by NombreLocal

delete from @MiTablaTemporalMemoria where NombreLocal like '%VPR%'

select * from @MiTablaTemporalMemoria 

---tabla temporal fisica
create table #MiTablaTemporalFisica
(
	NombreLocal varchar(300)
)


insert into #MiTablaTemporalFisica (NombreLocal)
select NombreLocal from AppTienda..Locales
group by NombreLocal


delete from #MiTablaTemporalFisica where NombreLocal like '%VPR%'

select * from #MiTablaTemporalFisica

---Tabla temporal Global
--Tabla Fisica en tempdb

create table ##MiTablaGlobalFisica
(
	NombreLocal varchar(300)
)


insert into ##MiTablaGlobalFisica (NombreLocal)
select NombreLocal from AppTienda..Locales
group by NombreLocal


delete from ##MiTablaGlobalFisica where NombreLocal like '%VPR%'

select * from ##MiTablaGlobalFisica
