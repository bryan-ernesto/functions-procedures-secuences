/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 09 mayo 2023
 Modificado: 09 mayo 2023
 Descripción: función que muestra la información de un usuario, permitiendo filtrar por distintos campos
 Dependencias: tbl_cat_usuario, tbl_cat_usuario_dominio, tbl_cat_usuario_categoria, tbl_det_usuario_asignacion_puesto, tbl_det_puesto_asignacion_equipo, tbl_cat_puesto, tbl_cat_equipo, tbl_cat_departamento, tbl_cat_empresa, tbl_det_usuario_asignacion_permiso, tbl_cat_permiso_grupo
 ERD: NO
 Nombre ERD: NO
 */

-- FUNCTION: usuarios.get_documento_usuario(character varying, integer, integer, character varying, integer, integer, integer)

-- DROP FUNCTION IF EXISTS usuarios.get_documento_usuario(character varying, integer, integer, character varying, integer, integer, integer);

CREATE OR REPLACE FUNCTION usuarios.get_documento_usuario(
	str_usuario_nombre character varying,
	int_creado_por integer,
	int_actualizado_por integer,
	str_username character varying,
	int_empresa integer,
	int_departamento integer,
	int_equipo integer)
    RETURNS TABLE(id_cat_usuario integer, nombre character varying, id_ad character varying, correo character varying, user_principal_name character varying, telefono character varying, codigo_pais integer, tipo_usuario integer, dominio_nombre character varying, dominio_id integer, categoria_nombre character varying, categoria_id integer, estado integer, fecha_creacion character varying, fecha_actualizacion character varying, creado_por_nombre character varying, creado_por_id integer, actualizado_por_nombre character varying, actualizado_por_id integer, username character varying, puesto character varying, equipo_id integer, equipo character varying, departamento character varying, empresa character varying, id_usuario_permiso character varying, nombre_grupo_permiso character varying) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN 
  RETURN QUERY

SELECT T_USUARIO.id_cat_usuario AS id_cat_usuario,
    T_USUARIO.nombre AS nombre,
    T_USUARIO.id_ad AS id_ad,
    T_USUARIO.correo AS correo,
    T_USUARIO.user_principal_name AS user_principal_name,
    T_USUARIO.telefono::VARCHAR AS telefono,
    T_USUARIO.codigo_pais AS codigo_pais,
    T_USUARIO.tipo_usuario AS tipo_usuario,
    T_DOMINIO.nombre AS dominio_nombre,
    T_USUARIO.id_cat_usuario_dominio AS dominio_id,
    T_US_CATEGORIA.nombre AS categoria_nombre,
    T_US_CATEGORIA.id_cat_usuario_categoria AS categoria_id,
    T_USUARIO.estado AS estado,
    to_char(T_USUARIO.fecha_creacion,'YYYY-MM-DD HH:MI:SS AM')::VARCHAR AS fecha_creacion,
    to_char(T_USUARIO.fecha_actualizacion,'YYYY-MM-DD HH:MI:SS AM')::VARCHAR AS fecha_actualizacion,
    T_CREADO.nombre AS creado_por_nombre,
    T_USUARIO.creado_por AS creado_por_id,
    T_ACTUALIZADO.nombre AS actualizado_por_nombre,
    T_USUARIO.actualizado_por AS actualizado_por_id,
    T_USUARIO.username AS username,
	T_PUESTO.nombre AS puesto,
	T_EQUIPO.id_cat_equipo AS equipo_id,
	T_EQUIPO.nombre AS equipo,
	T_DEPARTAMENTO.nombre AS departamento,
	T_EMPRESA.nombre AS empresa,
  	COALESCE(T_US_PERMISO.id_det_usuario_asignacion_permiso::VARCHAR, 'Usuario sin permisos asignados') AS id_usuario_permiso,
	COALESCE(T_P_GRUPO.nombre::VARCHAR, 'Sin permiso asignado') AS nombre_grupo_permiso
  FROM usuarios.tbl_cat_usuario T_USUARIO
    LEFT JOIN usuarios.tbl_cat_usuario_dominio T_DOMINIO ON T_USUARIO.id_cat_usuario_dominio = T_DOMINIO.id_cat_usuario_dominio
    LEFT JOIN usuarios.tbl_cat_usuario_categoria T_US_CATEGORIA ON T_US_CATEGORIA.id_cat_usuario_categoria = T_USUARIO.id_cat_usuario_categoria
	LEFT JOIN usuarios.tbl_det_usuario_asignacion_puesto T_US_A_PUESTO ON T_USUARIO.id_cat_usuario = T_US_A_PUESTO.id_cat_usuario
	LEFT JOIN usuarios.tbl_det_puesto_asignacion_equipo T_PU_A_EQUIPO ON T_US_A_PUESTO.id_det_puesto_asignacion_equipo = T_PU_A_EQUIPO.id_det_puesto_asignacion_equipo
	LEFT JOIN usuarios.tbl_cat_puesto T_PUESTO ON T_PU_A_EQUIPO.id_cat_puesto = T_PUESTO.id_cat_puesto
	LEFT JOIN usuarios.tbl_cat_equipo T_EQUIPO ON T_PU_A_EQUIPO.id_cat_equipo = T_EQUIPO.id_cat_equipo
	LEFT JOIN usuarios.tbl_cat_departamento T_DEPARTAMENTO ON T_EQUIPO.id_cat_departamento = T_DEPARTAMENTO.id_cat_departamento
	LEFT JOIN usuarios.tbl_cat_empresa T_EMPRESA ON T_DEPARTAMENTO.id_cat_empresa = T_EMPRESA.id_cat_empresa
	LEFT JOIN usuarios.tbl_det_usuario_asignacion_permiso T_US_PERMISO ON T_USUARIO.id_cat_usuario = T_US_PERMISO.id_cat_usuario
	LEFT JOIN usuarios.tbl_cat_permiso_grupo T_P_GRUPO ON T_US_PERMISO.id_cat_permiso_grupo = T_P_GRUPO.id_cat_permiso_grupo
    LEFT JOIN LATERAL (SELECT T_USUARIO2.nombre AS nombre FROM usuarios.tbl_cat_usuario T_USUARIO2 WHERE T_USUARIO2.id_cat_usuario = T_USUARIO.creado_por) T_CREADO ON true
    LEFT JOIN LATERAL (SELECT T_USUARIO2.nombre AS nombre FROM usuarios.tbl_cat_usuario T_USUARIO2 WHERE T_USUARIO2.id_cat_usuario = T_USUARIO.actualizado_por) T_ACTUALIZADO ON true
  
  WHERE 
    (UPPER(T_USUARIO.nombre) LIKE ('%' || UPPER(str_usuario_nombre) || '%')::VARCHAR OR LENGTH (UPPER(str_usuario_nombre)) = 0)
    AND (T_USUARIO.creado_por = int_creado_por OR int_creado_por = 0)
    AND (T_USUARIO.actualizado_por = int_actualizado_por OR int_actualizado_por = 0)
	AND (T_EMPRESA.id_cat_empresa = int_empresa OR int_empresa = 0)
	AND (T_DEPARTAMENTO.id_cat_departamento = int_departamento OR int_departamento = 0)
	AND (T_EQUIPO.id_cat_equipo = int_equipo OR int_equipo = 0)
    AND (UPPER(T_USUARIO.username) LIKE ('%' || UPPER(str_username) || '%')::VARCHAR OR LENGTH (UPPER(str_username)) = 0);
END
$BODY$;

ALTER FUNCTION usuarios.get_documento_usuario(character varying, integer, integer, character varying, integer, integer, integer)
    OWNER TO vince;
