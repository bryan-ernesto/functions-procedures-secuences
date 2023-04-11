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
-- FUNCTION: general.get_documento_moneda(character varying, character varying)
-- DROP FUNCTION IF EXISTS general.get_documento_moneda(character varying, character varying);
CREATE
OR REPLACE FUNCTION general.get_documento_moneda(
  str_simbolo character varying,
  str_nombre character varying
) RETURNS TABLE(
  id_moneda integer,
  simbolo_moneda character varying,
  nombre_moneda character varying,
  estado integer,
  creado_por integer,
  actualizado_por integer,
  fecha_creacion character varying,
  fecha_actualizacion character varying
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
SELECT
  TCM.id_cat_moneda AS id_moneda,
  TCM.simbolo AS simbolo_moneda,
  TCM.nombre AS nombre_moneda,
  TCM.estado,
  TCM.creado_por,
  TCM.actualizado_por,
  to_char(TCM.fecha_creacion, 'YYYY-MM-DD') :: varchar AS fecha_creacion,
  to_char(TCM.fecha_actualizacion, 'YYYY-MM-DD') :: varchar AS fecha_actualizacion
FROM
  general.tbl_cat_moneda TCM
WHERE
  (
    UPPER(TCM.simbolo) LIKE ('%' || UPPER(str_simbolo) || '%') :: VARCHAR
    OR LENGTH (UPPER(str_simbolo)) = 0
  )
  AND (
    UPPER(TCM.nombre) LIKE ('%' || UPPER(str_nombre) || '%') :: VARCHAR
    OR LENGTH (UPPER(str_nombre)) = 0
  );

END $ BODY $;

ALTER FUNCTION general.get_documento_moneda(character varying, character varying) OWNER TO vince;