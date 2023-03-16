/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: función que permite hacer un conteo del tiempo que un usuario permanece activo durante el día
 Dependencias: 
 ERD:
 Nombre ERD: 
 */
-- FUNCTION: nova_proceso_tarea.get_count_tiempo_activo_x_dia_actual(integer, integer)
-- DROP FUNCTION IF EXISTS nova_proceso_tarea.get_count_tiempo_activo_x_dia_actual(integer, integer);
CREATE
OR REPLACE FUNCTION nova_proceso_tarea.get_count_tiempo_activo_x_dia_actual(
  int_id_cat_usuario integer,
  int_id_cat_tarea integer
) RETURNS TABLE(tiempo_en_tareas text) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY WITH tiempo_en_segundos AS (
  SELECT
    sum(
      DATE_PART('epoch', tbtr.fin - tbtr.inicio) :: integer
    ) as diferencia_segundos
  FROM
    nova_proceso_tarea.tbl_bit_tarea_registro tbtr
    JOIN nova_proceso_tarea.tbl_cat_tarea tct ON tct.id_cat_tarea = tbtr.id_cat_tarea
  WHERE
    (
      tbtr.id_cat_usuario = int_id_cat_usuario
      or int_id_cat_usuario = 0
    )
    and (
      tbtr.id_cat_tarea = int_id_cat_tarea
      or int_id_cat_tarea = 0
    )
    AND tbtr.fin IS not null
    and to_date(to_char(tbtr.inicio, 'YYYY-MM-DD'), 'YYYY-MM-DD') = current_date
),
horas_minutos_segundos AS (
  SELECT
    (diferencia_segundos / 3600) AS horas,
    (diferencia_segundos % 3600 / 60) AS minutos,
    (diferencia_segundos % 60) AS segundos
  FROM
    tiempo_en_segundos
)
SELECT
  to_char(horas, 'FM09') || ':' || to_char(minutos, 'FM09') || ':' || to_char(segundos, 'FM09') as tiempo_en_tareas
FROM
  horas_minutos_segundos;

END;

$ BODY $;

ALTER FUNCTION nova_proceso_tarea.get_count_tiempo_activo_x_dia_actual(integer, integer) OWNER TO vince;