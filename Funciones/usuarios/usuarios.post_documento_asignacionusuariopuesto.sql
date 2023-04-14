/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 marzo 2023
 Modificado: 14 marzo 2023
 Descripción: función que permite asignar un usuario a un puesto
 Dependencias: usuarios.tbl_det_usuario_asignacion_puesto
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.post_documento_asignacionusuariopuesto(integer, integer, integer, integer)

-- DROP FUNCTION IF EXISTS usuarios.post_documento_asignacionusuariopuesto(integer, integer, integer, integer);

CREATE OR REPLACE FUNCTION usuarios.post_documento_asignacionusuariopuesto(
	int_id_cat_usuario integer,
	int_predeterminado integer,
	int_id_pet_puesto_asignacion_equipo integer,
	int_id_creador integer)
    RETURNS TABLE(id_puestoequipo integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	INSERT INTO usuarios.tbl_det_usuario_asignacion_puesto(
		id_cat_usuario,
		estado,
		creado_por, 
		actualizado_por,
		fecha_creacion, 
		fecha_actualizacion,
		predeterminado,
		id_det_puesto_asignacion_equipo
	)
	VALUES (
		int_id_cat_usuario, -- idCatPermisoAccion
		1, -- estado
		int_id_creador, -- creadoPor
		int_id_creador, -- actualizadoPor
		now(), -- fechaCreacion
		now(), -- fechaActualizacion,
		1,
		int_id_pet_puesto_asignacion_equipo
	) RETURNING usuarios.tbl_det_usuario_asignacion_puesto.id_det_usuario_asignacion_puesto;

END;
$BODY$;

ALTER FUNCTION usuarios.post_documento_asignacionusuariopuesto(integer, integer, integer, integer)
    OWNER TO vince;
