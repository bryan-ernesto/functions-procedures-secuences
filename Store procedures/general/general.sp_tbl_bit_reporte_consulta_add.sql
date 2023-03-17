/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 17 marzo 2023
 Modificado: 17 marzo 2023
 Descripción: procedimiento que permite agregar un nuevo reporte consulta
 Dependencias: general.tbl_bit_reporte_consulta
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: compras_proveedor.sp_tbl_cat_proveedor_update(integer, integer, integer, character varying, character varying, character varying, integer, integer, character varying, integer, integer, integer)
-- DROP PROCEDURE IF EXISTS compras_proveedor.sp_tbl_cat_proveedor_update(integer, integer, integer, character varying, character varying, character varying, integer, integer, character varying, integer, integer, integer);
-- PROCEDURE: general.sp_tbl_bit_reporte_consulta_add(character varying, character varying, character varying, character varying, character varying, character varying)
-- DROP PROCEDURE IF EXISTS general.sp_tbl_bit_reporte_consulta_add(character varying, character varying, character varying, character varying, character varying, character varying);
CREATE
OR REPLACE PROCEDURE general.sp_tbl_bit_reporte_consulta_add(
  str_usuario character varying,
  str_reporte character varying,
  str_fechai character varying,
  str_fechaf character varying,
  str_empresa character varying,
  str_cuenta character varying
) LANGUAGE 'plpgsql' AS $ BODY $ begin
INSERT INTO
  "general".tbl_bit_reporte_consulta (usuario, reporte, fecha_hora, consulta)
VALUES
(
    str_usuario,
    str_reporte,
    now(),
    JSONB_BUILD_OBJECT(
      'fecha_inicio',
      str_fechaI,
      'fecha_fin',
      str_fechaF,
      'empresa',
      str_Empresa,
      'cuenta',
      str_Cuenta
    )
  );

end $ BODY $;

ALTER PROCEDURE general.sp_tbl_bit_reporte_consulta_add(
  character varying,
  character varying,
  character varying,
  character varying,
  character varying,
  character varying
) OWNER TO vince;