/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que asigna un estado a un canal
 Dependencias: recepciones_documento.tbl_det_documento_estado_asignacion_canal
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.post_documento_estadoasignacioncanal(integer, integer, numeric, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.post_documento_estadoasignacioncanal(integer, integer, numeric, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.post_documento_estadoasignacioncanal(
	int_id_cat_documento_estado integer,
	int_id_cat_documento_canal integer,
	numeric_progreso numeric,
	int_id_creador integer)
    RETURNS TABLE(id_asignacion_canal integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	INSERT INTO recepciones_documento.tbl_det_documento_estado_asignacion_canal(
		id_cat_documento_estado,
		id_cat_documento_canal,
		progreso,
		creado_por,
		actualizado_por,
		fecha_creacion,
		fecha_actualizacion,
		estado
	)
	VALUES (
		int_id_cat_documento_estado, -- idCatDocumentoEstado
		int_id_cat_documento_canal, -- idCatDocumentoCanal
		numeric_progreso, -- progreso
		int_id_creador, -- creadoPor
		int_id_creador, -- actualizadoPor
		now(), -- fechaCreacion
		now(), -- fechaActualizacion
		1 -- estado
	) RETURNING recepciones_documento.tbl_det_documento_estado_asignacion_canal.id_det_documento_estado_asignacion_canal;

END;
$BODY$;

ALTER FUNCTION recepciones_documento.post_documento_estadoasignacioncanal(integer, integer, numeric, integer)
    OWNER TO vince;
