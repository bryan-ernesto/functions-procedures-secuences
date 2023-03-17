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
-- PROCEDURE: general.sp_tbl_bit_reporte_consulta_add_general(character varying, character varying, character varying, character varying, character varying)
-- DROP PROCEDURE IF EXISTS general.sp_tbl_bit_reporte_consulta_add_general(character varying, character varying, character varying, character varying, character varying);
CREATE
OR REPLACE PROCEDURE general.sp_tbl_bit_reporte_consulta_add_general(
  str_usuario character varying,
  str_reporte character varying,
  str_desc1 character varying,
  str_desc2 character varying,
  str_desc3 character varying
) LANGUAGE 'plpgsql' AS $ BODY $ begin
INSERT INTO
  "general".tbl_bit_reporte_consulta (usuario, reporte, fecha_hora, consulta)
VALUES
  (
    str_usuario,
    str_reporte,
    now(),
    JSONB_BUILD_OBJECT(
      'minor_status',
      str_desc1,
      'major_status',
      str_desc2,
      'tipo_busqueda',
      str_desc3
    )
  );

end $ BODY $;

ALTER PROCEDURE general.sp_tbl_bit_reporte_consulta_add_general(
  character varying,
  character varying,
  character varying,
  character varying,
  character varying
) OWNER TO vince;