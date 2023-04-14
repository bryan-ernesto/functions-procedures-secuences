/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 marzo 2023
 Modificado: 14 marzo 2023
 Descripción: función que permite asignar un puesto a un equipo 
 Dependencias: usuarios.tbl_det_puesto_asignacion_equipo
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.post_documento_asignacionpuestoequipo(integer, integer, integer)

-- DROP FUNCTION IF EXISTS usuarios.post_documento_asignacionpuestoequipo(integer, integer, integer);

CREATE OR REPLACE FUNCTION usuarios.post_documento_asignacionpuestoequipo(
	int_id_cat_puesto integer,
	int_id_cat_equipo integer,
	int_id_creador integer)
    RETURNS TABLE(id_puestoequipo integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	INSERT INTO usuarios.tbl_det_puesto_asignacion_equipo(
		id_cat_puesto,
		id_cat_equipo,
		estado,
		creado_por, 
		actualizado_por,
		fecha_creacion, 
		fecha_actualizacion
	)
	VALUES (
		int_id_cat_puesto, -- idCatPermisoAccion
		int_id_cat_equipo, -- idCatPermisoNivel
		1, -- estado
		int_id_creador, -- creadoPor
		int_id_creador, -- actualizadoPor
		now(), -- fechaCreacion
		now() -- fechaActualizacion
	) RETURNING usuarios.tbl_det_puesto_asignacion_equipo.id_det_puesto_asignacion_equipo;

END;
$BODY$;

ALTER FUNCTION usuarios.post_documento_asignacionpuestoequipo(integer, integer, integer)
    OWNER TO vince;
