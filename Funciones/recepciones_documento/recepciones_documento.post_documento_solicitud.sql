/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que registra una nueva solicitud de documento
 Dependencias: recepciones_documento.tbl_det_documento_recepcion_solicitud
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.post_documento_solicitud(integer, integer, integer, integer, integer, integer)
-- DROP FUNCTION IF EXISTS recepciones_documento.post_documento_solicitud(integer, integer, integer, integer, integer, integer);
CREATE
OR REPLACE FUNCTION recepciones_documento.post_documento_solicitud(
  int_individual_masiva integer,
  int_id_cat_documento_estado integer,
  int_id_cat_documento_tipo integer,
  int_id_cat_usuario_autorizador integer,
  int_id_cat_empresa integer,
  int_id_creador integer
) RETURNS TABLE(id_documento_solicitud integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
INSERT INTO
  recepciones_documento.tbl_det_documento_recepcion_solicitud(
    individual_masiva,
    id_cat_documento_estado,
    id_cat_documento_tipo,
    id_cat_usuario_autorizador,
    id_cat_empresa,
    creado_por,
    actualizado_por,
    fecha_creacion,
    fecha_actualizacion
  )
VALUES
  (
    int_individual_masiva,
    -- individualMasiva
    int_id_cat_documento_estado,
    -- idCatDocumentoEstado
    int_id_cat_documento_tipo,
    -- idCatDocumentoTipo
    int_id_cat_usuario_autorizador,
    -- idCatUsuarioAutorizador
    int_id_cat_empresa,
    -- idCatEmpresa
    int_id_creador,
    -- creadoPor
    int_id_creador,
    -- actualizadoPor
    now(),
    -- fechaCreacion
    now() -- fechaActualizacion
  ) RETURNING recepciones_documento.tbl_det_documento_recepcion_solicitud.id_det_documento_recepcion_solicitud;

END;

$ BODY $;

ALTER FUNCTION recepciones_documento.post_documento_solicitud(
  integer,
  integer,
  integer,
  integer,
  integer,
  integer
) OWNER TO vince;