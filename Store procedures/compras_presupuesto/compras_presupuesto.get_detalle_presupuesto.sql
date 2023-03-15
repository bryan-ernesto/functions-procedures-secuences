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
-- FUNCTION: compras_presupuesto.get_detalle_presupuesto(integer)
-- DROP FUNCTION IF EXISTS compras_presupuesto.get_detalle_presupuesto(integer);
CREATE
OR REPLACE FUNCTION compras_presupuesto.get_detalle_presupuesto(int_id_cat_presupuesto integer) RETURNS TABLE(
  presupuesto_id_det integer,
  cuenta_id integer,
  cuenta_nombre character varying,
  monto_inicial numeric,
  monto_final numeric,
  enero_inicial numeric,
  enero_final numeric,
  febrero_inicial numeric,
  febrero_final numeric,
  marzo_inicial numeric,
  marzo_final numeric,
  abril_inicial numeric,
  abril_final numeric,
  mayo_inicial numeric,
  mayo_final numeric,
  junio_inicial numeric,
  junio_final numeric,
  julio_inicial numeric,
  julio_final numeric,
  agosto_inicial numeric,
  agosto_final numeric,
  septiembre_inicial numeric,
  septiembre_final numeric,
  octubre_inicial numeric,
  octubre_final numeric,
  noviembre_inicial numeric,
  noviembre_final numeric,
  diciembre_inicial numeric,
  diciembre_final numeric,
  estado integer,
  fecha_creacion_nombre character varying,
  fecha_actualizacion_nombre character varying,
  creado_por_id integer,
  actualizado_por_id integer,
  creado_por_nombre character varying,
  actualizado_por_nombre character varying
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
SELECT
  tdp.id_det_presupuesto presupuesto_id_det,
  tdp.id_cat_cuenta cuenta_id,
  tcc.nombre cuenta_nombre,
  tdp.monto_inicial monto_inicial,
  tdp.monto_final monto_final,
  tdp.enero_inicial,
  tdp.enero_final,
  tdp.febrero_inicial,
  tdp.febrero_final,
  tdp.marzo_inicial,
  tdp.marzo_final,
  tdp.abril_inicial,
  tdp.abril_final,
  tdp.mayo_inicial,
  tdp.mayo_final,
  tdp.junio_inicial,
  tdp.junio_final,
  tdp.julio_inicial,
  tdp.julio_final,
  tdp.agosto_inicial,
  tdp.agosto_final,
  tdp.septiembre_inicial,
  tdp.septiembre_final,
  tdp.octubre_inicial,
  tdp.octubre_final,
  tdp.noviembre_inicial,
  tdp.noviembre_final,
  tdp.diciembre_inicial,
  tdp.diciembre_final,
  tdp.estado,
  to_char(tdp.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as fecha_creacion_nombre,
  to_char(
    tdp.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as fecha_actualizacion_nombre,
  tdp.creado_por as creado_por_id,
  tdp.actualizado_por as actualizado_por_id,
  cast(creado_por_nombre.nombre as varchar) as creado_por_nombre,
  (modificado_por_nombre.nombre) :: varchar as actualizado_por_nombre
FROM
  compras_presupuesto.tbl_det_presupuesto tdp
  JOIN compras_presupuesto.tbl_cat_presupuesto tcp ON tcp.id_cat_presupuesto = tdp.id_cat_presupuesto
  JOIN compras_cuenta.tbl_cat_cuenta tcc ON tcc.id_cat_cuenta = tdp.id_cat_cuenta
  LEFT JOIN LATERAL (
    SELECT
      tcu3.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu3
    WHERE
      tcu3.id_cat_usuario = tcp.creado_por
  ) creado_por_nombre ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu4.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu4
    WHERE
      tcu4.id_cat_usuario = tcp.actualizado_por
  ) modificado_por_nombre ON true
where
  (
    tdp.id_cat_presupuesto = int_id_cat_presupuesto
    or int_id_cat_presupuesto = 0
  )
order by
  tdp.id_det_presupuesto asc;

END;

$ BODY $;

ALTER FUNCTION compras_presupuesto.get_detalle_presupuesto(integer) OWNER TO vince;