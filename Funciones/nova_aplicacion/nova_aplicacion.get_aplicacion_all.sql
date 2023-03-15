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
-- FUNCTION: nova_aplicacion.get_aplicacion_all(integer, character varying, integer, integer, integer, character varying, character varying)
-- DROP FUNCTION IF EXISTS nova_aplicacion.get_aplicacion_all(integer, character varying, integer, integer, integer, character varying, character varying);
CREATE
OR REPLACE FUNCTION nova_aplicacion.get_aplicacion_all(
  int_cat_aplicacion integer,
  str_nombre character varying,
  int_estado integer,
  int_creado_por integer,
  int_modificado_por integer,
  str_fecha_creacion_i character varying,
  str_fecha_actualizacion_f character varying
) RETURNS TABLE(
  id_cat_aplicacion integer,
  nombre character varying,
  descripcion character varying,
  estado integer,
  creado_por integer,
  modificado_por integer,
  fecha_creacion timestamp without time zone,
  fecha_actualizacion timestamp without time zone
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
SELECT
  apt.id_cat_aplicacion,
  apt.nombre,
  apt.descripcion,
  apt.estado,
  apt.creado_por,
  apt.modificado_por,
  apt.fecha_creacion,
  apt.fecha_actualizacion
FROM
  nova_aplicacion.tbl_cat_aplicacion apt
where
  (
    apt.id_cat_aplicacion = int_cat_aplicacion
    or int_cat_aplicacion is null
  )
  and (
    apt.nombre like str_nombre
    or str_nombre is null
  )
  and (
    apt.estado = int_estado
    or int_estado is null
  )
  and (
    apt.creado_por = int_creado_por
    or int_creado_por is null
  )
  and (
    apt.modificado_por = int_modificado_por
    or int_modificado_por is null
  )
  and (
    to_char(apt.fecha_creacion, 'YYYY-MM-dd') >= str_fecha_creacion_i
    AND to_char(apt.fecha_creacion, 'YYYY-MM-dd') <= str_fecha_actualizacion_f
    or str_fecha_creacion_i is null
    and str_fecha_actualizacion_f is null
  );

END;

$ BODY $;

ALTER FUNCTION nova_aplicacion.get_aplicacion_all(
  integer,
  character varying,
  integer,
  integer,
  integer,
  character varying,
  character varying
) OWNER TO vince;