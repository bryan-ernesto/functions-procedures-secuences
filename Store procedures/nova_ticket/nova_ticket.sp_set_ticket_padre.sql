/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 17 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: 
 Dependencias: 
 ERD:
 Nombre ERD: 
 */
-- PROCEDURE: nova_ticket.sp_set_ticket_padre(character varying, character varying, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer)
-- DROP PROCEDURE IF EXISTS nova_ticket.sp_set_ticket_padre(character varying, character varying, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer);
CREATE
OR REPLACE PROCEDURE nova_ticket.sp_set_ticket_padre(
  str_resumen character varying,
  str_descripcion character varying,
  int_id_cat_equipo integer,
  int_id_estado_proceso integer,
  int_estado_resolucion integer,
  int_id_responsable integer,
  int_id_solicitante integer,
  int_id_cat_proceso integer,
  int_id_ticket_canal integer,
  int_id_ticket_prioridad integer,
  int_estado integer,
  int_creado_por integer,
  int_actualizado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ BEGIN
INSERT INTO
  nova_ticket.tbl_bit_ticket (
    id_bit_ticket,
    id_cat_ticket_tipo,
    referencia,
    resumen,
    descripcion,
    id_cat_equipo,
    id_cat_ticket_estado_proceso,
    id_cat_ticket_estado_resolucion,
    referencia_ticket_padre,
    fecha_asignacion,
    fecha_resolucion,
    fecha_ultima_vista,
    fecha_primera_respuesta,
    fecha_vencimiento,
    usuario_responsable,
    usuario_solicitante,
    id_cat_proceso,
    id_cat_ticket_canal,
    id_cat_ticket_prioridad,
    estado,
    creado_por,
    actualizado_por,
    fecha_creacion,
    fecha_actualizacion
  )
VALUES
  (
    nextval(
      'nova_ticket.tbl_bit_ticket_id_bit_ticket_seq' :: regclass
    ),
    1,
    (
      SELECT
        (
          upper(substring(tcd.nombre, 1, 3)) || '-' || upper(substring(tce.nombre, 1, 3))
        ) || '-' || contador.siguiente_correlativo AS nombre_recomendado
      FROM
        usuarios.get_equipo_usuario(int_id_responsable, int_id_cat_equipo) AS fnc
        JOIN usuarios.tbl_cat_equipo tce ON tce.id_cat_equipo = fnc.equipo_id
        JOIN usuarios.tbl_cat_departamento tcd ON tcd.id_cat_departamento = tce.id_cat_departamento
        LEFT JOIN LATERAL(
          SELECT
            (
              CASE
                WHEN count(*) = 0 THEN 1
                ELSE count(*) + 1
              END
            ) :: INTEGER :: VARCHAR AS siguiente_correlativo
          FROM
            nova_ticket.tbl_bit_ticket tbt
            JOIN usuarios.tbl_cat_departamento tcd2 ON tcd2.id_cat_departamento = tce.id_cat_departamento
          WHERE
            tbt.id_cat_ticket_tipo = 1
            AND tbt.id_cat_equipo = tce.id_cat_equipo
            AND tcd2.id_cat_departamento = tcd.id_cat_departamento
        ) contador ON true
    ),
    str_resumen,
    str_descripcion,
    int_id_cat_equipo,
    int_id_estado_proceso,
    int_estado_resolucion,
    null,
    now(),
    null,
    null,
    null,
    null,
    int_id_responsable,
    int_id_solicitante,
    int_id_cat_proceso,
    int_id_ticket_canal,
    int_id_ticket_prioridad,
    int_estado,
    int_creado_por,
    int_actualizado_por,
    now(),
    now()
  ) RETURNING id_bit_ticket;

END $ BODY $;

ALTER PROCEDURE nova_ticket.sp_set_ticket_padre(
  character varying,
  character varying,
  integer,
  integer,
  integer,
  integer,
  integer,
  integer,
  integer,
  integer,
  integer,
  integer,
  integer
) OWNER TO vince;