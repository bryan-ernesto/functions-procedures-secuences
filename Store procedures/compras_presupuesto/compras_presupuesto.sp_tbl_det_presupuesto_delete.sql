/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 13 marzo 2023
 Modificado: 16 marzo 2023
 Descripción: procedimiento que permite eliminar el detalle de un presupuesto por medio de su id
 Dependencias: compras_presupuesto.tbl_det_presupuesto
 ERD: NO
 Nombre ERD: NO
 */
-- PROCEDURE: compras_presupuesto.sp_tbl_det_presupuesto_delete(integer)
-- DROP PROCEDURE IF EXISTS compras_presupuesto.sp_tbl_det_presupuesto_delete(integer);
CREATE
OR REPLACE PROCEDURE compras_presupuesto.sp_tbl_det_presupuesto_delete(int_det_presupuesto_id integer) LANGUAGE 'plpgsql' AS $ BODY $ begin
DELETE FROM
  compras_presupuesto.tbl_det_presupuesto
WHERE
  id_det_presupuesto = int_det_presupuesto_id;

end $ BODY $;

ALTER PROCEDURE compras_presupuesto.sp_tbl_det_presupuesto_delete(integer) OWNER TO vince;