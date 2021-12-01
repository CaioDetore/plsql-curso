ANALYZE TABLE TALUNO COMPUTE STATISTICS;

EXEC DBMS_UTILITY.ANALYZE_SCHEMA('ALUNO','COMPUTE');

EXEC DBMS_STATS.GATHER_DATABASE_STATS;

DECLARE
  libcac NUMBER(10, 2);
  rowcac NUMBER(10, 2);
  bufcac NUMBER(10, 2);
  redlog NUMBER(10, 2);
  spsize NUMBER;
  blkbuf NUMBER;
  logbuf NUMBER;
BEGIN
  SELECT VALUE
  INTO redlog
  FROM v$sysstat
  WHERE name = 'redo log space requests';
SELECT 100 * (SUM(pins) - SUM(reloads)) / SUM(pins)
  INTO libcac
  FROM v$librarycache;
 
  SELECT 100 * (SUM(gets) - SUM(getmisses)) / SUM(gets)
  INTO rowcac
  FROM v$rowcache;
SELECT 100 * (cur.VALUE + con.VALUE - phys.VALUE) /(cur.VALUE + con.VALUE)
  INTO bufcac
  FROM v$sysstat cur, v$sysstat con, v$sysstat phys, 
  v$statname ncu, v$statname nco, v$statname nph
  WHERE cur.statistic# = ncu.statistic#
  AND ncu.name = 'db block gets'
  AND con.statistic# = nco.statistic#
  AND nco.name = 'consistent gets'
  AND phys.statistic# = nph.statistic#
  AND nph.name = 'physical reads';
  SELECT VALUE INTO spsize
  FROM v$parameter
  WHERE name = 'shared_pool_size';
  SELECT VALUE INTO blkbuf
  FROM v$parameter
  WHERE name = 'db_block_buffers';
  SELECT VALUE INTO logbuf FROM v$parameter WHERE name = 'log_buffer';
  DBMS_OUTPUT.put_line('> SGA CACHE STATISTICS');
  DBMS_OUTPUT.put_line('> ********************');
  DBMS_OUTPUT.put_line('> SQL Cache Hit rate = ' || libcac);
  DBMS_OUTPUT.put_line('> Dict Cache Hit rate = ' || rowcac);
  DBMS_OUTPUT.put_line('> Buffer Cache Hit rate = ' || bufcac);
  DBMS_OUTPUT.put_line('> Redo Log space requests = ' || redlog);
  DBMS_OUTPUT.put_line('> ');
  DBMS_OUTPUT.put_line('> INIT.ORA SETTING');
  DBMS_OUTPUT.put_line('> ****************');
  DBMS_OUTPUT.put_line('> Shared Pool Size = ' || spsize || ' Bytes');
  DBMS_OUTPUT.put_line('> DB Block Buffer = ' || blkbuf || ' Blocks');
  DBMS_OUTPUT.put_line('> Log Buffer = ' || logbuf || ' Bytes');
  DBMS_OUTPUT.put_line('> ');
  IF libcac < 99 THEN
    DBMS_OUTPUT.put_line('*** HINT: Library Cache muito baixo! Aumente Shared Pool Size.');
  END IF;
  IF rowcac < 85 THEN
    DBMS_OUTPUT.put_line('*** HINT: Row Cache muito baixo! Aumente Shared Pool Size.');
  END IF;
  IF bufcac < 90 THEN
    DBMS_OUTPUT.put_line('*** HINT: Buffer Cache muito baixo! Aumente DB Block Buffer value.');
  END IF;
  IF redlog > 100 THEN
    DBMS_OUTPUT.put_line('*** HINT: Valor de Log Buffer é muito baixo!');
  END IF;
 
END;

-- VIEW MATERIALIZADA
GRANT CREATE ANY MATERIALIZED VIEW TO aluno;

CREATE MATERIALIZED VIEW LOG ON taluno TABLESPACE tbs_dados;

DROP MATERIALIZED VIEW V_MAT;

CREATE MATERIALIZED VIEW V_MAT
TABLESPACE tbs_dados
BUILD IMMEDIATE
REFRESH FAST ON COMMIT AS
(SELECT COD_ALUNO, NOME, CIDADE FROM TALUNO 
WHERE CIDADE = 'NOVO HABURGO');

INSERT INTO TALUNO (COD_ALUNO,NOME,CIDADE)
VALUES(SEQ_ALUNO.NEXTVAL,'TESTE 2','NOVO HAMBURGO');

SELECT * FROM TALUNO;

SELECT * FROM V_MAT;


-- HINTS DE PESQUISA

--Conectado como system --Visão dos hints 
select * from v$sql_hint;

grant select_catalog_role to marcio; 
grant select any dictionary to marcio;

select * from taluno;

create index ind_aluno_nome on taluno(nome);

select /*+ first_rows(2) */ cod_aluno, nome from taluno;

-- all_rows: Para forçar varredura completa na tabela.

select /*+ all_rows (10) */ cod_aluno, nome
from taluno;

-- full: Para forçar um scan completo na tabela. 
-- A hint full também pode causar resultados inesperados como varredura 
-- na tabela em ordem diferente da ordem padrão.
 
select /*+ full_rows (taluno) */ cod_aluno, nome
from taluno
where nome = 'MARCIO' 

select /*+ index */ cod_aluno, nome
from taluno
where nome = 'MARCIO' ;

select /*+ index (taluno ind_aluno_nome) */ cod_aluno, nome, cidade
from taluno
where nome = 'MARCIO' ;

select /*+ no_index (taluno ind_aluno_nome) */ cod_aluno, nome, cidade
from taluno
where nome = 'MARCIO' ;

select /*+ index_join (taluno ind_aluno_nome, ind_aluno_cidade) */ cod_aluno, nome, cidade
from taluno
where nome = 'MARCIO' AND cidade = 'NOVO HAMBURGO';

select /*+ and_equal (taluno ind_aluno_nome, ind_aluno_cidade) */ cod_aluno, nome, cidade
from taluno
where nome = 'MARCIO' AND cidade = 'NOVO HAMBURGO';

select /*+ index_ffs (taluno ind_aluno_nome) */ cod_aluno, nome
from taluno
where nome = 'MARCIO'
