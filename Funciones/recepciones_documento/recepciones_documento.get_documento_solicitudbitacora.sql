/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 19 abril 2023
 Modificado: 19 abril 2023
 Descripción: función que permite ver el cambio de estado de una solicitud 
 Dependencias: recepciones_documento.tbl_bit_documento_recepcion_solicitud, recepciones_documento.tbl_det_documento_recepcion_solicitud, recepciones_documento.tbl_cat_documento_estado, recepciones_documento
 ERD: NO
 Nombre ERD: NO
 */

-- FUNCTION: recepciones_documento.get_documento_solicitudbitacora(integer, integer, character varying, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.get_documento_solicitudbitacora(integer, integer, character varying, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.get_documento_solicitudbitacora(
	int_id_recepcion_solicitud integer,
	int_individual_masiva integer,
	str_nombre_estado character varying,
	int_estado integer)
    RETURNS TABLE(id_bit_recepcion_solicitud integer, id_recepcion_solicitud integer, individual_masiva integer, id_documento_estado integer, nombre_estado character varying, estado integer, creado_por integer, nombre_creado_por character varying, actualizado_por integer, nombre_actualizado_por character varying, fecha_creacion character varying, fecha_actualizacion character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
RETURN QUERY
	SELECT 
		TBDRS.id_bit_documento_recepcion_solicitud AS id_bit_recepcion_solicitud,
		TBDRS.id_det_documento_recepcion AS id_recepcion_solicitud,
		TDDRS.individual_masiva,
		TBDRS.id_cat_documento_estado AS id_documento_estado,
		TCDE.nombre AS nombre_estado,
		TBDRS.estado,
		TBDRS.creado_por,
		nombre_creado_por.nombre AS nombre_creado_por,
		TBDRS.actualizado_por,
		nombre_actualizado_por.nombre AS nombre_actualizado_por,
		to_char(TBDRS.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_creacion,
		to_char(TBDRS.fecha_actualizacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_actualizacion
	FROM recepciones_documento.tbl_bit_documento_recepcion_solicitud TBDRS
	LEFT JOIN recepciones_documento.tbl_det_documento_recepcion_solicitud TDDRS
	ON TBDRS.id_det_documento_recepcion = TDDRS.id_det_documento_recepcion_solicitud
	LEFT JOIN recepciones_documento.tbl_cat_documento_estado TCDE
	ON TBDRS.id_cat_documento_estado = TCDE.id_cat_documento_estado
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TBDRS.creado_por) nombre_creado_por ON true
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TBDRS.actualizado_por) nombre_actualizado_por ON true
	WHERE (TBDRS.id_det_documento_recepcion = int_id_recepcion_solicitud OR int_id_recepcion_solicitud = 0)
	AND (TDDRS.individual_masiva = int_individual_masiva OR int_individual_masiva = 2)
	AND (UPPER(TCDE.nombre) LIKE ('%' || UPPER(str_nombre_estado) || '%') :: VARCHAR OR LENGTH (UPPER (str_nombre_estado)) = 0)
	AND (TBDRS.estado = int_estado OR int_estado = 2);
END
$BODY$;

ALTER FUNCTION recepciones_documento.get_documento_solicitudbitacora(integer, integer, character varying, integer)
    OWNER TO vince;
