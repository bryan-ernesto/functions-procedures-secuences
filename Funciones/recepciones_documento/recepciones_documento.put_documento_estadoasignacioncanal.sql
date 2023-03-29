/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que modificar la información la asignación de un estado a un canal
 Dependencias: recepciones_documento.tbl_det_documento_estado_asignacion_canal
 ERD: NO
 Nombre ERD: NO
 */
 -- FUNCTION: recepciones_documento.put_documento_estadoasignacioncanal(integer, integer, integer, numeric, integer, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.put_documento_estadoasignacioncanal(integer, integer, integer, numeric, integer, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.put_documento_estadoasignacioncanal(
	int_id_det_documento_estado_asignacion_canal integer,
	int_id_cat_documento_estado integer,
	int_id_cat_documento_canal integer,
	numeric_progreso numeric,
	int_estado integer,
	int_actualizado_por integer)
    RETURNS TABLE(id_estadoasignacioncanal integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	UPDATE recepciones_documento.tbl_det_documento_estado_asignacion_canal
	SET 
		id_cat_documento_estado = CASE WHEN int_id_cat_documento_estado IS NOT NULL THEN int_id_cat_documento_estado ELSE id_cat_documento_estado END,
		id_cat_documento_canal = CASE WHEN int_id_cat_documento_canal IS NOT NULL THEN int_id_cat_documento_canal ELSE id_cat_documento_canal END,
		progreso = CASE WHEN numeric_progreso IS NOT NULL THEN numeric_progreso ELSE progreso END,
		estado = CASE WHEN int_estado IS NOT NULL THEN int_estado ELSE estado END,
		actualizado_por = CASE WHEN int_actualizado_por IS NOT NULL THEN int_actualizado_por ELSE actualizado_por END,
		fecha_actualizacion = now()
    WHERE id_det_documento_estado_asignacion_canal = int_id_det_documento_estado_asignacion_canal
RETURNING recepciones_documento.tbl_det_documento_estado_asignacion_canal.id_det_documento_estado_asignacion_canal;
END;
$BODY$;

ALTER FUNCTION recepciones_documento.put_documento_estadoasignacioncanal(integer, integer, integer, numeric, integer, integer)
    OWNER TO vince;
