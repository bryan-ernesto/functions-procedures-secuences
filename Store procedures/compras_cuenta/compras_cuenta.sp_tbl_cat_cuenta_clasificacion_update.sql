/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: Procedimiento que permite la actualización del nombre del nombre de una clasificación de cuenta.
 Dependencias: compras_cuenta.tbl_cat_cuenta_clasificacion
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: compras_cuenta.sp_tbl_cat_cuenta_clasificacion_update(integer, character varying, integer, integer)
-- DROP PROCEDURE IF EXISTS compras_cuenta.sp_tbl_cat_cuenta_clasificacion_update(integer, character varying, integer, integer);
CREATE
OR REPLACE PROCEDURE compras_cuenta.sp_tbl_cat_cuenta_clasificacion_update(
  int_clasificacion_id integer,
  str_nombre character varying,
  int_estado integer,
  int_actualizado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
UPDATE
  compras_cuenta.tbl_cat_cuenta_clasificacion
SET
  nombre = str_nombre,
  estado = int_estado,
  fecha_actualizacion = now(),
  actualizado_por = int_actualizado_por
WHERE
  id_cat_cuenta_clasificacion = int_clasificacion_id;

end $ BODY $;

ALTER PROCEDURE compras_cuenta.sp_tbl_cat_cuenta_clasificacion_update(integer, character varying, integer, integer) OWNER TO vince;