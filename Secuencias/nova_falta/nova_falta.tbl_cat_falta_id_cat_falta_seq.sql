/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_falta de la tabla tbl_cat_falta, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_falta
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: nova_falta.tbl_cat_falta_id_cat_falta_seq
-- DROP SEQUENCE IF EXISTS nova_falta.tbl_cat_falta_id_cat_falta_seq;
CREATE SEQUENCE IF NOT EXISTS nova_falta.tbl_cat_falta_id_cat_falta_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

ALTER SEQUENCE nova_falta.tbl_cat_falta_id_cat_falta_seq OWNER TO vince;