/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_bit_presupuesto_ajuste de la tabla tbl_bit_presupuesto_ajuste, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_bit_presupuesto_ajuste
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: compras_presupuesto.tbl_bit_presupuesto_ajuste_id_bit_presupuesto_ajuste_seq
-- DROP SEQUENCE IF EXISTS compras_presupuesto.tbl_bit_presupuesto_ajuste_id_bit_presupuesto_ajuste_seq;
CREATE SEQUENCE IF NOT EXISTS compras_presupuesto.tbl_bit_presupuesto_ajuste_id_bit_presupuesto_ajuste_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_bit_presupuesto_ajuste.id_bit_presupuesto_ajuste;

ALTER SEQUENCE compras_presupuesto.tbl_bit_presupuesto_ajuste_id_bit_presupuesto_ajuste_seq OWNER TO vince;