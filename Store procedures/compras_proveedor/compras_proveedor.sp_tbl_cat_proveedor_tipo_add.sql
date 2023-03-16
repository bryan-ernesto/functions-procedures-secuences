/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 13 marzo 2023
 Descripción: procedimiento que agrega un nuevo tipo de proveedor.
 Dependencias: compras_proveedor.tbl_cat_proveedor_tipo
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: compras_proveedor.sp_tbl_cat_proveedor_tipo_add(character varying, integer)
-- DROP PROCEDURE IF EXISTS compras_proveedor.sp_tbl_cat_proveedor_tipo_add(character varying, integer);
CREATE
OR REPLACE PROCEDURE compras_proveedor.sp_tbl_cat_proveedor_tipo_add(
  str_nombre character varying,
  int_creado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
INSERT INTO
  compras_proveedor.tbl_cat_proveedor_tipo (
    nombre,
    estado,
    fecha_creacion,
    fecha_actualizacion,
    creado_por,
    actualizado_por
  )
VALUES
  (
    str_nombre,
    1,
    now(),
    now(),
    int_creado_por,
    int_creado_por
  );

end $ BODY $;

ALTER PROCEDURE compras_proveedor.sp_tbl_cat_proveedor_tipo_add(character varying, integer) OWNER TO vince;