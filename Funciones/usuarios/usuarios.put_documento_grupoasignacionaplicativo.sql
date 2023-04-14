/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 14 marzo 2023
 Modificado: 14 marzo 2023
 Descripción: función que permite actualizar la asignación de un grupo de permisos a un aplicativo
 Dependencias: usuarios.tbl_det_grupo_asignacion_aplicativo
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.put_documento_grupoasignacionaplicativo(integer, integer, integer, integer, integer)

-- DROP FUNCTION IF EXISTS usuarios.put_documento_grupoasignacionaplicativo(integer, integer, integer, integer, integer);

CREATE OR REPLACE FUNCTION usuarios.put_documento_grupoasignacionaplicativo(
	int_id_det_grupo_asignacion_aplicativo integer,
	int_id_cat_permiso_grupo integer,
	int_id_cat_aplicativo integer,
	int_estado integer,
	int_actualizado_por integer)
    RETURNS TABLE(id_grupo_aplicativo integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	UPDATE usuarios.tbl_det_grupo_asignacion_aplicativo
	SET 
		id_cat_permiso_grupo = CASE WHEN int_id_cat_permiso_grupo IS NOT NULL THEN int_id_cat_permiso_grupo ELSE id_cat_permiso_grupo END,
		id_cat_aplicativo = CASE WHEN int_id_cat_aplicativo IS NOT NULL THEN int_id_cat_aplicativo ELSE id_cat_aplicativo END,
		estado = CASE WHEN int_estado IS NOT NULL THEN int_estado ELSE estado END,
		actualizado_por = CASE WHEN int_actualizado_por IS NOT NULL THEN int_actualizado_por ELSE actualizado_por END,
		fecha_actualizacion = now()
    WHERE id_det_grupo_asignacion_aplicativo = int_id_det_grupo_asignacion_aplicativo
RETURNING usuarios.tbl_det_grupo_asignacion_aplicativo.id_det_grupo_asignacion_aplicativo;
END;
$BODY$;

ALTER FUNCTION usuarios.put_documento_grupoasignacionaplicativo(integer, integer, integer, integer, integer)
    OWNER TO vince;
