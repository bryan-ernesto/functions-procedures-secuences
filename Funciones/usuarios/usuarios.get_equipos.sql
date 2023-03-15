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
-- FUNCTION: usuarios.get_equipos(character varying, integer, integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.get_equipos(character varying, integer, integer, integer);
CREATE
OR REPLACE FUNCTION usuarios.get_equipos(
  str_equipo_nombre character varying,
  int_id_cat_departamento integer,
  int_creado_por integer,
  int_actualizado_por integer
) RETURNS TABLE(
  equipo_id_cat_equipo integer,
  equipo_nombre character varying,
  departamento_id_cat_departamento integer,
  departamento_nombre character varying,
  equipo_responsable_estado integer,
  equipo_responsable_fecha_creacion character varying,
  equipo_responsable_fecha_actualizacion character varying,
  equipo_responsable_creado_por character varying,
  equipo_responsable_id_creado_por integer,
  equipo_responsable_actualizado_por character varying,
  equipo_responsable_id_actualizado_por integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tce.id_cat_equipo as equipo_id_cat_equipo,
  tce.nombre as equipo_nombre,
  tcd.id_cat_departamento as departamento_id_cat_departamento,
  tcd.nombre as departamento_nombre,
  tce.estado as equipo_responsable_estado,
  to_char(tce.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as equipo_responsable_fecha_creacion,
  to_char(
    tce.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as equipo_responsable_fecha_actualizacion,
  nombre_creado_por.nombre as equipo_responsable_creado_por,
  tce.creado_por as equipo_responsable_id_creado_por,
  nombre_actualizado_por.nombre as equipo_responsable_actualizado_por,
  tce.actualizado_por as equipo_responsable_id_actualizado_por
from
  usuarios.tbl_cat_equipo tce
  join usuarios.tbl_cat_departamento tcd on tce.id_cat_departamento = tcd.id_cat_departamento
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
    upper(tce.nombre) LIKE ('%' || upper(str_equipo_nombre) || '%') :: varchar
    or LENGTH (upper(str_equipo_nombre)) = 0
  )
  and (
    tcd.id_cat_departamento = int_id_cat_departamento
    or int_id_cat_departamento = 0
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

ALTER FUNCTION usuarios.get_equipos(character varying, integer, integer, integer) OWNER TO vince;