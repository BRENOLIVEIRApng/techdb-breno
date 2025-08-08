CREATE OR REPLACE TRIGGER TRG_AUDITORIA_LIMITE
    BEFORE UPDATE OF LIMITE_CREDITO ON CARTOES
    FOR EACH ROW
    WHEN (
        OLD.LIMITE_CREDITO != NEW.LIMITE_CREDITO OR
        (OLD.LIMITE_CREDITO IS NULL AND NEW.LIMITE_CREDITO IS NOT NULL) OR
        (OLD.LIMITE_CREDITO IS NOT NULL AND NEW.LIMITE_CREDITO IS NULL)
    )
DECLARE
    V_USUARIO  VARCHAR2(50);
BEGIN

    V_USUARIO := SYS_CONTEXT('USERENV', 'SESSION_USER');

-- =============================================================================
-- ========== REGISTRA A ALTERAÇÃO DO LIMITE DE CRÉDITO ========================
-- =============================================================================

    INSERT INTO LOG_ALTERACAO_LIMITE (
        ID_CARTAO,
        LIMITE_ANTIGO,
        LIMITE_NOVO,
        USUARIO_RESPONSAVEL
    ) VALUES (
        :NEW.ID_CARTAO,
        :OLD.LIMITE_CREDITO,
        :NEW.LIMITE_CREDITO,
        V_USUARIO
    );
END;
/