/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 abril 2023
 Modificado: 14 abril 2023
 Descripción: función que registra el cambio de estado de un detalle para una solicitud 
 Dependencias: recepciones_documento.tbl_bit_documento_recepcion_solicitud_detalle
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.post_documento_solicituddetallebitacora(integer, integer, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.post_documento_solicituddetallebitacora(integer, integer, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.post_documento_solicituddetallebitacora(
	int_id_det_documento_recepcion_solicitud_detalle integer,
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
	INSERT INTO recepciones_documento.tbl_bit_documento_recepcion_solicitud_detalle(
		id_det_documento_recepcion_solicitud_detalle, 
		id_cat_documento_estado,
		creado_por,
		actualizado_por,
		fecha_creacion,
		fecha_actualizacion,
		estado
	)
	VALUES (
		int_id_det_documento_recepcion_solicitud_detalle, -- idDetDocumentoRecepcionSolicitudDetalle
		int_id_cat_documento_estado, -- idCatDocumentoEstado
		int_id_creador, -- creadoPor
		int_id_creador, -- actualizadoPor
		now(), -- fechaCreacion
		now(), -- fechaActualizacion
		1
	) RETURNING recepciones_documento.tbl_bit_documento_recepcion_solicitud_detalle.id_bit_documento_recepcion_solicitud_detalle;

END;
$BODY$;

ALTER FUNCTION recepciones_documento.post_documento_solicituddetallebitacora(integer, integer, integer)
    OWNER TO vince;
