/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_documento_validacion de la tabla tbl_cat_documento_validacion, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_documento_validacion
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: recepciones_documento.tbl_cat_documento_validacion_id_cat_documento_validacion_seq
-- DROP SEQUENCE IF EXISTS recepciones_documento.tbl_cat_documento_validacion_id_cat_documento_validacion_seq;
CREATE SEQUENCE IF NOT EXISTS recepciones_documento.tbl_cat_documento_validacion_id_cat_documento_validacion_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_documento_validacion.id_cat_documento_validacion;

ALTER SEQUENCE recepciones_documento.tbl_cat_documento_validacion_id_cat_documento_validacion_seq OWNER TO vince;