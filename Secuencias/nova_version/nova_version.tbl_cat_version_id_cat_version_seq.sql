/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_version de la tabla tbl_cat_version, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_version
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: nova_version.tbl_cat_version_id_cat_version_seq
-- DROP SEQUENCE IF EXISTS nova_version.tbl_cat_version_id_cat_version_seq;
CREATE SEQUENCE IF NOT EXISTS nova_version.tbl_cat_version_id_cat_version_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_version.id_cat_version;

ALTER SEQUENCE nova_version.tbl_cat_version_id_cat_version_seq OWNER TO vince;