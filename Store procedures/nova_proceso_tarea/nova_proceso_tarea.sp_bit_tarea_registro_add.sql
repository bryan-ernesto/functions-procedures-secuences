/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: procedimiento que permite agregar el registro de una nueva tarea para un usuario
 Dependencias: nova_proceso_tarea.tbl_bit_tarea_registro
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: nova_proceso_tarea.sp_bit_tarea_registro_add(integer, integer, integer, date, integer, integer, integer)
-- DROP PROCEDURE IF EXISTS nova_proceso_tarea.sp_bit_tarea_registro_add(integer, integer, integer, date, integer, integer, integer);
CREATE
OR REPLACE PROCEDURE nova_proceso_tarea.sp_bit_tarea_registro_add(
  int_id_cat_usuario integer,
  int_id_cat_tarea_estado integer,
  int_id_cat_tarea integer,
  dt_fecha date,
  int_estado integer,
  int_creado_por integer,
  int_modificado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
INSERT INTO
  nova_proceso_tarea.tbl_bit_tarea_registro (
    id_cat_usuario,
    id_cat_tarea_estado,
    id_cat_tarea,
    fecha,
    inicio,
    fin,
    estado,
    creado_por,
    modificado_por,
    fecha_creacion,
    fecha_actualizacion
  )
VALUES
  (
    int_id_cat_usuario,
    int_id_cat_tarea_estado,
    int_id_cat_tarea,
    dt_fecha,
    now(),
    null,
    int_estado,
    int_creado_por,
    int_modificado_por,
    now(),
    now()
  );

end $ BODY $;

ALTER PROCEDURE nova_proceso_tarea.sp_bit_tarea_registro_add(
  integer,
  integer,
  integer,
  date,
  integer,
  integer,
  integer
) OWNER TO vince;