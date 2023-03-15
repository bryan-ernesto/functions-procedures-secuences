/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 13 marzo 2023
 Descripción: 
 Dependencias: 
 ERD:
 Nombre ERD: 
 */
-- FUNCTION: usuarios.get_departamentos(character varying, integer, integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.get_departamentos(character varying, integer, integer, integer);
CREATE
OR REPLACE FUNCTION usuarios.get_departamentos(
  str_departamento_nombre character varying,
  int_creado_por integer,
  int_actualizado_por integer,
  int_id_cat_empresa integer
) RETURNS TABLE(
  departamento_id_cat_departamento integer,
  departamento_nombre character varying,
  empresa_id_cat_empresa integer,
  empresa_nombre_empresa character varying,
  departamento_id_estado integer,
  departamento_fecha_creacion character varying,
  departamento_fecha_actualizacion character varying,
  departamento_nombre_creado_por character varying,
  departamento_id_creado_por integer,
  departamento_nombre_actualizado_por character varying,
  departamento_id_actualizado_por integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tcd.id_cat_departamento as departamento_id_cat_departamento,
  tcd.nombre as departamento_nombre,
  tcd.id_cat_empresa as empresa_id_cat_empresa,
  nombre_empresa.nombre as empresa_nombre_empresa,
  tcd.estado as departamento_id_estado,
  to_char(tcd.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar asdepartamento_fecha_creacion,
  to_char(
    tcd.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as departamento_fecha_actualizacion,
  nombre_creado_por.nombre as empresa_nombre_creado_por,
  tcd.creado_por as departamento_id_creado_por,
  nombre_actualizado_por.nombre as departamento_nombre_actualizado_por,
  tcd.actualizado_por as departamento_id_actualizado_por
from
  usuarios.tbl_cat_departamento tcd
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_empresa tcu2
    WHERE
      tcu2.id_cat_empresa = tcd.id_cat_empresa
  ) nombre_empresa ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tcd.creado_por
  ) nombre_creado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tcd.actualizado_por
  ) nombre_actualizado_por ON true
where
  (
    upper(tcd.nombre) LIKE ('%' || upper(str_departamento_nombre) || '%') :: varchar
    or LENGTH (upper(str_departamento_nombre)) = 0
  )
  and (
    tcd.creado_por = int_creado_por
    or int_creado_por = 0
  )
  and (
    tcd.actualizado_por = int_actualizado_por
    or int_actualizado_por = 0
  )
  and (
    tcd.id_cat_empresa = int_id_cat_empresa
    or int_id_cat_empresa = 0
  );

END;

$ BODY $;

ALTER FUNCTION usuarios.get_departamentos(character varying, integer, integer, integer) OWNER TO vince;