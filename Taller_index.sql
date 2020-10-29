USE [AppTienda]
GO

/****** Object:  Index [TestIndex1]    Script Date: 28/10/2020 21:07:54 ******/
CREATE NONCLUSTERED INDEX [TestIndex1] ON [dbo].[ProductosXLocales]
(
	[IdLocal] ASC,
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


