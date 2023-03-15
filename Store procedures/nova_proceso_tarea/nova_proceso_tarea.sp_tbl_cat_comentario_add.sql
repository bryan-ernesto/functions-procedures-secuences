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
-- PROCEDURE: nova_proceso_tarea.sp_tbl_cat_comentario_add(integer, character varying, integer, integer)
-- DROP PROCEDURE IF EXISTS nova_proceso_tarea.sp_tbl_cat_comentario_add(integer, character varying, integer, integer);
CREATE
OR REPLACE PROCEDURE nova_proceso_tarea.sp_tbl_cat_comentario_add(
  int_id_bit_tarea_registro integer,
  str_descripcion character varying,
  int_estado integer,
  int_id_cat_usuario integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
INSERT INTO
  nova_proceso_tarea.tbl_bit_tarea_comentario (
    id_bit_tarea_registro,
    descripcion,
    estado,
    fecha_creacion,
    fecha_actualizacion,
    creado_por,
    modificador_por
  )
VALUES
  (
    int_id_bit_tarea_registro,
    str_descripcion,
    int_estado,
    now(),
    now(),
    int_id_cat_usuario,
    int_id_cat_usuario
  );

end $ BODY $;

ALTER PROCEDURE nova_proceso_tarea.sp_tbl_cat_comentario_add(integer, character varying, integer, integer) OWNER TO vince;