/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 abril 2023
 Modificado: 14 abril 2023
 Descripción: función que obtiene la información de la asignación de un usuario a un grupo de permisos
 Dependencias: usuarios.tbl_det_usuario_asignacion_permiso, usuarios.tbl_cat_usuario, usuarios.tbl_cat_permiso_grupo, usuarios.tbl_det_usuario_asignacion_equipo, usuarios.tbl_cat_equipo, usuarios.tbl_cat_departamento, usuarios.tbl_cat_empresa
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.get_documento_usuarioasignacionpermiso(integer, integer, character varying, character varying, character varying, character varying, integer)

-- DROP FUNCTION IF EXISTS usuarios.get_documento_usuarioasignacionpermiso(integer, integer, character varying, character varying, character varying, character varying, integer);

CREATE OR REPLACE FUNCTION usuarios.get_documento_usuarioasignacionpermiso(
	int_id_usuario integer,
	int_permiso integer,
	str_nombre_usuario character varying,
	str_nombre_empresa character varying,
	str_nombre_equipo character varying,
	str_nombre_departamento character varying,
	int_estado integer)
    RETURNS TABLE(id_usuario_asignacion_permiso integer, id_usuario integer, nombre_usuario character varying, id_permiso integer, nombre_grupo character varying, nombre_empresa character varying, nombre_equipo character varying, nombre_departamento character varying, estado integer, fecha_creacion character varying, fecha_actualizacion character varying, creado_por integer, nombre_creado_por character varying, actualizado_por integer, nombre_actualizado_por character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
RETURN QUERY
		SELECT 
		TDUAP.id_det_usuario_asignacion_permiso AS id_usuario_asignacion_permiso,
		TCU.id_cat_usuario AS id_usuario,
		TCU.nombre AS nombre_usuario,
		TCPG.id_cat_permiso_grupo AS id_permiso,
		TCPG.nombre AS nombre_grupo,
		TCE.nombre AS nombre_equipo,
		TCD.nombre AS nombre_departamento,
		TCEM.nombre AS nombre_empresa,
		TDUAP.estado,
		to_char(TDUAP.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_creacion,
		to_char(TDUAP.fecha_actualizacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_actualizacion,
		TDUAP.creado_por,
		nombre_creado_por.nombre AS nombre_creado_por,
		TDUAP.actualizado_por,
		nombre_actualizado_por.nombre AS nombre_actualizado_por
	FROM usuarios.tbl_det_usuario_asignacion_permiso TDUAP
	LEFT JOIN usuarios.tbl_cat_usuario TCU
	ON TDUAP.id_cat_usuario = TCU.id_cat_usuario
	LEFT JOIN usuarios.tbl_cat_permiso_grupo TCPG
	ON TDUAP.id_cat_permiso_grupo = TCPG.id_cat_permiso_grupo
	LEFT JOIN usuarios.tbl_det_usuario_asignacion_equipo TDUAE
	ON TCU.id_cat_usuario = TDUAE.id_cat_usuario
	LEFT JOIN usuarios.tbl_cat_equipo TCE
	ON TDUAE.id_cat_equipo = TCE.id_cat_equipo
	LEFT JOIN usuarios.tbl_cat_departamento TCD
	ON TCE.id_cat_departamento = TCD.id_cat_departamento
	LEFT JOIN usuarios.tbl_cat_empresa TCEM
	ON TCD.id_cat_empresa = TCEM.id_cat_empresa
	LEFT JOIN LATERAL (SELECT TCU2.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU2 WHERE TCU2.id_cat_usuario = TDUAP.creado_por) nombre_creado_por ON true
	LEFT JOIN LATERAL (SELECT TCU2.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU2 WHERE TCU2.id_cat_usuario = TDUAP.actualizado_por) nombre_actualizado_por ON true
	WHERE (TCU.id_cat_usuario = int_id_usuario OR int_id_usuario = 0)
		AND (TDUAP.id_cat_permiso_grupo = int_permiso OR int_permiso = 0)
		AND (UPPER(TCU.nombre) LIKE ('%' || UPPER(str_nombre_usuario) || '%')::VARCHAR OR LENGTH (UPPER(str_nombre_usuario)) = 0)
		AND (UPPER(TCEM.nombre) LIKE ('%' || UPPER(str_nombre_empresa) || '%')::VARCHAR OR LENGTH (UPPER(str_nombre_empresa)) = 0)
		AND (UPPER(TCE.nombre) LIKE ('%' || UPPER(str_nombre_equipo) || '%')::VARCHAR OR LENGTH (UPPER(str_nombre_equipo)) = 0)
		AND (UPPER(TCD.nombre) LIKE ('%' || UPPER(str_nombre_departamento) || '%')::VARCHAR OR LENGTH (UPPER(str_nombre_departamento)) = 0)
		AND (TDUAP.estado = int_estado OR int_estado = 2);
END
$BODY$;

ALTER FUNCTION usuarios.get_documento_usuarioasignacionpermiso(integer, integer, character varying, character varying, character varying, character varying, integer)
    OWNER TO vince;
