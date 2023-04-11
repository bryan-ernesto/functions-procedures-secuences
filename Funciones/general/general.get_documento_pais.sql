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
-- FUNCTION: general.get_documento_pais(character varying)
-- DROP FUNCTION IF EXISTS general.get_documento_pais(character varying);
CREATE
OR REPLACE FUNCTION general.get_documento_pais(str_nombre character varying) RETURNS TABLE(
  id_pais integer,
  nombre_pais character varying,
  estado integer,
  creado_por integer,
  actualizado_por integer,
  fecha_creacion character varying,
  fecha_actualizacion character varying
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
SELECT
  TCP.id_cat_pais AS id_pais,
  TCP.nombre AS nombre_pais,
  TCP.estado,
  TCP.creado_por,
  TCP.actualizado_por,
  to_char(TCP.fecha_creacion, 'YYYY-MM-DD') :: varchar AS fecha_creacion,
  to_char(TCP.fecha_actualizacion, 'YYYY-MM-DD') :: varchar AS fecha_actualizacion
FROM
  general.tbl_cat_pais TCP
WHERE
  (
    UPPER(TCP.nombre) LIKE ('%' || UPPER(str_nombre) || '%') :: VARCHAR
    OR LENGTH (UPPER(str_nombre)) = 0
  );

END $ BODY $;

ALTER FUNCTION general.get_documento_pais(character varying) OWNER TO vince;