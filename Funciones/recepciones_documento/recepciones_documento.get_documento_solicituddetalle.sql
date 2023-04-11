/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 11 abril 2023
 Modificado: 11 abril 2023
 Descripción: función que permite mostrar la información del detalle de una solicitud, permitiendo filtrar por id_solicitud, dte, proveedor, nit, numeic, moneda, descripción, pais, adjunto sharepoint
 Dependencias: recepciones_documento.tbl_det_documento_estado_asignacion_canal, recepciones_documento.tbl_cat_documento_estado, recepciones_documento.tbl_cat_documento_canal
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.get_documento_solicituddetalle(integer, bigint, character varying, integer, numeric, integer, character varying, integer, integer)
-- DROP FUNCTION IF EXISTS recepciones_documento.get_documento_solicituddetalle(integer, bigint, character varying, integer, numeric, integer, character varying, integer, integer);
CREATE
OR REPLACE FUNCTION recepciones_documento.get_documento_solicituddetalle(
  int_id_solicitud integer,
  int_dte bigint,
  str_proveedor character varying,
  int_nit integer,
  numeric_monto numeric,
  int_id_moneda integer,
  str_descripcion character varying,
  int_id_pais integer,
  int_id_sharepoint integer
) RETURNS TABLE(
  id_solicitud_detalle integer,
  id_solicitud integer,
  id_estado integer,
  nombre_estado character varying,
  dte bigint,
  proveedor character varying,
  nit integer,
  monto numeric,
  fecha_factura character varying,
  id_moneda integer,
  nombre_moneda character varying,
  descripcion_factura character varying,
  id_pais integer,
  nombre_pais character varying,
  id_anticipo integer,
  estado integer,
  creado_por integer,
  actualizado_por integer,
  fecha_creacion character varying,
  fecha_actualizacion character varying,
  id_sharepoint integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
SELECT
  TDDRSD.id_det_documento_recepcion_solicitud_detalle AS id_solicitud_detalle,
  TDDRSD.id_det_documento_recepcion_solicitud AS id_solicitud,
  TDDRSD.id_cat_documento_estado AS id_estado,
  TCDE.nombre AS nombre_estado,
  TDDRSD.dte,
  TDDRSD.proveedor,
  TDDRSD.nit,
  TDDRSD.monto,
  to_char(TDDRSD.fecha, 'YYYY-MM-DD') :: varchar AS fecha_factura,
  TDDRSD.id_cat_moneda AS id_moneda,
  TCM.nombre AS nombre_moneda,
  TDDRSD.descripcion descripcion_factura,
  TDDRSD.id_cat_pais AS id_pais,
  TCP.nombre AS nombre_pais,
  TDDRSD.id_det_documento_anticipo AS id_anticipo,
  TDDRSD.estado,
  TDDRSD.creado_por,
  TDDRSD.actualizado_por,
  to_char(TDDRSD.fecha_creacion, 'YYYY-MM-DD') :: varchar AS fecha_creacion,
  to_char(TDDRSD.fecha_actualizacion, 'YYYY-MM-DD') :: varchar AS fecha_actualizacion,
  TDDRSD.adjunto_id_sharepoint AS id_sharepoint
FROM
  recepciones_documento.tbl_det_documento_recepcion_solicitud_detalle TDDRSD
  LEFT JOIN recepciones_documento.tbl_cat_documento_estado TCDE ON TDDRSD.id_cat_documento_estado = TCDE.id_cat_documento_estado
  LEFT JOIN general.tbl_cat_moneda TCM ON TDDRSD.id_cat_moneda = TCM.id_cat_moneda
  LEFT JOIN general.tbl_cat_pais TCP ON TDDRSD.id_cat_pais = TCP.id_cat_pais
WHERE
  (
    TDDRSD.id_det_documento_recepcion_solicitud = int_id_solicitud
    OR int_id_solicitud = 0
  )
  AND (
    TDDRSD.dte = int_dte
    OR int_dte = 0
  )
  AND (
    UPPER(TDDRSD.proveedor) LIKE ('%' || UPPER(str_proveedor) || '%') :: VARCHAR
    OR LENGTH (UPPER (str_proveedor)) = 0
  )
  AND (
    TDDRSD.nit = int_nit
    OR int_nit = 0
  )
  AND (
    TDDRSD.monto = numeric_monto
    OR numeric_monto = 0
  )
  AND (
    TDDRSD.id_cat_moneda = int_id_moneda
    OR int_id_moneda = 0
  )
  AND (
    UPPER(TDDRSD.descripcion) LIKE ('%' || UPPER(str_descripcion) || '%') :: VARCHAR
    OR LENGTH (UPPER(str_descripcion)) = 0
  )
  AND (
    TDDRSD.id_cat_pais = int_id_pais
    OR int_id_pais = 0
  )
  AND (
    TDDRSD.adjunto_id_sharepoint = int_id_sharepoint
    OR int_id_sharepoint = 0
  );

END $ BODY $;

ALTER FUNCTION recepciones_documento.get_documento_solicituddetalle(
  integer,
  bigint,
  character varying,
  integer,
  numeric,
  integer,
  character varying,
  integer,
  integer
) OWNER TO vince;