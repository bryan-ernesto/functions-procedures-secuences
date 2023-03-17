/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_det_tarea_asignacion_usuar de la tabla tbl_det_tarea_asignacion_pues, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_det_tarea_asignacion_pues 
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: nova_proceso_tarea.tbl_det_tarea_asignacion_pues_id_det_tarea_asignacion_usuar_seq
-- DROP SEQUENCE IF EXISTS nova_proceso_tarea.tbl_det_tarea_asignacion_pues_id_det_tarea_asignacion_usuar_seq;
CREATE SEQUENCE IF NOT EXISTS nova_proceso_tarea.tbl_det_tarea_asignacion_pues_id_det_tarea_asignacion_usuar_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

ALTER SEQUENCE nova_proceso_tarea.tbl_det_tarea_asignacion_pues_id_det_tarea_asignacion_usuar_seq OWNER TO vince;