use musicallyapp
go


Create Trigger InsPersonas
on GEN_PERSONA
for update
as
begin
	
	--inserted  = update (actualizacion) - insert (registro)
	--deleted = borrar

	declare @cedulainserted varchar(13)

	select @cedulainserted = CEDULA from inserted

	update GEN_PERSONA
	set FECHA_ACT = GETDATE(), USUARIO_ACT = 'VPR'
	where CEDULA = @cedulainserted

end