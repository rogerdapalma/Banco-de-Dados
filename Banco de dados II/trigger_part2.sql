USE Biblioteca;
/*
1. Verificação de IDENTITY INSERT
2. Restrição (Constraint) de Nulos (NULL)
3. Checagem de tipos de dados
4. Execução de trigger INSTEAD OF (a execução do DML pára aqui; esse trigger
não é recursivo)
5. Restrição de Chave Primária
6. Restrição “Check”
7. Restrição Chave Estrangeira
8. Execução do DML e atualização do log de transações
9. Execução do trigger AFTER
10. Commit da transação (Confirmação
*/
-- CRIANDO UM TRIGGER
GO
CREATE TRIGGER tg_trigger_after
ON dbo.editora
AFTER INSERT 
AS 
PRINT 'OLA TRIGGER AFTER';
GO

-- INSERINDO UMA NOVA EDITORA PARA ATIVAÇÃO DO TRIGGER 

INSERT INTO editora (nome) VALUES ('EDITORA11');

-- DESCREVE OQUE CADA CAMPO É
SP_HELP EDITORA;

-- VERIFICANDO SE A INSERÇÃO JA FOI REALIZADA
SELECT * FROM EDITORA;

-- REMOVENDO TRIGGER
DROP TRIGGER tg_trigger_after;

-- CRIANDO UM TRIGGER PARA MANIPULAR OUTRAS TABELAS

CREATE TRIGGER tg_after
ON editora
AFTER INSERT
AS 
INSERT INTO AUTOR VALUES ('Juca da Silva' , 'Brasil');
INSERT INTO LIVRO VALUES ('B2312','Mais um Juca no Brasil',1995,6,1);

-- ATIVANDO O TRRIGER 

INSERT INTO EDITORA (nome) VALUES ('EDITORA12');

SELECT * FROM EDITORA;

SELECT * FROM LIVRO;

SELECT * FROM AUTOR;

-- CRIANDO UM TRIGGER COM INSTADOF

CREATE TRIGGER tg_insteadof
ON AUTOR 
INSTEAD OF INSERT -- AO INVES DE FAZER ISSO
AS
PRINT 'OLA DE NOVO TRIGGER'; -- FAZ ISSO 

-- ATIVANDO TRIGGER
INSERT INTO AUTOR VALUES ('Judas','Brasil');
-- verificando o valor que nao foi inserido
SELECT * FROM AUTOR;

-- DESABILITAR UM TRIGGER ESPECIFICO DA TABELA 
ALTER TABLE AUTOR 
DISABLE TRIGGER tg_insteadof ;

-- VERIFICAR A EXISTENCIA DE TRIGGERS EM UMA TABLETA 
EXEC  sp_helptrigger @tabname=Editora;

-- VERIFICAR A EXISTENCIA DE TRIGGER EM TODO O BANCO 
SELECT * FROM sys.triggers
WHERE is_disabled = 0 OR is_disabled = 1;

-- TRIGGER COM BASE EM COMANDOS DML EM CONSULTA ESPECIFICAS
GO
CREATE TRIGGER tg_after_autores
ON AUTOR 
AFTER INSERT, UPDATE
AS 
IF UPDATE(NOME)
	BEGIN
		PRINT 'O NOME FOI ALTERADO';
	END
ELSE 
	BEGIN
		PRINT'O NOME NAO FOI ALTERADO';
	END 
GO


SELECT * FROM AUTOR;
-- MUDANDO O NOME DE UM AUTOR PARA VEREFICAR O TRIGGER
UPDATE AUTOR 
SET NOME = 'Gertulino Gonsalves'
WHERE ID = 5;

UPDATE AUTOR
SET nacionalidade = 'Urugai'
WHERE ID = 5 ;

SELECT * FROM AUTOR;

-- ATIVANDO TRIGGER RECURSIVO NO MEU BANCO DE DADOS
ALTER DATABASE BIBLIOTECA
SET RECURSIVE_TRIGGERS ON

-- CRIANDO UMA TABELA PARA TRIGGER RECURSIVO

CREATE TABLE tbl_tg_recursivo
(codigo INT PRIMARY KEY);

-- CRIANDO O TRIGGER RECURSIVO
GO
CREATE TRIGGER tg_rec
ON tbl_tg_recursivo
AFTER INSERT
AS
DECLARE @cod INT
SELECT 
@cod = MAX(codigo)
FROM tbl_tg_recursivo
IF @cod <10
	BEGIN
		INSERT INTO tbl_tg_recursivo
		SELECT MAX(codigo) + 1 FROM tbl_tg_recursivo
	END
ELSE 
	BEGIN
		PRINT 'TRIGGER RECURSIVO FINALIZADO!';
	END
GO

-- VERIFICAR A FUNCIONALIDADE DO MEU TRIGGER 
SELECT * FROM tbl_tg_recursivo ;

-- ATIVANDO O TRIGGER 
INSERT INTO tbl_tg_recursivo VALUES (1);

SELECT * FROM tbl_tg_recursivo ;





