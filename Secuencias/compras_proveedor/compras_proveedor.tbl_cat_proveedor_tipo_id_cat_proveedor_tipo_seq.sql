/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_proveedor_tipo de la tabla tbl_cat_proveedor_tipo, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_proveedor_tipo
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: compras_proveedor.tbl_cat_proveedor_tipo_id_cat_proveedor_tipo_seq
-- DROP SEQUENCE IF EXISTS compras_proveedor.tbl_cat_proveedor_tipo_id_cat_proveedor_tipo_seq;
CREATE SEQUENCE IF NOT EXISTS compras_proveedor.tbl_cat_proveedor_tipo_id_cat_proveedor_tipo_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_proveedor_tipo.id_cat_proveedor_tipo;

ALTER SEQUENCE compras_proveedor.tbl_cat_proveedor_tipo_id_cat_proveedor_tipo_seq OWNER TO vince;