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
-- FUNCTION: usuarios.get_puestos(character varying, integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.get_puestos(character varying, integer, integer);
CREATE
OR REPLACE FUNCTION usuarios.get_puestos(
  str_puesto_nombre character varying,
  int_creado_por integer,
  int_actualizado_por integer
) RETURNS TABLE(
  id_cat_puesto integer,
  puesto_nombre character varying,
  puesto_estado integer,
  puesto_fecha_creacion character varying,
  puesto_fecha_actualizacion character varying,
  puesto_nombre_creado_por character varying,
  puesto_id_creado_por integer,
  puesto_nombre_actualizado_por character varying,
  puesto_id_actualizado_por integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tcp.id_cat_puesto,
  tcp.nombre as puesto_nombre,
  tcp.estado as puesto_estado,
  to_char(tcp.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as puesto_fecha_creacion,
  to_char(
    tcp.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as puesto_fecha_actualizacion,
  nombre_creado_por.nombre as puesto_nombre_creado_por,
  tcp.creado_por as puesto_id_creado_por,
  nombre_actualizado_por.nombre as puesto_nombre_actualizado_por,
  tcp.actualizado_por as puesto_id_actualizado_por
from
  usuarios.tbl_cat_puesto tcp
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tcp.creado_por
  ) nombre_creado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tcp.actualizado_por
  ) nombre_actualizado_por ON true
where
  (
    tcp.nombre LIKE ('%' || upper(str_puesto_nombre) || '%') :: varchar
    or LENGTH (upper(str_puesto_nombre)) = 0
  )
  and (
    tcp.creado_por = int_creado_por
    or int_creado_por = 0
  )
  and (
    tcp.actualizado_por = int_actualizado_por
    or int_actualizado_por = 0
  );

END;

$ BODY $;

ALTER FUNCTION usuarios.get_puestos(character varying, integer, integer) OWNER TO vince;