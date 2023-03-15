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
-- SEQUENCE: nova_metrica.tbl_cat_sla_id_cat_sla_seq
-- DROP SEQUENCE IF EXISTS nova_metrica.tbl_cat_sla_id_cat_sla_seq;
CREATE SEQUENCE IF NOT EXISTS nova_metrica.tbl_cat_sla_id_cat_sla_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

ALTER SEQUENCE nova_metrica.tbl_cat_sla_id_cat_sla_seq OWNER TO vince;