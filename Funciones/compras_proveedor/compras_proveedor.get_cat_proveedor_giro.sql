/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 13 marzo 2023
 Descripción: procedimiento que muestra el tipo de giro de un proveedor
 Dependencias: compras_proveedor.tbl_cat_proveedor_giro
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: compras_proveedor.get_cat_proveedor_giro(character varying, integer, integer)
-- DROP FUNCTION IF EXISTS compras_proveedor.get_cat_proveedor_giro(character varying, integer, integer);
CREATE
OR REPLACE FUNCTION compras_proveedor.get_cat_proveedor_giro(
  str_nombre character varying,
  int_id_creado_por integer,
  int_id_actualizado_por integer
) RETURNS TABLE(
  tipo_id integer,
  nombre character varying,
  estado integer,
  fecha_creacion character varying,
  fecha_actualizacion character varying,
  creado_por_id integer,
  actualizado_por_id integer,
  creado_por character varying,
  actualizado_por character varying
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tcpt.id_cat_proveedor_giro as tipo_id,
  tcpt.nombre as nombre,
  tcpt.estado as estado,
  to_char(tcpt.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as fecha_creacion,
  to_char(
    tcpt.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as fecha_actualizacion,
  tcpt.creado_por as creado_por_id,
  tcpt.actualizado_por as actualizado_por_id,
  creado_por.nombre as creado_por,
  modificado_por.nombre as actualizado_por
from
  compras_proveedor.tbl_cat_proveedor_giro tcpt
  LEFT JOIN LATERAL (
    SELECT
      tcu3.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu3
    WHERE
      tcu3.id_cat_usuario = tcpt.creado_por
  ) creado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu4.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu4
    WHERE
      tcu4.id_cat_usuario = tcpt.actualizado_por
  ) modificado_por ON true
where
  (
    upper(tcpt.nombre) LIKE ('%' || upper(str_nombre) || '%') :: varchar
    or LENGTH (upper(str_nombre)) = 0
  )
  and (
    tcpt.creado_por = int_id_creado_por
    or int_id_creado_por = 0
  )
  and (
    tcpt.actualizado_por = int_id_actualizado_por
    or int_id_actualizado_por = 0
  );

END;

$ BODY $;

ALTER FUNCTION compras_proveedor.get_cat_proveedor_giro(character varying, integer, integer) OWNER TO vince;