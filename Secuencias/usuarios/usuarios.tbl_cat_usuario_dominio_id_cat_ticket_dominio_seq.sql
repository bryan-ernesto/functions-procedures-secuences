/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 16 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: 
 Dependencias: 
 ERD:
 Nombre ERD: 
 */
-- SEQUENCE: usuarios.tbl_cat_usuario_dominio_id_cat_ticket_dominio_seq
-- DROP SEQUENCE IF EXISTS usuarios.tbl_cat_usuario_dominio_id_cat_ticket_dominio_seq;
CREATE SEQUENCE IF NOT EXISTS usuarios.tbl_cat_usuario_dominio_id_cat_ticket_dominio_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

ALTER SEQUENCE usuarios.tbl_cat_usuario_dominio_id_cat_ticket_dominio_seq OWNER TO vince;