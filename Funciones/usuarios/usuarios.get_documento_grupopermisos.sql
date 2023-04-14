/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 abril 2023
 Modificado: 14 abril 2023
 Descripción: función que obtiene la información sobre la asignación de un grupo de permisos a un aplicativo
 Dependencias: usuarios.tbl_cat_permiso_grupo, usuarios.tbl_cat_permiso_nivel, usuarios.tbl_det_grupo_asignacion_aplicativo, usuarios.tbl_cat_aplicativo
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.get_documento_grupopermisos(character varying, character varying, character varying, integer)

-- DROP FUNCTION IF EXISTS usuarios.get_documento_grupopermisos(character varying, character varying, character varying, integer);

CREATE OR REPLACE FUNCTION usuarios.get_documento_grupopermisos(
	str_nombre_grupo character varying,
	str_nombre_nivel character varying,
	str_descripcion_nivel character varying,
	int_estado integer)
    RETURNS TABLE(id_permiso_grupo integer, nombre_grupo character varying, id_permiso_nivel integer, nombre_nivel character varying, descripcion_nivel character varying, nombre_aplicativo character varying, estado integer, fecha_creacion character varying, fecha_actualizacion character varying, creado_por integer, nombre_creado_por character varying, actualizado_por integer, nombre_actualizado_por character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
RETURN QUERY
	SELECT 
		TCPG.id_cat_permiso_grupo AS id_permiso_grupo,
		TCPG.nombre AS nombre_grupo,
		TCPG.id_cat_permiso_nivel AS id_permiso_nivel,
		TCPN.nombre AS nombre_nivel,
		TCPN.descripcion AS descripcion_nivel,
		TCA.nombre AS nombre_aplicativo,
		TCPG.estado,
		to_char(TCPG.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_creacion,
		to_char(TCPG.fecha_actualizacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_actualizacion,
		TCPG.creado_por,
		nombre_creado_por.nombre AS nombre_creado_por,
		TCPG.actualizado_por,
		nombre_actualizado_por.nombre AS nombre_actualizado_por
	FROM usuarios.tbl_cat_permiso_grupo TCPG
	LEFT JOIN usuarios.tbl_cat_permiso_nivel TCPN
	ON TCPG.id_cat_permiso_nivel = TCPN.id_cat_permiso_nivel
	LEFT JOIN usuarios.tbl_det_grupo_asignacion_aplicativo TDGAA
	ON TCPG.id_cat_permiso_grupo = TDGAA.id_cat_permiso_grupo
	LEFT JOIN usuarios.tbl_cat_aplicativo TCA
	ON TDGAA.id_cat_aplicativo = TCA.id_cat_aplicativo
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TCPG.creado_por) nombre_creado_por ON true
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TCPG.actualizado_por) nombre_actualizado_por ON true
	WHERE (UPPER(TCPG.nombre) LIKE ('%' || UPPER(str_nombre_grupo) || '%')::VARCHAR OR LENGTH (UPPER (str_nombre_grupo)) = 0)
		AND (UPPER(TCPN.nombre) LIKE ('%' || UPPER(str_nombre_nivel) || '%')::VARCHAR OR LENGTH (UPPER (str_nombre_nivel)) = 0)
		AND (UPPER(TCPN.descripcion) LIKE ('%' || UPPER(str_descripcion_nivel) || '%')::VARCHAR OR LENGTH (UPPER(str_descripcion_nivel)) = 0)
		AND (TCPG.estado = int_estado OR int_estado = 2);
END
$BODY$;

ALTER FUNCTION usuarios.get_documento_grupopermisos(character varying, character varying, character varying, integer)
    OWNER TO vince;
