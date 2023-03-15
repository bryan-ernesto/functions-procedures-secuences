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
-- PROCEDURE: compras_cuenta.sp_tbl_cat_cuenta_add(integer, character varying, character varying, integer)
-- DROP PROCEDURE IF EXISTS compras_cuenta.sp_tbl_cat_cuenta_add(integer, character varying, character varying, integer);
CREATE
OR REPLACE PROCEDURE compras_cuenta.sp_tbl_cat_cuenta_add(
  int_clasificacion_id integer,
  str_nombre character varying,
  str_descripcion character varying,
  int_creado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
INSERT INTO
  compras_cuenta.tbl_cat_cuenta (
    id_cat_cuenta_clasificacion,
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
    int_clasificacion_id,
    str_nombre,
    str_descripcion,
    1,
    now(),
    now(),
    int_creado_por,
    int_creado_por
  );

end $ BODY $;

ALTER PROCEDURE compras_cuenta.sp_tbl_cat_cuenta_add(
  integer,
  character varying,
  character varying,
  integer
) OWNER TO vince;