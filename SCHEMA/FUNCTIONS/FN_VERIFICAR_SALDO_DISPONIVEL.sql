CREATE OR REPLACE FUNCTION FN_VERIFICAR_SALDO_DISPONIVEL (
                                                         P_ID_CARTAO        IN NUMBER,
                                                         P_VALOR_TRANSACAO  IN NUMBER
) RETURN BOOLEAN
IS
    V_LIMITE_CARTAO     CARTOES.LIMITE_CREDITO%TYPE := 0;
    V_TOTAL_UTILIZADO   NUMBER(12,2) := 0;

-- =============================================================================
-- =============== BUSCAR O LIMITE DE CRÉDITO DO CARTÃO ========================
-- =============================================================================
BEGIN

    SELECT LIMITE_CREDITO
      INTO V_LIMITE_CARTAO
      FROM CARTOES
     WHERE ID_CARTAO = P_ID_CARTAO;

-- =============================================================================
-- ========= SOMAR O TOTAL DE TRANSAÇÕES APROVADAS OU PENDENTES ================
-- =============================================================================

    SELECT NVL(SUM(VALOR_TRANSACAO), 0)
      INTO V_TOTAL_UTILIZADO
      FROM TRANSACOES
     WHERE ID_CARTAO = P_ID_CARTAO
       AND STATUS_TRANSACAO IN ('A', 'P');

    RETURN (V_LIMITE_CARTAO - V_TOTAL_UTILIZADO) >= P_VALOR_TRANSACAO;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;

    WHEN OTHERS THEN
        RETURN FALSE;
END;
/