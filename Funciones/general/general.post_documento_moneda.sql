/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que permite ingresar una nueva moneda
 Dependencias: general.tbl_cat_moneda
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: general.post_documento_moneda(character varying, character varying, integer)
-- DROP FUNCTION IF EXISTS general.post_documento_moneda(character varying, character varying, integer);
CREATE
OR REPLACE FUNCTION general.post_documento_moneda(
  str_simbolo character varying,
  str_nombre character varying,
  int_id_creador integer
) RETURNS TABLE(id_tipo integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
INSERT INTO
  general.tbl_cat_moneda(
    simbolo,
    nombre,
    estado,
    creado_por,
    actualizado_por,
    fecha_creacion,
    fecha_actualizacion
  )
VALUES
  (
    str_simbolo,
    -- simbolo
    str_nombre,
    -- nombre
    1,
    -- estado
    int_id_creador,
    -- creadoPor
    int_id_creador,
    -- actualizadoPor
    now(),
    -- fechaCreacion
    now() -- fechaActualizacion
  ) RETURNING general.tbl_cat_moneda.id_cat_moneda;

END;

$ BODY $;

ALTER FUNCTION general.post_documento_moneda(character varying, character varying, integer) OWNER TO vince;