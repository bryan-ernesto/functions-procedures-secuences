/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_bit_reporte_consulta de la tabla tbl_bit_reporte_consulta, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_bit_reporte_consulta
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: general.tbl_bit_reporte_consulta_id_bit_reporte_consulta_seq
-- DROP SEQUENCE IF EXISTS general.tbl_bit_reporte_consulta_id_bit_reporte_consulta_seq;
CREATE SEQUENCE IF NOT EXISTS general.tbl_bit_reporte_consulta_id_bit_reporte_consulta_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_bit_reporte_consulta.id_bit_reporte_consulta;

ALTER SEQUENCE general.tbl_bit_reporte_consulta_id_bit_reporte_consulta_seq OWNER TO vince;