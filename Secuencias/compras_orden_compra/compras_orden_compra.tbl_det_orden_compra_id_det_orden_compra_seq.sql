/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 13 marzo 2023
 Descripción: 
 Dependencias: 
 ERD:
 Nombre ERD: 
 */
-- SEQUENCE: compras_orden_compra.tbl_det_orden_compra_id_det_orden_compra_seq
-- DROP SEQUENCE IF EXISTS compras_orden_compra.tbl_det_orden_compra_id_det_orden_compra_seq;
CREATE SEQUENCE IF NOT EXISTS compras_orden_compra.tbl_det_orden_compra_id_det_orden_compra_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_det_orden_compra.id_det_orden_compra;

ALTER SEQUENCE compras_orden_compra.tbl_det_orden_compra_id_det_orden_compra_seq OWNER TO vince;