/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que permite asignar un usuario a un grupo de permisos
 Dependencias: usuarios.tbl_det_usuario_asignacion_permiso, usuarios.tbl_id_cat_usuario, usuarios.tbl_cat_permiso_grupo
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.post_documento_grupousuario(integer, integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.post_documento_grupousuario(integer, integer, integer);
CREATE
OR REPLACE FUNCTION usuarios.post_documento_grupousuario(
  int_id_cat_usuario integer,
  int_id_cat_permiso_grupo integer,
  int_id_creador integer
) RETURNS TABLE(id_canal integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
INSERT INTO
  usuarios.tbl_det_usuario_asignacion_permiso(
    id_cat_usuario,
    id_cat_permiso_grupo,
    estado,
    fecha_creacion,
    fecha_actualizacion,
    creado_por,
    actualizado_por
  )
VALUES
  (
    int_id_cat_usuario,
    -- idCatUsuario
    int_id_cat_permiso_grupo,
    -- idCatPermisoGrupo
    1,
    -- estado
    now(),
    -- fechaCreacion
    now(),
    -- fechaActualizacion
    int_id_creador,
    -- creadoPor
    int_id_creador -- actualizadoPor
  ) RETURNING usuarios.tbl_det_usuario_asignacion_permiso.id_det_usuario_asignacion_permiso;

END;

$ BODY $;

ALTER FUNCTION usuarios.post_documento_grupousuario(integer, integer, integer) OWNER TO vince;