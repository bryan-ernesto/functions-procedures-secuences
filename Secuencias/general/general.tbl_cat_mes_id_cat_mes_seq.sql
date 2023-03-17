/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_mes de la tabla tbl_cat_mes, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_mes
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: general.tbl_cat_mes_id_cat_mes_seq
-- DROP SEQUENCE IF EXISTS general.tbl_cat_mes_id_cat_mes_seq;
CREATE SEQUENCE IF NOT EXISTS general.tbl_cat_mes_id_cat_mes_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_mes.id_cat_mes;

ALTER SEQUENCE general.tbl_cat_mes_id_cat_mes_seq OWNER TO vince;