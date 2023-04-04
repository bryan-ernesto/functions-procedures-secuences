/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 04 abril 2023
 Modificado: 04 abril 2023
 Descripción: función que permite mostrar la información del detalle de un documento de la SAT, permitiendo filtrar por cada uno de ellos
 Dependencias: recepciones_documento.tbl_det_documento_recepcion_sat, general.tbl_cat_moneda, general.tbl_cat_pais
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.get_documento_detallefacturasat(bigint, integer, character varying, numeric, integer, character varying, integer)
-- DROP FUNCTION IF EXISTS recepciones_documento.get_documento_detallefacturasat(bigint, integer, character varying, numeric, integer, character varying, integer);
CREATE
OR REPLACE FUNCTION recepciones_documento.get_documento_detallefacturasat(
  int_dte bigint,
  int_nit integer,
  str_proveedor character varying,
  numeric_monto numeric,
  int_id_moneda integer,
  str_descripcion character varying,
  int_id_pais integer
) RETURNS TABLE(
  factura_sat_id integer,
  dte bigint,
  nit integer,
  nombre_proveedor character varying,
  monto numeric,
  nombre_moneda character varying,
  descripcion_factura character varying,
  nombre_pais character varying,
  fecha_emision_factura character varying
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
SELECT
  TDDRS.id_det_documento_recepcion_sat AS factura_sat_id,
  TDDRS.dte,
  TDDRS.nit,
  TDDRS.proveedor AS nombre_proveedor,
  TDDRS.monto,
  TCM.nombre AS nombre_moneda,
  TDDRS.descripcion AS descripcion_factura,
  TCP.nombre AS nombre_pais,
  to_char(TDDRS.fecha_emision, 'YYYY-MM-DD') :: varchar AS fecha_emision_factura
FROM
  recepciones_documento.tbl_det_documento_recepcion_sat TDDRS
  LEFT JOIN general.tbl_cat_moneda TCM ON TDDRS.id_cat_moneda = TCM.id_cat_moneda
  LEFT JOIN general.tbl_cat_pais TCP ON TDDRS.id_cat_pais = TCP.id_cat_pais
WHERE
  (
    TDDRS.dte = int_dte
    OR int_dte = 0
  )
  AND (
    TDDRS.nit = int_nit
    OR int_nit = 0
  )
  AND (
    UPPER(TDDRS.proveedor) LIKE ('%' || UPPER(str_proveedor) || '%') :: VARCHAR
    OR LENGTH (UPPER (str_proveedor)) = 0
  )
  AND (
    TDDRS.monto = numeric_monto
    OR numeric_monto = 0
  )
  AND (
    TDDRS.id_cat_moneda = int_id_moneda
    OR int_id_moneda = 0
  )
  AND (
    UPPER(TDDRS.descripcion) LIKE ('%' || UPPER(str_descripcion) || '%') :: VARCHAR
    OR LENGTH (UPPER(str_descripcion)) = 0
  )
  AND (
    TDDRS.id_cat_pais = int_id_pais
    OR int_id_pais = 0
  );

END $ BODY $;

ALTER FUNCTION recepciones_documento.get_documento_detallefacturasat(
  bigint,
  integer,
  character varying,
  numeric,
  integer,
  character varying,
  integer
) OWNER TO vince;