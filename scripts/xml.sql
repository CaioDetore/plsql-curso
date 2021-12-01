SELECT XMLELEMENT("cod_aluno", cod_aluno) AS Aluno FROM taluno;

SELECT XMLELEMENT("Aluno",
	XMLATTIBUTES(cod_aluno AS "codigo",
				 nome AS "nome",
				 cidade AS "cidade")) AS Aluno
FROM TALUNO; 

SELECT XMLELEMENT("Aluno",
	XMLFOREST(cod_aluno AS "codigo",
				 nome AS "nome",
				 cidade AS "cidade")) AS Aluno
FROM TALUNO; 