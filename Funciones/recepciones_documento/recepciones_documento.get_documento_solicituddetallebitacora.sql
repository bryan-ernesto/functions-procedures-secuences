/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 19 abril 2023
 Modificado: 19 abril 2023
 Descripción: función que permite ver el cambio de estado del detalle de una solicitud
 Dependencias: recepciones_documento.tbl_bit_documento_recepcion_solicitud_detalle, recepciones_documento.tbl_det_documento_recepcion_solicitud_detalle, recepciones_documento.tbl_cat_documento_estado, recepciones_documento
 ERD: NO
 Nombre ERD: NO
 */
 -- FUNCTION: recepciones_documento.get_documento_solicituddetallebitacora(integer, integer, character varying, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.get_documento_solicituddetallebitacora(integer, integer, character varying, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.get_documento_solicituddetallebitacora(
	int_id_det_documento_recepcion_solicitud_detalle integer,
	int_det_documento_recepcion_solicitud integer,
	str_nombre_estado character varying,
	int_estado integer)
    RETURNS TABLE(id_bit_recepcion_solicitud_detalle integer, id_det_recepcion_solicitud_detalle integer, id_recepcion_solicitud integer, id_estado integer, nombre_estado character varying, estado integer, creado_por integer, nombre_creado_por character varying, actualizado_por integer, nombre_actualizado_por character varying, fecha_creacion character varying, fecha_actualizacion character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
RETURN QUERY
	SELECT 
		TBDRSD.id_bit_documento_recepcion_solicitud_detalle AS id_bit_recepcion_solicitud_detalle,
		TBDRSD.id_det_documento_recepcion_solicitud_detalle AS id_det_recepcion_solicitud_detalle,
		TDDRSD.id_det_documento_recepcion_solicitud AS id_recepcion_solicitud,
		TBDRSD.id_cat_documento_estado AS id_estado,
		TCDE.nombre AS nombre_estado,
		TBDRSD.estado,
		TBDRSD.creado_por,
		nombre_creado_por.nombre AS nombre_creado_por,
		TBDRSD.actualizado_por,
		nombre_actualizado_por.nombre AS nombre_actualizado_por,
		to_char(TBDRSD.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_creacion,
		to_char(TBDRSD.fecha_actualizacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_actualizacion
	FROM recepciones_documento.tbl_bit_documento_recepcion_solicitud_detalle TBDRSD
	LEFT JOIN recepciones_documento.tbl_det_documento_recepcion_solicitud_detalle TDDRSD
	ON TBDRSD.id_det_documento_recepcion_solicitud_detalle = TDDRSD.id_det_documento_recepcion_solicitud_detalle
	LEFT JOIN recepciones_documento.tbl_cat_documento_estado TCDE
	ON TDDRSD.id_cat_documento_estado = TCDE.id_cat_documento_estado
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TBDRSD.creado_por) nombre_creado_por ON true
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TBDRSD.actualizado_por) nombre_actualizado_por ON true
	WHERE (TBDRSD.id_det_documento_recepcion_solicitud_detalle = int_id_det_documento_recepcion_solicitud_detalle OR int_id_det_documento_recepcion_solicitud_detalle = 0)
	AND (TDDRSD.id_det_documento_recepcion_solicitud = int_det_documento_recepcion_solicitud OR int_det_documento_recepcion_solicitud = 0)
	AND (UPPER(TCDE.nombre) LIKE ('%' || UPPER(str_nombre_estado) || '%') :: VARCHAR OR LENGTH (UPPER (str_nombre_estado)) = 0)
	AND (TBDRSD.estado = int_estado OR int_estado = 2);
END
$BODY$;

ALTER FUNCTION recepciones_documento.get_documento_solicituddetallebitacora(integer, integer, character varying, integer)
    OWNER TO vince;
