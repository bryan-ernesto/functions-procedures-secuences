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
-- SEQUENCE: compras_orden_compra.tbl_cat_orden_compra_metodo_p_id_cat_orden_compra_metodo_pa_seq
-- DROP SEQUENCE IF EXISTS compras_orden_compra.tbl_cat_orden_compra_metodo_p_id_cat_orden_compra_metodo_pa_seq;
CREATE SEQUENCE IF NOT EXISTS compras_orden_compra.tbl_cat_orden_compra_metodo_p_id_cat_orden_compra_metodo_pa_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_orden_compra_metodo_pago.id_cat_orden_compra_metodo_pago;

ALTER SEQUENCE compras_orden_compra.tbl_cat_orden_compra_metodo_p_id_cat_orden_compra_metodo_pa_seq OWNER TO vince;