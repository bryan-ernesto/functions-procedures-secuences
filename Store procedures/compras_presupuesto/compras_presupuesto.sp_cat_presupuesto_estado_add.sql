/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: procedimiento que permite agregar un nuevo estado para un presupuesto
 Dependencias: compras_presupuesto.tbl_cat_presupuesto_estado
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: compras_presupuesto.sp_cat_presupuesto_estado_add(character varying, character varying, integer)
-- DROP PROCEDURE IF EXISTS compras_presupuesto.sp_cat_presupuesto_estado_add(character varying, character varying, integer);
CREATE
OR REPLACE PROCEDURE compras_presupuesto.sp_cat_presupuesto_estado_add(
  str_nombre character varying,
  str_descripcion character varying,
  int_id_cat_usuario integer
) LANGUAGE 'plpgsql' AS $ BODY $ begin
INSERT INTO
  compras_presupuesto.tbl_cat_presupuesto_estado (
    nombre,
    descripcion,
    estado,
    fecha_creacion,
    fecha_actualizacion,
    creado_por,
    actualizado_por
  )
VALUES
  (
    str_nombre,
    str_descripcion,
    1,
    now(),
    now(),
    int_id_cat_usuario,
    int_id_cat_usuario
  );

end $ BODY $;

ALTER PROCEDURE compras_presupuesto.sp_cat_presupuesto_estado_add(character varying, character varying, integer) OWNER TO vince;