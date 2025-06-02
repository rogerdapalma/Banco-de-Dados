-- Seleciona os bancos existentes
SELECT name, database_id, create_date
FROM sys.databases;

-- Cria o banco de dados
CREATE DATABASE editora_db;
GO

-- Usa o banco de dados
USE editora_db;
GO

-- Criação das tabelas
CREATE TABLE Autor (
    idAutor INT NOT NULL PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE Editora (
    idEditora INT NOT NULL PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

CREATE TABLE Genero (
    idGenero INT NOT NULL PRIMARY KEY,
    descricao VARCHAR(45) NOT NULL
);

CREATE TABLE Livro (
    idLivro INT NOT NULL PRIMARY KEY,
    titulo VARCHAR(45) NOT NULL,
    preco DECIMAL(10,2) NULL,
    idEditora INT NOT NULL,
    idGenero INT NOT NULL,
    CONSTRAINT fk_Livro_Editora FOREIGN KEY (idEditora) REFERENCES Editora(idEditora),
    CONSTRAINT fk_Livro_Genero FOREIGN KEY (idGenero) REFERENCES Genero(idGenero)
);

CREATE TABLE Livro_Autor (
    idAutor INT NOT NULL,
    idLivro INT NOT NULL,
    PRIMARY KEY (idAutor, idLivro),
    CONSTRAINT fk_LivroAutor_Autor FOREIGN KEY (idAutor) REFERENCES Autor(idAutor),
    CONSTRAINT fk_LivroAutor_Livro FOREIGN KEY (idLivro) REFERENCES Livro(idLivro)
);

CREATE TABLE Ranking (
    idRanking INT NOT NULL PRIMARY KEY,
    dataInicial DATE NOT NULL,
    dataFinal DATE NOT NULL
);

CREATE TABLE Ranking_Semanal (
    idRanking INT NOT NULL,
    idLivro INT NOT NULL,
    posicao DECIMAL(10,2) NULL,
    quantidadeSemanas DECIMAL(10,2) NULL,
    semanasConsecutivas DECIMAL(10,2) NULL,
    posicaoSemanaAnterior DECIMAL(10,2) NULL,
    PRIMARY KEY (idRanking, idLivro),
    CONSTRAINT fk_RankingLivro_Ranking FOREIGN KEY (idRanking) REFERENCES Ranking(idRanking),
    CONSTRAINT fk_RankingLivro_Livro FOREIGN KEY (idLivro) REFERENCES Livro(idLivro)
);

-- Inserção de dados
INSERT INTO Genero VALUES
(1, 'Infantil'), (2, 'Ficção'), (3, 'Romance'),
(4, 'Auto-ajuda'), (5, 'Negócios'), (6, 'História');

INSERT INTO Editora VALUES
(1, 'Ática'), (2, 'Makron Books'), (3, 'Rocco'), (4, 'Scipione'), (5, 'Sagra Luzato');

INSERT INTO Autor VALUES
(1, 'Pedro'), (2, 'Marcos'), (3, 'Felipe'),
(4, 'Ana'), (5, 'Maria'), (6, 'Francisco'), (7, 'Lucas');

INSERT INTO Livro VALUES
(1, 'A', 25.30, 1, 1), (2, 'B', 32.45, 1, 4), (3, 'C', 122.00, 4, 2),
(4, 'D', 100.99, 4, 3), (5, 'E', 16.16, 1, 5), (6, 'F', 4.56, 3, 1),
(7, 'G', 85.20, 2, 5), (8, 'H', 89.90, 5, 5), (9, 'I', 63.36, 2, 2),
(10, 'J', 41.40, 3, 3), (11, 'K', 200.30, 4, 6), (12, 'L', 99.99, 2, 4);

INSERT INTO Livro_Autor VALUES
(1, 1), (6, 1), (6, 2), (5, 3), (1, 3), (4, 3), (4, 4), (1, 5), (5, 6),
(3, 6), (3, 7), (2, 8), (6, 9), (6, 10), (1, 10), (2, 11), (2, 12);

INSERT INTO Ranking VALUES
(1, '2003-08-17', '2003-08-23'),
(2, '2003-08-24', '2003-08-30'),
(3, '2003-08-31', '2003-09-06'),
(4, '2003-09-07', '2003-09-13');

INSERT INTO Ranking_Semanal VALUES
(1,1,4,6,3,3), (2,1,5,7,3,4), (3,2,1,1,1,NULL),
(4,2,1,2,2,1), (1,3,2,2,2,NULL), (2,3,2,3,3,2),
(3,3,8,4,4,2), (4,3,10,5,5,8), (1,4,1,50,43,1),
(2,5,1,1,1,NULL), (3,5,2,2,2,1), (4,5,9,3,3,2),
(4,6,8,1,1,NULL), (3,7,5,1,1,NULL), (4,7,5,2,2,5),
(1,8,3,13,12,6), (2,8,3,14,13,3), (3,8,3,15,14,3),
(4,8,4,16,15,3), (2,9,7,1,1,NULL), (3,9,7,2,2,7),
(1,10,8,4,4,10), (2,10,9,5,5,8), (3,11,9,1,1,NULL),
(1,12,6,3,2,6);

-- Consultas
-- i. Todos os autores
SELECT * FROM Autor;

-- ii. Apenas os nomes dos autores
SELECT nome FROM Autor;

-- iii. Nome e ID dos autores
SELECT nome, idAutor FROM Autor;

-- iv. Nome dos autores na tabela Livro_Autor (sem duplicidade) "DISTINCT"
SELECT DISTINCT A.nome
FROM Autor A
JOIN Livro_Autor LA ON A.idAutor = LA.idAutor;

-- v. Autores em ordem alfabética "ORDER BY"
SELECT DISTINCT A.nome
FROM Autor A
JOIN Livro_Autor LA ON A.idAutor = LA.idAutor
ORDER BY A.nome;

-- vi. Títulos dos livros da editora Rocco ou Scipione "WHERE"
SELECT L.titulo, E.nome
FROM Livro L
JOIN Editora E ON L.idEditora = E.idEditora
WHERE E.nome IN ('Rocco', 'Scipione');

-- vii. Autores que começam com 'M' "LIKE "INICIAL% ORDER BY""
SELECT nome FROM Autor WHERE nome LIKE 'M%' ORDER BY nome;

-- viii. Autores que começam com 'L'
SELECT nome FROM Autor WHERE nome LIKE 'L%' ORDER BY nome;

-- ix. Autores que NÃO começam com 'L'
SELECT nome FROM Autor WHERE nome NOT LIKE 'L%' ORDER BY nome;

-- x. Autores que NÃO começam com 'M'
SELECT nome FROM Autor WHERE nome NOT LIKE 'M%' ORDER BY nome;

-- xi. Livros das editoras 1 ou 5
SELECT L.titulo, E.nome
FROM Livro L
JOIN Editora E ON L.idEditora = E.idEditora
WHERE E.idEditora IN (1,5);


-- xii. Livros infantis das editoras 1 ou 5 "AS [CODIGO]"
SELECT L.titulo, G.descricao, L.idEditora AS [Código Editora], E.nome AS Editora
FROM Livro L
JOIN Genero G ON L.idGenero = G.idGenero
JOIN Editora E ON L.idEditora = E.idEditora
WHERE G.descricao = 'Infantil' AND L.idEditora IN (1, 5);

-- xiii. Código, título e preço dos livros
SELECT idLivro, titulo, preco FROM Livro;

-- xiv. Autores em ordem alfabética reversa "ORDER BY atributo DESC"
SELECT * FROM Autor ORDER BY nome DESC;

-- xv. Livros do mais caro ao mais barato "ORDER BY atributo DESC"
SELECT * FROM Livro ORDER BY preco DESC;

-- xvi. Livros do mais barato ao mais caro "ORDER BY atributo ASC"
SELECT * FROM Livro ORDER BY preco ASC;

-- xvii. Livros de auto-ajuda por preço crescente
SELECT L.titulo, L.preco
FROM Livro L
JOIN Genero G ON L.idGenero = G.idGenero
WHERE G.descricao = 'Auto-ajuda'
ORDER BY L.preco ASC;

-- xviii. Total de autores cadastrados "COUNT(*) AS"
SELECT COUNT(*) AS TotalAutores FROM Autor;

-- xix. Livro mais barato e mais caro da editora 1 "MAX(atributo) AS apelido, MIN()(atributo) AS apelido"
SELECT MAX(preco) AS LivroMaisCaro, MIN(preco) AS LivroMaisBarato
FROM Livro WHERE idEditora = 1;

-- xx. Títulos e preços dos livros mais caro e mais barato da editora 1
SELECT titulo, preco FROM Livro
WHERE preco = (SELECT MAX(preco) FROM Livro WHERE idEditora = 1)
   OR preco = (SELECT MIN(preco) FROM Livro WHERE idEditora = 1)
   AND idEditora = 1;

-- xxi. Média de preços dos livros da editora 2
SELECT ROUND(AVG(preco), 2) AS PrecoMedio FROM Livro WHERE idEditora = 2;

-- View de média de preço
CREATE VIEW MediaPreco AS
SELECT ROUND(AVG(preco), 2) AS PrecoMedio FROM Livro WHERE idEditora = 2;

-- xxii. Título do livro com nome da editora e gênero
SELECT L.titulo, E.nome AS Editora, G.descricao AS Genero
FROM Livro L
JOIN Editora E ON L.idEditora = E.idEditora
JOIN Genero G ON L.idGenero = G.idGenero;

-- xxiii. Título do livro e nome do autor
SELECT L.titulo, A.nome
FROM Livro L
JOIN Livro_Autor LA ON L.idLivro = LA.idLivro
JOIN Autor A ON LA.idAutor = A.idAutor;

-- xxiv. Livro com mais semanas consecutivas em 1º lugar
SELECT TOP 1 L.titulo, RS.semanasConsecutivas
FROM Livro L
JOIN Ranking_Semanal RS ON L.idLivro = RS.idLivro
WHERE RS.posicao = 1
ORDER BY RS.semanasConsecutivas DESC;

-- xxv. Autores com livros no ranking da semana de 24/08/2003 a 30/08/2003
SELECT DISTINCT A.nome AS Autor
FROM Autor A
JOIN Livro_Autor LA ON A.idAutor = LA.idAutor
JOIN Livro L ON LA.idLivro = L.idLivro
JOIN Ranking_Semanal RS ON RS.idLivro = L.idLivro
JOIN Ranking R ON RS.idRanking = R.idRanking
WHERE R.dataInicial = '2003-08-24' AND R.dataFinal = '2003-08-30';
