/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que permite ingresar uu nuevo país
 Dependencias: general.tbl_cat_moneda
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: general.get_documento_moneda(character varying, character varying)

-- DROP FUNCTION IF EXISTS general.get_documento_moneda(character varying, character varying);

CREATE OR REPLACE FUNCTION general.get_documento_moneda(
	str_simbolo character varying,
	str_nombre character varying)
    RETURNS TABLE(id_moneda integer, simbolo_moneda character varying, nombre_moneda character varying, estado integer, creado_por integer, nombre_creado_por character varying, actualizado_por integer, nombre_actualizado_por character varying, fecha_creacion character varying, fecha_actualizacion character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
RETURN QUERY
	SELECT 
		TCM.id_cat_moneda AS id_moneda,
		TCM.simbolo AS simbolo_moneda,
		TCM.nombre AS nombre_moneda,
		TCM.estado,
		TCM.creado_por,
		nombre_creado_por.nombre AS nombre_creado_por,
		TCM.actualizado_por,
		nombre_actualizado_por.nombre AS nombre_actualizado_por,
		to_char(TCM.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_creacion,
		to_char(TCM.fecha_actualizacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_actualizacion
	FROM general.tbl_cat_moneda TCM
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TCM.creado_por) nombre_creado_por ON true
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TCM.actualizado_por) nombre_actualizado_por ON true
	WHERE (UPPER(TCM.simbolo) LIKE ('%' || UPPER(str_simbolo) || '%')::VARCHAR OR LENGTH (UPPER(str_simbolo)) = 0)
	AND (UPPER(TCM.nombre) LIKE ('%' || UPPER(str_nombre) || '%')::VARCHAR OR LENGTH (UPPER(str_nombre)) = 0);
END
$BODY$;

ALTER FUNCTION general.get_documento_moneda(character varying, character varying)
    OWNER TO vince;
