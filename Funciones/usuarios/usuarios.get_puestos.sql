/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: función que obtiene la información de todos los puestos de trabajo
 Dependencias: usuarios.tbl_cat_puesto, usuarios.tbl_cat_usuario
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: usuarios.get_puestos(character varying, integer, integer)
-- DROP FUNCTION IF EXISTS usuarios.get_puestos(character varying, integer, integer);
CREATE
OR REPLACE FUNCTION usuarios.get_puestos(
  str_puesto_nombre character varying,
  int_creado_por integer,
  int_actualizado_por integer
) RETURNS TABLE(
  id_cat_puesto integer,
  puesto_nombre character varying,
  puesto_estado integer,
  puesto_fecha_creacion character varying,
  puesto_fecha_actualizacion character varying,
  puesto_nombre_creado_por character varying,
  puesto_id_creado_por integer,
  puesto_nombre_actualizado_por character varying,
  puesto_id_actualizado_por integer
) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
SELECT  
		tcp.id_cat_puesto,
		tcp.nombre AS puesto_nombre,
		tcp.estado AS puesto_estado,
		to_char(tcp.fecha_creacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS puesto_fecha_creacion,
		to_char(tcp.fecha_actualizacion, 'YYYY-MM-DD HH:MI:SS AM')::varchar AS puesto_fecha_actualizacion,
		nombre_creado_por.nombre AS puesto_nombre_creado_por,
		tcp.creado_por AS puesto_id_creado_por,
		nombre_actualizado_por.nombre AS puesto_nombre_actualizado_por,
		tcp.actualizado_por AS puesto_id_actualizado_por
		FROM usuarios.tbl_cat_puesto tcp 
		LEFT JOIN LATERAL (SELECT tcu2.nombre AS nombre  FROM usuarios.tbl_cat_usuario tcu2 WHERE tcu2.id_cat_usuario = tcp.creado_por) nombre_creado_por ON true
		LEFT JOIN LATERAL (SELECT tcu2.nombre AS nombre  FROM usuarios.tbl_cat_usuario tcu2 WHERE tcu2.id_cat_usuario = tcp.actualizado_por) nombre_actualizado_por ON true
		WHERE (tcp.nombre LIKE ('%' || UPPER(str_puesto_nombre)  || '%')::varchar OR LENGTH (UPPER(str_puesto_nombre)) = 0)
		AND (tcp.creado_por = int_creado_por  OR int_creado_por = 0)
		AND (tcp.actualizado_por = int_actualizado_por  OR int_actualizado_por = 0)
;

END;

$ BODY $;

ALTER FUNCTION usuarios.get_puestos(character varying, integer, integer) OWNER TO vince;