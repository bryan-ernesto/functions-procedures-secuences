/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: función qué permite obtener la referencia de un ticket creado por medio de su id
 Dependencias: nova_ticket.tbl_bit_ticket
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: nova_ticket.get_referencia_ticket_creado(integer, integer)
-- DROP FUNCTION IF EXISTS nova_ticket.get_referencia_ticket_creado(integer, integer);
CREATE
OR REPLACE FUNCTION nova_ticket.get_referencia_ticket_creado(
  int_id_cat_tipo integer,
  int_creado_por integer
) RETURNS TABLE(referencia character varying) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
SELECT
  tbt.referencia AS referencia
FROM
  nova_ticket.tbl_bit_ticket tbt
WHERE
  tbt.id_cat_ticket_tipo = int_id_cat_tipo
  AND tbt.creado_por = int_creado_por
ORDER BY
  tbt.id_bit_ticket DESC
limit
  1;

END;

$ BODY $;

ALTER FUNCTION nova_ticket.get_referencia_ticket_creado(integer, integer) OWNER TO vince;