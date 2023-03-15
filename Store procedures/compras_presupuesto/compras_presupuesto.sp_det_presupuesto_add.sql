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
-- PROCEDURE: compras_presupuesto.sp_det_presupuesto_add(integer, integer, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, integer)
-- DROP PROCEDURE IF EXISTS compras_presupuesto.sp_det_presupuesto_add(integer, integer, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, integer);
CREATE
OR REPLACE PROCEDURE compras_presupuesto.sp_det_presupuesto_add(
  det_presupuesto_id integer,
  cuenta_id integer,
  nmc_monto_inicial numeric,
  nmc_monto_final numeric,
  nmc_enero_inicial numeric,
  nmc_enero_final numeric,
  nmc_febrero_inicial numeric,
  nmc_febrero_final numeric,
  nmc_marzo_inicial numeric,
  nmc_marzo_final numeric,
  nmc_abril_inicial numeric,
  nmc_abril_final numeric,
  nmc_mayo_inicial numeric,
  nmc_mayo_final numeric,
  nmc_junio_inicial numeric,
  nmc_junio_final numeric,
  nmc_julio_inicial numeric,
  nmc_julio_final numeric,
  nmc_agosto_inicial numeric,
  nmc_agosto_final numeric,
  nmc_septiembre_inicial numeric,
  nmc_septiembre_final numeric,
  nmc_octubre_inicial numeric,
  nmc_octubre_final numeric,
  nmc_noviembre_inicial numeric,
  nmc_noviembre_final numeric,
  nmc_diciembre_inicial numeric,
  nmc_diciembre_final numeric,
  creado_por_id integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
INSERT INTO
  compras_presupuesto.tbl_det_presupuesto (
    id_cat_presupuesto,
    id_cat_cuenta,
    monto_inicial,
    enero_inicial,
    enero_final,
    febrero_inicial,
    febrero_final,
    marzo_inicial,
    marzo_final,
    abril_inicial,
    abril_final,
    mayo_inicial,
    mayo_final,
    junio_inicial,
    junio_final,
    julio_inicial,
    julio_final,
    agosto_inicial,
    agosto_final,
    septiembre_inicial,
    septiembre_final,
    octubre_inicial,
    octubre_final,
    noviembre_inicial,
    noviembre_final,
    diciembre_inicial,
    diciembre_final,
    estado,
    fecha_creacion,
    fecha_actualizacion,
    creado_por,
    actualizado_por,
    monto_final
  )
VALUES
  (
    det_presupuesto_id,
    cuenta_id,
    nmc_monto_inicial,
    nmc_enero_inicial,
    nmc_enero_final,
    nmc_febrero_inicial,
    nmc_febrero_final,
    nmc_marzo_inicial,
    nmc_marzo_final,
    nmc_abril_inicial,
    nmc_abril_final,
    nmc_mayo_inicial,
    nmc_mayo_final,
    nmc_junio_inicial,
    nmc_junio_final,
    nmc_julio_inicial,
    nmc_julio_final,
    nmc_agosto_inicial,
    nmc_agosto_final,
    nmc_septiembre_inicial,
    nmc_septiembre_final,
    nmc_octubre_inicial,
    nmc_octubre_final,
    nmc_noviembre_inicial,
    nmc_noviembre_final,
    nmc_diciembre_inicial,
    nmc_diciembre_final,
    1,
    now(),
    now(),
    creado_por_id,
    creado_por_id,
    nmc_monto_final
  );

end $ BODY $;

ALTER PROCEDURE compras_presupuesto.sp_det_presupuesto_add(
  integer,
  integer,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  numeric,
  integer
) OWNER TO vince;