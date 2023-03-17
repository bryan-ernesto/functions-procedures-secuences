/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_orden_compra_tipo_cuot de la tabla tbl_cat_orden_compra_tipo_cuo, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_orden_compra_tipo_cuo
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: compras_orden_compra.tbl_cat_orden_compra_tipo_cuo_id_cat_orden_compra_tipo_cuot_seq
-- DROP SEQUENCE IF EXISTS compras_orden_compra.tbl_cat_orden_compra_tipo_cuo_id_cat_orden_compra_tipo_cuot_seq;
CREATE SEQUENCE IF NOT EXISTS compras_orden_compra.tbl_cat_orden_compra_tipo_cuo_id_cat_orden_compra_tipo_cuot_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_orden_compra_tipo_cuota.id_cat_orden_compra_tipo_cuota;

ALTER SEQUENCE compras_orden_compra.tbl_cat_orden_compra_tipo_cuo_id_cat_orden_compra_tipo_cuot_seq OWNER TO vince;