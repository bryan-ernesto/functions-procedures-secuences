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
-- FUNCTION: usuarios.get_asignacion_equipo(integer)
-- DROP FUNCTION IF EXISTS usuarios.get_asignacion_equipo(integer);
CREATE
OR REPLACE FUNCTION usuarios.get_asignacion_equipo(int_id_cat_puesto integer) RETURNS TABLE(
  id_det_puesto_asignacion_equipo integer,
  puesto_nombre character varying,
  puesto_id_cat_puesto integer,
  equipo_nombre character varying,
  equipo_id_equipo integer,
  asignacion_equipo_estado integer,
  asignacion_fecha_creacion character varying,
  asignacion_fecha_actualizacion character varying,
  asignacion_creado_por integer,
  asignacion_nombre_creado_por character varying,
  asignacion_actualizado_por integer,
  asignacion_nombre_actualizado_por character varying
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tdpae.id_det_puesto_asignacion_equipo,
  tcp.nombre as puesto_nombre,
  tcp.id_cat_puesto as puesto_id_cat_puesto,
  tce.nombre as equipo_nombre,
  tce.id_cat_equipo as equipo_id_equipo,
  tce.estado as asignacion_equipo_estado,
  to_char(tce.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as asignacion_fecha_creacion,
  to_char(
    tce.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as asignacion_fecha_actualizacion,
  tce.creado_por as asignacion_creado_por,
  nombre_creado_por.nombre as asignacion_nombre_creado_por,
  tce.actualizado_por as asignacion_actualizado_por,
  nombre_actualizado_por.nombre as asignacion_nombre_actualizado_por
from
  usuarios.tbl_det_puesto_asignacion_equipo tdpae
  join usuarios.tbl_cat_equipo tce on tdpae.id_cat_equipo = tce.id_cat_equipo
  join usuarios.tbl_cat_puesto tcp on tcp.id_cat_puesto = tdpae.id_cat_puesto
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
    tcp.id_cat_puesto = int_id_cat_puesto
    or int_id_cat_puesto = 0
  );

END;

$ BODY $;

ALTER FUNCTION usuarios.get_asignacion_equipo(integer) OWNER TO vince;