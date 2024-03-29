CREATE TABLE TDESCONTO
( CLASSE VARCHAR(2),
  INFERIOR INTEGER,
  SUPERIOR INTEGER );

A 00 10
B 11 20
C 21 30

SELECT * FROM TDESCONTO ORDER BY CLASSE;

INSERT INTO TDESCONTO(CLASSE, INFERIOR, SUPERIOR)
VALUES (:cla, :inf, :sup);

SELECT * FROM TDESCONTO
WHERE CLASSE = :cla;

UPDATE TDESCONTO SET
INFERIOR = :inf ,
SUPERIOR = :sup
WHERE CLASSE = :cla;

DELETE FROM TDESCONTO
WHERE CLASSE = :cla;

----------------------------------------
DROP TABLE TDESCONTO2;

CREATE TABLE TDESCONTO2
  AS SELECT * FROM TDESCONTO;

SELECT * FROM TDESCONTO2;

COMMIT;


--Transação (Commit/Rollback)

--
DELETE FROM TDESCONTO2;

--Deleta todos os registros
ROLLBACK;

--Delete todos os registros da tabela
--Nao tem clausula Where
TRUNCATE TABLE TDESCONTO2;


SELECT * FROM TDESCONTO2;


--Deleta todos os registros nao tem volta/
--nao funciona (Commit/Rollback)


SELECT * FROM TDESCONTO2;

ROLLBACK;

COMMIT;

SELECT * FROM TDESCONTO;

--Savepoint
SAVEPOINT upd_b;

UPDATE TDESCONTO SET
SUPERIOR = 88
WHERE CLASSE = 'B';

SAVEPOINT upd_a;

UPDATE TDESCONTO SET
SUPERIOR = 99
WHERE CLASSE = 'A';

--ponto de restauraçao
SAVEPOINT ins_Ok;
--
INSERT INTO tdesconto(classe, inferior, superior)
VALUES (:cla, :inf, :sup);

SELECT * FROM TDESCONTO;

ROLLBACK TO SAVEPOINT ins_Ok;
ROLLBACK TO SAVEPOINT upd_a;
ROLLBACK TO SAVEPOINT upd_b;

--excluir tabela
DROP TABLE TDESCONTO2;