/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_cuenta_clasificación de la tabla tbl_cat_cuenta_clasificacion, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_cuenta_clasificacion
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: compras_cuenta.tbl_cat_cuenta_clasificacion_id_cat_cuenta_clasificacion_seq
-- DROP SEQUENCE IF EXISTS compras_cuenta.tbl_cat_cuenta_clasificacion_id_cat_cuenta_clasificacion_seq;
CREATE SEQUENCE IF NOT EXISTS compras_cuenta.tbl_cat_cuenta_clasificacion_id_cat_cuenta_clasificacion_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_cuenta_clasificacion.id_cat_cuenta_clasificacion;

ALTER SEQUENCE compras_cuenta.tbl_cat_cuenta_clasificacion_id_cat_cuenta_clasificacion_seq OWNER TO vince;