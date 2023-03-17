/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_det_recepcion de la tabla tbl_det_recepcion, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_det_recepcion 
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: compras_recepcion.tbl_det_recepcion_id_det_recepcion_seq
-- DROP SEQUENCE IF EXISTS compras_recepcion.tbl_det_recepcion_id_det_recepcion_seq;
CREATE SEQUENCE IF NOT EXISTS compras_recepcion.tbl_det_recepcion_id_det_recepcion_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_det_recepcion.id_det_recepcion;

ALTER SEQUENCE compras_recepcion.tbl_det_recepcion_id_det_recepcion_seq OWNER TO vince;