CREATE OR REPLACE PROCEDURE PR_REGISTRAR_NOVO_CARTAO (
                                                     P_ID_CLIENTE           IN CARTOES.ID_CLIENTE%TYPE,
                                                     P_ID_DEPARTAMENTO      IN CARTOES.ID_DEPARTAMENTO%TYPE,
                                                     P_NUMERO_CARTAO_HASH   IN CARTOES.NUMERO_CARTAO_HASH%TYPE,
                                                     P_LIMITE_CREDITO       IN CARTOES.LIMITE_CREDITO%TYPE DEFAULT 0
                                                    )
IS
    V_EXIST_CLIENTE        NUMBER := 0;
    V_EXIST_DEPARTAMENTO   NUMBER := 0;
    V_EXIST_HASH           NUMBER := 0;

-- =============================================================================
-- ================== VERIFICA SE O CLIENTE EXISTE =============================
-- =============================================================================
BEGIN
    SELECT COUNT(*)
    INTO V_EXIST_CLIENTE
    FROM CLIENTES
    WHERE ID_CLIENTE = P_ID_CLIENTE;

            IF V_EXIST_CLIENTE = 0 THEN
                RAISE_APPLICATION_ERROR(-20001, 'ERRO: CLIENTE COM ID ' || P_ID_CLIENTE || ' NÃO EXISTE.');
            END IF;

-- =============================================================================
-- ======== VERIFICA SE O DEPARTAMENTO EXISTE E PERTENCE AO CLIENTE ============
-- =============================================================================

    SELECT COUNT(*)
    INTO V_EXIST_DEPARTAMENTO
    FROM DEPARTAMENTOS
    WHERE ID_DEPARTAMENTO = P_ID_DEPARTAMENTO
      AND ID_CLIENTE = P_ID_CLIENTE;

            IF V_EXIST_DEPARTAMENTO = 0 THEN
                RAISE_APPLICATION_ERROR(-20002, 'ERRO: DEPARTAMENTO INVÁLIDO OU NÃO PERTENCE AO CLIENTE INFORMADO.');
            END IF;

-- =============================================================================
-- ============ VERIFICA SE O HASH DO CARTÃO JÁ EXISTE =========================
-- =============================================================================

    SELECT COUNT(*)
    INTO V_EXIST_HASH
    FROM CARTOES
    WHERE NUMERO_CARTAO_HASH = P_NUMERO_CARTAO_HASH;

            IF V_EXIST_HASH > 0 THEN
                RAISE_APPLICATION_ERROR(-20003, 'ERRO: NÚMERO DO CARTÃO JÁ ESTÁ CADASTRADO (HASH DUPLICADO).');
            END IF;

-- =============================================================================
-- ================ VALIDA LIMITE DE CRÉDITO ===================================
-- =============================================================================

        IF P_LIMITE_CREDITO < 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'ERRO: LIMITE DE CRÉDITO NÃO PODE SER NEGATIVO.');
        END IF;

-- =============================================================================
-- ======================= INSERE O NOVO CARTÃO ================================
-- =============================================================================

    INSERT INTO CARTOES (
        ID_CLIENTE,
        ID_DEPARTAMENTO,
        NUMERO_CARTAO_HASH,
        LIMITE_CREDITO
    )
    VALUES (
        P_ID_CLIENTE,
        P_ID_DEPARTAMENTO,
        P_NUMERO_CARTAO_HASH,
        NVL(P_LIMITE_CREDITO, 0)  -- Tratar NULL como zero
    );

    DBMS_OUTPUT.PUT_LINE('CARTÃO REGISTRADO COM SUCESSO PARA O CLIENTE ID ' || P_ID_CLIENTE);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: JÁ EXISTE UM CARTÃO COM O MESMO HASH.');

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: REGISTRO NÃO ENCONTRADO EM UMA DAS TABELAS RELACIONADAS.');

    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: FORAM ENCONTRADOS MÚLTIPLOS REGISTROS QUANDO APENAS UM ERA ESPERADO.');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO INESPERADO: ' || SQLERRM);
END;
/
