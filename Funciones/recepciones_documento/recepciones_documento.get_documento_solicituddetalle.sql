/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 11 abril 2023
 Modificado: 11 abril 2023
 Descripción: función que permite mostrar la información del detalle de una solicitud, permitiendo filtrar por id_solicitud, dte, proveedor, nit, numeic, moneda, descripción, pais, adjunto sharepoint
 Dependencias: recepciones_documento.tbl_det_documento_estado_asignacion_canal, recepciones_documento.tbl_cat_documento_estado, recepciones_documento.tbl_cat_documento_canal
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.get_documento_solicituddetalle(integer, bigint, character varying, integer, numeric, integer, character varying, integer, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.get_documento_solicituddetalle(integer, bigint, character varying, integer, numeric, integer, character varying, integer, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.get_documento_solicituddetalle(
	int_id_solicitud integer,
	int_dte bigint,
	str_proveedor character varying,
	int_nit integer,
	numeric_monto numeric,
	int_id_moneda integer,
	str_descripcion character varying,
	int_id_pais integer,
	int_id_sharepoint integer,
	int_estado integer,
	int_cantidad integer,
	int_cuenta_contable_sugerida integer,
	int_centro_costo integer,
	str_nombre_cuenta_sugerida character varying,
	str_codigo_proveedor character varying,
	str_nombre_proveedor character varying)
    RETURNS TABLE(id_solicitud_detalle integer, id_solicitud integer, id_estado integer, nombre_estado character varying, dte bigint, proveedor character varying, nit integer, monto numeric, fecha_factura character varying, id_moneda integer, nombre_moneda character varying, descripcion_factura character varying, id_pais integer, nombre_pais character varying, id_anticipo integer, estado integer, creado_por integer, nombre_creado_por character varying, actualizado_por integer, nombre_actualizado_por character varying, fecha_creacion character varying, fecha_actualizacion character varying, id_sharepoint integer, cantidad integer, cuenta_contable_sugerida integer, centro_costo integer, nombre_centro_costo character varying, nombre_cuenta_sugerida character varying, codigo_proveedor character varying, nombre_proveedor character varying, comentario character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
RETURN QUERY
	SELECT 
		TDDRSD.id_det_documento_recepcion_solicitud_detalle AS id_solicitud_detalle,
		TDDRSD.id_det_documento_recepcion_solicitud AS id_solicitud,
		TDDRSD.id_cat_documento_estado AS id_estado,
		TCDE.nombre AS nombre_estado,
		TDDRSD.dte,
		TDDRSD.proveedor AS proveedor,
		TDDRSD.nit,
		TDDRSD.monto,
		to_char(TDDRSD.fecha, 'YYYY-MM-DD HH:MI:SS AM') :: varchar AS fecha_factura,
		TDDRSD.id_cat_moneda AS id_moneda,
		TCM.nombre AS nombre_moneda,
		TDDRSD.descripcion descripcion_factura,
		TDDRSD.id_cat_pais AS id_pais,
		TCP.nombre AS nombre_pais,
		TDDRSD.id_det_documento_anticipo AS id_anticipo,
		TDDRSD.estado,
		TDDRSD.creado_por,
		nombre_creado_por.nombre AS nombre_creado_por,
		TDDRSD.actualizado_por,
		nombre_actualizado_por.nombre AS nombre_actualizado_por,
		to_char(TDDRSD.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar AS fecha_creacion,
		to_char(TDDRSD.fecha_actualizacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar AS fecha_actualizacion,
		TDDRSD.adjunto_id_sharepoint AS id_sharepoint,
		TDDRSD.cantidad,
		TDDRSD.cuenta_contable_sugerida,
		TDDRSD.centro_costo,
		TDDRSD.nombre_centro_costo,
		TDDRSD.nombre_cuenta_sugerida,
		TDDRSD.codigo_proveedor,
		TDDRSD.nombre_proveedor,
		TDDRSD.comentario
	FROM recepciones_documento.tbl_det_documento_recepcion_solicitud_detalle TDDRSD
	LEFT JOIN recepciones_documento.tbl_cat_documento_estado TCDE 
	ON TDDRSD.id_cat_documento_estado = TCDE.id_cat_documento_estado
	LEFT JOIN general.tbl_cat_moneda TCM
	ON TDDRSD.id_cat_moneda = TCM.id_cat_moneda
	LEFT JOIN general.tbl_cat_pais TCP
	ON TDDRSD.id_cat_pais = TCP.id_cat_pais
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TDDRSD.creado_por) nombre_creado_por ON true
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TDDRSD.actualizado_por) nombre_actualizado_por ON true
	WHERE (TDDRSD.id_det_documento_recepcion_solicitud = int_id_solicitud OR int_id_solicitud = 0)
		AND (TDDRSD.dte = int_dte OR int_dte = 0)
		AND (UPPER(TDDRSD.proveedor) LIKE ('%' || UPPER(str_proveedor) || '%') :: VARCHAR OR LENGTH (UPPER (str_proveedor)) = 0)
		AND (TDDRSD.nit = int_nit OR int_nit = 0)
		AND (TDDRSD.monto = numeric_monto OR numeric_monto = 0)
		AND (TDDRSD.id_cat_moneda = int_id_moneda OR int_id_moneda = 0)
		AND (UPPER(TDDRSD.descripcion) LIKE ('%' || UPPER(str_descripcion) || '%') :: VARCHAR OR LENGTH (UPPER(str_descripcion)) = 0)
		AND (TDDRSD.id_cat_pais = int_id_pais OR int_id_pais = 0)
		AND (TDDRSD.adjunto_id_sharepoint = int_id_sharepoint OR int_id_sharepoint = 0)
		AND (TDDRSD.estado = int_estado OR int_estado = 2)
		AND (TDDRSD.cantidad = int_cantidad OR int_cantidad = 0)
		AND (TDDRSD.cuenta_contable_sugerida = int_cuenta_contable_sugerida OR int_cuenta_contable_sugerida = 0)
		AND (TDDRSD.centro_costo = int_centro_costo OR int_centro_costo = 0)
		AND (UPPER(TDDRSD.nombre_cuenta_sugerida) LIKE ('%' || UPPER(str_nombre_cuenta_sugerida) || '%') :: VARCHAR OR LENGTH (UPPER (str_nombre_cuenta_sugerida)) = 0)
		AND (UPPER(TDDRSD.codigo_proveedor) LIKE ('%' || UPPER(str_codigo_proveedor) || '%') :: VARCHAR OR LENGTH (UPPER (str_codigo_proveedor)) = 0)
		AND (UPPER(TDDRSD.nombre_proveedor) LIKE ('%' || UPPER(str_nombre_proveedor) || '%') :: VARCHAR OR LENGTH (UPPER (str_nombre_proveedor)) = 0);
END
$BODY$;

ALTER FUNCTION recepciones_documento.get_documento_solicituddetalle(integer, bigint, character varying, integer, numeric, integer, character varying, integer, integer, integer, integer, integer, integer, character varying, integer, character varying)
    OWNER TO vince;
