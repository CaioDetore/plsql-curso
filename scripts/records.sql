DECLARE 
	TYPE rec_aluno IS RECORD(
		cod_aluno NUMBER NOT NULL := 0,
		nome TALUNO.Nome%TYPE,
		cidade TALUNO.Cidade%TYPE 
	);
	registro rec_aluno;
BEGIN
	registro.cod_aluno := 50;
	registro.nome := 'Marcio Konrath';
	registro.cidade := 'Novo Hamburgo';
	Dbms_Output.Put_line('Código: '||registro.cod_aluno);
	Dbms_Output.Put_line('Nome: '||registro.nome);
	Dbms_Output.Put_line('Cidade: '||registro.cidade);
END;

DECLARE
	reg TALUNO%ROWTYPE;
	vcep VARCHAR(10) := '98300000';
BEGIN
	SELECT COD_ALUNO, NOME, CIDADE
	INTO reg.cod_aluno, reg.nome, reg.cidade
	FROM TALUNO 
	WHERE COD_ALUNO = 1;
	
	vcep := '98300000';
	reg.cep := vCep;

	Dbms_Output.Put_line('Código: '||reg.cod_aluno);
	Dbms_Output.Put_line('Nome: '||reg.nome);
	Dbms_Output.Put_line('Cidade: '||reg.cidade);
	Dbms_Output.Put_line('CEP: '||reg.cep);
END;
	
DECLARE 
	TYPE t_aluno IS TABLE OF taluno.nome%TYPE
	INDEX BY BINARY_INTEGER; -- matriz

	registro t_aluno; -- record
BEGIN 
	registro(1) := 'MARCIO';
	registro(2) := 'JOSE';
	registro(3) := 'PEDRO';
	--
	Dbms_Output.Put_line('Nome 1: '||registro(1));
	Dbms_Output.Put_line('Nome 2: '||registro(2));
	Dbms_Output.Put_line('Nome 3: '||registro(3));
END;

DECLARE 
	
--
SELECT cod_aluno, NOME
FROM tALUNO WHERE COD_ALUNO = 1;
--
--

DECLARE
	TYPE nome_type IS TABLE OF taluno.nome%TYPE;
	nome_table nome_type := nome_type(); --Criando Instancia
BEGIN
	nome_table.EXTEND; -- alocando uma nova linha
	nome_table(1) := 'Marcelo';
	nome_table.EXTEND; -- alocando uma nova linha
	nome_table(2) := 'Marcio';
	Dbms_Output.Put_Line('Nome 1: '||nome_table(1));
	Dbms_Output.Put_Line('Nome 2: '||nome_table(2));
END;
--

DECLARE
	TYPE tipo IS TABLE OF VARCHAR2(40) INDEX BY VARCHAR2(2);
	--
	uf_capital tipo;
BEGIN
	uf_capital('RS') := 'PORTO ALEGRE';
	uf_capital('RJ') := 'RIO DE JANEIRO';
	uf_capital('PR') := 'CURITIBA';
	uf_capital('MT') := 'CUIABA';
	dbms_output.put_line(uf_capital('RS'));
	dbms_output.put_line(uf_capital('RJ'));
	dbms_output.put_line(uf_capital('PR'));
	dbms_output.put_line(uf_capital('MT'));
END;


-- VARRAY
DECLARE
	TYPE nome_varray IS VARRAY(5) OF taluno.nome%TYPE;
	nome_vetor nome_varray := nome_varray();
BEGIN
	nome_vetor.EXTEND;
	nome_vetor(1) := 'MasterTraining';
	Dbms_Output.Put_Line(nome_vetor(1));
END;
	
		