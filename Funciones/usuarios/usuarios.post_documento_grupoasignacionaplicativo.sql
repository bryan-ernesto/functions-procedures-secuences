/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 marzo 2023
 Modificado: 14 marzo 2023
 Descripción: función que permite asignar un grupo de permisos a un aplicativo
 Dependencias: usuarios.tbl_det_grupo_asignacion_aplicativo
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.post_documento_grupoasignacionaplicativo(integer, integer, integer)

-- DROP FUNCTION IF EXISTS usuarios.post_documento_grupoasignacionaplicativo(integer, integer, integer);

CREATE OR REPLACE FUNCTION usuarios.post_documento_grupoasignacionaplicativo(
	int_id_cat_permiso_grupo integer,
	int_id_cat_aplicativo integer,
	int_id_creador integer)
    RETURNS TABLE(id_ integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	INSERT INTO usuarios.tbl_det_grupo_asignacion_aplicativo(
		id_cat_permiso_grupo,
		id_cat_aplicativo,
		estado,
		fecha_creacion, 
		fecha_actualizacion,
		creado_por, 
		actualizado_por
	)
	VALUES (
		int_id_cat_permiso_grupo, -- idCatPermisoAccion
		int_id_cat_aplicativo, -- idCatPermisoNivel
		1, -- estado
		now(), -- fechaCreacion
		now(), -- fechaActualizacion
		int_id_creador, -- creadoPor
		int_id_creador -- actualizadoPor
	) RETURNING usuarios.tbl_det_grupo_asignacion_aplicativo.id_det_grupo_asignacion_aplicativo;

END;
$BODY$;

ALTER FUNCTION usuarios.post_documento_grupoasignacionaplicativo(integer, integer, integer)
    OWNER TO vince;
