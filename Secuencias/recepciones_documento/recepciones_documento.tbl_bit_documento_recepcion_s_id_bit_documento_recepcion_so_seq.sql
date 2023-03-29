/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_bit_documento_recepcion_solicitud de la tabla tbl_bit_documento_recepcion_solicitud, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_bit_documento_recepcion_solicitud
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: recepciones_documento.tbl_bit_documento_recepcion_s_id_bit_documento_recepcion_so_seq
-- DROP SEQUENCE IF EXISTS recepciones_documento.tbl_bit_documento_recepcion_s_id_bit_documento_recepcion_so_seq;
CREATE SEQUENCE IF NOT EXISTS recepciones_documento.tbl_bit_documento_recepcion_s_id_bit_documento_recepcion_so_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_bit_documento_recepcion_solicitud.id_bit_documento_recepcion_solicitud;

ALTER SEQUENCE recepciones_documento.tbl_bit_documento_recepcion_s_id_bit_documento_recepcion_so_seq OWNER TO vince;