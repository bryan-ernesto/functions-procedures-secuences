/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_det_solicitud de la tabla tbl_det_solicitud, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_det_solicitud
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: compras_solicitud.tbl_det_solicitud_id_det_solicitud_seq
-- DROP SEQUENCE IF EXISTS compras_solicitud.tbl_det_solicitud_id_det_solicitud_seq;
CREATE SEQUENCE IF NOT EXISTS compras_solicitud.tbl_det_solicitud_id_det_solicitud_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_det_solicitud.id_det_solicitud;

ALTER SEQUENCE compras_solicitud.tbl_det_solicitud_id_det_solicitud_seq OWNER TO vince;