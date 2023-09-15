CREATE PROCEDURE teste 
AS 
SELECT 'Herysson Figueiredo' AS Nome 

EXEC teste;
GO

CREATE PROCEDURE P_TituloAno
AS
SELECT titulo,ano
FROM Livro

EXEC P_TituloAno;
GO

CREATE PROCEDURE Autor_Livro
AS 
SELECT 
	Autor.id as AutorID,
	Autor.nome AS NomeAutor,
	Autor.nacionalidade as Nascionalidade,
	Livro.isbn as ISBN,
	Livro.titulo AS TituloLivro,
	Livro.ano AS AnoPublicado
FROM Autor
JOIN LivroAutor ON AUTOR.id = LivroAutor.fk_autor
JOIN Livro ON LivroAutor.fk_livro = LIVRO.isbn

EXEC Autor_Livro;

-- Visualizar oque tem no procedure

EXEC sp_helptext nome_procedimento

--EX
EXEC sp_helptext P_LivroValor;


GO
CREATE PROCEDURE P_LivroISBN
WITH ENCRYPTION
AS 
SELECT titulo,isbn
FROM Livro

EXEC P_LivroISBN;

EXEC sp_helptext P_LivroISBN;
GO

ALTER PROCEDURE teste (@PAR1 AS INT)
AS
SELECT @PAR1

EXEC teste 22;

GO
CREATE PROCEDURE teste2 (@PAR1 AS INT, @PAR2 AS INT)
AS
SELECT @PAR1 - @PAR2 

EXEC teste2 22,22;

GO 
CREATE PROCEDURE P_TituloAno1
(@ANO INT)
AS
SELECT TITULO AS 'LIVRO',ANO AS 'ANO PUBLICAÇÃO'
FROM Livro
WHERE ano = @ANO

EXEC P_TituloAno1 2000;
GO
CREATE PROCEDURE teste3(@PAR1 AS INT, @PAR2 AS VARCHAR(20))
AS
BEGIN
SELECT @PAR1
SELECT @PAR2
END

EXEC teste3 22, 'Vermelho';

EXEC teste3 @PAR1 = 25, @PAR2 = 'Laranja' ;

GO
CREATE PROCEDURE teste5 (@ANO AS INT , @TITULO AS VARCHAR (100))
AS

SELECT titulo AS 'LIVRO', ano AS 'Ano Publicacao'
FROM LIVRO
WHERE ano>@ANO AND titulo LIKE '%'+@TITULO+'%'

EXEC teste5 @ANO = 1980, @TITULO = Potter;

GO
CREATE PROCEDURE P_Insere_Editora (@nome varchar (50))
AS
INSERT INTO Editora(nome)
VALUES (@NOME)

EXEC P_Insere_Editora @NOME = 'Editora Exemplo';
SELECT * FROM Editora

GO
CREATE PROCEDURE P_Teste_Valor_Padrao(
@PARAM1 INT, @PARAM2 VARCHAR(20) = 'valor padrao')
AS
SELECT 'valor do parametro 1 : ' + CAST (@PARAM1 AS VARCHAR)
SELECT 'valor do parametro 2 : ' + @PARAM2

EXEC P_Teste_Valor_Padrao 30 ;

EXEC P_Teste_Valor_Padrao @PARAM1 = 40, @PARAM2 = 'Valor modificado';
GO
CREATE PROCEDURE Teste6 (@PAR1 AS INT OUTPUT)
AS
SELECT @PAR1*2
RETURN

DECLARE @VALOR AS INT = 15 
EXEC Teste6 @VALOR OUTPUT;
PRINT @VALOR;
