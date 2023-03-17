/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_orden_compra_estado de la tabla tbl_cat_orden_compra_estado, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_orden_compra_estado
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: compras_orden_compra.tbl_cat_orden_compra_estado_id_cat_orden_compra_estado_seq
-- DROP SEQUENCE IF EXISTS compras_orden_compra.tbl_cat_orden_compra_estado_id_cat_orden_compra_estado_seq;
CREATE SEQUENCE IF NOT EXISTS compras_orden_compra.tbl_cat_orden_compra_estado_id_cat_orden_compra_estado_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_orden_compra_estado.id_cat_orden_compra_estado;

ALTER SEQUENCE compras_orden_compra.tbl_cat_orden_compra_estado_id_cat_orden_compra_estado_seq OWNER TO vince;