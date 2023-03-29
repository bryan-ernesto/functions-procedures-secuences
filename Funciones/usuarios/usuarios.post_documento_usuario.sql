/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que permite ingresar la información de un nuevo usuario
 Dependencias: usuarios.tbl_cat_usuario, usuarios.tbl_cat_usuario_dominio, usuarios.tbl_usuario_categoria
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.post_documento_usuario(character varying, character varying, character varying, integer, character varying, integer, integer, integer, integer, integer, integer, character varying)
-- DROP FUNCTION IF EXISTS usuarios.post_documento_usuario(character varying, character varying, character varying, integer, character varying, integer, integer, integer, integer, integer, integer, character varying);
CREATE
OR REPLACE FUNCTION usuarios.post_documento_usuario(
  str_nombre character varying,
  str_id_ad character varying,
  str_correo character varying,
  int_id_creador integer,
  str_user_principal_name character varying,
  bit_apagado_automatico integer,
  int_telefono integer,
  int_codigo_pais integer,
  int_id_cat_usuario_dominio integer,
  int_tipo_usuario integer,
  int_id_cat_usuario_categoria integer,
  str_username character varying
) RETURNS TABLE(id_usuario integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
INSERT INTO
  usuarios.tbl_cat_usuario(
    nombre,
    id_ad,
    correo,
    estado,
    fecha_creacion,
    fecha_actualizacion,
    creado_por,
    actualizado_por,
    user_principal_name,
    apagado_automatico,
    telefono,
    codigo_pais,
    id_cat_usuario_dominio,
    tipo_usuario,
    id_cat_usuario_categoria,
    username
  )
VALUES
  (
    str_nombre,
    str_id_ad,
    str_correo,
    1,
    now(),
    now(),
    int_id_creador,
    int_id_creador,
    str_user_principal_name,
CASE
      WHEN bit_apagado_automatico = 0 THEN B '0'
      ELSE B '1'
    END,
    int_telefono,
    int_codigo_pais,
    int_id_cat_usuario_dominio,
    int_tipo_usuario,
    int_id_cat_usuario_categoria,
    str_username
  ) RETURNING usuarios.tbl_cat_usuario.id_cat_usuario;

END $ BODY $;

ALTER FUNCTION usuarios.post_documento_usuario(
  character varying,
  character varying,
  character varying,
  integer,
  character varying,
  integer,
  integer,
  integer,
  integer,
  integer,
  integer,
  character varying
) OWNER TO vince;