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
-- PROCEDURE: nova_dispositivo.sp_bit_dispositivo_diagnostico_add(integer, numeric, time without time zone, integer, numeric, numeric, numeric, numeric, integer, integer, integer, integer)
-- DROP PROCEDURE IF EXISTS nova_dispositivo.sp_bit_dispositivo_diagnostico_add(integer, numeric, time without time zone, integer, numeric, numeric, numeric, numeric, integer, integer, integer, integer);
CREATE
OR REPLACE PROCEDURE nova_dispositivo.sp_bit_dispositivo_diagnostico_add(
  id_cat_dispositivo integer,
  in_cpu_uso numeric,
  in_cpu_tiempo_activo time without time zone,
  in_cpu_tiempo_activo_dia integer,
  in_ram_disponible_mb numeric,
  in_disco_disponible_mb numeric,
  in_internet_descarga_mb numeric,
  in_internet_carga_mb numeric,
  in_internet_latencia_descarga_ms integer,
  in_internet_latencia_carga_ms integer,
  in_creado_por integer,
  in_actualizado_por integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
INSERT INTO
  nova_dispositivo.tbl_bit_dispositivo_diagnostico (
    id_cat_dispositivo,
    cpu_uso,
    cpu_tiempo_activo,
    cpu_tiempo_activo_dia,
    ram_disponible_mb,
    disco_disponible_mb,
    internet_descarga_mb,
    internet_carga_mb,
    internet_latencia_descarga_ms,
    internet_latencia_carga_ms,
    creado_por,
    actualizado_por,
    fecha_creacion,
    fecha_actualizacion
  )
VALUES
  (
    id_cat_dispositivo,
    in_cpu_uso,
    in_cpu_tiempo_activo,
    in_cpu_tiempo_activo_dia,
    in_ram_disponible_mb,
    in_disco_disponible_mb,
    in_internet_descarga_mb,
    in_internet_carga_mb,
    in_internet_latencia_descarga_ms,
    in_internet_latencia_carga_ms,
    in_creado_por,
    in_actualizado_por,
    now(),
    now()
  );

end $ BODY $;

ALTER PROCEDURE nova_dispositivo.sp_bit_dispositivo_diagnostico_add(
  integer,
  numeric,
  time without time zone,
  integer,
  numeric,
  numeric,
  numeric,
  numeric,
  integer,
  integer,
  integer,
  integer
) OWNER TO vince;