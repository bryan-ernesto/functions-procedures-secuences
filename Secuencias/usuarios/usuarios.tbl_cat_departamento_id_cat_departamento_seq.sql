/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_departamento de la tabla tbl_cat_departamento, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_departamento
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: usuarios.tbl_cat_departamento_id_cat_departamento_seq
-- DROP SEQUENCE IF EXISTS usuarios.tbl_cat_departamento_id_cat_departamento_seq;
CREATE SEQUENCE IF NOT EXISTS usuarios.tbl_cat_departamento_id_cat_departamento_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_departamento.id_cat_departamento;

ALTER SEQUENCE usuarios.tbl_cat_departamento_id_cat_departamento_seq OWNER TO vince;