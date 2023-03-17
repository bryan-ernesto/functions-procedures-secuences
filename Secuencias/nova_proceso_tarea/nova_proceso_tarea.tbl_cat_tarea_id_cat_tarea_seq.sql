/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_tarea de la tabla tbl_cat_tarea, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_tarea
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: nova_proceso_tarea.tbl_cat_tarea_id_cat_tarea_seq
-- DROP SEQUENCE IF EXISTS nova_proceso_tarea.tbl_cat_tarea_id_cat_tarea_seq;
CREATE SEQUENCE IF NOT EXISTS nova_proceso_tarea.tbl_cat_tarea_id_cat_tarea_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

ALTER SEQUENCE nova_proceso_tarea.tbl_cat_tarea_id_cat_tarea_seq OWNER TO vince;