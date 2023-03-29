/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que permite ingresar un nuevo grupo de permisos
 Dependencias: usuarios.tbl_cat_permiso_grupo, usuarios.tbl_cat_permiso_nivel
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.post_documento_gruponuevo(integer, character varying, integer)
-- DROP FUNCTION IF EXISTS usuarios.post_documento_gruponuevo(integer, character varying, integer);
CREATE
OR REPLACE FUNCTION usuarios.post_documento_gruponuevo(
  int_id_cat_permiso_nivel integer,
  str_nombre character varying,
  int_id_creador integer
) RETURNS TABLE(id_canal integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
INSERT INTO
  usuarios.tbl_cat_permiso_grupo(
    id_cat_permiso_nivel,
    nombre,
    estado,
    fecha_creacion,
    fecha_actualizacion,
    creado_por,
    actualizado_por
  )
VALUES
  (
    int_id_cat_permiso_nivel,
    -- idCatPermisoNivel
    str_nombre,
    -- nombre
    1,
    -- estado
    now(),
    -- fechaCreacion
    now(),
    -- fechaActualizacion
    int_id_creador,
    -- creadoPor
    int_id_creador -- actualizadoPor
  ) RETURNING usuarios.tbl_cat_permiso_grupo.id_cat_permiso_grupo;

END;

$ BODY $;

ALTER FUNCTION usuarios.post_documento_gruponuevo(integer, character varying, integer) OWNER TO vince;