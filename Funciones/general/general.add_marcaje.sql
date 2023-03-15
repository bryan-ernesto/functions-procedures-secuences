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
-- FUNCTION: general.add_marcaje(character varying, character varying)
-- DROP FUNCTION IF EXISTS general.add_marcaje(character varying, character varying);
CREATE
OR REPLACE FUNCTION general.add_marcaje(
  str_usuario character varying,
  str_accion character varying
) RETURNS TABLE(id_registro integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
INSERT INTO
  general.tbl_bit_marcaje(id_bit_marcaje, usuario, accion)
VALUES
  (
    nextval(
      'general.tbl_bit_marcaje_id_bit_marcaje_seq' :: regclass
    ),
    str_usuario,
    str_accion
  ) RETURNING general.tbl_bit_marcaje.id_bit_marcaje;

END $ BODY $;

ALTER FUNCTION general.add_marcaje(character varying, character varying) OWNER TO vince;