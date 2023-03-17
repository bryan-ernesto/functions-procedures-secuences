/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 16 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_det_grupo_asignacion_aplic de la tabla tbl_det_grupo_asignacion_apli, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_det_grupo_asignacion_apli
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: usuarios.tbl_det_grupo_asignacion_apli_id_det_grupo_asignacion_aplic_seq
-- DROP SEQUENCE IF EXISTS usuarios.tbl_det_grupo_asignacion_apli_id_det_grupo_asignacion_aplic_seq;
CREATE SEQUENCE IF NOT EXISTS usuarios.tbl_det_grupo_asignacion_apli_id_det_grupo_asignacion_aplic_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_det_grupo_asignacion_aplicativo.id_det_grupo_asignacion_aplicativo;

ALTER SEQUENCE usuarios.tbl_det_grupo_asignacion_apli_id_det_grupo_asignacion_aplic_seq OWNER TO vince;