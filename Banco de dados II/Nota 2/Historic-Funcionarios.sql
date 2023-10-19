CREATE DATABASE AtividadeBD

USE AtividadeBD;


CREATE TABLE Funcionarios

(
    FuncionarioID INT PRIMARY KEY,
    Nome NVARCHAR(255),
    Cargo NVARCHAR(255),
    Salario DECIMAL(10, 2),
    DataInicio DATE,
    DataFim DATE,
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN, 
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)
);

INSERT INTO Funcionarios (FuncionarioID, Nome, Cargo, Salario, DataInicio, DataFim)
VALUES
(1, 'João Silva', 'Analista', 5000.00, '2022-01-01', NULL),
(2, 'Maria Oliveira', 'Gerente', 7000.00, '2022-02-01', NULL),
(3, 'Pedro Castro', 'Desenvolvedor', 6000.00, '2022-02-10', NULL),
(4, 'Fernanda Lima', 'Analista', 5200.00, '2022-04-15', NULL),
(5, 'Lucas Andrade', 'Desenvolvedor Sênior', 6500.00, '2022-05-01', NULL),
(6, 'Camila Rocha', 'Desenvolvedor', 5800.00, '2022-06-20', NULL),
(7, 'Rafael Souza', 'Analista Sênior', 5600.00, '2022-08-01', NULL),
(8, 'Aline Costa', 'Gerente', 7100.00, '2022-09-10', NULL),
(9, 'Bruno Ribeiro', 'Analista', 5050.00, '2022-10-05', NULL),
(10, 'Amanda Gomes', 'Desenvolvedor', 5750.00, '2022-10-15', NULL),
(11, 'Carlos Peixoto', 'Desenvolvedor Sênior', 6550.00, '2022-11-01', NULL),
(12, 'Daniela Lopes', 'Analista', 5000.00, '2022-11-20', NULL),
(13, 'Eduardo Pires', 'Gerente', 7200.00, '2023-01-05', NULL),
(14, 'Gabriela Neves', 'Desenvolvedor', 5900.00, '2023-02-01', NULL),
(15, 'Roberto Moraes', 'Analista', 5100.00, '2023-02-15', NULL);

SELECT * FROM Funcionarios;


/*
a. Crie uma tabela temporal para manter um histórico dos Funcionários.
*/
GO
CREATE SCHEMA Historico;
GO

GO
CREATE TABLE Historico.Funcionarios
(
FuncionarioID INT PRIMARY KEY,
    Nome NVARCHAR(255),
    Cargo NVARCHAR(255),
    Salario DECIMAL(10, 2),
    DataInicio DATE,
    DataFim DATE,
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN,
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)
);
GO

-- Ativar a Tabela Temporal
ALTER TABLE Historico.Funcionarios
	SET (SYSTEM_VERSIONING = ON);

INSERT INTO Historico.Funcionarios (FuncionarioID, Nome, Cargo, Salario, DataInicio, DataFim)
VALUES (1, 'João Silva', 'Analista', 5000.00, '2022-01-01', NULL),
(2, 'Maria Oliveira', 'Gerente', 7000.00, '2022-02-01', NULL),
(3, 'Pedro Castro', 'Desenvolvedor', 6000.00, '2022-02-10', NULL),
(4, 'Fernanda Lima', 'Analista', 5200.00, '2022-04-15', NULL),
(5, 'Lucas Andrade', 'Desenvolvedor Sênior', 6500.00, '2022-05-01', NULL),
(6, 'Camila Rocha', 'Desenvolvedor', 5800.00, '2022-06-20', NULL),
(7, 'Rafael Souza', 'Analista Sênior', 5600.00, '2022-08-01', NULL),
(8, 'Aline Costa', 'Gerente', 7100.00, '2022-09-10', NULL),
(9, 'Bruno Ribeiro', 'Analista', 5050.00, '2022-10-05', NULL),
(10, 'Amanda Gomes', 'Desenvolvedor', 5750.00, '2022-10-15', NULL),
(11, 'Carlos Peixoto', 'Desenvolvedor Sênior', 6550.00, '2022-11-01', NULL),
(12, 'Daniela Lopes', 'Analista', 5000.00, '2022-11-20', NULL),
(13, 'Eduardo Pires', 'Gerente', 7200.00, '2023-01-05', NULL),
(14, 'Gabriela Neves', 'Desenvolvedor', 5900.00, '2023-02-01', NULL),
(15, 'Roberto Moraes', 'Analista', 5100.00, '2023-02-15', NULL);

UPDATE Historico.Funcionarios
SET Cargo = 'Analista Sênior', Salario = 5502.00
WHERE FuncionarioID = 1;


UPDATE Historico.Funcionarios
SET DataFim = '2022-12-31'
WHERE FuncionarioID = 1;


SELECT * FROM Historico.Funcionarios;

SELECT * FROM Historico.Funcionarios
FOR SYSTEM_TIME ALL
WHERE FuncionarioID = 1;

/*b. Insira um novo funcionário na tabela Funcionarios.*/INSERT INTO Funcionarios (FuncionarioID, Nome, Cargo, Salario, DataInicio, DataFim)
VALUES (16, 'José Santos', 'Desenvolvedor Júnior', 4800.00, '2023-03-01', NULL);

SELECT * FROM Funcionarios;

/*
Promova 4 vezes o funcionários inserido para um novo cargo com um
aumento salarial. Verifique como o histórico é mantido na tabela
FuncionariosHistorico.
*/
SELECT * FROM Funcionarios WHERE FuncionarioID = 16;

INSERT INTO Historico.Funcionarios (FuncionarioID, Nome, Cargo, Salario, DataInicio, DataFim)
VALUES (16, 'José Santos', 'Desenvolvedor Júnior', 4800.00, '2023-03-01', NULL);

UPDATE Historico.Funcionarios
SET Cargo = 'Analista Sênior', Salario = 5502.00
WHERE FuncionarioID = 16;

UPDATE Historico.Funcionarios
SET Cargo = 'Desenvolvedor Pleno', Salario = 5200.00
WHERE FuncionarioID = 16;

UPDATE Historico.Funcionarios
SET Cargo = 'Desenvolvedor Sênior', Salario = 5800.00
WHERE FuncionarioID = 16;

UPDATE Historico.Funcionarios
SET Cargo = 'Gerente de Projetos', Salario = 7000.00
WHERE FuncionarioID = 16;

UPDATE Historico.Funcionarios
SET Cargo = 'Gerente Chefe', Salario = Salario * 1.10
WHERE FuncionarioID = 16;

SELECT * FROM Historico.Funcionarios FOR SYSTEM_TIME ALL
WHERE FuncionarioID = 16;

/*
d. Liste todos os cargos anteriores de um funcionário específico, juntamente
com os períodos em que ele ocupou esses cargos.
*/
DECLARE @FuncionarioID INT = 16;

SELECT 
    FuncionarioID,
    Cargo AS CargoAnterior,
    SysStartTime AS DataInicioCargo,
    DATEADD(MILLISECOND, -3, LEAD(SysStartTime) OVER (PARTITION BY FuncionarioID ORDER BY SysStartTime)) AS DataFimCargo
FROM Historico.Funcionarios
WHERE FuncionarioID = @FuncionarioID
    AND SysStartTime <> SysEndTime
ORDER BY SysStartTime;

/*
e. Determine o salário de um funcionário em uma data específica no passado.
*/

DECLARE @FuncionarioID INT = 16;

DECLARE @DataEspecifica DATE = '2023-03-02';

SELECT TOP 1
    FuncionarioID,
    Salario,
    SysStartTime AS DataInicioSalario
FROM Historico.Funcionarios
WHERE FuncionarioID = @FuncionarioID
    AND @DataEspecifica BETWEEN SysStartTime AND SysEndTime
ORDER BY SysStartTime DESC;

/*
f. Liste todos os funcionários que já ocuparam o cargo de "Gerente" em algum
momento.
*/

SELECT DISTINCT
    FuncionarioID,
    Nome
FROM Historico.Funcionarios
WHERE Cargo = 'Gerente';

/*
g. Identifique as mudanças salariais de todos os funcionários no último ano.
*/

-- Consulta para identificar as mudanças salariais de todos os funcionários no último ano
SELECT
    FuncionarioID,
    Nome,
    Cargo,
    Salario AS SalarioAtual,
    LAG(Salario) OVER (PARTITION BY FuncionarioID ORDER BY SysStartTime) AS SalarioAnterior,
    SysStartTime AS DataInicioSalario,
    SysEndTime AS DataFimSalario
FROM Historico.Funcionarios
WHERE DATEDIFF(YEAR, SysStartTime, GETDATE()) = 1
    AND SysStartTime <> SysEndTime
ORDER BY FuncionarioID, SysStartTime;

/*
h. Desative o versionamento de sistema da tabela Funcionários e verifique o
que acontece com a tabela FuncionariosHistorico.
*/

ALTER TABLE Funcionarios
    SET (SYSTEM_VERSIONING = OFF);

	
