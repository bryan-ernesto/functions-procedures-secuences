/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 abril 2023
 Modificado: 14 abril 2023
 Descripción: función que obtiene la información del loggeo a un aplicativo
 Dependencias: usuarios.tbl_cat_permiso_grupo, usuarios.tbl_cat_permiso_nivel, usuarios.tbl_det_grupo_asignacion_aplicativo, usuarios.tbl_cat_aplicativo
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.get_documento_login(character varying, character varying)

-- DROP FUNCTION IF EXISTS usuarios.get_documento_login(character varying, character varying);

CREATE OR REPLACE FUNCTION usuarios.get_documento_login(
	str_nombre_aplicativo character varying,
	str_nombre_usuario character varying)
    RETURNS TABLE(id_login integer, id_aplicativo integer, nombre_aplicativo character varying, id_usuario integer, nombre_usuario character varying, estado integer, creado_por integer, nombre_creado_por character varying, actualizado_por integer, nombre_actualizado_por character varying, fecha_creacion character varying, fecha_actualizacion character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
RETURN QUERY
	SELECT 
		TBAL.id_cat_aplicativo_login AS id_login,
		TBAL.id_cat_aplicativo AS id_aplicativo,
		TCA.nombre AS nombre_aplicativo,
		TBAL.id_cat_usuario AS id_usuario,
		TCU.nombre AS nombre_usuario,
		TBAL.estado,
		TBAL.creado_por,
		nombre_creado_por.nombre AS nombre_creado_por,
		TBAL.actualizado_por,
		nombre_actualizado_por.nombre AS nombre_actualizado_por,
		to_char(TBAL.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_creacion,
		to_char(TBAL.fecha_actualizacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS fecha_actualizacion
	FROM usuarios.tbl_bit_aplicativo_login TBAL
	LEFT JOIN usuarios.tbl_cat_aplicativo TCA
	ON TBAL.id_cat_aplicativo = TCA.id_cat_aplicativo
	LEFT JOIN usuarios.tbl_cat_usuario TCU
	ON TBAL.id_cat_usuario = TCU.id_cat_usuario
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TBAL.creado_por) nombre_creado_por ON true
	LEFT JOIN LATERAL (SELECT TCU.nombre AS nombre FROM usuarios.tbl_cat_usuario TCU WHERE TCU.id_cat_usuario = TBAL.actualizado_por) nombre_actualizado_por ON true
	WHERE (UPPER(TCA.nombre) LIKE ('%' || UPPER(str_nombre_aplicativo) || '%')::VARCHAR OR LENGTH (UPPER (str_nombre_aplicativo)) = 0)
		AND (UPPER(TCU.nombre) LIKE ('%' || UPPER(str_nombre_usuario) || '%')::VARCHAR OR LENGTH (UPPER(str_nombre_usuario)) = 0);
END
$BODY$;

ALTER FUNCTION usuarios.get_documento_login(character varying, character varying)
    OWNER TO vince;
