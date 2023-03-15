/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 13 marzo 2023
 Descripción: 
 Dependencias: 
 ERD:
 Nombre ERD: 
 */
-- SEQUENCE: compras_cuenta.tbl_cat_cuenta_id_cat_cuenta_seq
-- DROP SEQUENCE IF EXISTS compras_cuenta.tbl_cat_cuenta_id_cat_cuenta_seq;
CREATE SEQUENCE IF NOT EXISTS compras_cuenta.tbl_cat_cuenta_id_cat_cuenta_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_cuenta.id_cat_cuenta;

ALTER SEQUENCE compras_cuenta.tbl_cat_cuenta_id_cat_cuenta_seq OWNER TO vince;