/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_cat_sla_campo_evaluacion de la tabla tbl_cat_sla_campo_evaluacion, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_cat_sla_campo_evaluacion
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: nova_metrica.tbl_cat_sla_campo_evaluacion_id_cat_sla_campo_evaluacion_seq
-- DROP SEQUENCE IF EXISTS nova_metrica.tbl_cat_sla_campo_evaluacion_id_cat_sla_campo_evaluacion_seq;
CREATE SEQUENCE IF NOT EXISTS nova_metrica.tbl_cat_sla_campo_evaluacion_id_cat_sla_campo_evaluacion_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

ALTER SEQUENCE nova_metrica.tbl_cat_sla_campo_evaluacion_id_cat_sla_campo_evaluacion_seq OWNER TO vince;