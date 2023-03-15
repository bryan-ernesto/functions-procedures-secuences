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
-- PROCEDURE: compras_presupuesto.sp_bit_presupuesto_ajuste_add(integer, character varying, integer, integer, numeric, character varying, integer)
-- DROP PROCEDURE IF EXISTS compras_presupuesto.sp_bit_presupuesto_ajuste_add(integer, character varying, integer, integer, numeric, character varying, integer);
CREATE
OR REPLACE PROCEDURE compras_presupuesto.sp_bit_presupuesto_ajuste_add(
  IN det_presupuesto_id integer,
  IN str_mes character varying,
  IN int_cuenta_abono integer,
  IN int_cuenta_cargo integer,
  IN mnt_monto numeric,
  IN str_justificacion character varying,
  IN creado_por_id integer
) LANGUAGE 'plpgsql' AS $ BODY $ BEGIN
INSERT INTO
  compras_presupuesto.tbl_bit_presupuesto_ajuste (
    id_det_presupuesto,
    mes,
    cuenta_abono,
    cuenta_cargo,
    monto,
    justificacion,
    estado,
    fecha_creacion,
    fecha_actualizacion,
    creado_por,
    actualizado_por
  )
VALUES
  (
    det_presupuesto_id,
    str_mes,
    int_cuenta_abono,
    int_cuenta_cargo,
    mnt_monto,
    str_justificacion,
    1,
    NOW(),
    NOW(),
    creado_por_id,
    creado_por_id
  );

-- Actualiza la columna correspondiente en la tabla tbl_det_presupuesto cargo
EXECUTE format(
  'UPDATE compras_presupuesto.tbl_det_presupuesto SET %I = %I - $1,fecha_actualizacion = now(),actualizado_por = $3,monto_final = monto_final - $1 WHERE  id_cat_cuenta = $2',
  str_mes,
  str_mes
) USING mnt_monto,
int_cuenta_cargo,
creado_por_id;

-- Actualiza la columna correspondiente en la tabla tbl_det_presupuesto abono
EXECUTE format(
  'UPDATE compras_presupuesto.tbl_det_presupuesto SET %I = %I + $1,fecha_actualizacion = now(),actualizado_por = $3,monto_final = monto_final + $1 WHERE  id_cat_cuenta = $2',
  str_mes,
  str_mes
) USING mnt_monto,
int_cuenta_abono,
creado_por_id;

END;

$ BODY $;

ALTER PROCEDURE compras_presupuesto.sp_bit_presupuesto_ajuste_add(
  integer,
  character varying,
  integer,
  integer,
  numeric,
  character varying,
  integer
) OWNER TO vince;