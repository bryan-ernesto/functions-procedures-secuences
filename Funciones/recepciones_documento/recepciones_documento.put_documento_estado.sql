/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que modificar la información del estado de un documento
 Dependencias: recepciones_documento.tbl_cat_documento_estado
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.put_documento_estado(integer, character varying, character varying, integer, integer, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.put_documento_estado(integer, character varying, character varying, integer, integer, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.put_documento_estado(
	int_id_cat_documento_estado integer,
	str_nombre character varying,
	str_descripcion character varying,
	int_estado_final integer,
	int_estado integer,
	int_actualizado_por integer)
    RETURNS TABLE(id_estado integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	UPDATE recepciones_documento.tbl_cat_documento_estado
	SET 
		nombre = CASE WHEN str_nombre <> '' THEN str_nombre ELSE nombre END,
		descripcion = CASE WHEN str_descripcion <> '' THEN str_descripcion ELSE descripcion END,
		estado_final = CASE WHEN int_estado_final IS NOT NULL THEN int_estado_final ELSE estado_final END,
		estado = CASE WHEN int_estado IS NOT NULL THEN int_estado ELSE estado END,
		actualizado_por = CASE WHEN int_actualizado_por IS NOT NULL THEN int_actualizado_por ELSE actualizado_por END,
		fecha_actualizacion = now()
    WHERE id_cat_documento_estado = int_id_cat_documento_estado
RETURNING recepciones_documento.tbl_cat_documento_estado.id_cat_documento_estado;
END;
$BODY$;

ALTER FUNCTION recepciones_documento.put_documento_estado(integer, character varying, character varying, integer, integer, integer)
    OWNER TO vince;
