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
-- FUNCTION: usuarios.get_usuario_puestos(integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.get_usuario_puestos(integer, integer);
CREATE
OR REPLACE FUNCTION usuarios.get_usuario_puestos(
  int_id_cat_usuario integer,
  int_predeterminado integer
) RETURNS TABLE(
  id integer,
  empresa_id integer,
  empresa_nombre character varying,
  departamento_id integer,
  departamento_nombre character varying,
  equipo_id integer,
  equipo_nombre character varying,
  nombre character varying,
  puesto_id integer,
  responsable_id integer,
  responsable character varying,
  predeterminado integer,
  estado integer,
  fecha_creacion character varying,
  fecha_actualizacion character varying,
  creado_por character varying,
  creado_por_id integer,
  actualizado_por character varying,
  actualizado_por_id integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tddar.id_det_usuario_asignacion_puesto as id,
  tcd.id_cat_empresa as empresa_id,
  tcee.nombre as empresa_nombre,
  tce.id_cat_departamento as departamento_id,
  tcd.nombre as departamento_nombre,
  tduap.id_cat_equipo as equipo_id,
  tce.nombre as equipo_nombre,
  tdear.nombre as nombre,
  tdear.id_cat_puesto as puesto_id,
  tddar.id_cat_usuario as responsable_id,
  nombre_usuario.nombre as responsable,
  tddar.predeterminado as predeterminado,
  tddar.estado as estado,
  to_char(tddar.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as fecha_creacion,
  to_char(
    tddar.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as fecha_actualizacion,
  nombre_creado_por.nombre as creado_por,
  tddar.creado_por as creado_por_id,
  nombre_actualizado_por.nombre as actualizado_por,
  tddar.actualizado_por as actualizado_por_id
from
  usuarios.tbl_det_usuario_asignacion_puesto tddar
  left join usuarios.tbl_det_puesto_asignacion_equipo tduap on tduap.id_det_puesto_asignacion_equipo = tddar.id_det_puesto_asignacion_equipo
  left join usuarios.tbl_cat_puesto tdear on tdear.id_cat_puesto = tduap.id_cat_puesto
  join usuarios.tbl_cat_equipo tce on tce.id_cat_equipo = tduap.id_cat_equipo
  join usuarios.tbl_cat_departamento tcd on tcd.id_cat_departamento = tce.id_cat_departamento
  join usuarios.tbl_cat_empresa tcee on tcee.id_cat_empresa = tcd.id_cat_empresa
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
    tddar.id_cat_usuario = int_id_cat_usuario
    or int_id_cat_usuario = 0
  )
  and (
    tddar.predeterminado = int_predeterminado
    or int_predeterminado = 0
  );

END;

$ BODY $;

ALTER FUNCTION usuarios.get_usuario_puestos(integer, integer) OWNER TO vince;