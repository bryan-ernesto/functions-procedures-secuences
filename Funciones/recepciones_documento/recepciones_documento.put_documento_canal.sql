/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que modificar la información del canal para un documento
 Dependencias: recepciones_documento.tbl_det_documento_recepcion_solicitud
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.put_documento_canal(integer, character varying, character varying, integer, integer)
-- DROP FUNCTION IF EXISTS recepciones_documento.put_documento_canal(integer, character varying, character varying, integer, integer);
CREATE
OR REPLACE FUNCTION recepciones_documento.put_documento_canal(
  int_id_cat_documento_canal integer,
  str_nombre character varying,
  str_descripcion character varying,
  int_estado integer,
  int_actualizado_por integer
) RETURNS TABLE(id_canal integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
UPDATE
  recepciones_documento.tbl_cat_documento_canal
SET
  nombre = CASE
    WHEN str_nombre <> '' THEN str_nombre
    ELSE nombre
  END,
  descripcion = CASE
    WHEN str_descripcion <> '' THEN str_descripcion
    ELSE descripcion
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
  id_cat_documento_canal = int_id_cat_documento_canal RETURNING recepciones_documento.tbl_cat_documento_canal.id_cat_documento_canal;

END;

$ BODY $;

ALTER FUNCTION recepciones_documento.put_documento_canal(
  integer,
  character varying,
  character varying,
  integer,
  integer
) OWNER TO vince;