/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_documento_canal de la tabla tbl_cat_documento_canal, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_documento_canal
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: recepciones_documento.tbl_cat_documento_canal_id_cat_documento_canal_seq
-- DROP SEQUENCE IF EXISTS recepciones_documento.tbl_cat_documento_canal_id_cat_documento_canal_seq;
CREATE SEQUENCE IF NOT EXISTS recepciones_documento.tbl_cat_documento_canal_id_cat_documento_canal_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_documento_canal.id_cat_documento_canal;

ALTER SEQUENCE recepciones_documento.tbl_cat_documento_canal_id_cat_documento_canal_seq OWNER TO vince;