/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 11 abril 2023
 Modificado: 11 abril 2023
 Descripción: función que permite mostrar la información de una asignación de un estado a un canal, permitiendo filtrar por nombre de estado, nombre de canal y progreso
 Dependencias: recepciones_documento.tbl_det_documento_estado_asignacion_canal, recepciones_documento.tbl_cat_documento_estado, recepciones_documento.tbl_cat_documento_canal
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.get_documento_estadoasignacioncanal(character varying, character varying, character varying)

-- DROP FUNCTION IF EXISTS recepciones_documento.get_documento_estadoasignacioncanal(character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION recepciones_documento.get_documento_estadoasignacioncanal(
	str_nombre_estado character varying,
	str_nombre_canal character varying,
	numeric_progreso character varying)
    RETURNS TABLE(id_estado_asignacion_canal integer, id_estado integer, nombre_estado character varying, id_canal integer, nombre_canal character varying, progreso character varying, estado integer, creado_por integer, nombre_creado_por character varying, actualizado_por integer, nombre_actualizado_por character varying, fecha_creacion character varying, fecha_actualizacion character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
RETURN QUERY
	SELECT 
		TDDEAC.id_det_documento_estado_asignacion_canal AS id_estado_asignacion_canal,
		TDDEAC.id_cat_documento_estado AS id_estado,
		TCDE.nombre AS nombre_estado,
		TDDEAC.id_cat_documento_canal AS id_canal,
		TCDC.nombre AS nombre_canal,
		(CONCAT(TDDEAC.progreso, '%'))::VARCHAR AS progreso,
		TDDEAC.estado,
		TDDEAC.creado_por,
		nombre_creado_por.nombre AS nombre_creado_por,
		TDDEAC.actualizado_por,
		nombre_actualizado_por.nombre AS nombre_actualizado_por,
		to_char(TDDEAC.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM')::VARCHAR AS fecha_creacion,
		to_char(TDDEAC.fecha_actualizacion, 'YYYY-MM-DD HH:MI:SS AM')::VARCHAR AS fecha_actualizacion
	FROM recepciones_documento.tbl_det_documento_estado_asignacion_canal TDDEAC
	LEFT JOIN recepciones_documento.tbl_cat_documento_estado TCDE
	ON TDDEAC.id_cat_documento_estado = TCDE.id_cat_documento_estado
	LEFT JOIN recepciones_documento.tbl_cat_documento_canal TCDC
	ON TDDEAC.id_cat_documento_canal = TCDC.id_cat_documento_canal
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TDDEAC.creado_por) nombre_creado_por ON true
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TDDEAC.actualizado_por) nombre_actualizado_por ON true
	WHERE (UPPER(TCDE.nombre) LIKE ('%' || UPPER(str_nombre_estado) || '%')::VARCHAR OR LENGTH (UPPER (str_nombre_estado)) = 0)
		AND (UPPER(TCDC.nombre) LIKE ('%' || UPPER(str_nombre_canal) || '%')::VARCHAR OR LENGTH (UPPER(str_nombre_canal)) = 0)
		AND (UPPER(TDDEAC.progreso::VARCHAR) LIKE ('%' || UPPER(numeric_progreso) || '%')::VARCHAR OR LENGTH (UPPER(numeric_progreso)) = 0);
END
$BODY$;

ALTER FUNCTION recepciones_documento.get_documento_estadoasignacioncanal(character varying, character varying, character varying)
    OWNER TO vince;
