/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 11 marzo 2023
 Modificado: 11 marzo 2023
 Descripción: función que permite agregar una nueva accion
 Dependencias: usuarios.tbl_cat_permiso_accion
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.post_documento_nuevaaccion(character varying, character varying, integer)
-- DROP FUNCTION IF EXISTS usuarios.post_documento_nuevaaccion(character varying, character varying, integer);
CREATE
OR REPLACE FUNCTION usuarios.post_documento_nuevaaccion(
  str_nombre character varying,
  str_descripcion character varying,
  int_id_creador integer
) RETURNS TABLE(id_accion integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
INSERT INTO
  usuarios.tbl_cat_permiso_accion(
    nombre,
    descripcion,
    estado,
    fecha_creacion,
    fecha_actualizacion,
    creado_por,
    actualizado_por
  )
VALUES
  (
    str_nombre,
    -- nombre
    str_descripcion,
    -- descripcion
    1,
    -- estado
    now(),
    -- fechaCreacion
    now(),
    -- fechaActualizacion
    int_id_creador,
    -- creadoPor
    int_id_creador -- actualizadoPor
  ) RETURNING usuarios.tbl_cat_permiso_accion.id_cat_permiso_accion;

END;

$ BODY $;

ALTER FUNCTION usuarios.post_documento_nuevaaccion(character varying, character varying, integer) OWNER TO vince;