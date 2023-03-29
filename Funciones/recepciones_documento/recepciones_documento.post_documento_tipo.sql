/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que registra un nuevo tipo de documento
 Dependencias: recepciones_documento.tbl_det_documento_recepcion_solicitud
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.post_documento_tipo(character varying, character varying, integer, integer)
-- DROP FUNCTION IF EXISTS recepciones_documento.post_documento_tipo(character varying, character varying, integer, integer);
CREATE
OR REPLACE FUNCTION recepciones_documento.post_documento_tipo(
  str_nombre character varying,
  str_descripcion character varying,
  int_tipo integer,
  int_id_creador integer
) RETURNS TABLE(id_tipo integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
INSERT INTO
  recepciones_documento.tbl_cat_documento_tipo(
    nombre,
    descripcion,
    estado,
    creado_por,
    actualizado_por,
    fecha_creacion,
    fecha_actualizacion,
    tipo
  )
VALUES
  (
    str_nombre,
    -- nombre
    str_descripcion,
    -- descripcion
    1,
    -- estado
    int_id_creador,
    -- creadoPor
    int_id_creador,
    -- actualizadoPor
    now(),
    -- fechaCreacion
    now(),
    -- fechaActualizacion
    int_tipo -- tipo
  ) RETURNING recepciones_documento.tbl_cat_documento_tipo.id_cat_documento_tipo;

END;

$ BODY $;

ALTER FUNCTION recepciones_documento.post_documento_tipo(
  character varying,
  character varying,
  integer,
  integer
) OWNER TO vince;