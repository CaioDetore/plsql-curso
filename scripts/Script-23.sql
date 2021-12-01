
----  UNION ALL - UNION -  INTERSECT - MINUS

  SELECT COD_ALUNO, TOTAL , DESCONTO
  FROM TCONTRATO
  WHERE COD_ALUNO = 1

--  UNION ALL       ---Nao agrupa iguais
  UNION         ---Agrupa iguais

  SELECT COD_ALUNO, TOTAL, DESCONTO
  FROM TCONTRATO
  WHERE TOTAL >= 1000;


--

SELECT COD_CONTRATO, DATA, total, 'UNION 1' AS QUERY
FROM   tcontrato
WHERE  TOTAL >= 1000 AND TOTAL < 2000

UNION  ALL

SELECT COD_CONTRATO, DATA, total, 'UNION 2' AS QUERY
FROM   tcontrato
WHERE  desconto IS NOT NULL

UNION

SELECT COD_CONTRATO, DATA, total, 'UNION 3' AS QUERY
FROM   tcontrato
WHERE  total > 2000

ORDER  BY QUERY;




--
SELECT COD_CONTRATO, DATA, DESCONTO, TOTAL
FROM   TCONTRATO
WHERE  DESCONTO IS NOT NULL

INTERSECT
--Registros estao presentes em todos os conjuntos.

SELECT COD_CONTRATO, DATA, DESCONTO, TOTAL
FROM   TCONTRATO
WHERE  TOTAL > 1000

ORDER  BY COD_CONTRATO;


--
SELECT COD_CONTRATO, DATA, DESCONTO, TOTAL
FROM   TCONTRATO
WHERE  DESCONTO IS NOT NULL

MINUS  -- traz todos os registros da primeira consulta
       -- menos os da segunda consulta ( ignora repetido )

SELECT COD_CONTRATO, DATA, DESCONTO, TOTAL
FROM   TCONTRATO
WHERE  TOTAL > 2000

ORDER  BY 1;










--
INSERT INTO TALUNO (COD_ALUNO, NOME)
VALUES( (SELECT NVL(MAX(COD_ALUNO),0) + 1 FROM TALUNO),
        'CLEBER');

--
SELECT * FROM TALUNO;


--
SELECT (SELECT MAX(Total) FROM TContrato) MAIOR,
       (SELECT MIN(Total) FROM TContrato) MENOR
FROM DUAL;

--








--Exercicios
--1
SELECT COD_CONTRATO, TOTAL, 'CONTRATOS' STRING
FROM TCONTRATO
 UNION
SELECT COD_CONTRATO, SUM(VALOR) VALOR, 'ITENS' STRING
FROM ITENS
GROUP BY COD_CONTRATO
ORDER BY 3,1;

--2
SELECT COD_CONTRATO, DATA, TOTAL
FROM TCONTRATO
 MINUS
SELECT COD_CONTRATO, DATA, TOTAL
FROM TCONTRATO
WHERE NVL(DESCONTO,0) = 0
 INTERSECT
SELECT CON.COD_CONTRATO, CON.DATA, CON.TOTAL
FROM TALUNO ALU, TCONTRATO CON
WHERE ALU.COD_ALUNO = CON.COD_ALUNO
AND ALU.ESTADO = 'RS';







