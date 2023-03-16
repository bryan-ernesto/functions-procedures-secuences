/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 13 marzo 2023
 Descripción: Función que permite obtener la información de las empresas que esten asignadas como empresas responsables
 Dependencias: usuarios.tbl_cat_empresa, usuarios.tbl_det_empresa_asignacion_responsable
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.get_empresa_responsable(integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.get_empresa_responsable(integer, integer);
CREATE
OR REPLACE FUNCTION usuarios.get_empresa_responsable(
  int_id_cat_usuario integer,
  int_id_cat_empresa integer
) RETURNS TABLE(
  id_det_empresa_asignacion_responsable integer,
  empresa_nombre character varying,
  empresa_id_cat_empresa integer,
  empresa_id_responsable integer,
  empresa_nombre_usuario_responsable character varying,
  asignacion_responsable_estado integer,
  asignacion_responsable_fecha_creacion character varying,
  asignacion_responsable_fecha_actualizacion character varying,
  asignacion_responsable_creado_por character varying,
  asignacion_responsable_id_creado_por integer,
  asignacion_responsable_actualizado_por character varying,
  asignacion_responsable_id_actualizado_por integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tdear.id_det_empresa_asignacion_responsable,
  tce.nombre as empresa_nombre,
  tdear.id_cat_empresa as empresa_id_cat_empresa,
  tdear.id_cat_usuario as empresa_id_responsable,
  nombre_usuario.nombre as empresa_nombre_usuario_responsable,
  tdear.estado as asignacion_responsable_estado,
  to_char(tdear.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as asignacion_responsable_fecha_creacion,
  to_char(
    tdear.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as asignacion_responsable_fecha_actualizacion,
  nombre_creado_por.nombre as asignacion_responsable_creado_por,
  tdear.creado_por as asignacion_responsable_id_creado_por,
  nombre_actualizado_por.nombre as asignacion_responsable_actualizado_por,
  tdear.actualizado_por as asignacion_responsable_id_actualizado_por
from
  usuarios.tbl_cat_empresa tce
  left join usuarios.tbl_det_empresa_asignacion_responsable tdear on tce.id_cat_empresa = tdear.id_cat_empresa
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tdear.creado_por
  ) nombre_creado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tdear.actualizado_por
  ) nombre_actualizado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tdear.id_cat_usuario
  ) nombre_usuario ON true
where
  (
    tdear.id_cat_usuario = int_id_cat_usuario
    or int_id_cat_usuario = 0
  )
  and (
    tdear.id_cat_empresa = int_id_cat_empresa
    or int_id_cat_empresa = 0
  );

END;

$ BODY $;

ALTER FUNCTION usuarios.get_empresa_responsable(integer, integer) OWNER TO vince;