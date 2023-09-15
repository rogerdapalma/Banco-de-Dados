-- Crie um trigger que impeça a inserção de livros com o mesmo Titulo na tabela Livro.USE Biblioteca;
IF OBJECT_ID('PreventDuplicarTitle','TR') IS NOT NULL   -- PASSANDO O NOME DO TRIGGER E INFORMANDO QUE É UM TRIGGER
	BEGIN
		DROP TRIGGER PreventDuplicarTitle;
	END

-- Criar o Trigger utilizando After
GO
CREATE TRIGGER PreventDuplicarTitle
ON livro
AFTER INSERT
AS
BEGIN
	-- verificar se há titulos duplicados
	-- como o trigger é um after o titulo esta presente 
	-- 'na memoria'
	IF EXISTS (SELECT TITULO 
			   FROM LIVRO 
			   GROUP BY TITULO 
			   HAVING COUNT(*) > 1
	) 
	BEGIN
		-- se houver titulos dublicados, desfazer a inserção
		ROLLBACK TRANSACTION;
		RAISERROR('Não permitido titulos duplicados', 16, 1);
		PRINT('Não permitido titulos duplicados');
	END
END;
GO
-- TESTANDO RESPOSTA RESPOSTA DO EXERCICIO 1
GO
SELECT * FROM LIVRO;
INSERT INTO Livro VALUES('12345','Harry Potter e A Pedra Filosofal','2000',1,1);
GO

-- exercicio 4

/*
Crie um trigger que exclua automaticamente registros da tabela LivroAutor quando o
livro correspondente é excluído da tabela Livro.*/GOIF OBJECT_ID('TriggerExcluiLivro','TR') IS NOT NULLBEGIN	DROP TRIGGER TriggerExcluiLivro;ENDGO-- criando o trigger CREATE TRIGGER TriggerExcluiLivroON LIVRO INSTEAD OF DELETE ASBEGIN	-- excluir os registros do livro autor associados ao livro a ser excluido	DELETE FROM LivroAutor	WHERE fk_livro IN (SELECT isbn FROM deleted)	-- excluir o livro tabela	DELETE FROM Livro	WHERE isbn IN (SELECT isbn FROM deleted)END
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
ORDER BY AUTOR.nome, LIVRO.ano;

-- Testando o trigger
DELETE FROM LIVRO WHERE Livro.titulo = 'Harry Potter e A Pedra Filosofal';


