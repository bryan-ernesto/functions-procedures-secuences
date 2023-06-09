/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: 
 Dependencias: compras_cuenta.tbl_cat_cuenta_clasificacion, usuarios.tbl_cat_usuario
 ERD:
 Nombre ERD: 
 */
-- FUNCTION: compras_cuenta.get_cuenta_clasificacion(character varying, integer, integer)
-- DROP FUNCTION IF EXISTS compras_cuenta.get_cuenta_clasificacion(character varying, integer, integer);
CREATE
OR REPLACE FUNCTION compras_cuenta.get_cuenta_clasificacion(
  cuenta_clasficacion_nombre character varying,
  int_id_creado_por integer,
  int_id_actualizado_por integer
) RETURNS TABLE(
  clasificacion_id integer,
  nombre character varying,
  estado integer,
  fecha_creacion character varying,
  fecha_actualizacion character varying,
  creado_por_id integer,
  creado_por character varying,
  actualizado_por_id integer,
  actualizado_por character varying
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tccc.id_cat_cuenta_clasificacion as clasificacion_id,
  tccc.nombre as nombre,
  tccc.estado as estado,
  to_char(tccc.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as fecha_creacion,
  to_char(
    tccc.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as fecha_actualizacion,
  tccc.creado_por as creado_por_id,
  creado_por.nombre as creado_por,
  tccc.actualizado_por as actualizado_por_id,
  modificado_por.nombre as actualizado_por
from
  compras_cuenta.tbl_cat_cuenta_clasificacion tccc
  LEFT JOIN LATERAL (
    SELECT
      tcu3.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu3
    WHERE
      tcu3.id_cat_usuario = tccc.creado_por
  ) creado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu4.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu4
    WHERE
      tcu4.id_cat_usuario = tccc.actualizado_por
  ) modificado_por ON true
where
  (
    upper(tccc.nombre) LIKE ('%' || upper(cuenta_clasficacion_nombre) || '%') :: varchar
    or LENGTH (upper(cuenta_clasficacion_nombre)) = 0
  )
  and (
    tccc.creado_por = int_id_creado_por
    or int_id_creado_por = 0
  )
  and (
    tccc.actualizado_por = int_id_actualizado_por
    or int_id_actualizado_por = 0
  );

END;

$ BODY $;

ALTER FUNCTION compras_cuenta.get_cuenta_clasificacion(character varying, integer, integer) OWNER TO vince;