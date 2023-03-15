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
-- FUNCTION: usuarios.add_usuario(character varying, character varying, character varying, integer, character varying, integer, integer, integer, integer, integer, integer, character varying)
-- DROP FUNCTION IF EXISTS usuarios.add_usuario(character varying, character varying, character varying, integer, character varying, integer, integer, integer, integer, integer, integer, character varying);
CREATE
OR REPLACE FUNCTION usuarios.add_usuario(
  str_nombre character varying,
  str_id_ad character varying,
  str_correo character varying,
  int_creado_por integer,
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
    id_cat_usuario,
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
    nextval(
      'usuarios.tbl_cat_usuario_id_cat_usuario_seq' :: regclass
    ),
    str_nombre,
    str_id_ad,
    str_correo,
    1,
    now(),
    now(),
    int_creado_por,
    int_creado_por,
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

ALTER FUNCTION usuarios.add_usuario(
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