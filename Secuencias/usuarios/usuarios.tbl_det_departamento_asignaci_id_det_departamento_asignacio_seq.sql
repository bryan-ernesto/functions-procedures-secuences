/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 16 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_det_departamento_asignacio de la tabla tbl_det_departamento_asignaci, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_det_departamento_asignaci
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: usuarios.tbl_det_departamento_asignaci_id_det_departamento_asignacio_seq
-- DROP SEQUENCE IF EXISTS usuarios.tbl_det_departamento_asignaci_id_det_departamento_asignacio_seq;
CREATE SEQUENCE IF NOT EXISTS usuarios.tbl_det_departamento_asignaci_id_det_departamento_asignacio_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_det_departamento_asignacion_responsable.id_det_departamento_asignacion_responsable;

ALTER SEQUENCE usuarios.tbl_det_departamento_asignaci_id_det_departamento_asignacio_seq OWNER TO vince;