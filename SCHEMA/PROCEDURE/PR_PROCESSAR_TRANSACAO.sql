CREATE OR REPLACE PROCEDURE PR_PROCESSAR_TRANSACAO (
                                                    P_ID_CARTAO           IN TRANSACOES.ID_CARTAO%TYPE,
                                                    P_ID_ESTABELECIMENTO  IN TRANSACOES.ID_ESTABELECIMENTO%TYPE,
                                                    P_VALOR_TRANSACAO     IN TRANSACOES.VALOR_TRANSACAO%TYPE
) AS
    V_LIMITE                  CARTOES.LIMITE_CREDITO%TYPE;
    V_ESTABELECIMENTO_EXISTE  NUMBER;
BEGIN

-- =============================================================================
-- ========== VERIFICA SE O CARTÃO EXISTE E PEGA O LIMITE ======================
-- =============================================================================
    BEGIN
        SELECT LIMITE_CREDITO
          INTO V_LIMITE
          FROM CARTOES
         WHERE ID_CARTAO = P_ID_CARTAO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'CARTÃO NÃO ENCONTRADO.');
    END;

-- =============================================================================
-- ============ VERIFICA SE O ESTABELECIMENTO EXISTE ===========================
-- =============================================================================

    BEGIN
        SELECT 1
          INTO V_ESTABELECIMENTO_EXISTE
          FROM ESTABELECIMENTOS
         WHERE ID_ESTABELECIMENTO = P_ID_ESTABELECIMENTO;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20002, 'ESTABELECIMENTO NÃO ENCONTRADO.');
    END;

-- =============================================================================
-- ========= VERIFICA SALDO DISPONÍVEL SE TRUE REGISTRA TRANSAÇÃO ==============
-- =============================================================================

    IF FN_VERIFICAR_SALDO_DISPONIVEL(P_ID_CARTAO, P_VALOR_TRANSACAO)  THEN

        INSERT INTO TRANSACOES (
            ID_CARTAO,
            ID_ESTABELECIMENTO,
            VALOR_TRANSACAO,
            STATUS_TRANSACAO
        ) VALUES (
            P_ID_CARTAO,
            P_ID_ESTABELECIMENTO,
            P_VALOR_TRANSACAO,
            'A' -- APROVADA
        );

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('TRANSAÇÃO APROVADA E REGISTRADA COM SUCESSO.');
    ELSE
        RAISE_APPLICATION_ERROR(-20003, 'SALDO INSUFICIENTE PARA A TRANSAÇÃO.');
    END IF;

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERRO: TRANSAÇÃO DUPLICADA.');

    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERRO INESPERADO: ' || SQLERRM);
END;