/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_bit_documento_anticipo de la tabla tbl_bit_documento_anticipo, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_bit_documento_anticipo
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: recepciones_documento.tbl_bit_documento_anticipo_id_bit_documento_recepcion_seq
-- DROP SEQUENCE IF EXISTS recepciones_documento.tbl_bit_documento_anticipo_id_bit_documento_recepcion_seq;
CREATE SEQUENCE IF NOT EXISTS recepciones_documento.tbl_bit_documento_anticipo_id_bit_documento_recepcion_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_bit_documento_anticipo.id_bit_documento_anticipo;

ALTER SEQUENCE recepciones_documento.tbl_bit_documento_anticipo_id_bit_documento_recepcion_seq OWNER TO vince;