/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_det_horario_asignacion_dia de la tabla tbl_det_horario_asignacion_dia, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_det_horario_asignacion_dia 
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: nova_horario.tbl_det_horario_asignacion_di_id_det_horario_asignacion_dia_seq
-- DROP SEQUENCE IF EXISTS nova_horario.tbl_det_horario_asignacion_di_id_det_horario_asignacion_dia_seq;
CREATE SEQUENCE IF NOT EXISTS nova_horario.tbl_det_horario_asignacion_di_id_det_horario_asignacion_dia_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

ALTER SEQUENCE nova_horario.tbl_det_horario_asignacion_di_id_det_horario_asignacion_dia_seq OWNER TO vince;