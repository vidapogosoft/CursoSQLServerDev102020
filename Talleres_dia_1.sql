
----Create => Creaciones
----Alter => Modificar
----Drop => Remover

use master
go

--Create database mibase
--drop database mibase

--Archivo Primario: .mdf
--Archivo Secundario: .ndf
--Archivo Log: .ldf

Create database AppTienda
on
(
	name = 	AppTienda_data,
	filename = 'E:\SQLDATA16\AppTiendadata.mdf',
	size = 100,
	maxsize = 1024,
	filegrowth = 100
)
log on
(
	name = AppTienda_log,
	filename = 'E:\SQLDATA16\AppTiendalog.ldf',
	size = 100,
	maxsize = 1024,
	filegrowth = 100
)

----archivos secundarios de base de datos

alter database AppTienda add filegroup AppTienda_data_2

alter database AppTienda
add file(
	
	name = AppTiendadata,
	filename = 'E:\SQLDATA16\AppTiendadata2.ndf',
	size = 200,
	maxsize = 2048,
	filegrowth = 300
)to filegroup AppTienda_data_2


--- toda tabla debe contar con su primary key
--- toda tabla debe estar bien relacionada
--- acostumbrar a que los PK identity
--- identificar en que filegroup

use AppTienda
go

create table Locales
(
	IdLocal int identity(1,1),
	NombreLocal varchar(100) NOT NULL,
	TipoLocal varchar(50) NOT NULL,
	FechaRegistro dateTime,

	constraint PK_IdLocal primary key clustered(IdLocal desc)
)


-----agregar mas campos a la tabla

alter table Locales add HoraRegistro Time
alter table Locales add UsuarioRegistro varchar(15)
alter table Locales add FechaModificacion Date not null default(getdate())

---Anexo clase dia 2
alter table Locales add IdTipoNegocio int

alter table Locales
with check add constraint FK_IdTipoNegocio foreign key (IdTipoNegocio)
references TipoLocal (IdTipoNegocio)


----Selecionando datos de mi tabla

select * from Locales

select getdate()

select * from Productos

select NombreProducto as Productos, FechaRegistro Fecha  from AppTienda..Productos
order by Productos -- aplico oradenamiento por el alias

select NombreProducto as Productos, FechaRegistro Fecha  from AppTienda..Productos
order by NombreProducto -- aplico oradenamiento por el nombre del campo de la tabla


select a.TipoLocal, a.NombreLocal from Locales a

select a.TipoLocal, a.NombreLocal from Locales a
order by a.TipoLocal asc


----Filtrado de datos
select a.TipoLocal, a.NombreLocal from Locales a
where a.TipoLocal like '%tecnolo%'


--------Anexo en el dia 2
--Creamos la tabla para manejar la relacion 1 a M
Create table TipoLocal
(
	IdTipoNegocio int identity(1,1),
	TipoNegocio varchar(100) NOT NULL,
	Estado char(1),

	constraint PK_IdTipoNegocio primary key clustered(IdTipoNegocio)
)

select * from AppTienda..TipoLocal

----DML
----Manipulacion (Insercion)
/*
insert into TipoLocal (TipoNegocio, Estado)
values ('Retail', 'A')
insert into TipoLocal (TipoNegocio, Estado)
values ('Ferreteria', 'A')
insert into TipoLocal (TipoNegocio, Estado)
values ('Tecnologia Hardware', 'A')
insert into TipoLocal (TipoNegocio, Estado)
values ('Tecnologia', 'A')
*/

---Update (Actualizaciones)

select * from AppTienda..Locales
select * from AppTienda..TipoLocal

select * from AppTienda..Locales where IdTipoNegocio = 2
select * from AppTienda..Locales where IdTipoNegocio = 4

update AppTienda..Locales set IdTipoNegocio = 4
where TipoLocal = 'Tecnologia'

update AppTienda..Locales set IdTipoNegocio = 3
where TipoLocal = 'Tecnologia Hardware'

update AppTienda..Locales set IdTipoNegocio = 1
where TipoLocal = 'Retail'

----Integridad Referencial



create table Productos
(
	IdProducto int identity(1,1),
	NombreProducto varchar(100) NOT NULL,
	FechaRegistro date not null default(getdate()),
	HoraRegistro Time,
	Estado char(1),
	FechaModificacion Date,
	UsuarioRegistro varchar(25)
	
	constraint PK_IdProducto primary key clustered(IdProducto desc)
)

---Normalizacion (Bridge)
--Pk Locales
--Pk Productos

Create Table ProductosXLocales
(
	IdProductoLocales int identity(1,1),
	IdLocal int,
	IdProducto int,
	FechaRegistro date not null default(getdate()),
	HoraRegistro Time,
	Estado char(1),
	FechaModificacion Date,
	UsuarioRegistro varchar(25),

	constraint PK_IdProductoLocales primary key clustered(IdProductoLocales)
)

----Creamos nuestras FK
---con la tabla locales
alter table ProductosXLocales
with check add constraint FK_IdLocal foreign key (IdLocal)
references Locales (IdLocal)

---con la tabla productos
alter table ProductosXLocales
with check add constraint FK_IdProducto foreign key (IdProducto)
references Productos (IdProducto)

