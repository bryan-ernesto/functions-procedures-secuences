/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que permite actualizar la información de una asignación de permisos a un usuario
 Dependencias: usuarios.tbl_det_usuario_asignacion_permiso, tbl_cat_usuario, tbl_cat_permiso_grupo
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.put_documento_grupousuario(integer, integer, integer, integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.put_documento_grupousuario(integer, integer, integer, integer, integer);
CREATE
OR REPLACE FUNCTION usuarios.put_documento_grupousuario(
  int_id_det_usuario_asignacion_permiso integer,
  int_id_cat_usuario integer,
  int_id_cat_permiso_grupo integer,
  int_estado integer,
  int_actualizado_por integer
) RETURNS TABLE(id_grupo_usuario integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
UPDATE
  usuarios.tbl_det_usuario_asignacion_permiso
SET
  id_cat_usuario = CASE
    WHEN int_id_cat_usuario IS NOT NULL THEN int_id_cat_usuario
    ELSE id_cat_usuario
  END,
  id_cat_permiso_grupo = CASE
    WHEN int_id_cat_permiso_grupo IS NOT NULL THEN int_id_cat_permiso_grupo
    ELSE id_cat_permiso_grupo
  END,
  estado = CASE
    WHEN int_estado IS NOT NULL THEN int_estado
    ELSE estado
  END,
  actualizado_por = CASE
    WHEN int_actualizado_por IS NOT NULL THEN int_actualizado_por
    ELSE actualizado_por
  END,
  fecha_actualizacion = now()
WHERE
  id_det_usuario_asignacion_permiso = int_id_det_usuario_asignacion_permiso RETURNING usuarios.tbl_det_usuario_asignacion_permiso.id_det_usuario_asignacion_permiso;

END;

$ BODY $;

ALTER FUNCTION usuarios.put_documento_grupousuario(integer, integer, integer, integer, integer) OWNER TO vince;