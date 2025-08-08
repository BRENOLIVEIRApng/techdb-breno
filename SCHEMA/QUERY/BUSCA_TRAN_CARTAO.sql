-- =============================================================================
-- ========== UMA BUSCA MAIS OTIMIZADA MELHORANDO A PERFORMANCE ================
-- ========== CRIANDO INDEX EM CAMPOS NECESSARIOS PARA MELHORA  ================
-- =============================================================================

SELECT ID_TRANSACAO,
       VALOR_TRANSACAO,
       DATA_TRANSACAO,
       STATUS_TRANSACAO
FROM TRANSACOES
WHERE ID_CARTAO = 1001 
  AND DATA_TRANSACAO BETWEEN TO_DATE('01/01/2024', 'DD/MM/YYYY')
                         AND TO_DATE('31/12/2024', 'DD/MM/YYYY')
ORDER BY DATA_TRANSACAO;