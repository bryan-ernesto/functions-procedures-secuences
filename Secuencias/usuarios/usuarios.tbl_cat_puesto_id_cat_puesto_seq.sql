/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 16 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_puesto de la tabla tbl_cat_puesto, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_puesto
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: usuarios.tbl_cat_puesto_id_cat_puesto_seq
-- DROP SEQUENCE IF EXISTS usuarios.tbl_cat_puesto_id_cat_puesto_seq;
CREATE SEQUENCE IF NOT EXISTS usuarios.tbl_cat_puesto_id_cat_puesto_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_puesto.id_cat_puesto;

ALTER SEQUENCE usuarios.tbl_cat_puesto_id_cat_puesto_seq OWNER TO vince;