/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 marzo 2023
 Modificado: 14 marzo 2023
 Descripción: función que permite asignar una acción a un nivel de permisos
 Dependencias: usuarios.tbl_det_nivel_asignacion_accion
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.post_documento_accionasignacionnivel(integer, integer, integer)

-- DROP FUNCTION IF EXISTS usuarios.post_documento_accionasignacionnivel(integer, integer, integer);

CREATE OR REPLACE FUNCTION usuarios.post_documento_accionasignacionnivel(
	int_id_cat_permiso_accion integer,
	int_id_cat_permiso_nivel integer,
	int_id_creador integer)
    RETURNS TABLE(id_accionnivel integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	INSERT INTO usuarios.tbl_det_nivel_asignacion_accion(
		id_cat_permiso_accion,
		id_cat_permiso_nivel,
		estado,
		fecha_creacion, 
		fecha_actualizacion, 
		creado_por, 
		actualizado_por
	)
	VALUES (
		int_id_cat_permiso_accion, -- idCatPermisoAccion
		int_id_cat_permiso_nivel, -- idCatPermisoNivel
		1, -- estado
		now(), -- fechaCreacion
		now(), -- fechaActualizacion
		int_id_creador, -- creadoPor
		int_id_creador -- actualizadoPor
	) RETURNING usuarios.tbl_det_nivel_asignacion_accion.id_det_accion_asignacion_nivel;

END;
$BODY$;

ALTER FUNCTION usuarios.post_documento_accionasignacionnivel(integer, integer, integer)
    OWNER TO vince;
