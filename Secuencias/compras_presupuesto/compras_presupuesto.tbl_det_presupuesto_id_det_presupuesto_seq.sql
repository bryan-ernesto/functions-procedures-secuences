/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_det_presupuesto de la tabla tbl_det_presupuesto, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: 
 ERD:
 Nombre ERD: 
 */
-- SEQUENCE: compras_presupuesto.tbl_det_presupuesto_id_det_presupuesto_seq
-- DROP SEQUENCE IF EXISTS compras_presupuesto.tbl_det_presupuesto_id_det_presupuesto_seq;
CREATE SEQUENCE IF NOT EXISTS compras_presupuesto.tbl_det_presupuesto_id_det_presupuesto_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_det_presupuesto.id_det_presupuesto;

ALTER SEQUENCE compras_presupuesto.tbl_det_presupuesto_id_det_presupuesto_seq OWNER TO vince;