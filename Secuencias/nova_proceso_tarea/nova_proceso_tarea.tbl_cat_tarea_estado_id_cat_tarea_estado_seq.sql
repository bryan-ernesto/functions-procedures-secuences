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
-- SEQUENCE: nova_proceso_tarea.tbl_cat_tarea_estado_id_cat_tarea_estado_seq
-- DROP SEQUENCE IF EXISTS nova_proceso_tarea.tbl_cat_tarea_estado_id_cat_tarea_estado_seq;
CREATE SEQUENCE IF NOT EXISTS nova_proceso_tarea.tbl_cat_tarea_estado_id_cat_tarea_estado_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

ALTER SEQUENCE nova_proceso_tarea.tbl_cat_tarea_estado_id_cat_tarea_estado_seq OWNER TO vince;