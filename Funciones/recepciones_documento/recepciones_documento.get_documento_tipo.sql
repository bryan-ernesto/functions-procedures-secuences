/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 11 abril 2023
 Modificado: 11 abril 2023
 Descripción: función que permite mostrar la información de una solicitud, permitiendo filtrar por si es individual o masiva, nombre de estado, nombre de tipo, nombre de empresa y adjunto en sharepoint
 Dependencias: recepciones_documento.tbl_det_documento_estado_asignacion_canal, recepciones_documento.tbl_cat_documento_estado, recepciones_documento.tbl_cat_documento_canal
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.get_documento_tipo(character varying, character varying, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.get_documento_tipo(character varying, character varying, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.get_documento_tipo(
	str_nombre character varying,
	str_descripcion character varying,
	int_tipo integer)
    RETURNS TABLE(id_documento_tipo integer, nombre character varying, descripcion character varying, tipo integer, estado integer, creado_por integer, nombre_creado_por character varying, actualizado_por integer, nombre_actualizado_por character varying, fecha_creacion character varying, fecha_actualizacion character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
RETURN QUERY
	SELECT 
		TCDT.id_cat_documento_tipo AS id_documento_tipo,
		TCDT.nombre,
		TCDT.descripcion,
		TCDT.tipo,
		TCDT.estado,
		TCDT.creado_por,
		nombre_creado_por.nombre AS nombre_creado_por,
		TCDT.actualizado_por,
		nombre_actualizado_por.nombre AS nombre_actualizado_por,
		to_char(TCDT.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_creacion,
		to_char(TCDT.fecha_actualizacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_actualizacion
	FROM recepciones_documento.tbl_cat_documento_tipo TCDT
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TCDT.creado_por) nombre_creado_por ON true
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TCDT.actualizado_por) nombre_actualizado_por ON true
	WHERE (UPPER(TCDT.nombre) LIKE ('%' || UPPER(str_nombre) || '%')::VARCHAR OR LENGTH (UPPER (str_nombre)) = 0)
		AND (UPPER(TCDT.descripcion) LIKE ('%' || UPPER(str_descripcion) || '%')::VARCHAR OR LENGTH (UPPER(str_descripcion)) = 0)
		AND (TCDT.tipo = int_tipo OR int_tipo = 2);
END
$BODY$;

ALTER FUNCTION recepciones_documento.get_documento_tipo(character varying, character varying, integer)
    OWNER TO vince;
