/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 abril 2023
 Modificado: 14 abril 2023
 Descripción: función que agrega una nueva validación
 Dependencias: recepciones_documento.tbl_bit_documento_validacion
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.post_documento_validacion(integer, integer, integer, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.post_documento_validacion(integer, integer, integer, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.post_documento_validacion(
	int_id_det_documento_anticipo integer,
	int_id_det_documento_recepcion_solicitud_detalle integer,
	int_id_cat_documento_validacion integer,
	int_id_creador integer)
    RETURNS TABLE(id_documento_validacion integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	INSERT INTO recepciones_documento.tbl_bit_documento_validacion(
		id_det_documento_anticipo, 
		id_det_documento_recepcion_solicitud_detalle,
		id_cat_documento_validacion,
		estado,
		creado_por,
		actualizado_por,
		fecha_creacion,
		fecha_actualizacion
	)
	VALUES (
		int_id_det_documento_anticipo, -- idDetDocumentoAnticipo
		int_id_det_documento_recepcion_solicitud_detalle, -- idDetDocumentoRecepcionSolicitudDetalle
		int_id_cat_documento_validacion, -- idCatDocumentoValidacion
		1, -- estado
		int_id_creador, -- creadoPor
		int_id_creador, -- actualizadoPor
		now(), -- fechaCreacion
		now() -- fechaActualizacion
	) RETURNING recepciones_documento.tbl_bit_documento_validacion.id_bit_documento_validacion;

END;
$BODY$;

ALTER FUNCTION recepciones_documento.post_documento_validacion(integer, integer, integer, integer)
    OWNER TO vince;
