BEGIN
    DBMS_SCHEDULER.CREATE_JOB (
        JOB_NAME        => 'JOB_ATUALIZA_LIMITE',
        JOB_TYPE        => 'PLSQL_BLOCK',
        JOB_ACTION      => 'BEGIN ATUALIZA_LIMITE_CARTOES(); END;',
        START_DATE      => SYSTIMESTAMP,
        REPEAT_INTERVAL => 'FREQ=DAILY;BYHOUR=0;BYMINUTE=0;BYSECOND=0',
        ENABLED         => TRUE,
        COMMENTS        => 'Job para atualizar limites de crédito diariamente'
    );
END;
/