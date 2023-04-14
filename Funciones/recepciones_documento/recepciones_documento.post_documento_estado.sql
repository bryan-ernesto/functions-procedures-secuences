/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que permite agregar un nuevo canal para documentos
 Dependencias: recepciones_documento.tbl_cat_documento_estado
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.post_documento_estado(character varying, character varying, integer, integer)

-- DROP FUNCTION IF EXISTS recepciones_documento.post_documento_estado(character varying, character varying, integer, integer);

CREATE OR REPLACE FUNCTION recepciones_documento.post_documento_estado(
	str_nombre character varying,
	str_descripcion character varying,
	int_estado_final integer,
	int_id_creador integer)
    RETURNS TABLE(id_estado integer) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
	RETURN QUERY
	INSERT INTO recepciones_documento.tbl_cat_documento_estado(
		nombre,
		descripcion,
		estado_final,
		estado, 
		creado_por, 
		actualizado_por, 
		fecha_creacion, 
		fecha_actualizacion
	)
	VALUES (
		str_nombre, -- nombre
		str_descripcion, -- descripcion
		int_estado_final, -- estadoFinal
		1, -- estado
		int_id_creador, -- creadoPor
		int_id_creador, -- actualizacionPor
		now(), -- fechaCreacion
		now() -- fechaActualizacion
	) RETURNING recepciones_documento.tbl_cat_documento_estado.id_cat_documento_estado;

END;
$BODY$;

ALTER FUNCTION recepciones_documento.post_documento_estado(character varying, character varying, integer, integer)
    OWNER TO vince;
