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
-- SEQUENCE: compras_solicitud.tbl_cat_solicitud_id_cat_solicitud_seq
-- DROP SEQUENCE IF EXISTS compras_solicitud.tbl_cat_solicitud_id_cat_solicitud_seq;
CREATE SEQUENCE IF NOT EXISTS compras_solicitud.tbl_cat_solicitud_id_cat_solicitud_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_solicitud.id_cat_solicitud;

ALTER SEQUENCE compras_solicitud.tbl_cat_solicitud_id_cat_solicitud_seq OWNER TO vince;