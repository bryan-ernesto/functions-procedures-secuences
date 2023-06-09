/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 abril 2023
 Modificado: 14 abril 2023
 Descripción: función que registra el detalle de una solicitud
 Dependencias: recepciones_documento.tbl_det_documento_recepcion_solicitud_detalle
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.post_documento_solicituddetalle(integer, integer, bigint, character varying, integer, numeric, date, integer, character varying, integer, integer, integer, integer, integer, integer, integer, character varying, character varying, character varying, character varying, character varying)

-- DROP FUNCTION IF EXISTS recepciones_documento.post_documento_solicituddetalle(integer, integer, bigint, character varying, integer, numeric, date, integer, character varying, integer, integer, integer, integer, integer, integer, integer, character varying, character varying, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION recepciones_documento.post_documento_solicituddetalle(
	int_id_det_documento_recepcion_solicitud integer,
	int_id_cat_documento_estado integer,
	int_dte bigint,
	str_proveedor character varying,
	int_nit integer,
	numeric_monto numeric,
	date_fecha date,
	int_id_cat_moneda integer,
	str_descripcion character varying,
	int_id_cat_pais integer,
	int_id_det_documento_anticipo integer,
	int_id_creador integer,
	int_adjunto_id_sharepoint integer,
	int_cantidad integer,
	int_cuenta_contable_sugerida integer,
	int_centro_costo integer,
	str_nombre_centro_costo character varying,
	str_nombre_cuenta_sugerida character varying,
	int_codigo_proveedor character varying,
	str_nombre_proveedor character varying,
	str_comentario character varying)
    RETURNS TABLE(id_documento_solicitud integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	INSERT INTO recepciones_documento.tbl_det_documento_recepcion_solicitud_detalle(
		id_det_documento_recepcion_solicitud, 
		id_cat_documento_estado,
		dte,
		proveedor,
		nit,
		monto,
		fecha,
		id_cat_moneda,
		descripcion,
		id_cat_pais,
		id_det_documento_anticipo,
		estado,
		creado_por,
		actualizado_por,
		fecha_creacion,
		fecha_actualizacion,
		adjunto_id_sharepoint,
		cantidad,
		cuenta_contable_sugerida,
		centro_costo,
		nombre_centro_costo,
		nombre_cuenta_sugerida,
		codigo_proveedor,
		nombre_proveedor,
		comentario
	)
	VALUES (
		int_id_det_documento_recepcion_solicitud, -- idDetDocumentoRecepcionSolicitud
		int_id_cat_documento_estado, -- idCatDocumentoEstado
		cast (int_dte AS bigint), -- dte
		str_proveedor, -- proveedor
		int_nit, -- nit
		numeric_monto, -- monto
		date_fecha, -- fecha
		int_id_cat_moneda, -- idCatMoneda
		str_descripcion, -- descripcion
		int_id_cat_pais, -- idCatPais
		int_id_det_documento_anticipo, -- idDetDocumentoAnticipo
		1, -- estado
		int_id_creador, -- creadoPor
		int_id_creador, -- actualizadoPor
		now(), -- fechaCreacion 
		now(), -- fechaActualizacion
		int_adjunto_id_sharepoint, -- idSharepoint
		int_cantidad,
		int_cuenta_contable_sugerida,
		int_centro_costo,
		str_nombre_centro_costo,
		str_nombre_cuenta_sugerida,
		int_codigo_proveedor,
		str_nombre_proveedor,
		str_comentario
	) RETURNING recepciones_documento.tbl_det_documento_recepcion_solicitud_detalle.id_det_documento_recepcion_solicitud_detalle;

END;
$BODY$;

ALTER FUNCTION recepciones_documento.post_documento_solicituddetalle(integer, integer, bigint, character varying, integer, numeric, date, integer, character varying, integer, integer, integer, integer, integer, integer, integer, character varying, character varying, character varying, character varying, character varying)
    OWNER TO vince;
