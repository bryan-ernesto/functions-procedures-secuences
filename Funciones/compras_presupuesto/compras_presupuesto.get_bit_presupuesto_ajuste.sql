/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 16 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: Función que obtiene la información de un presupuesto y sus modificaciones
 Dependencias: compras_presupuesto.tbl_bit_presupuesto_ajuste, compras_presupuesto.tbl_det_presupuesto, compras_cuenta.tbl_cat_cuenta, tbl_cat_usuario
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: compras_presupuesto.get_bit_presupuesto_ajuste(integer, integer, integer, integer, integer)
-- DROP FUNCTION IF EXISTS compras_presupuesto.get_bit_presupuesto_ajuste(integer, integer, integer, integer, integer);
CREATE
OR REPLACE FUNCTION compras_presupuesto.get_bit_presupuesto_ajuste(
  int_id_cuenta_abono integer,
  int_id_cuenta_cargo integer,
  int_id_det_presupuesto integer,
  int_id_cat_usuario_creado_por integer,
  int_id_cat_usuario_actualizado_por integer
) RETURNS TABLE(
  ajuste_id integer,
  det_presupuesto_id integer,
  mes text,
  cuenta_cargo_id integer,
  cuenta_cargo character varying,
  cuenta_abono_id integer,
  cuenta_abono character varying,
  monto numeric,
  justificacion character varying,
  estado integer,
  fecha_creacion_nombre character varying,
  fecha_actualizacion_nombre character varying,
  creado_por_id integer,
  actualizado_por_id integer,
  creado_por_nombre character varying,
  actualizado_por_nombre character varying
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
SELECT
  tbpa.id_bit_presupuesto_ajuste ajuste_id,
  tbpa.id_det_presupuesto as det_presupuesto_id,
  replace(tbpa.mes, '_final', '') as mes,
  tbpa.cuenta_cargo as cuenta_cargo_id,
  cuenta_cargo_nombre.nombre as cuenta_cargo,
  tbpa.cuenta_abono as cuenta_abono_id,
  cuenta_abono_nombre.nombre as cuenta_abono,
  tbpa.monto,
  tbpa.justificacion,
  tbpa.estado,
  to_char(tbpa.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as fecha_creacion_nombre,
  to_char(
    tbpa.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as fecha_actualizacion_nombre,
  tbpa.creado_por as creado_por_id,
  tbpa.actualizado_por as actualizado_por_id,
  cast(creado_por_nombre.nombre as varchar) as creado_por_nombre,
  (modificado_por_nombre.nombre) :: varchar as actualizado_por_nombre
FROM
  compras_presupuesto.tbl_bit_presupuesto_ajuste tbpa
  JOIN compras_presupuesto.tbl_det_presupuesto tdp ON tdp.id_det_presupuesto = tbpa.id_det_presupuesto
  join compras_cuenta.tbl_cat_cuenta tcc on tcc.id_cat_cuenta = tdp.id_cat_cuenta
  LEFT JOIN LATERAL (
    SELECT
      tcu3.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu3
    WHERE
      tcu3.id_cat_usuario = tbpa.creado_por
  ) creado_por_nombre ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu4.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu4
    WHERE
      tcu4.id_cat_usuario = tbpa.actualizado_por
  ) modificado_por_nombre ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu5.nombre as nombre
    FROM
      compras_cuenta.tbl_cat_cuenta tcu5
    WHERE
      tcu5.id_cat_cuenta = tbpa.cuenta_abono
  ) cuenta_abono_nombre ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu6.nombre as nombre
    FROM
      compras_cuenta.tbl_cat_cuenta tcu6
    WHERE
      tcu6.id_cat_cuenta = tbpa.cuenta_cargo
  ) cuenta_cargo_nombre ON true
where
  (
    tbpa.cuenta_abono = int_id_cuenta_abono
    or int_id_cuenta_abono = 0
  )
  and (
    tbpa.cuenta_cargo = int_id_cuenta_cargo
    or int_id_cuenta_cargo = 0
  )
  and (
    tbpa.id_det_presupuesto = int_id_det_presupuesto
    or int_id_det_presupuesto = 0
  )
  and (
    tbpa.creado_por = int_id_cat_usuario_creado_por
    or int_id_cat_usuario_creado_por = 0
  )
  and (
    tbpa.actualizado_por = int_id_cat_usuario_actualizado_por
    or int_id_cat_usuario_actualizado_por = 0
  );

END;

$ BODY $;

ALTER FUNCTION compras_presupuesto.get_bit_presupuesto_ajuste(integer, integer, integer, integer, integer) OWNER TO vince;