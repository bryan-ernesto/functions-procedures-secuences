/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_tipo_horario de la tabla tbl_bit_horario_marcaje, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_bit_horario_marcaje
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: nova_horario.tbl_bit_horario_marcaje_id_cat_tipo_horario_seq
-- DROP SEQUENCE IF EXISTS nova_horario.tbl_bit_horario_marcaje_id_cat_tipo_horario_seq;
CREATE SEQUENCE IF NOT EXISTS nova_horario.tbl_bit_horario_marcaje_id_cat_tipo_horario_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

ALTER SEQUENCE nova_horario.tbl_bit_horario_marcaje_id_cat_tipo_horario_seq OWNER TO vince;