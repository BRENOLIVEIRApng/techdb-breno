CREATE OR REPLACE PROCEDURE PR_ATUALIZAR_SALDOS_CARTOES
IS
    V_DATA_INICIO DATE := TRUNC(SYSDATE - 1); -- 00:00 DO DIA ANTERIOR
    V_DATA_FIM    DATE := TRUNC(SYSDATE);     -- 00:00 DO DIA ATUAL

-- =============================================================================
-- =========== LOOP PARA PROCESSAR TRANSACOES VALIDAS DO DIA ANTERIOR ==========
-- =============================================================================
BEGIN

    FOR R IN (
        SELECT 
            T.ID_CARTAO,
            SUM(T.VALOR_TRANSACAO) AS TOTAL_GASTO
        FROM TRANSACOES T
        WHERE T.STATUS_TRANSACAO IN ('A', 'P')
          AND T.DATA_TRANSACAO >= V_DATA_INICIO
          AND T.DATA_TRANSACAO < V_DATA_FIM
        GROUP BY T.ID_CARTAO
    ) LOOP
-- =============================================================================
-- ====== ATUALIZA O SALDO DO CARTAO (SUBTRAI VALOR TOTAL DO DIA ANTERIOR) =====
-- =============================================================================

        UPDATE CARTOES
        SET LIMITE_CREDITO = LIMITE_CREDITO - R.TOTAL_GASTO
        WHERE ID_CARTAO = R.ID_CARTAO;
    END LOOP;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'SALDOS ATUALIZADOS COM BASE EM TRANSACOES DO DIA ANTERIOR: ' || TO_CHAR(V_DATA_INICIO, 'DD/MM/YYYY')
    );

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO NA ROTINA DE ATUALIZACAO: ' || SQLERRM);
        ROLLBACK;
END;
/