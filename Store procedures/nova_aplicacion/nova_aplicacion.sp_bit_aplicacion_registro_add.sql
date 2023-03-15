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
-- PROCEDURE: nova_aplicacion.sp_bit_aplicacion_registro_add(integer, integer, integer, integer, integer, integer, character varying)
-- DROP PROCEDURE IF EXISTS nova_aplicacion.sp_bit_aplicacion_registro_add(integer, integer, integer, integer, integer, integer, character varying);
CREATE
OR REPLACE PROCEDURE nova_aplicacion.sp_bit_aplicacion_registro_add(
  IN int_id_cat_usuario integer,
  IN int_id_cat_aplicacion integer,
  IN int_estado integer,
  IN int_creado_por integer,
  IN int_modificado_por integer,
  IN int_id_bit_tarea_registro integer,
  IN str_descripcion character varying
) LANGUAGE 'plpgsql' AS $ BODY $ begin IF (
  (
    SELECT
      count(*)
    FROM
      nova_aplicacion.tbl_bit_aplicacion_registro
    where
      id_cat_usuario = int_id_cat_usuario
      and id_cat_aplicacion = int_id_cat_aplicacion
      and id_bit_tarea_registro = int_id_bit_tarea_registro
      and descripcion = str_descripcion
  ) <= 0
) then
INSERT INTO
  nova_aplicacion.tbl_bit_aplicacion_registro (
    id_cat_usuario,
    id_cat_aplicacion,
    estado,
    creado_por,
    modificado_por,
    fecha_creacion,
    fecha_actualizacion,
    id_bit_tarea_registro,
    descripcion
  )
VALUES
(
    int_id_cat_usuario,
    int_id_cat_aplicacion,
    int_estado,
    int_creado_por,
    int_modificado_por,
    now(),
    now(),
    int_id_bit_tarea_registro,
    str_descripcion
  );

end IF;

end $ BODY $;

ALTER PROCEDURE nova_aplicacion.sp_bit_aplicacion_registro_add(
  integer,
  integer,
  integer,
  integer,
  integer,
  integer,
  character varying
) OWNER TO vince;