/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 13 marzo 2023
 Descripción: procedimiento que permite agregar un nuevo presupuesto
 Dependencias: compras_presupuesto.tbl_cat_presupuesto
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: compras_presupuesto.sp_cat_presupuesto_add(integer, numeric, integer, integer, integer, integer)
-- DROP PROCEDURE IF EXISTS compras_presupuesto.sp_cat_presupuesto_add(integer, numeric, integer, integer, integer, integer);
CREATE
OR REPLACE PROCEDURE compras_presupuesto.sp_cat_presupuesto_add(
  empresa_id integer,
  nmc_monto numeric,
  "int_año" integer,
  responsable_id integer,
  presupuesto_id integer,
  creado_por_id integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
INSERT INTO
  compras_presupuesto.tbl_cat_presupuesto (
    id_cat_empresa,
    monto,
    año,
    usuario_responsable,
    id_cat_presupuesto_estado,
    estado,
    fecha_creacion,
    fecha_actualizacion,
    creado_por,
    actualizado_por
  )
VALUES
  (
    empresa_id,
    nmc_monto,
    int_año,
    responsable_id,
    1,
    presupuesto_id,
    now(),
    now(),
    creado_por_id,
    creado_por_id
  );

end $ BODY $;

ALTER PROCEDURE compras_presupuesto.sp_cat_presupuesto_add(
  integer,
  numeric,
  integer,
  integer,
  integer,
  integer
) OWNER TO vince;