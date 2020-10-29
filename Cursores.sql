---CURSORES
---uso de memoria RAM
---DATOS EN BUCLES
---CONTROVERSIA DEL RENDEMIENTO

---Pasos en consideracion para trabajar con cursores

--declarar el cursor, a traves de DECLARE
--abrir
--lee los datos del cursor (bucle -- fetch)
--cerrar el cursor
--liberar el cursor (liberar recursor tomados)

/*
DECLARE[NOMBRE CURSOR]CURSOR[ LOCAL | GLOBAL ] [ FORWARD_ONLY | SCROLL ] FOR [SENTENCIA DE SQL (SELECT)] 
-- Apertura del cursor 
OPEN[NOMBRE CURSOR]  
-- Lectura de la primera fila del cursor 
FETCH[NOMBRE CURSOR]INTO[LISTA DE VARIABLES DECLARADAS] 
WHILE(@@FETCH_STATUS= 0) 
BEGIN 
-- Lectura de la siguiente fila de un cursor 
FETCH[NOMBRE CURSOR]INTO[LISTA DE VARIABLES DECLARADAS] ... 
-- Fin del bucle WHILE 
END 
-- Cierra el cursor 
CLOSE[NOMBRE CURSOR] 
-- Libera los recursos del cursor 
DEALLOCATE[NOMBRE CURSOR]
*/


use musicallyapp
go

declare @IdCliente int, @NombreCliente varchar(max)

declare cursor_ejemplo cursor fast_forward for
-- instruccion de toma de datos

	select top 10 IdCliente, NombreCliente from Clientes

	open cursor_ejemplo

		fetch next from cursor_ejemplo into @IdCliente, @NombreCliente

		while (@@FETCH_STATUS = 0)
		begin

		---Procesos a transaccionar
		--simple codigo transact
		---llamar funciones
		---llamar procedures

			select convert(varchar,  @IdCliente) + '-' + @NombreCliente

			fetch next from cursor_ejemplo into @IdCliente, @NombreCliente
		end
     close cursor_ejemplo
deallocate cursor_ejemplo


