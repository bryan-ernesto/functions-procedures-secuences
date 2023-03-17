/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_det_orden_compra de la tabla tbl_det_orden_compra, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: 
 ERD:
 Nombre ERD: 
 */
-- SEQUENCE: compras_orden_compra.tbl_det_orden_compra_id_det_orden_compra_seq
-- DROP SEQUENCE IF EXISTS compras_orden_compra.tbl_det_orden_compra_id_det_orden_compra_seq;
CREATE SEQUENCE IF NOT EXISTS compras_orden_compra.tbl_det_orden_compra_id_det_orden_compra_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_det_orden_compra.id_det_orden_compra;

ALTER SEQUENCE compras_orden_compra.tbl_det_orden_compra_id_det_orden_compra_seq OWNER TO vince;