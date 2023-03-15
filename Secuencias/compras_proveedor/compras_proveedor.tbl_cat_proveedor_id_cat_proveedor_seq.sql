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
-- SEQUENCE: compras_proveedor.tbl_cat_proveedor_id_cat_proveedor_seq
-- DROP SEQUENCE IF EXISTS compras_proveedor.tbl_cat_proveedor_id_cat_proveedor_seq;
CREATE SEQUENCE IF NOT EXISTS compras_proveedor.tbl_cat_proveedor_id_cat_proveedor_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_proveedor.id_cat_proveedor;

ALTER SEQUENCE compras_proveedor.tbl_cat_proveedor_id_cat_proveedor_seq OWNER TO vince;