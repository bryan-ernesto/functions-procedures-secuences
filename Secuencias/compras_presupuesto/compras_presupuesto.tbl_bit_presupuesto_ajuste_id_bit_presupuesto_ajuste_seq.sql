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
-- SEQUENCE: compras_presupuesto.tbl_bit_presupuesto_ajuste_id_bit_presupuesto_ajuste_seq
-- DROP SEQUENCE IF EXISTS compras_presupuesto.tbl_bit_presupuesto_ajuste_id_bit_presupuesto_ajuste_seq;
CREATE SEQUENCE IF NOT EXISTS compras_presupuesto.tbl_bit_presupuesto_ajuste_id_bit_presupuesto_ajuste_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_bit_presupuesto_ajuste.id_bit_presupuesto_ajuste;

ALTER SEQUENCE compras_presupuesto.tbl_bit_presupuesto_ajuste_id_bit_presupuesto_ajuste_seq OWNER TO vince;