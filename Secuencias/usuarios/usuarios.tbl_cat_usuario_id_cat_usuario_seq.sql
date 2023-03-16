/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 16 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: 
 Dependencias: 
 ERD:
 Nombre ERD: 
 */
-- SEQUENCE: usuarios.tbl_cat_usuario_id_cat_usuario_seq
-- DROP SEQUENCE IF EXISTS usuarios.tbl_cat_usuario_id_cat_usuario_seq;
CREATE SEQUENCE IF NOT EXISTS usuarios.tbl_cat_usuario_id_cat_usuario_seq INCREMENT 1 START 78 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_cat_usuario.id_cat_usuario;

ALTER SEQUENCE usuarios.tbl_cat_usuario_id_cat_usuario_seq OWNER TO vince;