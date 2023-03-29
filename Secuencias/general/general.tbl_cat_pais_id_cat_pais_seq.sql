/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_pais de la tabla tbl_cat_pais, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_pais
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: general.tbl_cat_pais_id_cat_pais_seq
-- DROP SEQUENCE IF EXISTS general.tbl_cat_pais_id_cat_pais_seq;
CREATE SEQUENCE IF NOT EXISTS general.tbl_cat_pais_id_cat_pais_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_pais.id_cat_pais;

ALTER SEQUENCE general.tbl_cat_pais_id_cat_pais_seq OWNER TO vince;