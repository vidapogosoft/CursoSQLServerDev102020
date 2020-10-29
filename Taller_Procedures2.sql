---Procedures
use musicallyapp
go

Create procedure InsBandas
--Parametros de entrada
--NombreBanda
--NombreDisco

@NombreBanda varchar(100),
@NombreDisco varchar(100),
@IdCategoria int,
@Usuario varchar(15)
as
begin

	declare @IdBanda int, @IdDisco int 
	DECLARE @ErrorMensaje varchar(max),  @ErrorEstado int,  @ErrorSeveridad int

	begin try
	
		begin transaction bnd
			
					insert into Banda(Nombre, FechaRegistro, HoraRegistro, UsuarioRegistro)
					values(@NombreBanda, GETDATE(), GETDATE(), @Usuario)
	
					select @IdBanda = @@IDENTITY

					insert into Discos(Descripcion, IdCategoria)
					values(@NombreDisco, @IdCategoria)

					select @IdDisco = @@IDENTITY
	
					insert into DiscosPorBanda(IdBanda, IdDisco, FechaRegistro, HoraRegistro, UsuarioRegistro)
					values(@IdBanda, @IdDisco, GETDATE(), GETDATE(), @Usuario )

		if (XACT_STATE()) = 1
			commit transaction bnd


	end try
	begin catch
		
		select @ErrorMensaje = ERROR_MESSAGE()
		Select @ErrorEstado = ERROR_STATE()
		Select @ErrorSeveridad = ERROR_SEVERITY()
		
		if (XACT_STATE()) = -1
			rollback transaction bnd


		RAISERROR (@ErrorMensaje, @ErrorSeveridad, @ErrorEstado)

	end catch

end