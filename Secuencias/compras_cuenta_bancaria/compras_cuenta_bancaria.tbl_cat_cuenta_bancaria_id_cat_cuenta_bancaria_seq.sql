/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_cuenta_bancaria de la tabla tbl_cat_cuenta_bancaria, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: 
 ERD:
 Nombre ERD: 
 */
-- SEQUENCE: compras_cuenta_bancaria.tbl_cat_cuenta_bancaria_id_cat_cuenta_bancaria_seq
-- DROP SEQUENCE IF EXISTS compras_cuenta_bancaria.tbl_cat_cuenta_bancaria_id_cat_cuenta_bancaria_seq;
CREATE SEQUENCE IF NOT EXISTS compras_cuenta_bancaria.tbl_cat_cuenta_bancaria_id_cat_cuenta_bancaria_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_cuenta_bancaria.id_cat_cuenta_bancaria;

ALTER SEQUENCE compras_cuenta_bancaria.tbl_cat_cuenta_bancaria_id_cat_cuenta_bancaria_seq OWNER TO vince;