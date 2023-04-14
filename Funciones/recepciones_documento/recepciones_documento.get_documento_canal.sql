/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 11 abril 2023
 Modificado: 11 abril 2023
 Descripción: función que permite mostrar la información de un canal para un documento, permitiendo filtrar por el nombre y la descripción
 Dependencias: recepciones_documento.tbl_cat_documento_canal
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.get_documento_canal(character varying, character varying)
-- DROP FUNCTION IF EXISTS recepciones_documento.get_documento_canal(character varying, character varying);
-- FUNCTION: recepciones_documento.get_documento_canal(character varying, character varying)

-- DROP FUNCTION IF EXISTS recepciones_documento.get_documento_canal(character varying, character varying);

CREATE OR REPLACE FUNCTION recepciones_documento.get_documento_canal(
	str_nombre character varying,
	str_descripcion character varying)
    RETURNS TABLE(id_documento_canal integer, nombre character varying, descripcion character varying, estado integer, creado_por integer, nombre_creado_por character varying, actualizado_por integer, nombre_actualizado_por character varying, fecha_creacion character varying, fecha_actualizacion character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
RETURN QUERY
	SELECT 
		TCDC.id_cat_documento_canal AS id_documento_canal,
		TCDC.nombre,
		TCDC.descripcion,
		TCDC.estado,
		TCDC.creado_por,
		nombre_creado_por.nombre AS nombre_creado_por,
		TCDC.actualizado_por,
		nombre_actualizado_por.nombre AS nombre_actualizado_por,
		to_char(TCDC.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_creacion,
		to_char(TCDC.fecha_actualizacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_actualizacion
	FROM recepciones_documento.tbl_cat_documento_canal TCDC
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TCDC.creado_por) nombre_creado_por ON true
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TCDC.actualizado_por) nombre_actualizado_por ON true
	WHERE (UPPER(TCDC.nombre) LIKE ('%' || UPPER(str_nombre) || '%')::VARCHAR OR LENGTH (UPPER (str_nombre)) = 0)
		AND (UPPER(TCDC.descripcion) LIKE ('%' || UPPER(str_descripcion) || '%')::VARCHAR OR LENGTH (UPPER(str_descripcion)) = 0);
END
$BODY$;

ALTER FUNCTION recepciones_documento.get_documento_canal(character varying, character varying)
    OWNER TO vince;
