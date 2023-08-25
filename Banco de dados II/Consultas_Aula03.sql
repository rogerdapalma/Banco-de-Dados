DECLARE @NOME_AUTOR VARCHAR(100);
SELECT @NOME_AUTOR;

SET @NOME_AUTOR = 'Roger da Palma';
SELECT @NOME_AUTOR AS 'Nome do autor';
-- ATRIBUINDO UM VALOR A UMA VARIAVEL ATRAVES DO SELECT
DECLARE @TITULO_LIVRO VARCHAR(100);
SELECT @TITULO_LIVRO = Biblioteca.dbo.Livro.titulo
FROM Biblioteca.dbo.Livro
WHERE Livro.isbn = '9788577343348';
SELECT @TITULO_LIVRO AS 'TITULO DO LIVRO';

SELECT * FROM Livro;

-- CALCULANDO A IDADE DO LIVRO
-- DECLARAÇÃO DE VARIAVEIS
DECLARE @ANO_PUBLICACAO INT,
		@ANO_ATUAL INT,
		@NOME VARCHAR(100);
SET @ANO_ATUAL = 2023;
-- ATRIBUIR VALOR POR UM SELECT
SELECT @ANO_PUBLICACAO = LIVRO.ano,
	   @NOME = Livro.titulo
FROM Livro
WHERE Livro.isbn = '9788577343348';
-- EXIBIR AS INFORMAÇÕES
SELECT @NOME AS 'TITULO LIVRO',
@ANO_ATUAL-@ANO_PUBLICACAO AS 'IDADE LIVRO';

SELECT * FROM Livro;
-- CONVERSAO DE DADOS 
--CAST (expressão AS novo_tipo_dados)
--CONVERT (novo_tipo_dados, expressão, estilo)
-- CAST
SELECT 'O livro ' + titulo + ' é do ano ' +
CAST(ano AS VARCHAR(10)) AS Ano
FROM Livro
WHERE isbn = '9788577343348';

--CONVERT
SELECT 'O livro ' + titulo + ' é do ano ' +
CONVERT(VARCHAR(10), ano) AS Ano
FROM Livro
WHERE isbn = '9788577343348';

--ADICIONAR DATA DE NASCIMENTO 
ALTER TABLE autor
ADD DataNascimento DATE;
-- ATUALIZAR DATA
update autor
set autor.DataNascimento = '1994/02/12'
where autor.id = 1;

update autor
set autor.DataNascimento = '1993/04/24'
where autor.id = 2;

update autor
set autor.DataNascimento = '1981/11/13'
where autor.id = 3;

update autor
set autor.DataNascimento = '1961/10/31'
where autor.id = 4;

update autor
set autor.DataNascimento = '1992/05/05'
where autor.id = 5;

update autor
set autor.DataNascimento = '2000/05/18'
where autor.id = 6;

SELECT * FROM Autor;

SELECT 'A data da venda é : ' +
CONVERT(VARCHAR(50), autor.DataNascimento)
FROM Autor
WHERE Autor.id = 3
SELECT 'A data da venda é : ' +
-- conversão de dados, mudando para data br
CONVERT(VARCHAR(50), autor.DataNascimento ,103) 
FROM Autor
WHERE Autor.id = 3

--SE NAO HOUVER AUTOR COM NOME: JUCA DA SILVA CADASTADOS
IF NOT EXISTS (SELECT * FROM Autor WHERE nome = 'Juca da Silva')
	BEGIN
	-- INSERIR UM NOVO AUTOR COM ESSE NOME
		INSERT INTO Autor VALUES ('Juca da Silva','Brasil','1962/07/18');
	END;

SELECT * FROM Autor;

IF EXISTS (SELECT * FROM Autor WHERE nome = 'Juca da Silva')
	BEGIN
		PRINT 'AUTOR JA CADASTRADO'
	END;
	ELSE
	BEGIN
	-- INSERIR UM NOVO AUTOR COM ESSE NOME
		INSERT INTO Autor VALUES ('Juca da Silva','Brasil','1962/07/18');
		PRINT 'CADASTRADO COM SUCESSO'
	END;
/*
IF condição
	BEGIN
		Bloco de código
	END;

*/
SELECT * FROM Autor;

/*
WHILE condição
	BEGIN
		Bloco de códigos
	END;

*/

DECLARE @VALOR INT
SET @VALOR = 0

WHILE @VALOR<=10
	BEGIN
		PRINT'NUMERO:' + CAST(@VALOR AS VARCHAR(2))
		SET @VALOR=@VALOR+1
	END;

-- ALTERAR TODAS AS DATAS DE NASCIMENTO DE TODOS OS AUTORES USANDO LAÇO WHILE
DECLARE @Counter INT
DECLARE @MaxCounter INT

-- Defina o valor inicial do contador
SET @Counter = 1

-- Obtenha o número máximo de registros na tabela de autores
SELECT @MaxCounter = COUNT(*) FROM Autor

-- Inicie o loop WHILE
WHILE @Counter <= @MaxCounter
BEGIN
    -- Atualize a tabela de autores definindo a data de nascimento como NULL
    UPDATE Autor
    SET DataNascimento = NULL
    WHERE Autor.id = @Counter
    
    -- Incrementar o contador
    SET @Counter = @Counter + 1
END
		
		
