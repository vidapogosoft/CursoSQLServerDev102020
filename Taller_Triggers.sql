

select * from AppTienda..Locales
select * from AppTienda..Productos
select * from AppTienda..ProductosXLocales

select * from MiTablaDelete

--delete from AppTienda..ProductosXLocales where IdProductoLocales = 6


use AppTienda
go
create trigger DelproductosLocales
on ProductosXLocales
for delete
as
begin
		declare @IdprodLocal int

		---deleted
		---inserted

		select @IdprodLocal = IdProductoLocales from deleted
	
		select * 
		into MiTablaDelete  ---copiado  total de una fuente a otra fuente manetniendo la estructura
		from deleted


end
