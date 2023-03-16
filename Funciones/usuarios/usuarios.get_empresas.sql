/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 13 marzo 2023
 Descripción: Función que permite obtener la información de todas las empresas.
 Dependencias: usuarios.tbl_cat_empresa, 
 ERD: NO
 Nombre ERD: NO 
 */
-- FUNCTION: usuarios.get_empresas(character varying, integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.get_empresas(character varying, integer, integer);
CREATE
OR REPLACE FUNCTION usuarios.get_empresas(
  str_empresa_nombre character varying,
  int_creado_por integer,
  int_actualizado_por integer
) RETURNS TABLE(
  empresa_id_cat_empresa integer,
  empresa_nombre character varying,
  empresa_id_estado integer,
  empresa_fecha_creacion character varying,
  empresa_fecha_actualizacion character varying,
  empresa_nombre_creado_por character varying,
  empresa_id_creado_por integer,
  empresa_nombre_actualizado_por character varying,
  empresa_id_actualizado_por integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tce.id_cat_empresa as empresa_id_cat_empresa,
  tce.nombre as empresa_nombre,
  tce.estado as empresa_id_estado,
  to_char(tce.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as empresa_fecha_creacion,
  to_char(
    tce.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as empresa_fecha_actualizacion,
  nombre_creado_por.nombre as empresa_nombre_creado_por,
  tce.creado_por as empresa_id_creado_por,
  nombre_actualizado_por.nombre as empresa_nombre_actualizado_por,
  tce.actualizado_por as empresa_id_actualizado_por
from
  usuarios.tbl_cat_empresa tce
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tce.creado_por
  ) nombre_creado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tce.actualizado_por
  ) nombre_actualizado_por ON true
where
  (
    tce.nombre LIKE ('%' || upper(str_empresa_nombre) || '%') :: varchar
    or LENGTH (upper(str_empresa_nombre)) = 0
  )
  and (
    tce.creado_por = int_creado_por
    or int_creado_por = 0
  )
  and (
    tce.actualizado_por = int_actualizado_por
    or int_actualizado_por = 0
  );

END;

$ BODY $;

ALTER FUNCTION usuarios.get_empresas(character varying, integer, integer) OWNER TO vince;