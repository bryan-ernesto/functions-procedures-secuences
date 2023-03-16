/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: procedimiento que permite agregar un nuevo giro para proveedores
 Dependencias: compras_proveedor.tbl_cat_proveedor_giro
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: compras_proveedor.sp_tbl_cat_proveedor_giro_add(character varying, character varying, integer)
-- DROP PROCEDURE IF EXISTS compras_proveedor.sp_tbl_cat_proveedor_giro_add(character varying, character varying, integer);
CREATE
OR REPLACE PROCEDURE compras_proveedor.sp_tbl_cat_proveedor_giro_add(
  str_nombre character varying,
  str_descripcion character varying,
  int_creado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
INSERT INTO
  compras_proveedor.tbl_cat_proveedor_giro (
    nombre,
    descripcion,
    estado,
    fecha_creacion,
    fecha_actualizacion,
    creado_por,
    actualizado_por
  )
VALUES
  (
    str_nombre,
    str_descripcion,
    1,
    now(),
    now(),
    int_creado_por,
    int_creado_por
  );

end $ BODY $;

ALTER PROCEDURE compras_proveedor.sp_tbl_cat_proveedor_giro_add(character varying, character varying, integer) OWNER TO vince;