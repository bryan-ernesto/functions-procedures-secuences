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
-- SEQUENCE: usuarios.tbl_cat_departamento_id_cat_departamento_seq
-- DROP SEQUENCE IF EXISTS usuarios.tbl_cat_departamento_id_cat_departamento_seq;
CREATE SEQUENCE IF NOT EXISTS usuarios.tbl_cat_departamento_id_cat_departamento_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_departamento.id_cat_departamento;

ALTER SEQUENCE usuarios.tbl_cat_departamento_id_cat_departamento_seq OWNER TO vince;