/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_bit_dispositivo_diagnostic de la tabla tbl_bit_dispositivo_diagnosti, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_bit_dispositivo_diagnosti
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: nova_dispositivo.tbl_bit_dispositivo_diagnosti_id_bit_dispositivo_diagnostic_seq
-- DROP SEQUENCE IF EXISTS nova_dispositivo.tbl_bit_dispositivo_diagnosti_id_bit_dispositivo_diagnostic_seq;
CREATE SEQUENCE IF NOT EXISTS nova_dispositivo.tbl_bit_dispositivo_diagnosti_id_bit_dispositivo_diagnostic_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_bit_dispositivo_diagnostico.id_bit_dispositivo_diagnostico;

ALTER SEQUENCE nova_dispositivo.tbl_bit_dispositivo_diagnosti_id_bit_dispositivo_diagnostic_seq OWNER TO vince;