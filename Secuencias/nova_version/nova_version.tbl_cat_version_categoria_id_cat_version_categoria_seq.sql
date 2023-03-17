/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_version_categoria de la tabla tbl_cat_version_categoria, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_version_categoria
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: nova_version.tbl_cat_version_categoria_id_cat_version_categoria_seq
-- DROP SEQUENCE IF EXISTS nova_version.tbl_cat_version_categoria_id_cat_version_categoria_seq;
CREATE SEQUENCE IF NOT EXISTS nova_version.tbl_cat_version_categoria_id_cat_version_categoria_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_version_categoria.id_cat_version_categoria;

ALTER SEQUENCE nova_version.tbl_cat_version_categoria_id_cat_version_categoria_seq OWNER TO vince;