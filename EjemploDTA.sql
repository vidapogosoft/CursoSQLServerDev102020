
select	convert(date, comprobante.FechaEmision) FechaEmisionRetencion, 
			substring(comprobante.NumeroComprobanteRetencion,1,3) Establecimiento,
			substring(comprobante.NumeroComprobanteRetencion,5,3) PuntoEmision,
			substring(comprobante.NumeroComprobanteRetencion,9,len(comprobante.NumeroComprobanteRetencion)) NumeroComprobanteRetencion,
			--comprobante.NumeroComprobanteRetencion,  
			comprobante.NumeroAutorizacion, 
			comprobante.ClienteNombre, 
			comprobante.ClienteIdentificacion,
			cp.NumeroDocumento,
			cp.SubTotal,
			cp.TotalIva,
			cp.TotalIce,
			cp.OtrosValores,
			r.BaseImponible, 
			case when r.Codigo=2 then 'IVA'else'RENTA'end AS TipoImpuesto,
			r.Valor,
			im.Descripcion Codigoretencion,
			cp.FechaEmision FechaEmisionComprobanteRetenido,
			--cp.NumeroDocumento ComprobanteRetenido,
			substring(replace(cp.NumeroDocumento,'-',''),1,15)+replicate('0',15-len(replace(cp.NumeroDocumento,'-',''))) ComprobanteRetenido,
			substring(replace(cp.NumeroDocumento,'-',''),7,15)+replicate('0',15-len(replace(cp.NumeroDocumento,'-',''))) NumeroDocumentoRetenido,
			substring(cp.NumeroDocumento, 1, 3) EstablecimientoRetenido,
			substring(replace(cp.NumeroDocumento,'-',''),4,3) PuntoEmisionRetenido,
			cp.Autorizacion Autorizacion,
			cd.Descripcion TipoComprobanteRetenido,
			cp.Concepto
	from Bd_Gtisys..ComprobanteComprobanteRetencion comprobante
	join Bd_Gtisys..CuentasXPagar cp on comprobante.IdCuentasXPagar= cp.IdCuentasXPagar and comprobante.IdEmpresa= cp.IdEmpresa
	join Bd_Gtisys..CuentasXPagarRetencion r on cp.IdCuentasXPagar = r.IdCuentasXPagar
	join Bd_Gtisys..CatalogoDetalle cd on cd.IdCatalogoDetalle = cp.TipoDocumento
	join Bd_Gtisys..Impuestos im on im.CodigoImpuesto = r.CodigoRetencion
	where cp.Estado = 'ACTI' 
	and cd.IdCatalogo = 'TICOM'  and im.TipoImpuesto = 'RIVA'
	and DATEPART(YEAR, comprobante.FechaEmision) = 2019
	and  DATEPART(MONTH, comprobante.FechaEmision) = 11
	and cp.UsuarioCreacion not in ('sinergiass')
	
	union all
	
	select	convert(date, comprobante.FechaEmision) FechaEmisionRetencion, 
			substring(comprobante.NumeroComprobanteRetencion,1,3) Establecimiento,
			substring(comprobante.NumeroComprobanteRetencion,5,3) PuntoEmision,
			substring(comprobante.NumeroComprobanteRetencion,9,len(comprobante.NumeroComprobanteRetencion)) NumeroComprobanteRetencion,
			--comprobante.NumeroComprobanteRetencion, 
			comprobante.NumeroAutorizacion, 
			comprobante.ClienteNombre, 
			comprobante.ClienteIdentificacion,
			cp.NumeroDocumento,
			cp.SubTotal,
			cp.TotalIva,
			cp.TotalIce,
			cp.OtrosValores,
			r.BaseImponible, 
			case when r.Codigo=2 then 'IVA'else'RENTA'end AS TipoImpuesto,
			r.Valor,
			im.Descripcion Codigoretencion,
			cp.FechaEmision FechaEmisionComprobanteRetenido,
			--cp.NumeroDocumento ComprobanteRetenido,
			substring(replace(cp.NumeroDocumento,'-',''),1,15)+replicate('0',15-len(replace(cp.NumeroDocumento,'-',''))) ComprobanteRetenido,
			substring(replace(cp.NumeroDocumento,'-',''),7,15)+replicate('0',15-len(replace(cp.NumeroDocumento,'-',''))) NumeroDocumentoRetenido,
			substring(cp.NumeroDocumento, 1, 3) EstablecimientoRetenido,
			substring(replace(cp.NumeroDocumento,'-',''),4,3) PuntoEmisionRetenido,
			cp.Autorizacion Autorizacion,
			cd.Descripcion TipoComprobanteRetenido,
			cp.Concepto
	from Bd_Gtisys..ComprobanteComprobanteRetencion comprobante
	join Bd_Gtisys..CuentasXPagar cp on comprobante.IdCuentasXPagar= cp.IdCuentasXPagar and comprobante.IdEmpresa= cp.IdEmpresa
	join Bd_Gtisys..CuentasXPagarRetencion r on cp.IdCuentasXPagar = r.IdCuentasXPagar
	join Bd_Gtisys..CatalogoDetalle cd on cd.IdCatalogoDetalle = cp.TipoDocumento
	join Bd_Gtisys..Impuestos im on im.CodigoImpuesto = r.CodigoRetencion
	where cp.Estado = 'ACTI'  
	and cd.IdCatalogo = 'TICOM'  and im.TipoImpuesto = 'RETR'
	and DATEPART(YEAR, comprobante.FechaEmision) = 2019
	and  DATEPART(MONTH, comprobante.FechaEmision) = 11
	and cp.UsuarioCreacion not in ('sinergiass')
	order by NumeroComprobanteRetencion asc
