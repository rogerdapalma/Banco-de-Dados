-- Criando database1
IF EXISTS(SELECT name FROM sys.databases
WHERE name = 'Seguranca_1')
	DROP DATABASE Seguranca_1
CREATE DATABASE Seguranca_1;

IF EXISTS(SELECT name FROM sys.databases
WHERE name = 'Seguranca_2')
	DROP DATABASE Seguranca_2
CREATE DATABASE Seguranca_2;


CREATE LOGIN [Juca] WITH PASSWORD=N'juca@123',
DEFAULT_DATABASE=[Seguranca_1],
CHECK_EXPIRATION=OFF,CHECK_POLICY=ON
GO


USE [master]
GO
CREATE LOGIN [Juca] WITH PASSWORD=N'juca@123',
DEFAULT_DATABASE=[Seguranca_1], 
CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
USE [Seguranca_1]
GO
CREATE USER [Juca] FOR LOGIN [Juca]
GO
--Query para vereficar todos os logons e senhas criados
SELECT name,
		create_date,
		modify_date,
		LOGINPROPERTY(name, 'DaysUnitiExpiration')DaysUnitiExpiration,
		LOGINPROPERTY(name, 'PasswordLastSetTime')PasswordLastSetTime,
		LOGINPROPERTY(name, 'iSeXPIRED')iSeXPIRED,
		LOGINPROPERTY(name, 'IsMustChange')IsMustChange,*

FROM sys.sql_logins


--Instancias de conexão 
SELECT * FROM sys.sysprocesses
WHERE loginame = 'Juca';

--Criar nova tabela SA

CREATE TABLE Disciplina(
	id INT IDENTITY,
	data DATETIME DEFAULT(GETDATE()),
	nome VARCHAR(100)
);

-- Preenchimento a tabela 
INSERT INTO Disciplina(nome)
SELECT 'Nome Preenchido'
GO 10

-- Verificando preenchimento
SELECT * FROM Disciplina;

--Dar acesso ao Juca
GRANT SELECT ON Disciplina TO Juca; 
GO
-- Criar função
CREATE FUNCTION fncDisciplina(@id int)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Disciplina WHERE ID = @id
);
GO
-- Verificar funcionamento da Função 
SELECT * FROM fncDisciplina(3);

-- Dando acesso a execução da função 
GRANT SELECT ON fncDisciplina TO Juca;

-- Criando uma View 

CREATE VIEW vw_Disciplina
AS
SELECT data, nome FROM Disciplina
GO
-- Dando acesso de view disciplina 
GRANT SELECT ON vw_Disciplina TO Juca;

-- Criando procedure 
CREATE PROCEDURE sp_Disciplina_01
AS
SELECT * FROM Disciplina;

-- Dando acesso ao procedure 
GRANT EXECUTE ON sp_Disciplina_01 TO Juca;

-- Criando 3 procedures

CREATE PROCEDURE sp_Disciplina_02
AS
SELECT * FROM Disciplina;
GO

CREATE PROCEDURE sp_Disciplina_03
AS
SELECT * FROM Disciplina;
GO

CREATE PROCEDURE sp_Disciplina_04
AS
SELECT * FROM Disciplina;
GO

-- Dando acesso a todos os procedures
GRANT EXECUTE TO Juca;

-- Negar acesso a um objeto especifico

DENY EXECUTE ON sp_Disciplina_04 TO Juca;

--Remover acesso de leitura 

DENY SELECT TO Juca;

USE Seguranca_2;

CREATE TABLE Instituicao
(
	id INT IDENTITY,
	nome VARCHAR(255),
	cod INT
);

--Preenchendo a tabela
INSERT INTO Instituicao (nome,cod)
SELECT 'Nome Instituição',123
GO 20

DENY UPDATE TO Juca;

USE Seguranca_1;
GO
CREATE PROCEDURE sp_Disciplina_05
AS
BEGIN
	SELECT * FROM Disciplina
	SELECT * FROM Seguranca_2..Instituicao
END 
GO

EXEC sp_Disciplina_05;


--Query para retornar as permiç~pes que sao dadas 
SELECT	state_desc, prmsn.permission_name as [Permission], sp.type_desc, sp.name,
		grantor_principal.name AS [Grantor], grantee_principal.name as [Grantee]
FROM sys.all_objects AS sp
	INNER JOIN sys.database_permissions AS prmsn 
	ON prmsn.major_id = sp.object_id AND prmsn.minor_id=0 AND prmsn.class = 1
	INNER JOIN sys.database_principals AS grantor_principal
	ON grantor_principal.principal_id = prmsn.grantor_principal_id
	INNER JOIN sys.database_principals AS grantee_principal 
	ON grantee_principal.principal_id = prmsn.grantee_principal_id
WHERE grantee_principal.name = 'Juca'
