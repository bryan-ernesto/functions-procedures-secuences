/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: procedimiento que permite actualizar la información de una tarea a través de su ID
 Dependencias: nova_proceso_tarea.tbl_bit_tarea_registro
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: nova_proceso_tarea.sp_bit_proceso_tarea_fin_upd(integer, integer)
-- DROP PROCEDURE IF EXISTS nova_proceso_tarea.sp_bit_proceso_tarea_fin_upd(integer, integer);
CREATE
OR REPLACE PROCEDURE nova_proceso_tarea.sp_bit_proceso_tarea_fin_upd(
  int_id_cat_usuario integer,
  int_id_bit_tarea_registro integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
UPDATE
  nova_proceso_tarea.tbl_bit_tarea_registro
SET
  fin = now(),
  modificado_por = int_id_cat_usuario,
  fecha_actualizacion = now()
WHERE
  id_cat_tarea = int_id_bit_tarea_registro
  and id_bit_tarea_registro = (
    select
      max(tct.id_bit_tarea_registro)
    from
      nova_proceso_tarea.tbl_bit_tarea_registro tct
    where
      tct.id_cat_tarea = int_id_bit_tarea_registro
      and tct.id_cat_usuario = int_id_cat_usuario
  );

end $ BODY $;

ALTER PROCEDURE nova_proceso_tarea.sp_bit_proceso_tarea_fin_upd(integer, integer) OWNER TO vince;