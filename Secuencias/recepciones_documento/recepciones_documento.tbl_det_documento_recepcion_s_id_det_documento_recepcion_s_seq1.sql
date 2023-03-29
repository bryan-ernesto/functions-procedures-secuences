/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_det_documento_recepcion_solicitud_detalle de la tabla tbl_det_documento_recepcion_solicitud_detalle, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_det_documento_recepcion_solicitud_detalle
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: recepciones_documento.tbl_det_documento_recepcion_s_id_det_documento_recepcion_s_seq1
-- DROP SEQUENCE IF EXISTS recepciones_documento.tbl_det_documento_recepcion_s_id_det_documento_recepcion_s_seq1;
CREATE SEQUENCE IF NOT EXISTS recepciones_documento.tbl_det_documento_recepcion_s_id_det_documento_recepcion_s_seq1 INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_det_documento_recepcion_solicitud_detalle.id_det_documento_recepcion_solicitud_detalle;

ALTER SEQUENCE recepciones_documento.tbl_det_documento_recepcion_s_id_det_documento_recepcion_s_seq1 OWNER TO vince;