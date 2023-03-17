/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: procedimiento que permite modificar / actualizar la informaciòn del detalle de un presupuesto por medio de su id
 Dependencias: compras_presupuesto.tbl_det_presupuesto
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: compras_presupuesto.sp_det_presupuesto_update(integer, integer, integer, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, integer)
-- DROP PROCEDURE IF EXISTS compras_presupuesto.sp_det_presupuesto_update(integer, integer, integer, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, integer);
CREATE
OR REPLACE PROCEDURE compras_presupuesto.sp_det_presupuesto_update(
  det_presupuesto_id integer,
  cat_presupuesto_id integer,
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
  int_estado numeric,
  int_actualizado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
UPDATE
  compras_presupuesto.tbl_det_presupuesto
SET
  id_cat_presupuesto = cat_presupuesto_id,
  id_cat_cuenta = cuenta_id,
  monto_inicial = nmc_monto_inicial,
  enero_inicial = nmc_enero_inicial,
  enero_final = nmc_enero_final,
  febrero_inicial = nmc_febrero_inicial,
  febrero_final = nmc_febrero_final,
  marzo_inicial = nmc_marzo_inicial,
  marzo_final = nmc_marzo_final,
  abril_inicial = nmc_abril_inicial,
  abril_final = nmc_abril_final,
  mayo_inicial = nmc_mayo_inicial,
  mayo_final = nmc_mayo_final,
  junio_inicial = nmc_junio_inicial,
  junio_final = nmc_junio_final,
  julio_inicial = nmc_julio_inicial,
  julio_final = nmc_julio_final,
  agosto_inicial = nmc_agosto_inicial,
  agosto_final = nmc_agosto_final,
  septiembre_inicial = nmc_septiembre_inicial,
  septiembre_final = nmc_septiembre_final,
  octubre_inicial = nmc_octubre_inicial,
  octubre_final = nmc_octubre_final,
  noviembre_inicial = nmc_noviembre_inicial,
  noviembre_final = nmc_noviembre_final,
  diciembre_inicial = nmc_diciembre_inicial,
  diciembre_final = nmc_diciembre_final,
  estado = int_estado,
  fecha_actualizacion = now(),
  actualizado_por = int_actualizado_por,
  monto_final = nmc_monto_final
WHERE
  id_det_presupuesto = det_presupuesto_id;

end $ BODY $;

ALTER PROCEDURE compras_presupuesto.sp_det_presupuesto_update(
  integer,
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
  numeric,
  integer
) OWNER TO vince;