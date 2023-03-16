/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: función que hace un conteo de las tareas activas que tiene un usuario por medio de su id
 Dependencias: nova_proceso_tarea.tbl_bit_tarea_registro, nova_proceso_tarea.tbl_cat_tarea
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: nova_proceso_tarea.get_count_tareas_activas(integer)
-- DROP FUNCTION IF EXISTS nova_proceso_tarea.get_count_tareas_activas(integer);
CREATE
OR REPLACE FUNCTION nova_proceso_tarea.get_count_tareas_activas(int_id_cat_usuario integer) RETURNS TABLE(
  tareas_contador_tareas_activas bigint,
  tareas_id_cat_tarea integer,
  tarea_nombre text,
  id_bit_tarea_registro integer,
  fecha_asignacion text
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
SELECT
  count(tbtr.id_bit_tarea_registro) AS tareas_contador_tareas_activas,
  tbtr.id_cat_tarea AS tareas_id_cat_tarea,
  trim(tct.nombre) AS tarea_nombre,
  tbtr.id_bit_tarea_registro,
  to_char(tbtr.inicio, 'YYYY-MM-DD HH:MI:SS') as fecha_asignacion
FROM
  nova_proceso_tarea.tbl_bit_tarea_registro tbtr
  JOIN nova_proceso_tarea.tbl_cat_tarea tct ON tct.id_cat_tarea = tbtr.id_cat_tarea
WHERE
  --tbtr.id_cat_usuario = 1
  (
    tbtr.id_cat_usuario = int_id_cat_usuario
    or int_id_cat_usuario = 0
  )
  AND tbtr.fin IS NULL
GROUP BY
  tbtr.id_cat_tarea,
  tct.nombre,
  tbtr.id_bit_tarea_registro,
  tbtr.inicio;

END;

$ BODY $;

ALTER FUNCTION nova_proceso_tarea.get_count_tareas_activas(integer) OWNER TO vince;