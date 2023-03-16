/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: procedimiento que permite agregar un nuevo proveedor
 Dependencias: compras_proveedor.tbl_cat_proveedor
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: compras_proveedor.sp_tbl_cat_proveedor_add(integer, integer, character varying, character varying, character varying, integer, integer, character varying, integer, integer)
-- DROP PROCEDURE IF EXISTS compras_proveedor.sp_tbl_cat_proveedor_add(integer, integer, character varying, character varying, character varying, integer, integer, character varying, integer, integer);
CREATE
OR REPLACE PROCEDURE compras_proveedor.sp_tbl_cat_proveedor_add(
  int_giro_id integer,
  int_tipo_id integer,
  str_nombre character varying,
  str_nit character varying,
  str_email character varying,
  int_telefono integer,
  int_celular integer,
  str_archivo character varying,
  int_creado_por integer,
  int_usuario_id integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
INSERT INTO
  compras_proveedor.tbl_cat_proveedor (
    id_cat_proveedor_giro,
    nombre_completo,
    nit,
    email,
    telefono_contacto,
    celular_personal,
    rtu_archivo,
    id_cat_proveedor_tipo,
    estado,
    fecha_creacion,
    fecha_actualizacion,
    creado_por,
    actualizado_por,
    id_cat_usuario
  )
VALUES
  (
    int_giro_id,
    str_nombre,
    str_nit,
    str_email,
    int_telefono,
    int_celular,
    str_archivo,
    int_tipo_id,
    1,
    now(),
    now(),
    int_creado_por,
    int_creado_por,
    int_usuario_id
  );

end $ BODY $;

ALTER PROCEDURE compras_proveedor.sp_tbl_cat_proveedor_add(
  integer,
  integer,
  character varying,
  character varying,
  character varying,
  integer,
  integer,
  character varying,
  integer,
  integer
) OWNER TO vince;