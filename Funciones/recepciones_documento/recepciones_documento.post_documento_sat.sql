/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 abril 2023
 Modificado: 14 abril 2023
 Descripción: función que ingresa información a la tabla sat
 Dependencias: recepciones_documento.tbl_det_documento_recepcion_sat
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.post_documento_sat(integer, integer, integer, integer, integer, character varying, numeric, timestamp without time zone, integer, character varying, integer, integer, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.post_documento_sat(integer, integer, integer, integer, integer, character varying, numeric, timestamp without time zone, integer, character varying, integer, integer, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.post_documento_sat(
	int_id_cat_documento_tipo integer,
	int_id_cat_documento_estado integer,
	int_id_cat_empresa integer,
	int_dte integer,
	int_nit integer,
	str_proveedor character varying,
	numeric_monto numeric,
	date_fecha_emision timestamp without time zone,
	int_id_cat_moneda integer,
	str_descripcion character varying,
	int_id_cat_pais integer,
	int_estado_anulado integer,
	int_id_creador integer)
    RETURNS TABLE(id_documento_sat integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	INSERT INTO recepciones_documento.tbl_det_documento_recepcion_sat(
		id_cat_documento_tipo, 
		id_cat_documento_estado,
		id_cat_empresa,
		dte,
		nit,
		proveedor,
		monto,
		fecha_emision,
		id_cat_moneda,
		descripcion,
		id_cat_pais,
		estado_anulado,
		creado_por,
		actualizado_por,
		fecha_creacion,
		fecha_actualizacion,
		estado
	)
	VALUES (
		int_id_cat_documento_tipo, -- idDetDocumentoRecepcionSolicitud
		int_id_cat_documento_estado, -- idCatDocumentoEstado
		int_id_cat_empresa, -- idCatEmpresa
		int_dte, -- dte
		int_nit, -- nit
		str_proveedor, -- proveedor
		numeric_monto, -- monto
		date_fecha_emision, -- fecha
		int_id_cat_moneda, -- idCatMoneda
		str_descripcion, -- descripcion
		int_id_cat_pais, -- idCatPais
		int_estado_anulado, -- idDetDocumentoAnticipo
		int_id_creador, -- creadoPor
		int_id_creador, -- actualizadoPor
		now(), -- fechaCreacion 
		now(), -- fechaActualizacion
		1 -- estado
	) RETURNING recepciones_documento.tbl_det_documento_recepcion_sat.id_det_documento_recepcion_sat;

END;
$BODY$;

ALTER FUNCTION recepciones_documento.post_documento_sat(integer, integer, integer, integer, integer, character varying, numeric, timestamp without time zone, integer, character varying, integer, integer, integer)
    OWNER TO vince;
