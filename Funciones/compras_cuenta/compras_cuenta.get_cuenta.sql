/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 13 marzo 2023
 Descripción: función que obtiene toda la información de una o todas las cuentas
 Dependencias: compras_cuenta.tbl_cat_cuenta, compras_cuenta.tbl_cat_cuenta_clasificacion
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: compras_cuenta.get_cuenta(character varying, integer, integer, integer)
-- DROP FUNCTION IF EXISTS compras_cuenta.get_cuenta(character varying, integer, integer, integer);
CREATE
OR REPLACE FUNCTION compras_cuenta.get_cuenta(
  cuenta_nombre character varying,
  int_clasificacion_id integer,
  int_id_creado_por integer,
  int_id_actualizado_por integer
) RETURNS TABLE(
  cuenta_id integer,
  nombre character varying,
  clasificacion_id integer,
  clasificacion_nombre character varying,
  descripcion character varying,
  estado integer,
  fecha_creacion character varying,
  fecha_actualizacion character varying,
  creado_por_id integer,
  actualizado_por_id integer,
  creado_por character varying,
  actualizado_por character varying
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tcc.id_cat_cuenta as cuenta_id,
  tcc.nombre as nombre,
  tccc.id_cat_cuenta_clasificacion as clasificacion_id,
  tccc.nombre as clasificacion_nombre,
  tcc.descripcion as descripcion,
  tcc.estado as estado,
  to_char(tcc.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as fecha_creacion,
  to_char(
    tcc.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as fecha_actualizacion,
  tcc.creado_por as creado_por_id,
  tcc.actualizado_por as actualizado_por_id,
  creado_por.nombre as creado_por,
  modificado_por.nombre as actualizado_por
from
  compras_cuenta.tbl_cat_cuenta tcc
  join compras_cuenta.tbl_cat_cuenta_clasificacion tccc on tcc.id_cat_cuenta_clasificacion = tccc.id_cat_cuenta_clasificacion
  LEFT JOIN LATERAL (
    SELECT
      tcu3.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu3
    WHERE
      tcu3.id_cat_usuario = tcc.creado_por
  ) creado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu4.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu4
    WHERE
      tcu4.id_cat_usuario = tcc.actualizado_por
  ) modificado_por ON true
where
  (
    upper(tcc.nombre) LIKE ('%' || upper(cuenta_nombre) || '%') :: varchar
    or LENGTH (upper(cuenta_nombre)) = 0
  )
  and (
    tcc.id_cat_cuenta_clasificacion = int_clasificacion_id
    or int_clasificacion_id = 0
  )
  and (
    tcc.creado_por = int_id_creado_por
    or int_id_creado_por = 0
  )
  and (
    tcc.actualizado_por = int_id_actualizado_por
    or int_id_actualizado_por = 0
  );

END;

$ BODY $;

ALTER FUNCTION compras_cuenta.get_cuenta(character varying, integer, integer, integer) OWNER TO vince;