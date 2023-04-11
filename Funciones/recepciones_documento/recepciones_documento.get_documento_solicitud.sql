/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 11 abril 2023
 Modificado: 11 abril 2023
 Descripción: función que permite mostrar la información de una solicitud, permitiendo filtrar por si es individual o masiva, nombre de estado, nombre de tipo, nombre de empresa y adjunto en sharepoint
 Dependencias: recepciones_documento.tbl_det_documento_recepcion_solicitud, recepciones_documento.tbl_cat_documento_estado, recepciones_documento.tbl_cat_documento_tipo, usuarios.tbl_cat_empresa
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.get_documento_solicitud(integer, character varying, character varying, character varying, integer)
-- DROP FUNCTION IF EXISTS recepciones_documento.get_documento_solicitud(integer, character varying, character varying, character varying, integer);
CREATE
OR REPLACE FUNCTION recepciones_documento.get_documento_solicitud(
  int_individual_masiva integer,
  str_nombre_estado character varying,
  str_nombre_tipo character varying,
  str_nombre_empresa character varying,
  int_id_adjunto_sharepoint integer
) RETURNS TABLE(
  id_recepcion_solicitud integer,
  individual_masiva integer,
  id_documento_estado integer,
  nombre_estado character varying,
  id_documento_tipo integer,
  nombre_tipo character varying,
  usuario_autorizador integer,
  id_cat_empresa integer,
  nombre_empresa character varying,
  creado_por integer,
  actualizado_por integer,
  fecha_creacion character varying,
  fecha_actualizacion character varying,
  estado integer,
  id_adjunto integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
SELECT
  TDDRS.id_det_documento_recepcion_solicitud AS id_recepcion_solicitud,
  TDDRS.individual_masiva,
  TDDRS.id_cat_documento_estado AS id_documento_estado,
  TCDE.nombre AS nombre_estado,
  TDDRS.id_cat_documento_tipo AS id_documento_tipo,
  TCDT.nombre AS nombre_tipo,
  TDDRS.id_cat_usuario_autorizador AS usuario_autorizador,
  TDDRS.id_cat_empresa,
  TCE.nombre AS nombre_empresa,
  TDDRS.creado_por,
  TDDRS.actualizado_por,
  to_char(TDDRS.fecha_creacion, 'YYYY-MM-DD') :: varchar AS fecha_creacion,
  to_char(TDDRS.fecha_actualizacion, 'YYYY-MM-DD') :: varchar AS fecha_actualizacion,
  TDDRS.estado,
  TDDRS.adjunto_id_sharepoint AS id_adjunto
FROM
  recepciones_documento.tbl_det_documento_recepcion_solicitud TDDRS
  LEFT JOIN recepciones_documento.tbl_cat_documento_estado TCDE ON TDDRS.id_cat_documento_estado = TCDE.id_cat_documento_estado
  LEFT JOIN recepciones_documento.tbl_cat_documento_tipo TCDT ON TDDRS.id_cat_documento_tipo = TCDT.id_cat_documento_tipo
  LEFT JOIN usuarios.tbl_cat_empresa TCE ON TDDRS.id_cat_empresa = TCE.id_cat_empresa
WHERE
  (
    TDDRS.individual_masiva = int_individual_masiva
    OR int_individual_masiva IS null
  )
  AND (
    UPPER(TCDE.nombre) LIKE ('%' || UPPER(str_nombre_estado) || '%') :: VARCHAR
    OR LENGTH (UPPER(str_nombre_estado)) = 0
  )
  AND (
    UPPER(TCDT.nombre) LIKE ('%' || UPPER(str_nombre_tipo) || '%') :: VARCHAR
    OR LENGTH (UPPER(str_nombre_tipo)) = 0
  )
  AND (
    UPPER(TCE.nombre) LIKE ('%' || UPPER(str_nombre_empresa) || '%') :: VARCHAR
    OR LENGTH (UPPER(str_nombre_empresa)) = 0
  )
  AND (
    TDDRS.adjunto_id_sharepoint = int_id_adjunto_sharepoint
    OR int_id_adjunto_sharepoint = 0
  );

END $ BODY $;

ALTER FUNCTION recepciones_documento.get_documento_solicitud(
  integer,
  character varying,
  character varying,
  character varying,
  integer
) OWNER TO vince;