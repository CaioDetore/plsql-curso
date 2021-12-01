create table teste (
  codigo number,
  nome varchar2(40),
  documento blob
);

create sequence seq_doc;

create or replace procedure grava_arquivo (p_file in varchar(40))
as
  v_bfile bfile;
  v_blob blob;
begin
  insert into teste (codigo,nome,documento)
  values (seq_doc.nextval,p_file_name,empty_blob())
  return documento into v_blob;
  -- Informação de directory tem que ser maiusculo 
  v_bfile := bfilename('ARQUIVOS',p_file);
  dbms_lob.fileopen(v_bfile, dbms_lob.file_readonly);     
  dbms_lob.loadfromfile(v_blob,v_bfile,dbms_lob.getlength(v_bfile));
  dbms_lob.fileclose(v_bfile);
  commit;
end;

execute grava_arquivo('arquivo.doc');

Select * from teste;

Select dbms_lob.getlength(documento) bytes from teste;

create index ind_teste_doc on teste (documento) indextype 
is ctxsys.context parameters ('sync (on commit)');

select * from ctx_user_index_errors;

select table_name from user_tables;
select index_name,table_name from user_indexes;

select codigo, nome from teste where contains(documento, 'Marcio', 1) > 0;

select codigo,nome from teste where contains(documento, 'curso', 1) > 0;


