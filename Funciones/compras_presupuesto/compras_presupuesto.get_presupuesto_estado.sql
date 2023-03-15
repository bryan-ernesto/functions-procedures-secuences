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
-- FUNCTION: compras_presupuesto.get_presupuesto_estado(character varying, integer, integer)
-- DROP FUNCTION IF EXISTS compras_presupuesto.get_presupuesto_estado(cha racter varying, integer, integer);
CREATE
OR REPLACE FUNCTION compras_presupuesto.get_presupuesto_estado(
  str_nombre character varying,
  int_id_creado_por integer,
  int_id_actualizado_por integer
) RETURNS TABLE(
  estado_id integer,
  nombre character varying,
  descripcion character varying,
  estado integer,
  fecha_creacion character varying,
  fecha_actualizacion character varying,
  actualizado_por_id integer,
  creado_por_id integer,
  creado_por character varying,
  actualizado_por character varying
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tcpe.id_cat_presupuesto_estado as estado_id,
  tcpe.nombre as nombre,
  tcpe.descripcion as descripcion,
  tcpe.estado,
  to_char(tcpe.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as fecha_creacion,
  to_char(
    tcpe.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as fecha_actualizacion,
  tcpe.actualizado_por actualizado_por_id,
  tcpe.creado_por as creado_por_id,
  creado_por.nombre as creado_por,
  modificado_por.nombre as actualizado_por
from
  compras_presupuesto.tbl_cat_presupuesto_estado tcpe
  LEFT JOIN LATERAL (
    SELECT
      tcu3.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu3
    WHERE
      tcu3.id_cat_usuario = tcpe.creado_por
  ) creado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu4.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu4
    WHERE
      tcu4.id_cat_usuario = tcpe.actualizado_por
  ) modificado_por ON TRUE
where
  (
    upper(tcpe.nombre) LIKE ('%' || upper(str_nombre) || '%') :: varchar
    or LENGTH (upper(str_nombre)) = 0
  )
  and (
    tcpe.creado_por = int_id_creado_por
    or int_id_creado_por = 0
  )
  and (
    tcpe.actualizado_por = int_id_actualizado_por
    or int_id_actualizado_por = 0
  );

END;

$ BODY $;

ALTER FUNCTION compras_presupuesto.get_presupuesto_estado(character varying, integer, integer) OWNER TO vince;