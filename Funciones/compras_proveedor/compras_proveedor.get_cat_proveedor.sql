/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: procedimiento que muestra la información de todos los proveedores
 Dependencias: compras_proveedor.tbl_cat_proveedor, compras_proveedor.tbl_cat_proveedor_giro, compras_proveedor.tbl_cat_proveedor_tipo, usuarios.tbl_cat_usuario
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: compras_proveedor.get_cat_proveedor(character varying, character varying, character varying, integer, integer, integer, integer)
-- DROP FUNCTION IF EXISTS compras_proveedor.get_cat_proveedor(character varying, character varying, character varying, integer, integer, integer, integer);
CREATE
OR REPLACE FUNCTION compras_proveedor.get_cat_proveedor(
  str_nombre character varying,
  str_nit character varying,
  str_correo character varying,
  int_proveedor_tipo integer,
  int_proveedor_giro integer,
  int_id_creado_por integer,
  int_id_actualizado_por integer
) RETURNS TABLE(
  id integer,
  nombre_completo character varying,
  giro_id integer,
  giro_nombre character varying,
  tipo_id integer,
  tipo_nombre character varying,
  usuario_id integer,
  usuario_nombre character varying,
  nit character varying,
  correo character varying,
  telefono integer,
  celular integer,
  rtu_archivo character varying,
  estado integer,
  fecha_creacion character varying,
  fecha_actualizacion character varying,
  creado_por_id integer,
  actualizado_por_id integer,
  creado_por character varying,
  actualizado_por character varying
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
select
  tcp.id_cat_proveedor as id,
  tcp.nombre_completo as nombre_completo,
  tcp.id_cat_proveedor_giro as giro_id,
  tcpg.nombre as giro_nombre,
  tcp.id_cat_proveedor_tipo as tipo_id,
  tcpt.nombre as tipo_nombre,
  tcp.id_cat_usuario as usuario_id,
  tcu.nombre as usuario_nombre,
  tcp.nit as nit,
  tcp.email as correo,
  tcp.telefono_contacto as telefono,
  tcp.celular_personal as celular,
  tcp.rtu_archivo as rtu_archivo,
  tcp.estado as estado,
  to_char(tcpt.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM') :: varchar as fecha_creacion,
  to_char(
    tcpt.fecha_actualizacion,
    'YYYY-MM-DD HH:MI:SS AM'
  ) :: varchar as fecha_actualizacion,
  tcp.creado_por as creado_por_id,
  tcp.actualizado_por as actualizado_por_id,
  creado_por.nombre as creado_por,
  modificado_por.nombre as actualizado_por
from
  compras_proveedor.tbl_cat_proveedor tcp
  join compras_proveedor.tbl_cat_proveedor_giro tcpg on tcpg.id_cat_proveedor_giro = tcp.id_cat_proveedor_giro
  join compras_proveedor.tbl_cat_proveedor_tipo tcpt on tcpt.id_cat_proveedor_tipo = tcp.id_cat_proveedor_tipo
  join usuarios.tbl_cat_usuario tcu on tcu.id_cat_usuario = tcp.id_cat_usuario
  LEFT JOIN LATERAL (
    SELECT
      tcu3.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu3
    WHERE
      tcu3.id_cat_usuario = tcp.creado_por
  ) creado_por ON true
  LEFT JOIN LATERAL (
    SELECT
      tcu4.nombre as nombre
    FROM
      usuarios.tbl_cat_usuario tcu4
    WHERE
      tcu4.id_cat_usuario = tcp.actualizado_por
  ) modificado_por ON true
where
  (
    upper(tcp.nombre_completo) LIKE ('%' || upper(str_nombre) || '%') :: varchar
    or LENGTH (upper(str_nombre)) = 0
  )
  and (
    upper(tcp.nit) LIKE ('%' || upper(str_nit) || '%') :: varchar
    or LENGTH (upper(str_nit)) = 0
  )
  and (
    upper(tcp.email) LIKE ('%' || upper(str_correo) || '%') :: varchar
    or LENGTH (upper(str_correo)) = 0
  )
  and (
    tcp.id_cat_proveedor_tipo = int_proveedor_tipo
    or int_proveedor_tipo = 0
  )
  and (
    tcp.id_cat_proveedor_giro = int_proveedor_giro
    or int_proveedor_giro = 0
  )
  and (
    tcp.creado_por = int_id_creado_por
    or int_id_creado_por = 0
  )
  and (
    tcp.actualizado_por = int_id_actualizado_por
    or int_id_actualizado_por = 0
  );

END;

$ BODY $;

ALTER FUNCTION compras_proveedor.get_cat_proveedor(
  character varying,
  character varying,
  character varying,
  integer,
  integer,
  integer,
  integer
) OWNER TO vince;