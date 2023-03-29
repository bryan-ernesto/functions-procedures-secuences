/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_aplicativo_login de la tabla tbl_bit_aplicativo_login, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_bit_aplicativo_login
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: usuarios.tbl_cat_aplicativo_login_id_cat_aplicativo_login_seq
-- DROP SEQUENCE IF EXISTS usuarios.tbl_cat_aplicativo_login_id_cat_aplicativo_login_seq;
CREATE SEQUENCE IF NOT EXISTS usuarios.tbl_cat_aplicativo_login_id_cat_aplicativo_login_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_bit_aplicativo_login.id_cat_aplicativo_login;

ALTER SEQUENCE usuarios.tbl_cat_aplicativo_login_id_cat_aplicativo_login_seq OWNER TO vince;