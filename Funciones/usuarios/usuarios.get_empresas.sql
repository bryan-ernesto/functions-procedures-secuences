/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 13 marzo 2023
 Descripción: Función que permite obtener la información de todas las empresas.
 Dependencias: usuarios.tbl_cat_empresa, 
 ERD: NO
 Nombre ERD: NO 
 */
-- FUNCTION: usuarios.get_empresas(character varying, integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.get_empresas(character varying, integer, integer);
CREATE OR REPLACE FUNCTION usuarios.get_empresas(
	str_empresa_nombre character varying,
	int_id_delta integer,
	str_nombre_delta character varying,
	int_creado_por integer,
	int_actualizado_por integer)
    RETURNS TABLE(empresa_id_cat_empresa integer, empresa_nombre character varying, id_delta integer, nombre_delta character varying, empresa_id_estado integer, empresa_fecha_creacion character varying, empresa_fecha_actualizacion character varying, empresa_nombre_creado_por character varying, empresa_id_creado_por integer, empresa_nombre_actualizado_por character varying, empresa_id_actualizado_por integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$

BEGIN
  RETURN QUERY
		SELECT tce.id_cat_empresa AS empresa_id_cat_empresa,
		tce.nombre AS empresa_nombre,
		tce.id_delta,
		tce.nombre_delta,
		tce.estado AS empresa_id_estado,
		to_char(tce.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS empresa_fecha_creacion,
		to_char(tce.fecha_actualizacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS empresa_fecha_actualizacion,
		nombre_creado_por.nombre AS empresa_nombre_creado_por,
		tce.creado_por AS empresa_id_creado_por,
		nombre_actualizado_por.nombre AS empresa_nombre_actualizado_por,
		tce.actualizado_por AS empresa_id_actualizado_por
		FROM usuarios.tbl_cat_empresa tce 
		LEFT JOIN LATERAL (SELECT tcu2.nombre AS nombre  FROM usuarios.tbl_cat_usuario tcu2 WHERE tcu2.id_cat_usuario = tce.creado_por) nombre_creado_por ON true
		LEFT JOIN LATERAL (SELECT tcu2.nombre AS nombre  FROM usuarios.tbl_cat_usuario tcu2 WHERE tcu2.id_cat_usuario = tce.actualizado_por) nombre_actualizado_por ON true
		WHERE (tce.nombre LIKE ('%' || UPPER(str_empresa_nombre) || '%')::varchar OR LENGTH (UPPER(str_empresa_nombre)) = 0)
		AND (tce.id_delta = int_id_delta OR int_id_delta = 0)
		AND (tce.nombre_delta LIKE ('%' || UPPER(str_nombre_delta) || '%')::varchar OR LENGTH (UPPER(str_nombre_delta)) = 0)
		AND (tce.creado_por = int_creado_por OR int_creado_por = 0)
		AND (tce.actualizado_por = int_actualizado_por OR int_actualizado_por = 0)
		;
END;
$BODY$;


ALTER FUNCTION usuarios.get_empresas(character varying, integer, integer) OWNER TO vince;