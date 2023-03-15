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
-- PROCEDURE: nova_dispositivo.sp_tbl_cat_dispositivo_upd(character varying, character varying, timestamp without time zone, integer)
-- DROP PROCEDURE IF EXISTS nova_dispositivo.sp_tbl_cat_dispositivo_upd(character varying, character varying, timestamp without time zone, integer);
CREATE
OR REPLACE PROCEDURE nova_dispositivo.sp_tbl_cat_dispositivo_upd(
  str_hostname character varying,
  str_ip character varying,
  dtm_ultimo_logueo timestamp without time zone,
  int_modificado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin IF (
  (
    select
      count(*)
    from
      nova_dispositivo.tbl_cat_dispositivo
    where
      hostname = str_hostname
      and ip = str_ip
  ) >= 0
) then
UPDATE
  nova_dispositivo.tbl_cat_dispositivo
SET
  ultimo_logueo = dtm_ultimo_logueo,
  fecha_actualizacion = now(),
  modificado_por = int_modificado_por
WHERE
  hostname = str_hostname
  and ip = str_ip;

end IF;

end $ BODY $;

ALTER PROCEDURE nova_dispositivo.sp_tbl_cat_dispositivo_upd(
  character varying,
  character varying,
  timestamp without time zone,
  integer
) OWNER TO vince;