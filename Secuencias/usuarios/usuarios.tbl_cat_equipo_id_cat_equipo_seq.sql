/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_equipo de la tabla tbl_cat_equipo, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_equipo
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: usuarios.tbl_cat_equipo_id_cat_equipo_seq
-- DROP SEQUENCE IF EXISTS usuarios.tbl_cat_equipo_id_cat_equipo_seq;
CREATE SEQUENCE IF NOT EXISTS usuarios.tbl_cat_equipo_id_cat_equipo_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_equipo.id_cat_equipo;

ALTER SEQUENCE usuarios.tbl_cat_equipo_id_cat_equipo_seq OWNER TO vince;