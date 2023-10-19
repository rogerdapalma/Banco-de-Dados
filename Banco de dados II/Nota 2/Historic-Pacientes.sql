CREATE DATABASE AtividadeBD1

USE AtividadeBD1;

CREATE TABLE Pacientes (
    PacienteID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Condicao VARCHAR(255),
    Medicamento VARCHAR(255),
    DataDiagnostico DATE,
    DataFinalizacao DATE
);

INSERT INTO Pacientes (PacienteID, Nome, Condicao, Medicamento, DataDiagnostico, DataFinalizacao)
VALUES
    (101, 'Alex Costa', 'Gripe', 'Paracetamol', '2022-06-01', '2022-06-10'),
    (102, 'Bia Souza', 'Nova doen�a', 'Rem�dioX', '2023-01-05', NULL),
    (103, 'Carlos Menezes', 'Bronquite', 'BroncoMed', '2022-11-20', '2023-02-01'),
    (104, 'Daniela Pereira', 'Nova doen�a', 'Rem�dioX', '2023-01-10', NULL),
    (105, 'Eduardo Lopes', 'Hipertens�o', 'HiperTensil', '2022-08-15', NULL),
    (106, 'Fernanda Oliveira', 'Diabetes', 'Insulina', '2022-02-01', NULL),
    (107, 'Gabriel Martins', 'Nova doen�a', 'Rem�dioX', '2023-01-12', NULL),
    (108, 'Helena Santos', 'Asma', 'AsmaMed', '2022-05-15', '2023-01-20'),
    (109, 'Isaac Ferreira', 'Bronquite', 'BroncoMed', '2023-01-25', NULL),
    (110, 'Juliana Teixeira', 'Gripe', 'Paracetamol', '2023-01-20', '2023-01-28'),
    (111, 'Lucas Monteiro', 'Nova doen�a', 'Rem�dioX', '2023-01-15', NULL),
    (112, 'Mariana Ribeiro', 'Hipertens�o', 'HiperTensil', '2022-10-10', NULL),
    (113, 'Nelson Pires', 'Diabetes', 'Insulina', '2022-03-12', NULL),
    (114, 'Ol�via Dias', 'Asma', 'AsmaMed', '2022-09-15', NULL),
    (115, 'Paulo Andrade', 'Gripe', 'Paracetamol', '2023-01-23', '2023-01-29');

/*
a. Crie uma tabela temporal para manter um hist�rico dos Pacientes (PacientesHistorico).
*/
CREATE TABLE PacientesHistorico (
    PacienteID INT PRIMARY KEY,
    Nome NVARCHAR(255),
    Condicao NVARCHAR(255),
    Medicamento NVARCHAR(255),
    DataDiagnostico DATE,
    DataFinaliza��o DATE,
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN,
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)
)
WITH (SYSTEM_VERSIONING = ON);

INSERT INTO PacientesHistorico
SELECT *
FROM Pacientes;
   
/*
b. a. Insira um paciente na tabela Pacientes que foi diagnosticado com essa
�nova doen�a�.
*/
INSERT INTO Pacientes (PacienteID, Nome, Condicao, Medicamento, DataDiagnostico)
VALUES(116, 'Jos� Silva', 'Nova doen�a', 'Rem�dioX', '2023-03-01');
/*
c. Atualize a condi��o de "Bia Souza" para indicar que ela se recuperou da
doen�a. Em seguida, verifique como o hist�rico � mantido na tabela
PacientesHistorico.
*/

UPDATE Pacientes
SET Condicao = 'Recuperado', 
    DataFinalizacao = GETDATE() 
WHERE Nome = 'Bia Souza';

SELECT *
FROM PacientesHistorico
FOR SYSTEM_TIME ALL
WHERE Nome = 'Bia Souza';
/*
d. Liste todas as condi��es m�dicas anteriores de "Carlos Menezes".
*/

SELECT DISTINCT Condicao
FROM PacientesHistorico
FOR SYSTEM_TIME ALL
WHERE Nome = 'Carlos Menezes';

/*
e. Determine a condi��o m�dica de "Eduardo Lopes" em '2022-10-01'.
*/
SELECT Condicao
FROM PacientesHistorico
FOR SYSTEM_TIME AS OF '2022-10-01'
WHERE Nome = 'Eduardo Lopes';

/*
f. Liste todos os pacientes que foram diagnosticados com a "Nova doen�a" em
janeiro de 2023.
*/
SELECT *
FROM Pacientes
WHERE Condicao = 'Nova doen�a' AND MONTH(DataDiagnostico) = 1 AND YEAR(DataDiagnostico) = 2023;
/*
g. Altere 2 pacientes com �Nova doen�a� para Bronquite
*/

UPDATE TOP(2) Pacientes
SET Condicao = 'Bronquite'
WHERE Condicao = 'Nova doen�a';

SELECT * FROM Pacientes;

/*
h. (Assumindo que a "Nova doen�a" pode levar a "Bronquite" em alguns casos)
Identifique todos os pacientes que tiveram a "Nova doen�a" e,
posteriormente, desenvolveram "Bronquite".
*/
SELECT p1.Nome, p1.DataDiagnostico AS DataDiagn�stico_NovaDoen�a, p2.DataDiagnostico AS DataDiagn�stico_Bronquite
FROM Pacientes p1
INNER JOIN Pacientes p2 ON p1.Nome = p2.Nome
WHERE p1.Condicao = 'Nova doen�a'
  AND p2.Condicao = 'Bronquite'
  AND p1.DataDiagnostico < p2.DataDiagnostico;
/*
i. Desative o versionamento do sistema da tabela Pacientes e verifique o que
acontece com a tabela PacientesHistorico.
*/
/*
j. "Alex Costa" argumenta que foi diagnosticado com "Bronquite" no passado.
Use a tabela temporal para verificar a validade dessa afirma��o.
*/

SELECT Nome, Condicao, DataDiagnostico, DataFinaliza��o
FROM PacientesHistorico
WHERE Nome = 'Alex Costa';

/*
k. O hospital deseja saber quantos pacientes foram diagnosticados com a
"Nova doen�a" nos �ltimos 6 meses.
*/
-- Contar pacientes diagnosticados com a "Nova doen�a" nos �ltimos 6 meses
DECLARE @DataAtual DATE = GETDATE();
DECLARE @DataSeisMesesAtras DATE = DATEADD(MONTH, -6, @DataAtual);

SELECT COUNT(*) AS TotalPacientesNovaDoencaNosUltimos6Meses
FROM Pacientes
WHERE Condicao = 'Nova doen�a' AND DataDiagnostico >= @DataSeisMesesAtras;

