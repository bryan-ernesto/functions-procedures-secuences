DECLARE @i_FechaInicio VARCHAR(10)
    ,@i_FechaFin VARCHAR(10)
DECLARE @i_Empresa VARCHAR(250)
    ,@i_CajaBanco VARCHAR(250)

SET @i_FechaInicio = (
        SELECT convert(VARCHAR, getdate(), 23)
        )
SET @i_FechaFin = (
        SELECT convert(VARCHAR, getdate(), 23)
        )
SET @i_Empresa = null
SET @i_CajaBanco = null

SELECT REPORTE_FINAL.FECHA AS FECHA
    ,LTRIM(RTRIM(REPORTE_FINAL.TIPO)) AS TIPO
    ,LTRIM(RTRIM(REPORTE_FINAL.OPERACION_NO_CHEQUE)) AS OPERACION_NO_CHEQUE
    ,LTRIM(RTRIM(REPORTE_FINAL.REFERENCIA)) AS REFERENCIA
    ,LTRIM(RTRIM(REPORTE_FINAL.BENEFICIARIO)) AS BENEFICIARIO
    ,LTRIM(RTRIM(REPLACE(REPLACE(REPORTE_FINAL.DESCRIPCION, CHAR(13), ''), CHAR(10), ''))) AS DESCRIPCION
    ,LTRIM(RTRIM(REPORTE_FINAL.SALDO_VALOR_CHEQUE)) AS SALDO_VALOR_CHEQUE
    ,LTRIM(RTRIM(REPORTE_FINAL.NOMBRE_BANCO)) AS NOMBRE_BANCO
    ,LTRIM(RTRIM(REPORTE_FINAL.SALDO_EN_LIBROS)) AS SALDO_EN_LIBROS
    ,LTRIM(RTRIM(REPORTE_FINAL.SALDO_CONCILIADO)) AS SALDO_CONCILIADO
    ,LTRIM(RTRIM(REPORTE_FINAL.CODIGO_EMPRESA)) AS CODIGO_EMPRESA
    ,LTRIM(RTRIM(REPORTE_FINAL.CODIGO_CUENTA)) AS CODIGO_CUENTA
    ,LTRIM(RTRIM(REPORTE_FINAL.CUENTA_BANCARIA)) AS CUENTA_BANCARIA
    ,LTRIM(RTRIM(REPORTE_FINAL.MONEDA)) AS MONEDA
    ,LTRIM(RTRIM(REPORTE_FINAL.TIPO_EXTRACCION)) AS TIPO_EXTRACCION
    ,LTRIM(RTRIM(REPORTE_FINAL.NOMBRE_CUENTA)) AS NOMBRE_CUENTA
    ,LTRIM(RTRIM(REPORTE_FINAL.NOMBRE_EMPRESA)) AS NOMBRE_EMPRESA
FROM (
    SELECT Prereporte.FECHA
        ,Prereporte.TIPO
        ,Prereporte.OPERACION_NO_CHEQUE
        ,Prereporte.REFERENCIA
        ,Prereporte.BENEFICIARIO
        ,Prereporte.DESCRIPCION
        ,Prereporte.SALDO_VALOR_CHEQUE
        ,Prereporte.NOMBRE_BANCO
        ,MONTOS.MONTO AS SALDO_EN_LIBROS
        ,MONTOS.SALDO_CONCILIADO AS SALDO_CONCILIADO
        ,Prereporte.CODIGO_EMPRESA
        ,Prereporte.CODIGO_CUENTA
        ,Prereporte.CUENTA_BANCARIA
        ,Prereporte.MONEDA
        ,Prereporte.TIPO_EXTRACCION
        ,Prereporte.NOMBRE_CUENTA
        ,Prereporte.NOMBRE_EMPRESA
        ,ROW_NUMBER() OVER (
            PARTITION BY Prereporte.OPERACION_NO_CHEQUE
            ,Prereporte.REFERENCIA ORDER BY Prereporte.OPERACION_NO_CHEQUE
                ,Prereporte.REFERENCIA
            ) AS POS
    FROM (
        SELECT convert(DATE, cp.FECHA_DOCTO, 103) AS FECHA
            ,mh.clave AS TIPO
            ,convert(VARCHAR, cp.NUMERO_CHEQUE) AS OPERACION_NO_CHEQUE
            ,cp.NUMERO_DOCTO AS REFERENCIA
            ,trim(cp.BENEFICIARIO) AS BENEFICIARIO
            ,cp.DESCRIPCION
            ,cp.valor_ext AS SALDO_VALOR_CHEQUE
            ,TRIM(c.NOMBRE_BANCO) AS NOMBRE_BANCO
            ,cp.EMPRESA AS CODIGO_EMPRESA
            ,cp.CAJA_O_BANCO AS CODIGO_CUENTA
            ,trim(c.CLAVE_BANCO) AS CUENTA_BANCARIA
            ,CASE
                WHEN trim(cp.MONEDA) = 'US$'
                    THEN 'DOLARES'
                WHEN trim(cp.MONEDA) = 'Q'
                    THEN 'QUETZALES'
                ELSE 'DEFINIR TIPO MONEDA'
                END AS MONEDA
            ,'Cheques en Circulación' AS TIPO_EXTRACCION
            ,em.CLAVE AS NOMBRE_CUENTA
            ,trim(em.NOMBRE_COMPLETO) AS NOMBRE_EMPRESA
        FROM ABO_CXP AS cp WITH (NOLOCK)
        INNER JOIN EMPRESA em WITH (NOLOCK) ON em.NUMERO = cp.EMPRESA
        INNER JOIN TIPABCXP mh WITH (NOLOCK) ON mh.NUMERO_INTERNO = cp.TIPO_ABONO_CXP
        INNER JOIN CAJA_BCO c WITH (NOLOCK) ON c.NUMERO_INTERNO = cp.CAJA_O_BANCO
        WHERE (
                (charindex(',' + CONVERT(VARCHAR(255), LTRIM(RTRIM(cast(cp.EMPRESA AS VARCHAR)))) + ',', REPLACE(''',' + @i_Empresa + ',''', ' ', '')) > 0)
                OR @i_Empresa IS NULL
                )
            AND (
                (charindex(',' + CONVERT(VARCHAR(255), LTRIM(RTRIM(cast(cp.CAJA_O_BANCO AS VARCHAR)))) + ',', REPLACE(''',' + @i_CajaBanco + ',''', ' ', '')) > 0)
                OR @i_CajaBanco IS NULL
                )
            AND cp.CONCILIADO_S_N = 'N'

        UNION

        SELECT convert(DATE, ac.FECHA_DOCTO, 103) AS FECHA
            ,ac.TIPO_ABONO_CXC AS TIPO
            ,ac.NUMERO_DOCTO AS OPERACION_NO_CHEQUE
            ,NULL AS REFERENCIA
            ,NULL AS BENEFICIARIO
            ,ac.DESCRIPCION
            ,ac.valor_ext AS SALDO_VALOR_CHEQUE
            ,trim(c.NOMBRE_BANCO) AS NOMBRE_BANCO
            ,ac.EMPRESA AS CODIGO_EMPRESA
            ,ac.CAJA_O_BANCO AS CODIGO_CUENTA
            ,trim(c.CLAVE_BANCO) AS CUENTA_BANCARIA
            ,CASE
                WHEN trim(ac.MONEDA) = 'US$'
                    THEN 'DOLARES'
                WHEN trim(ac.MONEDA) = 'Q'
                    THEN 'QUETZALES'
                ELSE 'DEFINIR TIPO MONEDA'
                END AS MONEDA
            ,'Depósitos no operados por el Banco' AS TIPO_EXTRACCION
            ,em.CLAVE AS NOMBRE_CUENTA
            ,em.NOMBRE_COMPLETO AS NOMBRE_EMPRESA
        FROM ABO_CXC ac
        INNER JOIN CAJA_BCO c WITH (NOLOCK) ON c.NUMERO_INTERNO = ac.CAJA_O_BANCO
        INNER JOIN EMPRESA em WITH (NOLOCK) ON em.NUMERO = ac.EMPRESA
        WHERE (
                (charindex(',' + CONVERT(VARCHAR(255), LTRIM(RTRIM(cast(ac.EMPRESA AS VARCHAR)))) + ',', REPLACE(''',' + @i_Empresa + ',''', ' ', '')) > 0)
                OR @i_Empresa IS NULL
                )
            AND (
                (charindex(',' + CONVERT(VARCHAR(255), LTRIM(RTRIM(cast(ac.CAJA_O_BANCO AS VARCHAR)))) + ',', REPLACE(''',' + @i_CajaBanco + ',''', ' ', '')) > 0)
                OR @i_CajaBanco IS NULL
                )

        UNION

        SELECT convert(DATE, mh.FECHA, 103) AS FECHA
            ,mh.TIPO_TRANSACC AS TIPO
            ,convert(VARCHAR, mh.NUMERO) AS OPERACION_NO_CHEQUE
            ,NULL AS REFERENCIA
            ,NULL AS BENEFICIARIO
            ,mh.DESCRIPCION
            ,mh.valor_ext_cgo AS SALDO_VALOR_CHEQUE
            ,TRIM(c.NOMBRE_BANCO) AS NOMBRE_BANCO
            ,mh.EMPRESA AS CODIGO_EMPRESA
            ,mh.CAJA_BANCO AS CODIGO_CUENTA
            ,trim(c.CLAVE_BANCO) AS CUENTA_BANCARIA
            ,CASE
                WHEN trim(mh.moneda2) = 'US$'
                    THEN 'DOLARES'
                WHEN trim(mh.moneda2) = 'Q'
                    THEN 'QUETZALES'
                ELSE 'DEFINIR TIPO MONEDA'
                END AS MONEDA
            ,'Otras operaciones Bancarias' AS TIPO_EXTRACCION
            ,em.CLAVE AS NOMBRE_CUENTA
            ,em.NOMBRE_COMPLETO AS NOMBRE_EMPRESA
        -- ,*
        FROM MOVBCO_H mh
        INNER JOIN EMPRESA em WITH (NOLOCK) ON em.NUMERO = mh.EMPRESA
        INNER JOIN CAJA_BCO c WITH (NOLOCK) ON c.NUMERO_INTERNO = mh.CAJA_BANCO
        WHERE

            mh.CONCILIADO_S_N = 'N'
            AND (
                (charindex(',' + CONVERT(VARCHAR(255), LTRIM(RTRIM(cast(mh.EMPRESA AS VARCHAR)))) + ',', REPLACE(''',' + @i_Empresa + ',''', ' ', '')) > 0)
                OR @i_Empresa IS NULL
                )
            AND (
                (charindex(',' + CONVERT(VARCHAR(255), LTRIM(RTRIM(cast(mh.CAJA_BANCO AS VARCHAR)))) + ',', REPLACE(''',' + @i_CajaBanco + ',''', ' ', '')) > 0)
                OR @i_CajaBanco IS NULL
                )


        ) AS Prereporte
    OUTER APPLY (
        SELECT SALDO_CONCILIADO.SALDO_CONCILIADO
            ,SALDO_CONCILIADO.EMPRESA
            ,SALDO_CONCILIADO.CAJA_O_BANCO
            ,MONTO_CONCILIADO.MONTO
            ,SALDO_CONCILIADO.NUMERO_DOCTO
        FROM (
            SELECT isnull(sum(cp.valor_ext), 0) AS SALDO_CONCILIADO
                ,cp.EMPRESA
                ,cp.CAJA_O_BANCO AS CAJA_O_BANCO
                ,'CHEQUES EN CIRCULACION' AS TIPO
                ,CONVERT(VARCHAR, cp.NUMERO_CHEQUE) AS NUMERO_DOCTO
            FROM ABO_CXP AS cp WITH (NOLOCK)
            WHERE (
                    (charindex(',' + CONVERT(VARCHAR(255), LTRIM(RTRIM(cast(cp.EMPRESA AS VARCHAR)))) + ',', REPLACE(''',' + @i_Empresa + ',''', ' ', '')) > 0)
                    OR @i_Empresa IS NULL
                    )
                AND (
                    (charindex(',' + CONVERT(VARCHAR(255), LTRIM(RTRIM(cast(cp.CAJA_O_BANCO AS VARCHAR)))) + ',', REPLACE(''',' + @i_CajaBanco + ',''', ' ', '')) > 0)
                    OR @i_CajaBanco IS NULL
                    )
                AND cp.CONCILIADO_S_N = 'N'
            GROUP BY cp.empresa
                ,cp.CAJA_O_BANCO
                ,cp.NUMERO_CHEQUE

            UNION

            SELECT isnull(sum(cc.valor_ext), 0) AS SALDO_CONCILIADO
                ,cc.EMPRESA
                ,cc.CAJA_O_BANCO AS CAJA_O_BANCO
                ,'DEPOSITOS NO OPERADOS POR EL BANCO' AS TIPO
                ,CONVERT(VARCHAR, cc.NUMERO_DOCTO) AS NUMERO_DOCTO
            FROM ABO_CXC AS cc WITH (NOLOCK)
            WHERE (
                    (charindex(',' + CONVERT(VARCHAR(255), LTRIM(RTRIM(cast(cc.EMPRESA AS VARCHAR)))) + ',', REPLACE(''',' + @i_Empresa + ',''', ' ', '')) > 0)
                    OR @i_Empresa IS NULL
                    )
                AND (
                    (charindex(',' + CONVERT(VARCHAR(255), LTRIM(RTRIM(cast(cc.CAJA_O_BANCO AS VARCHAR)))) + ',', REPLACE(''',' + @i_CajaBanco + ',''', ' ', '')) > 0)
                    OR @i_CajaBanco IS NULL
                    )
                AND TIPO_ABONO_CXC IN (
                    'NC'
                    ,'DE'
                    )

            GROUP BY cc.empresa
                ,cc.CAJA_O_BANCO
                ,cC.NUMERO_DOCTO

            UNION

            SELECT isnull(sum(mh.VALOR_ABONO) - sum(mh.valor_ext_cgo), 0) AS SALDO_CONCILIADO
                ,mh.EMPRESA
                ,mh.CAJA_BANCO AS CAJA_O_BANCO
                ,'OTRAS OPERACIONES BANCARIAS' AS TIPO
                ,CONVERT(VARCHAR, mh.NUMERO ) AS NUMERO_DOCTO
            FROM MOVBCO_H AS mh WITH (NOLOCK)
            WHERE (
                    (charindex(',' + CONVERT(VARCHAR(255), LTRIM(RTRIM(cast(mh.EMPRESA AS VARCHAR)))) + ',', REPLACE(''',' + @i_Empresa + ',''', ' ', '')) > 0)
                    OR @i_Empresa IS NULL
                    )
                AND (
                    (charindex(',' + CONVERT(VARCHAR(255), LTRIM(RTRIM(cast(mh.CAJA_BANCO AS VARCHAR)))) + ',', REPLACE(''',' + @i_CajaBanco + ',''', ' ', '')) > 0)
                    OR @i_CajaBanco IS NULL
                    )
                AND mh.CONCILIADO_S_N = 'N'
            GROUP BY mh.empresa
                ,mh.CAJA_BANCO
                ,mh.NUMERO
            ) AS SALDO_CONCILIADO
        OUTER APPLY (
            SELECT (
                    (
                        SELECT isnull(sum(cc.valor_ext), 0)
                        FROM ABO_CXC AS cc WITH (NOLOCK)
                        WHERE cc.EMPRESA = SALDO_CONCILIADO.EMPRESA
                            AND cc.CAJA_O_BANCO = SALDO_CONCILIADO.CAJA_O_BANCO

                        ) - (
                        SELECT sum(cp.valor_ext)
                        FROM ABO_CXP AS cp WITH (NOLOCK)
                        WHERE cp.EMPRESA = SALDO_CONCILIADO.EMPRESA
                            AND cp.CAJA_O_BANCO = SALDO_CONCILIADO.CAJA_O_BANCO
                        ) + (
                        SELECT sum(mh.valor_ext_cgo) - sum(mh.valor_ext_abo)
                        FROM MOVBCO_H AS mh WITH (NOLOCK)
                        WHERE mh.EMPRESA = SALDO_CONCILIADO.EMPRESA
                            AND mh.CAJA_BANCO = SALDO_CONCILIADO.CAJA_O_BANCO
                        )
                    ) AS MONTO
            ) AS MONTO_CONCILIADO
        WHERE SALDO_CONCILIADO.EMPRESA =  Prereporte.CODIGO_EMPRESA
            AND SALDO_CONCILIADO.CAJA_O_BANCO =  Prereporte.CODIGO_CUENTA
            AND  Prereporte.OPERACION_NO_CHEQUE =  SALDO_CONCILIADO.NUMERO_DOCTO
        GROUP BY SALDO_CONCILIADO.SALDO_CONCILIADO
            ,SALDO_CONCILIADO.EMPRESA
            ,SALDO_CONCILIADO.CAJA_O_BANCO
            ,MONTO_CONCILIADO.MONTO
            ,SALDO_CONCILIADO.NUMERO_DOCTO
        ) AS MONTOS
    ) AS REPORTE_FINAL
WHERE REPORTE_FINAL.POS = 1
order by REPORTE_FINAL.CODIGO_EMPRESA asc,REPORTE_FINAL.CODIGO_CUENTA asc,REPORTE_FINAL.FECHA asc