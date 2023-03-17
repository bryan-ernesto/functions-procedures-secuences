/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: proceso que permite agregar una nueva aplicación al catálogo de aplicaciones
 Dependencias: nova_aplicacion.tbl_cat_aplicacion
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: nova_aplicacion.sp_nova_aplicacion_add(character varying, character varying, integer, integer, integer)
-- DROP PROCEDURE IF EXISTS nova_aplicacion.sp_nova_aplicacion_add(character varying, character varying, integer, integer, integer);
CREATE
OR REPLACE PROCEDURE nova_aplicacion.sp_nova_aplicacion_add(
  str_nombre character varying,
  str_descripcion character varying,
  int_estado integer,
  int_creado_por integer,
  int_modificado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin IF (
  (
    SELECT
      count(*)
    FROM
      nova_aplicacion.tbl_cat_aplicacion
    where
      nombre = str_nombre
  ) <= 0
) then
INSERT INTO
  nova_aplicacion.tbl_cat_aplicacion (
    id_cat_aplicacion,
    nombre,
    descripcion,
    estado,
    creado_por,
    modificado_por,
    fecha_creacion,
    fecha_actualizacion
  )
VALUES
  (
    nextval(
      'nova_aplicacion.tbl_cat_aplicacion_id_cat_aplicacion_seq' :: regclass
    ),
    str_nombre,
    str_descripcion,
    int_estado,
    int_creado_por,
    int_modificado_por,
    now(),
    now()
  );

end IF;

end $ BODY $;

ALTER PROCEDURE nova_aplicacion.sp_nova_aplicacion_add(
  character varying,
  character varying,
  integer,
  integer,
  integer
) OWNER TO vince;