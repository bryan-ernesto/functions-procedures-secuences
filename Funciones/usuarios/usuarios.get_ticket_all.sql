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
-- FUNCTION: usuarios.get_ticket_all(character varying, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying)
-- DROP FUNCTION IF EXISTS usuarios.get_ticket_all(character varying, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying);
CREATE
OR REPLACE FUNCTION usuarios.get_ticket_all(
    string_nombre_referencia character varying,
    int_id_prioridad integer,
    int_estado_resolucion integer,
    int_id_proceso integer,
    int_id_cat_tipo integer,
    int_id_cat_canal integer,
    int_id_cat_equipo integer,
    int_id_cat_seguimiento integer,
    int_id_cat_responsable integer,
    int_id_cat_solicitante integer,
    int_id_cat_creado_por integer,
    date_asignacion_inicio character varying,
    date_asignacion_fin character varying,
    date_resolucion_inicio character varying,
    date_resolucion_fin character varying,
    date_ultima_vista_inicio character varying,
    date_ultima_vista_fin character varying,
    date_vencimiento_inicio character varying,
    date_vencimiento_fin character varying,
    date_primera_respuesta_inicio character varying,
    date_primera_respuesta_fin character varying,
    date_creacion_inicio character varying,
    date_creacion_fin character varying,
    date_actualizacion_inicio character varying,
    date_actualizacion_fin character varying
) RETURNS TABLE(
    id_ticket integer,
    solicitante_nombre character varying,
    solicitante_id integer,
    equipo character varying,
    id_cat_equipo integer,
    id_responsable integer,
    usuario_responsable character varying,
    tipo_ticket character varying,
    id_cat_ticket_tipo integer,
    referencia character varying,
    referencia_ticket_padre character varying,
    canal character varying,
    id_cat_ticket_canal integer,
    resumen character varying,
    descripcion character varying,
    prioridad character varying,
    id_cat_ticket_prioridad integer,
    proceso character varying,
    id_cat_ticket_estado_proceso integer,
    estado_resolucion character varying,
    id_cat_ticket_estado_resolucion integer,
    nombre_proceso character varying,
    id_cat_proceso integer,
    fecha_asignacion character varying,
    fecha_resolucion character varying,
    fecha_ultima_vista character varying,
    fecha_vencimiento character varying,
    fecha_primera_respuesta character varying,
    creado_por integer,
    creado_nombre character varying,
    actualizado_por integer,
    actualizado_nombre character varying,
    id_cat_usuario integer,
    fecha_creacion character varying,
    fecha_actualizacion character varying,
    seguimiento character varying,
    id_bit_ticket_seguimiento integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
SELECT
    tbt.id_bit_ticket AS id_ticket,
    tcu.nombre AS solicitante_nombre,
    tcu.id_cat_usuario AS solicitante_id,
    tce.nombre AS equipo,
    tce.id_cat_equipo AS id_cat_equipo,
    tbt.usuario_responsable AS id_responsable,
    responsable.nombre AS usuario_responsable,
    tctt.nombre AS tipo_ticket,
    tctt.id_cat_ticket_tipo,
    tbt.referencia,
    tbt.referencia_ticket_padre,
    tctc.nombre AS canal,
    tctc.id_cat_ticket_canal,
    tbt.resumen,
    tbt.descripcion,
    tctp.nombre AS prioridad,
    tctp.id_cat_ticket_prioridad,
    tctep.nombre AS proceso,
    tctep.id_cat_ticket_estado_proceso,
    tcter.nombre AS estado_resolucion,
    tcter.id_cat_ticket_estado_resolucion,
    tcp.nombre AS nombre_proceso,
    tcp.id_cat_proceso,
    to_char(tbt.fecha_asignacion, 'YYYY-MM-DD HH:MI:SS AM') :: VARCHAR AS fecha_asignacion,
    to_char(tbt.fecha_resolucion, 'YYYY-MM-DD HH:MI:SS AM') :: VARCHAR AS fecha_resolucion,
    to_char(tbt.fecha_ultima_vista, 'YYYY-MM-DD HH:MI:SS AM') :: VARCHAR AS fecha_ultima_vista,
    to_char(tbt.fecha_vencimiento, 'YYYY-MM-DD HH:MI:SS AM') :: VARCHAR AS fecha_vencimiento,
    to_char(
        tbt.fecha_primera_respuesta,
        'YYYY-MM-DD HH:MI:SS AM'
    ) :: VARCHAR AS fecha_primera_respuesta,
    tbt.creado_por,
    creado_por.nombre AS creado_nombre,
    tbt.actualizado_por,
    modificado_por.nombre AS actualizado_nombre,
    tcu.id_cat_usuario,
    to_char(tbt.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: VARCHAR AS fecha_creacion,
    to_char(
        tbt.fecha_actualizacion,
        'YYYY-MM-DD HH:MI:SS AM'
    ) :: VARCHAR AS fecha_actualizacion,
    seguimiento.nombre AS seguimiento,
    tbts.id_bit_ticket_seguimiento
FROM
    nova_ticket.tbl_bit_ticket tbt
    LEFT JOIN usuarios.tbl_cat_usuario tcu ON tcu.id_cat_usuario = tbt.usuario_solicitante
    LEFT JOIN usuarios.tbl_cat_equipo tce ON tce.id_cat_equipo = tbt.id_cat_equipo
    LEFT JOIN nova_ticket.tbl_cat_ticket_tipo tctt ON tctt.id_cat_ticket_tipo = tbt.id_cat_ticket_tipo
    LEFT JOIN nova_ticket.tbl_cat_ticket_canal tctc ON tctc.id_cat_ticket_canal = tbt.id_cat_ticket_canal
    LEFT JOIN nova_ticket.tbl_cat_ticket_prioridad tctp ON tctp.id_cat_ticket_prioridad = tbt.id_cat_ticket_prioridad
    LEFT JOIN nova_ticket.tbl_cat_ticket_estado_proceso tctep ON tctep.id_cat_ticket_estado_proceso = tbt.id_cat_ticket_estado_proceso
    LEFT JOIN nova_ticket.tbl_cat_ticket_estado_resolucion tcter ON tcter.id_cat_ticket_estado_resolucion = tbt.id_cat_ticket_estado_resolucion
    LEFT JOIN nova_proceso_tarea.tbl_cat_proceso tcp ON tcp.id_cat_proceso = tbt.id_cat_proceso
    LEFT JOIN nova_ticket.tbl_bit_ticket_seguimiento tbts ON tbts.id_bit_ticket = tbt.id_bit_ticket
    AND tbts.id_cat_usuario = tcu.id_cat_usuario
    LEFT JOIN LATERAL (
        SELECT
            tcu2.nombre AS nombre
        FROM
            usuarios.tbl_cat_usuario tcu2
        WHERE
            tcu2.id_cat_usuario = tbt.usuario_responsable
    ) responsable ON true
    LEFT JOIN LATERAL (
        SELECT
            tcu3.nombre AS nombre
        FROM
            usuarios.tbl_cat_usuario tcu3
        WHERE
            tcu3.id_cat_usuario = tbt.creado_por
    ) creado_por ON true
    LEFT JOIN LATERAL (
        SELECT
            tcu4.nombre AS nombre
        FROM
            usuarios.tbl_cat_usuario tcu4
        WHERE
            tcu4.id_cat_usuario = tbt.actualizado_por
    ) modificado_por ON TRUE
    LEFT JOIN LATERAL (
        SELECT
            tcu5.nombre AS nombre
        FROM
            usuarios.tbl_cat_usuario tcu5
        WHERE
            tcu5.id_cat_usuario = tbts.id_cat_usuario
    ) seguimiento ON TRUE
WHERE
    (
        (
            UPPER(tbt.resumen) LIKE ('%' || UPPER(string_nombre_referencia) || '%') :: VARCHAR
        )
        OR (
            UPPER(tbt.referencia) LIKE ('%' || UPPER(string_nombre_referencia) || '%') :: VARCHAR
        )
        OR (LENGTH(string_nombre_referencia) = 0)
    )
    AND (
        tctp.id_cat_ticket_prioridad = int_id_prioridad
        OR int_id_prioridad = 0
    )
    AND (
        tcter.id_cat_ticket_estado_resolucion = int_estado_resolucion
        OR int_estado_resolucion = 0
    )
    AND (
        tcp.id_cat_proceso = int_id_proceso
        OR int_id_proceso = 0
    )
    AND (
        tctt.id_cat_ticket_tipo = int_id_cat_tipo
        OR int_id_cat_tipo = 0
    )
    AND (
        tctc.id_cat_ticket_canal = int_id_cat_canal
        OR int_id_cat_canal = 0
    )
    AND (
        tce.id_cat_equipo = int_id_cat_equipo
        OR int_id_cat_equipo = 0
    )
    AND (
        tbts.id_bit_ticket_seguimiento = int_id_cat_seguimiento
        OR int_id_cat_seguimiento = 0
    )
    AND (
        tbt.usuario_responsable = int_id_cat_responsable
        OR int_id_cat_responsable = 0
    )
    AND (
        tbt.usuario_solicitante = int_id_cat_solicitante
        OR int_id_cat_solicitante = 0
    )
    AND (
        (
            to_char(tbt.fecha_asignacion, 'YYYY-MM-dd') >= date_asignacion_inicio
            AND to_char(tbt.fecha_asignacion, 'YYYY-MM-dd') <= date_asignacion_fin
        )
        OR (
            LENGTH(date_asignacion_inicio) = 0
            AND LENGTH(date_asignacion_fin) = 0
        )
    )
    AND (
        (
            to_char(tbt.fecha_resolucion, 'YYYY-MM-dd') >= date_resolucion_inicio
            AND to_char(tbt.fecha_resolucion, 'YYYY-MM-dd') <= date_resolucion_fin
        )
        OR (
            LENGTH(date_resolucion_inicio) = 0
            AND LENGTH(date_resolucion_fin) = 0
        )
    )
    AND (
        (
            to_char(tbt.fecha_ultima_vista, 'YYYY-MM-dd') >= date_ultima_vista_inicio
            AND to_char(tbt.fecha_ultima_vista, 'YYYY-MM-dd') <= date_ultima_vista_fin
        )
        OR (
            LENGTH(date_ultima_vista_inicio) = 0
            AND LENGTH(date_ultima_vista_fin) = 0
        )
    )
    AND (
        (
            to_char(tbt.fecha_vencimiento, 'YYYY-MM-dd') >= date_vencimiento_inicio
            AND to_char(tbt.fecha_vencimiento, 'YYYY-MM-dd') <= date_vencimiento_fin
        )
        OR (
            LENGTH(date_vencimiento_inicio) = 0
            AND LENGTH(date_vencimiento_fin) = 0
        )
    )
    AND (
        (
            to_char(tbt.fecha_primera_respuesta, 'YYYY-MM-dd') >= date_primera_respuesta_inicio
            AND to_char(tbt.fecha_primera_respuesta, 'YYYY-MM-dd') <= date_primera_respuesta_fin
        )
        OR (
            LENGTH(date_primera_respuesta_inicio) = 0
            AND LENGTH(date_primera_respuesta_fin) = 0
        )
    )
    AND (
        (
            to_char(tbt.fecha_creacion, 'YYYY-MM-dd') >= date_creacion_inicio
            AND to_char(tbt.fecha_creacion, 'YYYY-MM-dd') <= date_creacion_fin
        )
        OR (
            LENGTH(date_creacion_inicio) = 0
            AND LENGTH(date_creacion_fin) = 0
        )
    )
    AND (
        (
            to_char(tbt.fecha_actualizacion, 'YYYY-MM-dd') >= date_actualizacion_inicio
            AND to_char(tbt.fecha_actualizacion, 'YYYY-MM-dd') <= date_actualizacion_fin
        )
        OR (
            LENGTH(date_actualizacion_inicio) = 0
            AND LENGTH(date_actualizacion_fin) = 0
        )
    )
ORDER BY
    tce.nombre ASC,
    tbt.referencia ASC,
    tbt.resumen ASC;

END;

$ BODY $;

ALTER FUNCTION usuarios.get_ticket_all(
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
    character varying,
    character varying,
    character varying,
    character varying,
    character varying,
    character varying,
    character varying,
    character varying,
    character varying,
    character varying,
    character varying,
    character varying,
    character varying,
    character varying
) OWNER TO vince;