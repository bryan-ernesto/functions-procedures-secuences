/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que modificar la información de una solicitud de documento
 Dependencias: recepciones_documento.tbl_det_documento_recepcion_solicitud
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.put_documento_solicitud(integer, integer, integer, integer, integer, integer, integer)
-- DROP FUNCTION IF EXISTS recepciones_documento.put_documento_solicitud(integer, integer, integer, integer, integer, integer, integer);
CREATE
OR REPLACE FUNCTION recepciones_documento.put_documento_solicitud(
  int_id_det_documento_recepcion_solicitud integer,
  int_individual_masiva integer,
  int_id_cat_documento_estado integer,
  int_id_cat_documento_tipo integer,
  int_id_cat_usuario_autorizador integer,
  int_id_cat_empresa integer,
  int_actualizado_por integer
) RETURNS TABLE(id_solicitud integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
UPDATE
  recepciones_documento.tbl_det_documento_recepcion_solicitud
SET
  individual_masiva = CASE
    WHEN int_individual_masiva IS NOT NULL THEN int_individual_masiva
    ELSE individual_masiva
  END,
  id_cat_documento_estado = CASE
    WHEN int_id_cat_documento_estado IS NOT NULL THEN int_id_cat_documento_estado
    ELSE id_cat_documento_estado
  END,
  id_cat_documento_tipo = CASE
    WHEN int_id_cat_documento_tipo IS NOT NULL THEN int_id_cat_documento_tipo
    ELSE id_cat_documento_tipo
  END,
  id_cat_usuario_autorizador = CASE
    WHEN int_id_cat_usuario_autorizador IS NOT NULL THEN int_id_cat_usuario_autorizador
    ELSE id_cat_usuario_autorizador
  END,
  id_cat_empresa = CASE
    WHEN int_id_cat_empresa IS NOT NULL THEN int_id_cat_empresa
    ELSE id_cat_empresa
  END,
  actualizado_por = CASE
    WHEN int_actualizado_por IS NOT NULL THEN int_actualizado_por
    ELSE actualizado_por
  END,
  fecha_actualizacion = now()
WHERE
  id_det_documento_recepcion_solicitud = int_id_det_documento_recepcion_solicitud RETURNING recepciones_documento.tbl_det_documento_recepcion_solicitud.id_det_documento_recepcion_solicitud;

END;

$ BODY $;

ALTER FUNCTION recepciones_documento.put_documento_solicitud(
  integer,
  integer,
  integer,
  integer,
  integer,
  integer,
  integer
) OWNER TO vince;