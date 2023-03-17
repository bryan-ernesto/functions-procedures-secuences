/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: procedimiento que permite agregar un nuevo horario de marcaje de entrada
 Dependencias: nova_horario.tbl_bit_horario_marcaje
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: nova_horario.sp_nova_horario_entrada(integer, integer, integer, timestamp without time zone, integer, timestamp without time zone)
-- DROP PROCEDURE IF EXISTS nova_horario.sp_nova_horario_entrada(integer, integer, integer, timestamp without time zone, integer, timestamp without time zone);
CREATE
OR REPLACE PROCEDURE nova_horario.sp_nova_horario_entrada(
  int_id_cat_horario_accion integer,
  int_id_cat_dispositivo integer,
  int_id_cat_usuario integer,
  dtm_fecha_hora timestamp without time zone,
  int_creado_por integer,
  dtm_fecha_actualizacion timestamp without time zone
) LANGUAGE 'plpgsql' AS $ BODY $ begin IF (
  (
    SELECT
      count(*)
    FROM
      nova_horario.tbl_det_horario_asignacion_dia tdhad
      INNER JOIN nova_horario.tbl_det_horario_asignacion_usuario tdhau ON tdhad.id_det_horario_asignacion_usuario = tdhau.id_det_horario_asignacion_usuario
      INNER JOIN nova_horario.tbl_cat_horario_accion tcha ON tcha.id_cat_horario_accion = tdhad.id_cat_horario_accion
      LEFT JOIN nova_horario.tbl_bit_horario_marcaje tbhm ON tbhm.id_cat_horario_accion = tcha.id_cat_horario_accion
    WHERE
      tbhm.id_cat_usuario = int_id_cat_usuario
      AND tbhm.id_cat_horario_accion = 1
      AND tbhm.fecha_creacion :: DATE = NOW() :: DATE
  ) <= 0
) then
INSERT INTO
  nova_horario.tbl_bit_horario_marcaje (
    id_cat_horario_accion,
    id_cat_dispositivo,
    id_cat_usuario,
    fecha_hora,
    creado_por,
    modificado_por,
    fecha_creacion,
    fecha_actuallizacion
  )
VALUES
  (
    int_id_cat_horario_accion,
    int_id_cat_dispositivo,
    int_id_cat_usuario,
    dtm_fecha_hora,
    int_creado_por,
    0,
    now(),
    dtm_fecha_actualizacion
  );

end IF;

end $ BODY $;

ALTER PROCEDURE nova_horario.sp_nova_horario_entrada(
  integer,
  integer,
  integer,
  timestamp without time zone,
  integer,
  timestamp without time zone
) OWNER TO vince;