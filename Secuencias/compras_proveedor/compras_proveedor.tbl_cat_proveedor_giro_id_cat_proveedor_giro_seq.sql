/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_proveedor_giro de la tabla tbl_cat_proveedor_giro, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_proveedor_giro
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: compras_proveedor.tbl_cat_proveedor_giro_id_cat_proveedor_giro_seq
-- DROP SEQUENCE IF EXISTS compras_proveedor.tbl_cat_proveedor_giro_id_cat_proveedor_giro_seq;
CREATE SEQUENCE IF NOT EXISTS compras_proveedor.tbl_cat_proveedor_giro_id_cat_proveedor_giro_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_proveedor_giro.id_cat_proveedor_giro;

ALTER SEQUENCE compras_proveedor.tbl_cat_proveedor_giro_id_cat_proveedor_giro_seq OWNER TO vince;