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
-- SEQUENCE: usuarios.tbl_cat_permiso_grupo_id_cat_permiso_grupo_seq
-- DROP SEQUENCE IF EXISTS usuarios.tbl_cat_permiso_grupo_id_cat_permiso_grupo_seq;
CREATE SEQUENCE IF NOT EXISTS usuarios.tbl_cat_permiso_grupo_id_cat_permiso_grupo_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_permiso_grupo.id_cat_permiso_grupo;

ALTER SEQUENCE usuarios.tbl_cat_permiso_grupo_id_cat_permiso_grupo_seq OWNER TO vince;