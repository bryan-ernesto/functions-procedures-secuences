/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 13 marzo 2023
 Descripción: procedimiento que permite actualizar la información de un estado para presupuestos por medio de su id
 Dependencias: compras_presupuesto.tbl_cat_presupuesto_estado
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: compras_presupuesto.sp_cat_presupuesto_estado_update(integer, character varying, character varying, integer, integer)
-- DROP PROCEDURE IF EXISTS compras_presupuesto.sp_cat_presupuesto_estado_update(integer, character varying, character varying, integer, integer);
CREATE
OR REPLACE PROCEDURE compras_presupuesto.sp_cat_presupuesto_estado_update(
  int_id_cat_presupuesto_estado integer,
  str_nombre character varying,
  str_descripcion character varying,
  int_estado integer,
  int_actualizado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
UPDATE
  compras_presupuesto.tbl_cat_presupuesto_estado
SET
  nombre = str_nombre,
  descripcion = str_descripcion,
  estado = int_estado,
  fecha_actualizacion = now(),
  actualizado_por = int_actualizado_por
WHERE
  id_cat_presupuesto_estado = int_id_cat_presupuesto_estado;

end $ BODY $;

ALTER PROCEDURE compras_presupuesto.sp_cat_presupuesto_estado_update(
  integer,
  character varying,
  character varying,
  integer,
  integer
) OWNER TO vince;