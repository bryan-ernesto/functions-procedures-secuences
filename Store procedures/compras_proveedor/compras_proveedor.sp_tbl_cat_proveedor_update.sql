/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: procedimiento que permite modificar la información de un proveedor por medio de su id
 Dependencias: compras_proveedor.tbl_cat_proveedor
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: compras_proveedor.sp_tbl_cat_proveedor_update(integer, integer, integer, character varying, character varying, character varying, integer, integer, character varying, integer, integer, integer)
-- DROP PROCEDURE IF EXISTS compras_proveedor.sp_tbl_cat_proveedor_update(integer, integer, integer, character varying, character varying, character varying, integer, integer, character varying, integer, integer, integer);
CREATE
OR REPLACE PROCEDURE compras_proveedor.sp_tbl_cat_proveedor_update(
  int_proveedor_id integer,
  int_giro_id integer,
  int_tipo_id integer,
  str_nombre character varying,
  str_nit character varying,
  str_email character varying,
  int_telefono integer,
  int_celular integer,
  str_rtu character varying,
  int_estado integer,
  int_actualizado_por integer,
  int_id_cat_usuario integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
UPDATE
  compras_proveedor.tbl_cat_proveedor
SET
  id_cat_proveedor_giro = int_giro_id,
  nombre_completo = str_nombre,
  nit = str_nit,
  email = str_email,
  telefono_contacto = int_telefono,
  celular_personal = int_celular,
  rtu_archivo = str_rtu,
  id_cat_proveedor_tipo = int_tipo_id,
  estado = int_estado,
  fecha_actualizacion = now(),
  actualizado_por = int_actualizado_por,
  id_cat_usuario = int_id_cat_usuario
WHERE
  id_cat_proveedor = int_proveedor_id;

end $ BODY $;

ALTER PROCEDURE compras_proveedor.sp_tbl_cat_proveedor_update(
  integer,
  integer,
  integer,
  character varying,
  character varying,
  character varying,
  integer,
  integer,
  character varying,
  integer,
  integer,
  integer
) OWNER TO vince;