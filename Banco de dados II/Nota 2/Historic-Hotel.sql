CREATE DATABASE AtividadeBD2

USE AtividadeBD2;

CREATE TABLE Hoteis
(
    HotelID INT PRIMARY KEY,
    Nome NVARCHAR(255),
    Localizacao NVARCHAR(255),
    Estrelas INT,
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN,
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime)
)
WITH (SYSTEM_VERSIONING = ON);

INSERT INTO Hoteis (HotelID, Nome, Localizacao, Estrelas)
VALUES
(201, 'Hotel Paradiso', 'São Paulo', 4),
(202, 'Hotel Sunlight', 'Rio de Janeiro', 5);

CREATE TABLE Quartos
(
    QuartoID INT PRIMARY KEY,
    HotelID INT,
    Tipo NVARCHAR(50),
    PrecoPorNoite DECIMAL(10, 2),
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN,
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime),
    FOREIGN KEY (HotelID) REFERENCES Hoteis(HotelID)
)
WITH (SYSTEM_VERSIONING = ON);

INSERT INTO Quartos (QuartoID, HotelID, Tipo, PrecoPorNoite)
VALUES
(301, 201, 'Individual', 150.00),
(302, 201, 'Duplo', 200.00),
(303, 202, 'Suíte', 500.00);


CREATE TABLE Reservas
(
    ReservaID INT PRIMARY KEY,
    QuartoID INT,
    Cliente NVARCHAR(100),
    DataInicio DATE,
    DataFinal DATE,
    SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN,
    SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN,
    PERIOD FOR SYSTEM_TIME (SysStartTime, SysEndTime),
    FOREIGN KEY (QuartoID) REFERENCES Quartos(QuartoID)
)
WITH (SYSTEM_VERSIONING = ON);

INSERT INTO Reservas (ReservaID, QuartoID, Cliente, DataInicio, DataFinal)
VALUES
(401, 301, 'Roberto Alves', '2023-03-01', '2023-03-05'),
(402, 302, 'Lívia Santos', '2023-03-03', '2023-03-04'),
(403, 303, 'Carlos Oliveira', '2023-03-02', '2023-03-03');

/*
a. Crie uma tabela temporal para manter o histórico de todas as relações
(tabelas).
*/
CREATE TABLE RelacoesHistorico
(
    RelacaoID INT IDENTITY(1,1) PRIMARY KEY,
    Tabela NVARCHAR(50),
    Operacao NVARCHAR(10),
    DataAlteracao DATETIME2,
    Usuario NVARCHAR(100)
);

/*
b. Adicione um novo hotel à base de dados.
*/

INSERT INTO Hoteis (HotelID, Nome, Localizacao, Estrelas)
VALUES (203, 'Hotel Beachfront', 'Florianópolis', 4);

-- Registrar a alteração na tabela de histórico
INSERT INTO RelacoesHistorico (Tabela, Operacao, DataAlteracao, Usuario)
VALUES ('Hoteis', 'INSERT', GETDATE(), 'SeuUsuario');

/*
c. Mude a classificação do 'Hotel Paradiso' para 5 estrelas e verifique o
histórico na tabela HoteisHistorico.
*/
UPDATE Hoteis
SET Estrelas = 5
WHERE Nome = 'Hotel Paradiso';

-- Registrar a alteração na tabela de histórico
INSERT INTO RelacoesHistorico (Tabela, Operacao, DataAlteracao, Usuario)
VALUES ('Hoteis', 'UPDATE', GETDATE(), 'SeuUsuario');

/*
d. Liste todas as reservas do 'Hotel Sunlight' com os nomes dos clientes e
datas.
*/
SELECT R.Cliente, R.DataInicio, R.DataFinal
FROM Reservas AS R
INNER JOIN Quartos AS Q ON R.QuartoID = Q.QuartoID
INNER JOIN Hoteis AS H ON Q.HotelID = H.HotelID
WHERE H.Nome = 'Hotel Sunlight';

/*
e. Encontre todos os quartos que ainda não foram reservados no 'Hotel
Paradiso'.
*/

/*
f. Calcule a receita total para o 'Hotel Paradiso' com base nas reservas e
preços dos quartos.
*/
SELECT SUM(Q.PrecoPorNoite * DATEDIFF(DAY, R.DataInicio, R.DataFinal)) AS ReceitaTotal
FROM Reservas AS R
INNER JOIN Quartos AS Q ON R.QuartoID = Q.QuartoID
WHERE Q.HotelID = (SELECT HotelID FROM Hoteis WHERE Nome = 'Hotel Paradiso');

/*
g. "Lívia Santos" alega que tinha uma reserva no 'Hotel Sunlight' que começava
em '2023-03-01'. Verifique a veracidade de sua afirmação.
*/

/*
h. Verifique quantos quartos do tipo 'Suíte' foram reservados nos últimos 6
meses.
*/
SELECT COUNT(*) AS QuartosSuiteReservados
FROM Reservas AS R
INNER JOIN Quartos AS Q ON R.QuartoID = Q.QuartoID
WHERE Q.Tipo = 'Suíte'
  AND R.DataInicio >= DATEADD(MONTH, -6, GETDATE());
