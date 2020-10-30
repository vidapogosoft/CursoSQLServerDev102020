

--Combinaciones internas
--inner join
-- registros identicos

--Combinaciones externas

--outer join
---nos permite seleccionar algunas fila de la tabla aunque estas no tengan correspondencia con las filas de la otra tabla

--- from tabla 1 left/right/full outer(opcional) join tabla 2  on condiciones

--left join

--Factura
--FacturaDetalle

Select * from musicallyapp.dbo.Factura where IdFactura = 2329 
Select * from musicallyapp.dbo.FacturaDetalle where IdFactura = 2329

--delete from musicallyapp.dbo.FacturaDetalle where IdFactura = 2329

select a.IdFactura, b.IdFactura  ,* from  musicallyapp.dbo.Factura a
left join musicallyapp.dbo.FacturaDetalle b on a.IdFactura = b.IdFactura
where b.IdFactura is null


---right join  
-- obtiene todas las filas de la tabal de la drecha qunque no tengan correspondencia en la tabal de la izqueirda

Select * from musicallyapp.dbo.Factura where IdFactura = 2338
Select * from musicallyapp.dbo.FacturaDetalle where IdFactura = 2338

--delete from musicallyapp.dbo.Factura where IdFactura = 2338

select a.IdFactura, b.IdFactura  ,* from  musicallyapp.dbo.Factura a
right join musicallyapp.dbo.FacturaDetalle b on a.IdFactura = b.IdFactura
where a.IdFactura is null

---FULL Join
select a.IdFactura, b.IdFactura  ,* from  musicallyapp.dbo.Factura a
full join musicallyapp.dbo.FacturaDetalle b on a.IdFactura = b.IdFactura


--Cross Join

select * from musicallyapp..GEN_PERSONA where CEDULA = '0201457561'
select * from musicallyapp..GEN_ESTADO_CIVIL

select * from musicallyapp..GEN_PERSONA a
cross join musicallyapp..GEN_ESTADO_CIVIL b
where a.CEDULA = '0201457561'


--A  B
--1	X
--2   Z

--1X
--1Z
--2X
--2Z


-----IN   --NOT IN
---EXIST  --NOT EXIST

select * from musicallyapp..INV_PRODUCTO
select * from musicallyapp..FacturaDetalle

select * from musicallyapp..INV_PRODUCTO a
where a.CODIGO in (select b.CodigoInterno from FacturaDetalle b)

select * from musicallyapp..INV_PRODUCTO a
where a.CODIGO not in (select b.CodigoInterno from FacturaDetalle b)

select * from musicallyapp..INV_PRODUCTO a
where exists (select 1 from FacturaDetalle b where b.CodigoInterno = a.CODIGO)

select * from musicallyapp..INV_PRODUCTO a
where not exists (select 1 from FacturaDetalle b where b.CodigoInterno = a.CODIGO)


---- puede objetos en el catalago de objetos del motor de la base de datos

select * from  sys.objects

USE musicallyapp
go

if not exists (select * from  sys.objects where name = 'GEN_PERSONAS_BORRADAS' and type = 'U')
begin
Create table GEN_PERSONAS_BORRADAS
(
	SECUENCIAL INT IDENTITY(1,1) PRIMARY KEY,
	ID_PERSONA INT,
	CEDULA VARCHAR(15),
	FECHA_BORRADO DATETIME
)
end

if exists (select * from  sys.objects where name = 'GEN_PERSONAS_BORRADAS' and type = 'U')
begin
	print 'alter table'
end


