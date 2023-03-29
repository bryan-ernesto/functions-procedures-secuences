/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que permite ingresar uu nuevo país
 Dependencias: general.tbl_cat_pais
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: general.post_documento_pais(character varying, integer)
-- DROP FUNCTION IF EXISTS general.post_documento_pais(character varying, integer);
CREATE
OR REPLACE FUNCTION general.post_documento_pais(
  str_nombre character varying,
  int_id_creador integer
) RETURNS TABLE(id_pais integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
INSERT INTO
  general.tbl_cat_pais(
    nombre,
    estado,
    creado_por,
    actualizado_por,
    fecha_creacion,
    fecha_actualizacion
  )
VALUES
  (
    str_nombre,
    -- nombre
    1,
    -- estado
    int_id_creador,
    -- CreadoPor
    int_id_creador,
    -- ActualizadoPor
    now(),
    -- FechaCreacion
    now() -- FechaActualizacion
  ) RETURNING general.tbl_cat_pais.id_cat_pais;

END;

$ BODY $;

ALTER FUNCTION general.post_documento_pais(character varying, integer) OWNER TO vince;