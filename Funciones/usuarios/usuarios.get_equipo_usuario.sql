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
-- FUNCTION: usuarios.get_equipo_usuario(integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.get_equipo_usuario(integer, integer);
CREATE
OR REPLACE FUNCTION usuarios.get_equipo_usuario(
  int_id_cat_usuario integer,
  int_cat_equipo integer
) RETURNS TABLE(
  id integer,
  equipo_id integer,
  equipo_nombre character varying,
  equipo_estado integer,
  usuario_id integer,
  usuario_nombre character varying,
  fecha_creacion character varying,
  fecha_actualizacion character varying,
  creado_por character varying,
  creado_por_id integer,
  actualizado_por character varying,
  actualizado_por_id integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tduae.id_det_usuario_asignacion_equipo as id,
  tce.id_cat_equipo as equipo_id,
  tce.nombre as equipo_nombre,
  tduae.estado as equipo_estado,
  tduae.id_cat_usuario as usuario_id,
  nombre_usuario.nombre as usuario_nombre,
  to_char(tduae.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as fecha_creacion,
  to_char(
    tduae.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as fecha_actualizacion,
  nombre_creado_por.nombre as creado_por,
  tduae.creado_por as creado_por_id,
  nombre_actualizado_por.nombre as actualizado_por,
  tduae.actualizado_por as actualizado_por_id
from
  usuarios.tbl_det_usuario_asignacion_equipo tduae
  join usuarios.tbl_cat_equipo tce on tce.id_cat_equipo = tduae.id_cat_equipo
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tduae.creado_por
  ) nombre_creado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tduae.actualizado_por
  ) nombre_actualizado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tduae.id_cat_usuario
  ) nombre_usuario ON true
where
  (
    tduae.id_cat_usuario = int_id_cat_usuario
    or int_id_cat_usuario = 0
  )
  and (
    tduae.id_cat_equipo = int_cat_equipo
    or int_cat_equipo = 0
  );

END;

$ BODY $;

ALTER FUNCTION usuarios.get_equipo_usuario(integer, integer) OWNER TO vince;