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
-- SEQUENCE: nova_version.tbl_bit_version_detalle_resum_id_bit_version_detalle_resume_seq
-- DROP SEQUENCE IF EXISTS nova_version.tbl_bit_version_detalle_resum_id_bit_version_detalle_resume_seq;
CREATE SEQUENCE IF NOT EXISTS nova_version.tbl_bit_version_detalle_resum_id_bit_version_detalle_resume_seq INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1 OWNED BY tbl_bit_version_detalle_resumen.id_bit_version_detalle_resumen;

ALTER SEQUENCE nova_version.tbl_bit_version_detalle_resum_id_bit_version_detalle_resume_seq OWNER TO vince;