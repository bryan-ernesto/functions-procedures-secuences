/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: función que permite el conteo de tiempo que un usuario permanece inactivo, cuantas tareas a realizado y cuanto tiempo a pasado activo
 Dependencias: nova_proceso_tarea.tbl_bit_tarea_registro, nova_proceso_tarea.tbl_bit_tarea_registro
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: nova_proceso_tarea.get_count_tiempo_inactivo_x_dia_actual_usuario(integer)
-- DROP FUNCTION IF EXISTS nova_proceso_tarea.get_count_tiempo_inactivo_x_dia_actual_usuario(integer);
CREATE
OR REPLACE FUNCTION nova_proceso_tarea.get_count_tiempo_inactivo_x_dia_actual_usuario(int_id_cat_usuario integer) RETURNS TABLE(
  tareas_realizadas bigint,
  diferencia_segundos numeric,
  str_tiempo_activo text,
  tiempo_activo integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
SELECT
  count(*) AS tareas_realizadas,
  sum(tiempo_activo.diferencia_segundos) AS diferencia_segundos,
  CASE
    WHEN sum(tiempo_activo.diferencia_segundos) :: integer < 60 THEN sum(tiempo_activo.diferencia_segundos) :: integer || ' segundos'
    WHEN sum(tiempo_activo.diferencia_segundos) :: integer >= 60
    AND sum(tiempo_activo.diferencia_segundos) :: integer < 3600 THEN (
      sum(tiempo_activo.diferencia_segundos) :: integer / 60
    ) :: integer || ' minutos'
    WHEN sum(tiempo_activo.diferencia_segundos) :: integer >= 3600 THEN (
      sum(tiempo_activo.diferencia_segundos) :: integer / 3600
    ) || ' horas'
  END AS str_tiempo_activo,
  CASE
    WHEN sum(tiempo_activo.diferencia_segundos) :: integer < 60 THEN sum(tiempo_activo.diferencia_segundos) :: integer
    WHEN sum(tiempo_activo.diferencia_segundos) :: integer >= 60
    AND sum(tiempo_activo.diferencia_segundos) :: integer < 3600 THEN (
      sum(tiempo_activo.diferencia_segundos) :: integer / 60
    ) :: integer
    WHEN sum(tiempo_activo.diferencia_segundos) :: integer >= 3600 THEN (
      sum(tiempo_activo.diferencia_segundos) :: integer / 3600
    )
  END AS tiempo_activo
FROM
  nova_proceso_tarea.tbl_bit_tarea_registro tbtr
  LEFT JOIN LATERAL(
    SELECT
      (
        sum(
          DATE_PART('epoch', tcu1.fin - tcu1.inicio) :: integer
        )
      ) AS diferencia_segundos
    FROM
      nova_proceso_tarea.tbl_bit_tarea_registro tcu1
    WHERE
      tcu1.id_bit_tarea_registro = tbtr.id_bit_tarea_registro
  ) tiempo_activo ON true
WHERE
  tbtr.fin IS NOT NULL
  AND to_date(to_char(tbtr.inicio, 'YYYY-MM-DD'), 'YYYY-MM-DD') = CURRENT_DATE
  and tbtr.id_cat_usuario = int_id_cat_usuario;

END;

$ BODY $;

ALTER FUNCTION nova_proceso_tarea.get_count_tiempo_inactivo_x_dia_actual_usuario(integer) OWNER TO vince;