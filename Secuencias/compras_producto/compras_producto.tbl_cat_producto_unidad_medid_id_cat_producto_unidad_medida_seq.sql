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
-- SEQUENCE: compras_producto.tbl_cat_producto_unidad_medid_id_cat_producto_unidad_medida_seq
-- DROP SEQUENCE IF EXISTS compras_producto.tbl_cat_producto_unidad_medid_id_cat_producto_unidad_medida_seq;
CREATE SEQUENCE IF NOT EXISTS compras_producto.tbl_cat_producto_unidad_medid_id_cat_producto_unidad_medida_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_producto_unidad_medida.id_cat_producto_unidad_medida;

ALTER SEQUENCE compras_producto.tbl_cat_producto_unidad_medid_id_cat_producto_unidad_medida_seq OWNER TO vince;