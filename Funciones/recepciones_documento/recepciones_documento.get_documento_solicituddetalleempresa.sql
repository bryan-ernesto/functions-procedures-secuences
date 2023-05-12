/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 12 mayo 2023
 Modificado: 12 mayo 2023
 Descripción: función que muestra los detalles de una solicitud filtrando por dte y empresa
 Dependencias: recepciones_documento.tbl_det_documento_recepcion_solicitud_detalle, recepciones_documento.tbl_cat_documento_estado, general.tbl_cat_moneda, general.tbl_cat_pais, recepciones_documento.tbl_det_documento_recepcion_solicitud, usuarios.tbl_cat_empresa
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.get_documento_solicituddetalleempresa(integer, integer, character varying, character varying, integer, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.get_documento_solicituddetalleempresa(integer, integer, character varying, character varying, integer, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.get_documento_solicituddetalleempresa(
	int_id_solicitud integer,
	int_id_empresa integer,
	int_dte character varying,
	str_nombre_empresa character varying,
	int_id_estado integer,
	int_estado integer)
    RETURNS TABLE(id_solicitud_detalle integer, id_solicitud integer, total_registros bigint, id_empresa integer, nombre_empresa character varying, id_estado integer, nombre_estado character varying, dte character varying, proveedor character varying, nit integer, cantidad_nit bigint, monto numeric, fecha_factura character varying, id_moneda integer, nombre_moneda character varying, descripcion_factura character varying, id_pais integer, nombre_pais character varying, id_anticipo integer, estado integer, creado_por integer, nombre_creado_por character varying, actualizado_por integer, nombre_actualizado_por character varying, fecha_creacion character varying, fecha_actualizacion character varying, id_sharepoint integer, cantidad integer, cuenta_contable_sugerida integer, centro_costo integer, nombre_centro_costo character varying, nombre_cuenta_sugerida character varying, codigo_proveedor character varying, nombre_proveedor character varying, comentario character varying, numero_proveedor integer) 
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
		(SELECT COUNT(*) FROM recepciones_documento.tbl_det_documento_recepcion_solicitud_detalle TDRSD2 WHERE id_det_documento_recepcion_solicitud = int_id_solicitud) AS total_registros,
		TDDRS.id_cat_empresa AS id_empresa,
		TCE.nombre AS nombre_empresa,
		TDDRSD.id_cat_documento_estado AS id_estado,
		TCDE.nombre AS nombre_estado,
		CAST(TDDRSD.dte AS varchar) AS dte,
		TDDRSD.proveedor AS proveedor,
		TDDRSD.nit,
		COUNT(*) OVER (PARTITION BY TDDRSD.nit) AS cantidad_nit,
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
		TDDRSD.comentario,
		TDDRSD.numero_proveedor
	FROM recepciones_documento.tbl_det_documento_recepcion_solicitud_detalle TDDRSD
	LEFT JOIN recepciones_documento.tbl_cat_documento_estado TCDE 
	ON TDDRSD.id_cat_documento_estado = TCDE.id_cat_documento_estado
	LEFT JOIN general.tbl_cat_moneda TCM
	ON TDDRSD.id_cat_moneda = TCM.id_cat_moneda
	LEFT JOIN general.tbl_cat_pais TCP
	ON TDDRSD.id_cat_pais = TCP.id_cat_pais
	LEFT JOIN recepciones_documento.tbl_det_documento_recepcion_solicitud TDDRS
	ON TDDRSD.id_det_documento_recepcion_solicitud = TDDRS.id_det_documento_recepcion_solicitud
	LEFT JOIN usuarios.tbl_cat_empresa TCE 
	ON TDDRS.id_cat_empresa = TCE.id_cat_empresa
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TDDRSD.creado_por) nombre_creado_por ON true
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TDDRSD.actualizado_por) nombre_actualizado_por ON true
	WHERE (TDDRSD.id_det_documento_recepcion_solicitud = int_id_solicitud OR int_id_solicitud = 0)
		AND (TDDRS.id_cat_empresa = int_id_empresa OR int_id_empresa = 0)
		AND ((TDDRSD.dte) :: varchar = (UPPER(int_dte)) :: VARCHAR OR (UPPER (int_dte)) = '-')
		AND (UPPER(TCE.nombre) LIKE ('%' || UPPER(str_nombre_empresa) || '%') :: VARCHAR OR LENGTH (UPPER (str_nombre_empresa)) = 0)
		AND (TDDRSD.id_cat_documento_estado = int_id_estado OR int_id_estado = 0)		
		AND (TDDRSD.estado = int_estado OR int_estado = 2)
		ORDER BY cantidad_nit DESC, TDDRSD.nit;
END
$BODY$;

ALTER FUNCTION recepciones_documento.get_documento_solicituddetalleempresa(integer, integer, character varying, character varying, integer, integer)
    OWNER TO vince;
