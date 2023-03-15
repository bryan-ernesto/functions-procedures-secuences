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
-- SEQUENCE: nova_aplicacion.tbl_cat_aplicacion_id_cat_aplicacion_seq
-- DROP SEQUENCE IF EXISTS nova_aplicacion.tbl_cat_aplicacion_id_cat_aplicacion_seq;
CREATE SEQUENCE IF NOT EXISTS nova_aplicacion.tbl_cat_aplicacion_id_cat_aplicacion_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

ALTER SEQUENCE nova_aplicacion.tbl_cat_aplicacion_id_cat_aplicacion_seq OWNER TO vince;