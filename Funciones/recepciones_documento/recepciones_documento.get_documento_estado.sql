/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 11 abril 2023
 Modificado: 11 abril 2023
 Descripción: función que permite mostrar la información de un estado para un documento, permitiendo filtrar por nombre, descripción o si es un estado final
 Dependencias: recepciones_documento.tbl_cat_documento_estado
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.get_documento_estado(character varying, character varying, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.get_documento_estado(character varying, character varying, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.get_documento_estado(
	str_nombre character varying,
	str_descripcion character varying,
	int_estado_final integer)
    RETURNS TABLE(id_documento_estado integer, nombre character varying, descripcion character varying, estado_final integer, estado integer, creado_por integer, nombre_creado_por character varying, actualizado_por integer, nombre_actualizado_por character varying, fecha_creacion character varying, fecha_actualizacion character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
RETURN QUERY
	SELECT 
		TCDE.id_cat_documento_estado AS id_documento_estado,
		TCDE.nombre,
		TCDE.descripcion,
		TCDE.estado_final,
		TCDE.estado,
		TCDE.creado_por,
		nombre_creado_por.nombre AS nombre_creado_por,
		TCDE.actualizado_por,
		nombre_actualizado_por.nombre AS nombre_actualizado_por,
		to_char(TCDE.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_creacion,
		to_char(TCDE.fecha_actualizacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_actualizacion
	FROM recepciones_documento.tbl_cat_documento_estado TCDE
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TCDE.creado_por) nombre_creado_por ON true
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TCDE.actualizado_por) nombre_actualizado_por ON true
	WHERE (UPPER(TCDE.nombre) LIKE ('%' || UPPER(str_nombre) || '%')::VARCHAR OR LENGTH (UPPER (str_nombre)) = 0)
		AND (UPPER(TCDE.descripcion) LIKE ('%' || UPPER(str_descripcion) || '%')::VARCHAR OR LENGTH (UPPER(str_descripcion)) = 0)
		AND (TCDE.estado_final = int_estado_final OR int_estado_final = 2);
END
$BODY$;

ALTER FUNCTION recepciones_documento.get_documento_estado(character varying, character varying, integer)
    OWNER TO vince;
