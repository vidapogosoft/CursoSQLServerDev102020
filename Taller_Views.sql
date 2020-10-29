
select * from AppTienda..Locales
select * from AppTienda..Productos
select * from AppTienda..ProductosXLocales


select * from AppTienda..ProductosXLocales where IdLocal = 1 and IdProducto = 10

Select Locales.NombreLocal, Productos.NombreProducto from ProductosXLocales 
inner join Locales on Locales.IdLocal = ProductosXLocales.IdLocal
inner join Productos on Productos.IdProducto = ProductosXLocales.IdProducto
go



select * from VistaproductosXLocal


use AppTienda
go

Create view VistaproductosXLocal
as
Select Locales.NombreLocal, Productos.NombreProducto from ProductosXLocales 
inner join Locales on Locales.IdLocal = ProductosXLocales.IdLocal
inner join Productos on Productos.IdProducto = ProductosXLocales.IdProducto
go


use musicallyapp
go

select Identificacion, Cliente, f.Email ,NumeroComprobante from VistaFacturas vwf
inner join Factura f on f.NumeroFactura = vwf.NumeroComprobante
where AnioAutorizacion = 2019

go


---VIEW - Vistas
use musicallyapp
go

Create view VistaFacturas
as
select
comprobante.ClienteIdentificacion as Identificacion,
comprobante.ClienteNombre as Cliente,
SUBSTRING(comprobante.NumeroFactura,1,3) as Establecimiento,
SUBSTRING(comprobante.NumeroFactura,5,3) as PuntoEmision,
SUBSTRING(comprobante.NumeroFactura,9,len(comprobante.NumeroFactura)) as SecuencialComprobante,
CONVERT(date,comprobante.FechaAutorizacion) as FechaAutorizacion,
YEAR(comprobante.FechaAutorizacion) as AnioAutorizacion,
Month(comprobante.FechaAutorizacion) as MesAutorizacion,
comprobante.NumeroFactura as NumeroComprobante,
'VENTAS' as TipoComprobante
from musicallyapp..ComprobanteFactura comprobante
inner join musicallyapp..Factura factura on factura.NumeroFactura = comprobante.NumeroFactura 

go