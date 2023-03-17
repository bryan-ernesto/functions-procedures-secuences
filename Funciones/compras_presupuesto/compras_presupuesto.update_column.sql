/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 17 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: 
 Dependencias: 
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: compras_presupuesto.update_column(text, text, numeric, integer)
-- DROP FUNCTION IF EXISTS compras_presupuesto.update_column(text, text, numeric, integer);
CREATE
OR REPLACE FUNCTION compras_presupuesto.update_column(
  p_table_name text,
  p_column_name text,
  p_value numeric,
  p_id integer
) RETURNS void LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE AS $ BODY $ DECLARE query text;

BEGIN query := 'UPDATE ' || p_table_name || ' SET ' || p_column_name || ' = ' || p_value || ' WHERE id_det_presupuesto = ' || p_id || ';';

EXECUTE query;

END;

$ BODY $;

ALTER FUNCTION compras_presupuesto.update_column(text, text, numeric, integer) OWNER TO vince;