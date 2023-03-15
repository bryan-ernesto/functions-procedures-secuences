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
-- FUNCTION: usuarios.get_equipo_responsable(integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.get_equipo_responsable(integer, integer);
CREATE
OR REPLACE FUNCTION usuarios.get_equipo_responsable(
  int_id_cat_usuario integer,
  int_cat_equipo integer
) RETURNS TABLE(
  id integer,
  equipo_id integer,
  equipo_nombre character varying,
  equipo_estado integer,
  responable_id integer,
  responsable_nombre character varying,
  fecha_creacion character varying,
  fecha_actualizacion character varying,
  creado_por character varying,
  creado_por_id integer,
  actualizado_por character varying,
  actualizado_por_id integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tdear.id_det_equipo_asignacion_responsable as id,
  tce.id_cat_equipo as equipo_id,
  tce.nombre as equipo_nombre,
  tdear.estado as equipo_estado,
  tdear.id_cat_usuario as responable_id,
  nombre_usuario.nombre as responsable_nombre,
  to_char(tdear.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as fecha_creacion,
  to_char(
    tdear.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as fecha_actualizacion,
  nombre_creado_por.nombre as creado_por,
  tdear.creado_por as creado_por_id,
  nombre_actualizado_por.nombre as actualizado_por,
  tdear.actualizado_por as actualizado_por_id
from
  usuarios.tbl_det_equipo_asignacion_responsable tdear
  join usuarios.tbl_cat_equipo tce on tce.id_cat_equipo = tdear.id_cat_equipo
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tdear.creado_por
  ) nombre_creado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tdear.actualizado_por
  ) nombre_actualizado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tdear.id_cat_usuario
  ) nombre_usuario ON true
where
  (
    tdear.id_cat_usuario = int_id_cat_usuario
    or int_id_cat_usuario = 0
  )
  and (
    tce.id_cat_equipo = int_cat_equipo
    or int_cat_equipo = 0
  );

END;

$ BODY $;

ALTER FUNCTION usuarios.get_equipo_responsable(integer, integer) OWNER TO vince;