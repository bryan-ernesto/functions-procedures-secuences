/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: 
 Dependencias: nova_ticket.tbl_bit_ticket_id_bit_ticket_seq, nova_ticket.tbl_bit_ticket, usuarios.tbl_cat_equipo, usuarios.tbl_cat_departamento, usuarios.tbl_cat_empresa, nova_ticket.tbl_bit_ticket, usuarios.tbl_cat_departamento
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: nova_ticket.add_ticket_primario(character varying, character varying, integer, integer, integer, integer, character varying, integer, integer, integer, integer, integer, integer, integer)
-- DROP FUNCTION IF EXISTS nova_ticket.add_ticket_primario(character varying, character varying, integer, integer, integer, integer, character varying, integer, integer, integer, integer, integer, integer, integer);
CREATE
OR REPLACE FUNCTION nova_ticket.add_ticket_primario(
  str_resumen character varying,
  str_descripcion character varying,
  int_id_cat_equipo integer,
  int_id_estado_proceso integer,
  int_estado_resolucion integer,
  int_id_responsable integer,
  str_ref_ticket_padre character varying,
  int_id_solicitante integer,
  int_id_cat_proceso integer,
  int_id_ticket_canal integer,
  int_id_ticket_prioridad integer,
  int_estado integer,
  int_creado_por integer,
  int_actualizado_por integer
) RETURNS TABLE(referencia character varying) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
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
          UPPER(SUBSTRING(emp.nombre, 1, 3)) || '-' || UPPER(SUBSTRING(tcd.nombre, 1, 3)) || '-' || UPPER(SUBSTRING(tce.nombre, 1, 3)) || '-' || contador.siguiente_correlativo
        ) AS nombre_recomendado
      FROM
        usuarios.tbl_cat_equipo AS tce
        JOIN usuarios.tbl_cat_departamento AS tcd ON tcd.id_cat_departamento = tce.id_cat_departamento
        JOIN usuarios.tbl_cat_empresa AS emp ON tcd.id_cat_empresa = emp.id_cat_empresa
        LEFT JOIN LATERAL (
          SELECT
            (
              CASE
                WHEN COUNT(*) = 0 THEN 1
                ELSE COUNT(*) + 1
              END
            ) :: INTEGER :: VARCHAR AS siguiente_correlativo
          FROM
            nova_ticket.tbl_bit_ticket AS tbt
            JOIN usuarios.tbl_cat_departamento tcd2 ON tcd2.id_cat_departamento = tce.id_cat_departamento
          WHERE
            tbt.id_cat_ticket_tipo = 1
            AND tbt.id_cat_equipo = int_id_cat_equipo
            AND tcd2.id_cat_departamento = tcd.id_cat_departamento
        ) AS contador ON true
      WHERE
        tce.id_cat_equipo = int_id_cat_equipo
      LIMIT
        1
    ), str_resumen, str_descripcion, int_id_cat_equipo, int_id_estado_proceso, int_estado_resolucion, null,
    /*referencia_ticket_padre*/
    null,
    /*fecha_asignacion*/
    null,
    /*fecha_resolucion*/
    null,
    /*fecha_ultima_vista*/
    null,
    /*fecha_primera_respuesta*/
    null,
    /*fecha_vencimiento*/
    int_id_responsable,
    /*usuario_responsable*/
    int_id_solicitante,
    /*usuario_solicitante*/
    null,
    /*int_id_cat_proceso*/
    int_id_ticket_canal,
    /*id_cat_ticket_canal*/
    int_id_ticket_prioridad,
    /*id_cat_ticket_prioridad*/
    int_estado,
    int_creado_por,
    int_actualizado_por,
    now(),
    now()
  ) RETURNING nova_ticket.tbl_bit_ticket.referencia;

END $ BODY $;

ALTER FUNCTION nova_ticket.add_ticket_primario(
  character varying,
  character varying,
  integer,
  integer,
  integer,
  integer,
  character varying,
  integer,
  integer,
  integer,
  integer,
  integer,
  integer,
  integer
) OWNER TO vince;