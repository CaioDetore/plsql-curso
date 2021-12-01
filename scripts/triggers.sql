CREATE TABLE log_ddl (
	DATA DATE,
	ususario varchar(40),
	SCHEMA varchar2(30),
	operacao varchar(100),
	objeto varchar2(1000)
);
CREATE TABLE purchase_order(
	DATA DATE
);
SELECT * FROM purchase_order;

CREATE OR REPLACE TRIGGER tri_log_ddl BEFORE ddl ON DATABASE 
DECLARE 
	v_oper varchar2(30);
	v_schema varchar2(30);
	v_obj varchar2(30);
BEGIN
	SELECT ora_sysevent, ora_dict_obj_owner, ora_dict_obj_name
	INTO v_oper, v_schema, v_obj FROM dual;
	INSERT INTO log_ddl VALUES (sysdate, USER, v_schema, v_oper, v_obj);
END;

DROP TABLE PURCHASE_ORDER;

SELECT * FROM log_ddl;