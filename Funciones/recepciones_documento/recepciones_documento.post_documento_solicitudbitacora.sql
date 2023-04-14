/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 abril 2023
 Modificado: 14 abril 2023
 Descripción: función que registra los estados por los que ha pasado una solicitud
 Dependencias: recepciones_documento.tbl_det_documento_recepcion_solicitud
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.tbl_bit_documento_recepcion_solicitud(integer, integer, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.post_documento_solicitudbitacora(integer, integer, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.post_documento_solicitudbitacora(
	int_id_det_documento_recepcion integer,
	int_id_cat_documento_estado integer,
	int_id_creador integer)
    RETURNS TABLE(id_documento_solicitudbitacora integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	INSERT INTO recepciones_documento.tbl_bit_documento_recepcion_solicitud(
		id_det_documento_recepcion, 
		id_cat_documento_estado,
		creado_por,
		actualizado_por,
		fecha_creacion,
		fecha_actualizacion,
		estado
	)
	VALUES (
		int_id_det_documento_recepcion, -- idDetDocumentoRecepcionSolicitud
		int_id_cat_documento_estado, -- idCatDocumentoEstado
		int_id_creador, -- creadoPor
		int_id_creador, -- actualizadoPor
		now(), -- fechaCreacion
		now(), -- fechaActualizacion
		1
	) RETURNING recepciones_documento.tbl_bit_documento_recepcion_solicitud.id_bit_documento_recepcion_solicitud;

END;
$BODY$;

ALTER FUNCTION recepciones_documento.post_documento_solicitudbitacora(integer, integer, integer)
    OWNER TO vince;
