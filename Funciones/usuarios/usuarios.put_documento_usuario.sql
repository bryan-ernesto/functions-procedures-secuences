/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que permite actualizar la información de un nuevo usuario
 Dependencias: usuarios.tbl_cat_usuario, nova_ticket.tbl_cat_usuario_dominio, nova_ticket.tbl_cat_usuario_categoria
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.put_documento_usuario(integer, character varying, character varying, integer, integer, integer, integer, integer, integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.put_documento_usuario(integer, character varying, character varying, integer, integer, integer, integer, integer, integer, integer);
CREATE
OR REPLACE FUNCTION usuarios.put_documento_usuario(
  int_id_cat_usuario integer,
  str_nombre character varying,
  str_correo character varying,
  int_telefono integer,
  int_codigo_pais integer,
  int_id_cat_usuario_dominio integer,
  int_tipo_usuario integer,
  int_id_cat_usuario_categoria integer,
  int_estado integer,
  int_actualizado_por integer
) RETURNS TABLE(id_grupo_usuario integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
UPDATE
  usuarios.tbl_cat_usuario
SET
  nombre = CASE
    WHEN str_nombre <> '' THEN str_nombre
    ELSE nombre
  END,
  correo = CASE
    WHEN str_correo <> '' THEN str_correo
    ELSE correo
  END,
  telefono = CASE
    WHEN int_telefono IS NOT NULL THEN int_telefono
    ELSE telefono
  END,
  codigo_pais = CASE
    WHEN int_codigo_pais IS NOT NULL THEN int_codigo_pais
    ELSE codigo_pais
  END,
  id_cat_usuario_dominio = CASE
    WHEN int_id_cat_usuario_dominio IS NOT NULL THEN int_id_cat_usuario_dominio
    ELSE id_cat_usuario_dominio
  END,
  tipo_usuario = CASE
    WHEN int_tipo_usuario IS NOT NULL THEN int_tipo_usuario
    ELSE tipo_usuario
  END,
  id_cat_usuario_categoria = CASE
    WHEN int_id_cat_usuario_categoria IS NOT NULL THEN int_id_cat_usuario_categoria
    ELSE id_cat_usuario_categoria
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
  id_cat_usuario = int_id_cat_usuario RETURNING usuarios.tbl_cat_usuario.id_cat_usuario;

END;

$ BODY $;

ALTER FUNCTION usuarios.put_documento_usuario(
  integer,
  character varying,
  character varying,
  integer,
  integer,
  integer,
  integer,
  integer,
  integer,
  integer
) OWNER TO vince;