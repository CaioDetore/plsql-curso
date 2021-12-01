CREATE TABLE teste_idx(
	codigo NUMBER,
	nome varchar2(40)
);

-- indice
CREATE INDEX ind_codigo ON teste_idx(codigo);

-- novo registro
INSERT INTO teste_idx VALUES(1, 'Marcio');

COMMIT;

-- verificado se o indices ja foi usado
SELECT index_name, table_name, used FROM "V$OBJECT_USAGE" ;

-- alterado indice 
ALTER INDEX ind_codigo monitoring USAGE;

-- select para usar o indice 
SELECT * FROM teste_idx WHERE codigo =1;

-- verificao se o indice ja foi usado novamente
SELECT INDEX_name, table_name, used FROM "V$OBJECT_USAGE";

-- alterado indice para não ser monitorado 
ALTER INDEX ind_codigo nomonitoring USAGE;



