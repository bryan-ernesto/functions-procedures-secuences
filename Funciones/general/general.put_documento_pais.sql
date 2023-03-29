/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que permite modificar la información de un país
 Dependencias: general.tbl_cat_pais
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: general.put_documento_pais(integer, character varying, integer, integer)
-- DROP FUNCTION IF EXISTS general.put_documento_pais(integer, character varying, integer, integer);
CREATE
OR REPLACE FUNCTION general.put_documento_pais(
  int_id_cat_pais integer,
  str_nombre character varying,
  int_estado integer,
  int_actualizado_por integer
) RETURNS TABLE(id_pais integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
UPDATE
  general.tbl_cat_pais
SET
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
  id_cat_pais = int_id_cat_pais RETURNING general.tbl_cat_pais.id_cat_pais;

END;

$ BODY $;

ALTER FUNCTION general.put_documento_pais(integer, character varying, integer, integer) OWNER TO vince;