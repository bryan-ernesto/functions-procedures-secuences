/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 13 marzo 2023
 Descripción: Procedimiento que permite la actualización de una cuenta con los parámetros enviados
 Dependencias: compras_cuenta.tbl_cat_cuenta
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: compras_cuenta.sp_tbl_cat_cuenta_update(integer, integer, character varying, character varying, integer, integer)
-- DROP PROCEDURE IF EXISTS compras_cuenta.sp_tbl_cat_cuenta_update(integer, integer, character varying, character varying, integer, integer);
CREATE
OR REPLACE PROCEDURE compras_cuenta.sp_tbl_cat_cuenta_update(
  int_cuenta_id integer,
  int_clasificacion_id integer,
  str_nombre character varying,
  str_descripcion character varying,
  int_estado integer,
  int_actualizado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
UPDATE
  compras_cuenta.tbl_cat_cuenta
SET
  id_cat_cuenta_clasificacion = int_clasificacion_id,
  nombre = str_nombre,
  descripcion = str_descripcion,
  estado = int_estado,
  fecha_actualizacion = now(),
  actualizado_por = int_actualizado_por
WHERE
  id_cat_cuenta = int_cuenta_id;

end $ BODY $;

ALTER PROCEDURE compras_cuenta.sp_tbl_cat_cuenta_update(
  integer,
  integer,
  character varying,
  character varying,
  integer,
  integer
) OWNER TO vince;