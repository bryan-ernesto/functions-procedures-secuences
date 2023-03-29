/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que permite actualizar la información de un grupo de usuarios
 Dependencias: usuarios.tbl_cat_permiso_grupo
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.put_documento_grupoeditar(integer, integer, character varying, integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.put_documento_grupoeditar(integer, integer, character varying, integer, integer);
CREATE
OR REPLACE FUNCTION usuarios.put_documento_grupoeditar(
  int_id_cat_permiso_grupo integer,
  int_id_cat_permiso_nivel integer,
  str_nombre character varying,
  int_estado integer,
  int_actualizado_por integer
) RETURNS TABLE(id_permiso_grupo integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
UPDATE
  usuarios.tbl_cat_permiso_grupo
SET
  id_cat_permiso_nivel = CASE
    WHEN int_id_cat_permiso_nivel IS NOT NULL THEN int_id_cat_permiso_nivel
    ELSE id_cat_permiso_nivel
  END,
  nombre = CASE
    WHEN str_nombre <> '' THEN str_nombre
    ELSE nombre
  END,
  estado = CASE
    WHEN int_estado IS NOT NULL THEN int_estado
    ELSE estado
  END,
  actualizado_por = CASE
    WHEN int_actualizado_por IS NOT NULL THEN int_actualizado_por
    ELSE actualizado_por
  END,
  fecha_actualizacion = now()
WHERE
  id_cat_permiso_grupo = int_id_cat_permiso_grupo RETURNING usuarios.tbl_cat_permiso_grupo.id_cat_permiso_grupo;

END;

$ BODY $;

ALTER FUNCTION usuarios.put_documento_grupoeditar(
  integer,
  integer,
  character varying,
  integer,
  integer
) OWNER TO vince;