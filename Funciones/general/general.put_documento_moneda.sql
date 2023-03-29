/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que permite actualizar la información de una moneda
 Dependencias: general.tbl_cat_moneda
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: general.put_documento_moneda(integer, character varying, character varying, integer, integer)
-- DROP FUNCTION IF EXISTS general.put_documento_moneda(integer, character varying, character varying, integer, integer);
CREATE
OR REPLACE FUNCTION general.put_documento_moneda(
  int_id_cat_moneda integer,
  str_simbolo character varying,
  str_nombre character varying,
  int_estado integer,
  int_actualizado_por integer
) RETURNS TABLE(id_moneda integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
UPDATE
  general.tbl_cat_moneda
SET
  simbolo = CASE
    WHEN str_simbolo <> '' THEN str_simbolo
    ELSE simbolo
  END,
  nombre = CASE
    WHEN str_nombre <> '' THEN str_nombre
    ELSE nombre
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
  id_cat_moneda = int_id_cat_moneda RETURNING general.tbl_cat_moneda.id_cat_moneda;

END;

$ BODY $;

ALTER FUNCTION general.put_documento_moneda(
  integer,
  character varying,
  character varying,
  integer,
  integer
) OWNER TO vince;