
select * from AppTienda..Locales
select * from AppTienda..Productos
select * from AppTienda..ProductosXLocales

exec InsProductosXLocales 1, 141
exec InsProductosXLocales 1, 142
exec InsProductosXLocales 1, 10


---Procedures

use AppTienda
go

alter Procedure InsProductosXLocales
---Parametros de entrada
@IdLocal int,
@idproducto int
as
begin

    declare @ErrorTexto varchar(max), @ErrorEstado int,  @ErrorSeveridad int

	begin try
		
		if not exists (select 1 from ProductosXLocales where IdLocal = @IdLocal 
						and IdProducto = @idproducto)
		begin
			insert into ProductosXLocales (IdLocal, IdProducto, FechaRegistro, HoraRegistro, Estado, 
			FechaModificacion, UsuarioRegistro)	
			values (@IdLocal, @idproducto, convert(date,GETDATE()), convert(time,GETDATE()), 'A',
					null, @@SERVERNAME)
	    end
		else
		begin
			print 'Registro ya existe en base de datos'
		end

	end try
	begin catch

		select @ErrorTexto = ERROR_MESSAGE()
		Select @ErrorEstado = ERROR_STATE()
		Select @ErrorSeveridad = ERROR_SEVERITY()
		
		RAISERROR (@ErrorTexto, @ErrorSeveridad, @ErrorEstado)

	end catch

end