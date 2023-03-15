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
-- FUNCTION: compras_presupuesto.get_presupuesto(integer, integer, integer, integer)
-- DROP FUNCTION IF EXISTS compras_presupuesto.get_presupuesto(integer, integer, integer, integer);
CREATE
OR REPLACE FUNCTION compras_presupuesto.get_presupuesto(
  int_id_cat_empresa integer,
  int_presupuesto_estado integer,
  int_creado_por integer,
  int_actualizado_por integer
) RETURNS TABLE(
  presupuesto_id integer,
  empresa_id integer,
  empresa_nombre character varying,
  usuario_responsable_id integer,
  usuario_responsable character varying,
  presupuesto_nombre_id integer,
  presupuesto_nombre_estado character varying,
  monto numeric,
  "año" integer,
  estado integer,
  fecha_creacion character varying,
  fecha_actualizacion character varying,
  creado_por_id integer,
  actualizado_por_id integer,
  creado_por character varying,
  actualizado_por character varying
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tcp.id_cat_presupuesto as presupuesto_id,
  tcp.id_cat_empresa as empresa_id,
  tce.nombre as empresa_nombre,
  tcp.usuario_responsable as usuario_responsable_id,
  tcu.nombre as usuario_responsable,
  tcpe.id_cat_presupuesto_estado as presupuesto_nombre_id,
  tcpe.nombre as presupuesto_nombre_estado,
  tcp.monto,
  tcp.año,
  tcp.estado,
  to_char(tcp.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as fecha_creacion,
  to_char(
    tcp.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as fecha_actualizacion,
  tcp.creado_por as creado_por_id,
  tcp.actualizado_por as actualizado_por_id,
  creado_por.nombre as creado_por,
  modificado_por.nombre as actualizado_por
from
  compras_presupuesto.tbl_cat_presupuesto tcp
  join usuarios.tbl_cat_empresa tce on tce.id_cat_empresa = tcp.id_cat_empresa
  join usuarios.tbl_cat_usuario tcu on tcu.id_cat_usuario = tcp.usuario_responsable
  join compras_presupuesto.tbl_cat_presupuesto_estado tcpe on tcpe.id_cat_presupuesto_estado = tcp.id_cat_presupuesto_estado
  LEFT JOIN LATERAL (
    SELECT
      tcu3.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu3
    WHERE
      tcu3.id_cat_usuario = tcp.creado_por
  ) creado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu4.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu4
    WHERE
      tcu4.id_cat_usuario = tcp.actualizado_por
  ) modificado_por ON TRUE
where
  (
    tcp.id_cat_empresa = int_id_cat_empresa
    or int_id_cat_empresa = 0
  )
  and (
    tcp.id_cat_presupuesto_estado = int_presupuesto_estado
    or int_presupuesto_estado = 0
  )
  and (
    tcp.creado_por = int_creado_por
    or int_creado_por = 0
  )
  and (
    tcp.actualizado_por = int_actualizado_por
    or int_actualizado_por = 0
  )
order by
  tcp.id_cat_presupuesto asc;

END;

$ BODY $;

ALTER FUNCTION compras_presupuesto.get_presupuesto(integer, integer, integer, integer) OWNER TO vince;