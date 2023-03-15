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
-- FUNCTION: usuarios.get_departamento_responsable(integer)
-- DROP FUNCTION IF EXISTS usuarios.get_departamento_responsable(integer);
CREATE
OR REPLACE FUNCTION usuarios.get_departamento_responsable(int_id_cat_departamento integer) RETURNS TABLE(
  id_det_departamento_asignacion_responsable integer,
  departamento_nombre character varying,
  departamento_id_cat_departamento integer,
  departamento_id_cat_responsable integer,
  departamento_nombre_responsable character varying,
  departamento_responsable_estado integer,
  departamento_responsable_fecha_creacion character varying,
  departemento_responsable_fecha_actualizacion character varying,
  departamento_responsable_creado_por character varying,
  departamento_responsable_id_creado_por integer,
  departamento_responsable_actualizado_por character varying,
  departamento_responsable_id_actualizado_por integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tddar.id_det_departamento_asignacion_responsable,
  tdear.nombre as departamento_nombre,
  tdear.id_cat_departamento as departamento_id_cat_departamento,
  tddar.id_cat_usuario as departamento_id_cat_responsable,
  nombre_usuario.nombre as departamento_nombre_responsable,
  tddar.estado as departamento_responsable_estado,
  to_char(tddar.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as departamento_responsable_fecha_creacion,
  to_char(
    tddar.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as departemento_responsable_fecha_actualizacion,
  nombre_creado_por.nombre as departamento_responsable_creado_por,
  tddar.creado_por as departamento_responsable_id_creado_por,
  nombre_actualizado_por.nombre as departamento_responsable_actualizado_por,
  tddar.actualizado_por as departamento_responsable_id_actualizado_por
from
  usuarios.tbl_det_departamento_asignacion_responsable tddar
  left join usuarios.tbl_cat_departamento tdear on tddar.id_cat_departamento = tdear.id_cat_departamento
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tddar.creado_por
  ) nombre_creado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tddar.actualizado_por
  ) nombre_actualizado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu2.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu2
    WHERE
      tcu2.id_cat_usuario = tddar.id_cat_usuario
  ) nombre_usuario ON true
where
  (
    tddar.id_cat_departamento = int_id_cat_departamento
    or int_id_cat_departamento = 0
  );

END;

$ BODY $;

ALTER FUNCTION usuarios.get_departamento_responsable(integer) OWNER TO vince;