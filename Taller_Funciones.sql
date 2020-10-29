
---Funciones definidas por el usuario

--Funciones Escalares
--Funciones con valores de tabla en linea
--Funciones con valores de tabla y multiples instruciones


--Funciones Escalares
---Reciben parametro de entrada, procesar y retornar 1 valor con un tipo de datos
use musicallyapp
go

Create function EdadPersona (@FechaNacimiento date)
returns int
as
begin
	
	declare @EdadActual int

	Select @EdadActual = DATEDIFF(YEAR, @FechaNacimiento, GETDATE())

	return(@EdadActual)

end
go

----Utilizar la funcion escalar

select dbo.EdadPersona('1980-05-11') as Edad
go

select
top 50
NOMBRES_COMPLETO, FECHA_NACIMIENTO,
dbo.EdadPersona(FECHA_NACIMIENTO) as Edad
from GEN_PERSONA
go

--Funciones con valores de tabla en linea
use musicallyapp
go
Create Function PersonaTipoIdentificacion()
returns @Person table
(
	Identificacion varchar(15),
	TipoIdentificacion varchar(30),
	NombresPersona varchar(max)
)
as
begin

	Insert @Person (Identificacion, TipoIdentificacion, NombresPersona)
	select 
	CEDULA,
	case when len(CEDULA) = 13 Then 'RUC'
		when len(CEDULA) = 10 Then 'CED'
		else 'ERR' end as Tipo,
	NOMBRES_COMPLETO
	from GEN_PERSONA

	return
end
GO

---Funcionamiento

select * from PersonaTipoIdentificacion()

select * from PersonaTipoIdentificacion() where TipoIdentificacion = 'ERR'

select * from PersonaTipoIdentificacion() where NombresPersona like 'Z%'

go

------Funciones con valores de tabla en linea y multiple instrucciones
use musicallyapp
go
Alter function SaldoCtaXPagar(@Anio int, @Saldo decimal(18,2))
returns table
as
return
(
	select IdCuentasXPagar Numero,
	FechaEmision, Total, Saldo, GETDATE() as FechaActual
	from CuentasXPagar
	where YEAR(FechaEmision) = @Anio
	and Saldo >=  @Saldo
)
go

---Funcionamiento

Select * from dbo.SaldoCtaXPagar(2019,100)
