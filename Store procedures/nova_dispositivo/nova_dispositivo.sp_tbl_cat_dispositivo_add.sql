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
-- PROCEDURE: nova_dispositivo.sp_tbl_cat_dispositivo_add(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, bit, timestamp without time zone, integer, integer)
-- DROP PROCEDURE IF EXISTS nova_dispositivo.sp_tbl_cat_dispositivo_add(character varying, character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, bit, timestamp without time zone, integer, integer);
CREATE
OR REPLACE PROCEDURE nova_dispositivo.sp_tbl_cat_dispositivo_add(
  str_hostname character varying,
  str_ip character varying,
  str_sistema_operativo character varying,
  str_cpu character varying,
  str_disco_primario_total character varying,
  str_disco_primario_tipo character varying,
  str_ram_total character varying,
  str_product_id character varying,
  dtm_ultimo_logueo timestamp without time zone,
  bit_estado bit,
  dtm_fecha_actualizacion timestamp without time zone,
  int_creado_por integer,
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
  ) <= 0
) then
INSERT INTO
  nova_dispositivo.tbl_cat_dispositivo (
    hostname,
    ip,
    sistema_operativo,
    cpu_nombre,
    disco_primario_total,
    disco_primario_tipo,
    ram_total,
    product_id,
    ultimo_logueo,
    estado,
    fecha_creacion,
    fecha_actualizacion,
    creado_por,
    modificado_por
  )
VALUES
  (
    str_hostname,
    str_ip,
    str_sistema_operativo,
    str_cpu,
    str_disco_primario_total,
    str_disco_primario_tipo,
    str_ram_total,
    str_product_id,
    dtm_ultimo_logueo,
    bit_estado,
    now(),
    dtm_fecha_actualizacion,
    int_creado_por,
    int_modificado_por
  );

end IF;

end $ BODY $;

ALTER PROCEDURE nova_dispositivo.sp_tbl_cat_dispositivo_add(
  character varying,
  character varying,
  character varying,
  character varying,
  character varying,
  character varying,
  character varying,
  character varying,
  timestamp without time zone,
  bit,
  timestamp without time zone,
  integer,
  integer
) OWNER TO vince;