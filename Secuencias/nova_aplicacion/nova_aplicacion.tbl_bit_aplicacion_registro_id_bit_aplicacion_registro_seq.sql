/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_bit_aplicacion_registro de la tabla tbl_bit_aplicacion_registro, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_bit_aplicacion_registro
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: nova_aplicacion.tbl_bit_aplicacion_registro_id_bit_aplicacion_registro_seq
-- DROP SEQUENCE IF EXISTS nova_aplicacion.tbl_bit_aplicacion_registro_id_bit_aplicacion_registro_seq;
CREATE SEQUENCE IF NOT EXISTS nova_aplicacion.tbl_bit_aplicacion_registro_id_bit_aplicacion_registro_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

ALTER SEQUENCE nova_aplicacion.tbl_bit_aplicacion_registro_id_bit_aplicacion_registro_seq OWNER TO vince;