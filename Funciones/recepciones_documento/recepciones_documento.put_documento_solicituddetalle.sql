/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 abril 2023
 Modificado: 14 abril 2023
 Descripción: función que modificar la información del detalle de una solicitud
 Dependencias: recepciones_documento.tbl_det_documento_recepcion_solicitud_detalle
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.put_documento_solicituddetalle(integer, integer, integer, bigint, character varying, integer, numeric, character varying, integer, character varying, integer, integer, integer, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.put_documento_solicituddetalle(integer, integer, integer, bigint, character varying, integer, numeric, character varying, integer, character varying, integer, integer, integer, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.put_documento_solicituddetalle(
	int_id_det_documento_recepcion_solicitud_detalle integer,
	int_id_det_documento_recepcion_solicitud integer,
	int_id_cat_documento_estado integer,
	int_dte bigint,
	str_proveedor character varying,
	int_nit integer,
	numeric_monto numeric,
	date_fecha character varying,
	int_id_cat_moneda integer,
	str_descripcion character varying,
	int_id_cat_pais integer,
	int_id_det_documento_anticipo integer,
	int_estado integer,
	int_actualizado_por integer,
	int_adjunto_sharepoint integer,
	int_cantidad integer,
	int_cuenta_contable_sugerida integer,
	int_centro_costo integer,
	str_nombre_centro_costo character varying,
	str_nombre_cuenta_sugerida character varying,
	int_codigo_proveedor character varying,
	str_nombre_proveedor character varying,
	str_comentario character varying)
    RETURNS TABLE(id_solicitud_detalle integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	UPDATE recepciones_documento.tbl_det_documento_recepcion_solicitud_detalle
	SET 
		id_det_documento_recepcion_solicitud = CASE WHEN int_id_det_documento_recepcion_solicitud IS NOT NULL THEN int_id_det_documento_recepcion_solicitud ELSE id_det_documento_recepcion_solicitud END,
		id_cat_documento_estado = CASE WHEN int_id_cat_documento_estado IS NOT NULL THEN int_id_cat_documento_estado ELSE id_cat_documento_estado END,
		dte = CASE WHEN int_dte IS NOT NULL THEN int_dte ELSE dte END,
		proveedor = CASE WHEN str_proveedor <> '' THEN str_proveedor ELSE proveedor END,
		nit = CASE WHEN int_nit IS NOT NULL THEN int_nit ELSE nit END,
		monto = CASE WHEN numeric_monto IS NOT NULL THEN numeric_monto ELSE monto END,
		fecha = CASE WHEN date_fecha <> '' THEN date_fecha::date ELSE fecha END,
		id_cat_moneda = CASE WHEN int_id_cat_moneda IS NOT NULL THEN int_id_cat_moneda ELSE id_cat_moneda END,
		descripcion = CASE WHEN str_descripcion <> '' THEN str_descripcion ELSE descripcion END,
		id_cat_pais = CASE WHEN int_id_cat_pais IS NOT NULL THEN int_id_cat_pais ELSE id_cat_pais END,
		id_det_documento_anticipo = CASE WHEN int_id_det_documento_anticipo IS NOT NULL THEN int_id_det_documento_anticipo ELSE id_det_documento_anticipo END,
		estado = CASE WHEN int_estado IS NOT NULL THEN int_estado ELSE estado END,
		actualizado_por = CASE WHEN int_actualizado_por IS NOT NULL THEN int_actualizado_por ELSE actualizado_por END,
		fecha_actualizacion = now(),
		adjunto_id_sharepoint = CASE WHEN int_adjunto_sharepoint IS NOT NULL THEN int_adjunto_sharepoint ELSE adjunto_id_sharepoint END,
		cantidad = CASE WHEN int_cantidad IS NOT NULL THEN int_cantidad ELSE cantidad END,
		cuenta_contable_sugerida = CASE WHEN int_cuenta_contable_sugerida IS NOT NULL THEN int_cuenta_contable_sugerida ELSE cuenta_contable_sugerida END,
		centro_costo = CASE WHEN int_centro_costo IS NOT NULL THEN int_centro_costo ELSE centro_costo END,
		nombre_centro_costo = CASE WHEN str_nombre_centro_costo <> '' THEN str_nombre_centro_costo ELSE nombre_centro_costo END,
		nombre_cuenta_sugerida = CASE WHEN str_nombre_cuenta_sugerida <> '' THEN str_nombre_cuenta_sugerida ELSE nombre_cuenta_sugerida END,
		codigo_proveedor = CASE WHEN int_codigo_proveedor <> '' THEN int_codigo_proveedor ELSE codigo_proveedor END,
		nombre_proveedor = CASE WHEN str_nombre_proveedor <> '' THEN str_nombre_proveedor ELSE nombre_proveedor END,
		comentario = CASE WHEN str_comentario <> '' THEN str_comentario ELSE comentario END
    WHERE id_det_documento_recepcion_solicitud_detalle = int_id_det_documento_recepcion_solicitud_detalle
RETURNING recepciones_documento.tbl_det_documento_recepcion_solicitud_detalle.id_det_documento_recepcion_solicitud_detalle;
END;
$BODY$;


ALTER FUNCTION recepciones_documento.put_documento_solicituddetalle(integer, integer, integer, bigint, character varying, integer, numeric, character varying, integer, character varying, integer, integer, integer, integer)
    OWNER TO vince;
