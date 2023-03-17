/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 16 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_det_usuario_asignacion_equipo de la tabla tbl_det_usuario_asignacion_equipo, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_det_usuario_asignacion_equipo
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: usuarios.tbl_det_usuario_asignacion_equipo_id_det_usuario_asignacion_seq
-- DROP SEQUENCE IF EXISTS usuarios.tbl_det_usuario_asignacion_equipo_id_det_usuario_asignacion_seq;
CREATE SEQUENCE IF NOT EXISTS usuarios.tbl_det_usuario_asignacion_equipo_id_det_usuario_asignacion_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_det_usuario_asignacion_equipo.id_det_usuario_asignacion_equipo;

ALTER SEQUENCE usuarios.tbl_det_usuario_asignacion_equipo_id_det_usuario_asignacion_seq OWNER TO vince;