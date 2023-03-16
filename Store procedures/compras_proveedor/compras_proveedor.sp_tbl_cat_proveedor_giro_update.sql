/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: procedimiento que permite actualizar la información de un giro para proveedor a través de su id
 Dependencias: compras_proveedor.tbl_cat_proveedor_giro
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: compras_proveedor.sp_tbl_cat_proveedor_giro_update(integer, character varying, character varying, integer, integer)
-- DROP PROCEDURE IF EXISTS compras_proveedor.sp_tbl_cat_proveedor_giro_update(integer, character varying, character varying, integer, integer);
CREATE
OR REPLACE PROCEDURE compras_proveedor.sp_tbl_cat_proveedor_giro_update(
  int_giro_id integer,
  str_nombre character varying,
  str_descripcion character varying,
  int_estado integer,
  int_actualizado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
UPDATE
  compras_proveedor.tbl_cat_proveedor_giro
SET
  nombre = str_nombre,
  descripcion = str_descripcion,
  estado = int_estado,
  fecha_actualizacion = now(),
  actualizado_por = int_actualizado_por
WHERE
  id_cat_proveedor_giro = int_giro_id;

end $ BODY $;

ALTER PROCEDURE compras_proveedor.sp_tbl_cat_proveedor_giro_update(
  integer,
  character varying,
  character varying,
  integer,
  integer
) OWNER TO vince;