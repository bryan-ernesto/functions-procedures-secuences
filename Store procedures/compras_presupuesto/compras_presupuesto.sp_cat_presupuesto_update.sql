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
-- PROCEDURE: compras_presupuesto.sp_cat_presupuesto_update(integer, integer, integer, integer, numeric, integer, integer, integer)
-- DROP PROCEDURE IF EXISTS compras_presupuesto.sp_cat_presupuesto_update(integer, integer, integer, integer, numeric, integer, integer, integer);
CREATE
OR REPLACE PROCEDURE compras_presupuesto.sp_cat_presupuesto_update(
  presupuesto_id integer,
  empresa_id integer,
  responsable_id integer,
  presupuesto_estado_id integer,
  nmc_monto numeric,
  "int_año" integer,
  int_estado integer,
  actualizado_por_id integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
UPDATE
  compras_presupuesto.tbl_cat_presupuesto
SET
  id_cat_empresa = empresa_id,
  monto = nmc_monto,
  año = int_año,
  usuario_responsable = responsable_id,
  id_cat_presupuesto_estado = presupuesto_estado_id,
  estado = int_estado,
  fecha_actualizacion = now(),
  actualizado_por = actualizado_por_id
WHERE
  id_cat_presupuesto = presupuesto_id;

end $ BODY $;

ALTER PROCEDURE compras_presupuesto.sp_cat_presupuesto_update(
  integer,
  integer,
  integer,
  integer,
  numeric,
  integer,
  integer,
  integer
) OWNER TO vince;