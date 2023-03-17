/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: secuencia que incrementa de uno en uno el id_bit_ticket_detalle_accion de la tabla tbl_bit_ticket_detalle_accion, cada vez que se ingrese un registro o se ejecute una función o procedimiento
 Dependencias: tbl_bit_ticket_detalle_accion
 ERD: NO
 Nombre ERD: NO
 */
-- SEQUENCE: nova_ticket.tbl_bit_ticket_detalle_accion_id_bit_ticket_detalle_accion_seq
-- DROP SEQUENCE IF EXISTS nova_ticket.tbl_bit_ticket_detalle_accion_id_bit_ticket_detalle_accion_seq;
CREATE SEQUENCE IF NOT EXISTS nova_ticket.tbl_bit_ticket_detalle_accion_id_bit_ticket_detalle_accion_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;

ALTER SEQUENCE nova_ticket.tbl_bit_ticket_detalle_accion_id_bit_ticket_detalle_accion_seq OWNER TO vince;