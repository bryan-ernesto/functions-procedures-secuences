/*
 Creado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Modificado por: Bryan Gámez (bgamez@groupnova.com.gt)
 Creado: 29 marzo 2023
 Modificado: 29 marzo 2023
 Descripción: función que permite agregar un nuevo canal para documentos
 Dependencias: recepciones_documento.tbl_cat_documento_canal
 ERD: NO
 Nombre ERD: NO
 */
-- FUNCTION: recepciones_documento.post_documento_canal(character varying, character varying, integer)
-- DROP FUNCTION IF EXISTS recepciones_documento.post_documento_canal(character varying, character varying, integer);
CREATE
OR REPLACE FUNCTION recepciones_documento.post_documento_canal(
  str_nombre character varying,
  str_descripcion character varying,
  int_id_creador integer
) RETURNS TABLE(id_canal integer) LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE ROWS 1000 AS $ BODY $ BEGIN RETURN QUERY
INSERT INTO
  recepciones_documento.tbl_cat_documento_canal(
    nombre,
    descripcion,
    estado,
    creado_por,
    actualizado_por,
    fecha_creacion,
    fecha_actualizacion
  )
VALUES
  (
    str_nombre,
    -- nombre
    str_descripcion,
    -- descripcion
    1,
    -- estado
    int_id_creador,
    -- creadoPor
    int_id_creador,
    -- actualizadoPor
    now(),
    -- fechaCreacion
    now() -- fechaActualizacion
  ) RETURNING recepciones_documento.tbl_cat_documento_canal.id_cat_documento_canal;

END;

$ BODY $;

ALTER FUNCTION recepciones_documento.post_documento_canal(character varying, character varying, integer) OWNER TO vince;