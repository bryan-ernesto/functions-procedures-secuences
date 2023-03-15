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
-- PROCEDURE: compras_cuenta.sp_tbl_cat_cuenta_clasificacion_add(character varying, integer)
-- DROP PROCEDURE IF EXISTS compras_cuenta.sp_tbl_cat_cuenta_clasificacion_add(character varying, integer);
CREATE
OR REPLACE PROCEDURE compras_cuenta.sp_tbl_cat_cuenta_clasificacion_add(
  str_nombre character varying,
  int_creado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
INSERT INTO
  compras_cuenta.tbl_cat_cuenta_clasificacion (
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
    NOW(),
    int_creado_por,
    int_creado_por
  );

end $ BODY $;

ALTER PROCEDURE compras_cuenta.sp_tbl_cat_cuenta_clasificacion_add(character varying, integer) OWNER TO vince;