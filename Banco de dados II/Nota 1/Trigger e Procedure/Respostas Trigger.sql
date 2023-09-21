USE Biblioteca;

--1. Crie um trigger que impeça a inserção de livros com o mesmo Titulo na tabela Livro.

GO
CREATE TRIGGER Livro_TitleCheck
ON Livro
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  -- Verifica se existem títulos duplicados na tabela Livro
  IF EXISTS (
    SELECT titulo
    FROM inserted
    GROUP BY titulo
    HAVING COUNT(*) > 1
  )
  BEGIN
    THROW 50000, 'Não é permitida a inserção de livros com o mesmo título.', 1;  --RESEERROR, ROOLBACK
  END;
END;

GO

--2. Crie um trigger que atualize automaticamente o ano de publicação na tabela Livro
--para o ano atual quando um novo livro é inserido.

GO
CREATE TRIGGER Livro_AtualizarAno
ON Livro
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  -- Atualizar o ano de publicação para o ano atual
  UPDATE Livro
  SET ano = YEAR(GETDATE())
  WHERE isbn IN (SELECT isbn FROM inserted);
END;
GO
--3. Crie um trigger que exclua automaticamente registros da tabela LivroAutor quando o
--livro correspondente é excluído da tabela Livro.

CREATE TRIGGER Livro_ExcluirLivroAutor
ON Livro
AFTER DELETE
AS
BEGIN
  SET NOCOUNT ON;

  -- Excluir registros da tabela LivroAutor relacionados ao livro excluído
  DELETE FROM LivroAutor
  WHERE fk_livro IN (SELECT isbn FROM deleted);
END;

--4. Crie um trigger que atualize o número total de livros em uma categoria específica na
--tabela Categoria sempre que um novo livro é inserido nessa categoria.

-- Adicionar coluna total_livros à tabela Categoria
ALTER TABLE Categoria
ADD total_livros INT DEFAULT 0;
GO
-- Criação do Trigger
CREATE TRIGGER Livro_AtualizarTotalCategoria
ON Livro
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  -- Atualizar o número total de livros na categoria específica
  DECLARE @CategoriaID INT;

  -- Obter o ID da categoria do livro inserido
  SELECT @CategoriaID = fk_categoria
  FROM inserted;

  -- Atualizar o número total de livros na categoria específica
  UPDATE Categoria
  SET total_livros = total_livros + 1
  WHERE id = @CategoriaID;
END;
GO

--5. Crie um trigger que restrinja a exclusão de categorias na tabela Categoria se houver
--livros associados a essa categoria.

GO

CREATE TRIGGER Categoria_RestringirExclusao
ON Categoria
INSTEAD OF DELETE
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @CategoriaID INT;

  -- Verificar se existem livros associados à categoria que está sendo excluída
  SELECT @CategoriaID = DELETED.id
  FROM DELETED
  INNER JOIN Livro ON Livro.fk_categoria = DELETED.id;

  -- Se houver livros associados, impedir a exclusão
  IF @CategoriaID IS NOT NULL
  BEGIN
	PRINT('Não é permitida a exclusão de categorias com livros associados. 16, 1');
    --RAISEERROR('Não é permitida a exclusão de categorias com livros associados.', 16, 1); -- não indentifiquei o erro
  END
  ELSE
  BEGIN
    -- Se não houver livros associados, permitir a exclusão da categoria
    DELETE FROM Categoria WHERE id = @CategoriaID;
  END
END;

--6. Crie um trigger que registre em uma tabela de auditoria sempre que um livro for
--atualizado na tabela Livro.

CREATE TABLE AuditoriaLivro (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  DataAlteracao DATETIME,
  ISBN VARCHAR(50),
  TituloAntigo VARCHAR(100),
  TituloNovo VARCHAR(100),
  AnoAntigo INT,
  AnoNovo INT,
  EditoraAntiga INT,
  EditoraNova INT,
  CategoriaAntiga INT,
  CategoriaNova INT
);


GO
CREATE TRIGGER Livro_Auditoria
ON Livro
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  -- Inserir um registro de auditoria para cada atualização na tabela Livro
  INSERT INTO AuditoriaLivro (DataAlteracao, ISBN, TituloAntigo, TituloNovo, AnoAntigo, AnoNovo, EditoraAntiga, EditoraNova, CategoriaAntiga, CategoriaNova)
  SELECT 
    GETDATE(),
    deleted.isbn,
    deleted.titulo,
    inserted.titulo,
    deleted.ano,
    inserted.ano,
    deleted.fk_editora,
    inserted.fk_editora,
    deleted.fk_categoria,
    inserted.fk_categoria
  FROM deleted
  INNER JOIN inserted ON deleted.isbn = inserted.isbn;
END;

--7. Crie um trigger que calcule automaticamente o número total de livros escritos por um
--autor na tabela Autor sempre que um novo livro é associado a esse autor na tabela
--LivroAutor.

-- Adicionar coluna total_livros à tabela Autor
ALTER TABLE Autor
ADD total_livros INT DEFAULT 0;

GO
CREATE TRIGGER Autor_CalcularTotalLivros
ON LivroAutor
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @AutorID INT;

  -- Obter o ID do autor do livro inserido
  SELECT @AutorID = fk_autor
  FROM inserted;

  -- Atualizar o número total de livros escritos pelo autor
  UPDATE Autor
  SET total_livros = (SELECT COUNT(*) FROM LivroAutor WHERE fk_autor = @AutorID)
  WHERE id = @AutorID;
END;

--8. Crie um trigger que restrinja a atualização do ISBN na tabela Livro para impedir que
--ele seja alterado.

GO
CREATE TRIGGER Livro_RestringirAtualizacaoISBN
ON Livro
INSTEAD OF UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  -- Verificar se houve tentativa de atualizar o ISBN
  IF UPDATE(isbn)
  BEGIN
	PRINT('ERRO');
   -- RAISEERROR('Não é permitida a atualização do ISBN na tabela Livro.', 16, 1); -- RAISEERROR NAO ESTA FUNCIONANDO
  END
  ELSE
  BEGIN
    -- Atualizar os demais campos, exceto o ISBN
    UPDATE Livro
    SET
      titulo = i.titulo,
      ano = i.ano,
      fk_editora = i.fk_editora,
      fk_categoria = i.fk_categoria
    FROM Livro AS l
    INNER JOIN inserted AS i ON l.isbn = i.isbn;
  END
END;

--9. Crie um trigger que limite o número de livros escritos por um autor na tabela
--LivroAutor para um máximo de 5 livros por autor.


GO
CREATE TRIGGER Autor_LimiteLivros
ON LivroAutor
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @AutorID INT;
  DECLARE @TotalLivros INT;

  -- Obter o ID do autor do livro inserido
  SELECT @AutorID = fk_autor
  FROM inserted;

  -- Contar o número total de livros escritos pelo autor
  SELECT @TotalLivros = COUNT(*)
  FROM LivroAutor
  WHERE fk_autor = @AutorID;

  -- Verificar se o autor excedeu o limite de 5 livros
  IF @TotalLivros > 5
  BEGIN
	PRINT('O autor já atingiu o limite de 5 livros nesta tabela., 16, 1');
    --RAISEERROR('O autor já atingiu o limite de 5 livros nesta tabela.', 16, 1);
    ROLLBACK TRANSACTION; -- Desfazer a inserção
  END
END;


--10. Crie um trigger que atualize automaticamente o campo total_livros na tabela
--Categoria sempre que um novo livro daquela categoria for inserido na tabela Livro.

GO
CREATE TRIGGER Categoria_AtualizarTotalLivros
ON Livro
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @CategoriaID INT;

  -- Obter o ID da categoria do livro inserido
  SELECT @CategoriaID = fk_categoria
  FROM inserted;

  -- Atualizar o campo total_livros na tabela Categoria
  UPDATE Categoria
  SET total_livros = total_livros + 1
  WHERE id = @CategoriaID;
END;

--11. Crie um trigger que, quando um livro for excluído da tabela Livro, verifique se há
--outros livros escritos pelo mesmo autor e, se não, remova automaticamente o autor
--da tabela Autor.


GO
CREATE TRIGGER Livro_ExcluirAutor
ON Livro
AFTER DELETE
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @AutorID INT;

  -- Obter o ID do autor do livro excluído
  SELECT @AutorID = fk_autor
  FROM LivroAutor
  WHERE fk_livro IN (SELECT isbn FROM deleted);

  -- Verificar se o autor não possui mais nenhum livro
  IF NOT EXISTS (SELECT 1 FROM LivroAutor WHERE fk_autor = @AutorID)
  BEGIN
    -- Se não houver mais livros do autor, remova o autor da tabela Autor
    DELETE FROM Autor WHERE id = @AutorID;
  END
END;

--12. Crie um trigger que limite o número de livros em uma categoria específica na tabela
--Categoria para um máximo de 100 livros e não permita mais inserções além desse
--limite.


GO
CREATE TRIGGER Categoria_LimiteLivros
ON Livro
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @CategoriaID INT;

  -- Obter o ID da categoria do livro inserido
  SELECT @CategoriaID = fk_categoria
  FROM inserted;

  -- Contar o número total de livros na categoria
  DECLARE @TotalLivros INT;
  SELECT @TotalLivros = COUNT(*)
  FROM Livro
  WHERE fk_categoria = @CategoriaID;

  -- Verificar se o limite de 100 livros foi atingido
  IF @TotalLivros > 100
  BEGIN
	PRINT('Limite de 100 livros nesta categoria foi atingido., 16, 1');
    --RAISEERROR('Limite de 100 livros nesta categoria foi atingido.', 16, 1);
    ROLLBACK TRANSACTION; -- Desfazer a inserção
  END
END;


--13. Crie um trigger que atualize automaticamente o campo nacionalidade na tabela
--Autor para 'Desconhecida' sempre que um autor for excluído da tabela Autor


GO
CREATE TRIGGER Autor_AtualizarNacionalidade
ON Autor
AFTER DELETE
AS
BEGIN
  SET NOCOUNT ON;

  -- Atualizar o campo nacionalidade para 'Desconhecida' para o autor excluído
  UPDATE Autor
  SET nacionalidade = 'Desconhecida'
  FROM deleted
  WHERE Autor.id = deleted.id;
END;

--14. Crie um trigger que registre automaticamente todas as exclusões de livros na tabela
--LogExclusaoLivros com detalhes sobre o livro excluído, data e hora.


GO
CREATE TRIGGER Livro_RegistrarExclusao
ON Livro
AFTER DELETE
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @LivroTitulo VARCHAR(100);
  DECLARE @LivroISBN VARCHAR(50);
  DECLARE @DataHoraExclusao DATETIME;

  -- Obter informações sobre o livro excluído
  SELECT @LivroTitulo = titulo, @LivroISBN = isbn, @DataHoraExclusao = GETDATE()
  FROM deleted;

  -- Registrar a exclusão na tabela LogExclusaoLivros
  INSERT INTO LogExclusaoLivros (livro_isbn, livro_titulo, data_hora_exclusao)
  VALUES (@LivroISBN, @LivroTitulo, @DataHoraExclusao);
END;

--15. Crie um trigger que, quando um livro for atualizado na tabela Livro, verifique se o
--novo título contém a palavra "proibido" e, se sim, reverta o título anterior.

CREATE TABLE Livro_TituloAnterior (
  livro_isbn VARCHAR(50) PRIMARY KEY,
  titulo_anterior VARCHAR(100)
);

GO
CREATE TRIGGER Livro_ReverterTitulo
ON Livro
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @LivroISBN VARCHAR(50);
  DECLARE @NovoTitulo VARCHAR(100);
  DECLARE @TituloAnterior VARCHAR(100);

  -- Obter informações sobre a atualização
  SELECT @LivroISBN = i.isbn, @NovoTitulo = i.titulo, @TituloAnterior = d.titulo
  FROM inserted i
  JOIN deleted d ON i.isbn = d.isbn;

  -- Verificar se o novo título contém a palavra "proibido"
  IF CHARINDEX('proibido', @NovoTitulo) > 0
  BEGIN
    -- Reverter para o título anterior
    UPDATE Livro
    SET titulo = @TituloAnterior
    WHERE isbn = @LivroISBN;

    -- Registrar o título anterior na tabela Livro_TituloAnterior
    INSERT INTO Livro_TituloAnterior (livro_isbn, titulo_anterior)
    VALUES (@LivroISBN, @NovoTitulo);
  END
END;


--16. Crie um trigger que, quando um livro for inserido na tabela Livro, verifique se a
--editora está na lista de editoras proibidas e, se estiver, impeça a inserção.

CREATE TABLE EditorasProibidas (
  id INT PRIMARY KEY IDENTITY(1,1),
  nome_editora VARCHAR(100) UNIQUE
);


GO
CREATE TRIGGER Livro_VerificarEditoraProibida
ON Livro
INSTEAD OF INSERT
AS
BEGIN
  SET NOCOUNT ON;

  -- Verificar se a editora está na lista de editoras proibidas
  IF EXISTS (
    SELECT 1
    FROM inserted i
    WHERE EXISTS (
      SELECT 1
      FROM EditorasProibidas ep
      WHERE ep.nome_editora = i.fk_editora
    )
  )
  BEGIN
	PRINT('Inserção de livro com editora proibida não é permitida., 16,1');
    --RAISEERROR('Inserção de livro com editora proibida não é permitida.', 16, 1);
  END
  ELSE
  BEGIN
    -- Se a editora não está na lista de editoras proibidas, realizar a inserção
    INSERT INTO Livro (isbn, titulo, ano, fk_editora, fk_categoria)
    SELECT isbn, titulo, ano, fk_editora, fk_categoria
    FROM inserted;
  END
END;

--17. Crie um trigger que atualize automaticamente o campo total_livros_escritos na
--tabela Autor sempre que um livro for associado a esse autor na tabela LivroAutor.

-- Adicionar a coluna total_livros_escritos à tabela Autor
ALTER TABLE Autor
ADD total_livros_escritos INT DEFAULT 0;



GO
CREATE TRIGGER Autor_AtualizarTotalLivrosEscritos
ON LivroAutor
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @AutorID INT;

  -- Obter o ID do autor a ser atualizado
  SELECT @AutorID = fk_autor
  FROM inserted;

  -- Atualizar o campo total_livros_escritos na tabela Autor
  UPDATE Autor
  SET total_livros_escritos = total_livros_escritos + 1
  WHERE id = @AutorID;
END;

--18. Crie um trigger que registre automaticamente todas as atualizações de livros na
--tabela LogAtualizacaoLivros com detalhes sobre o livro atualizado, data e hora.

CREATE TABLE LogAtualizacaoLivros (
  id INT PRIMARY KEY IDENTITY(1,1),
  livro_isbn VARCHAR(50),
  data_hora_atualizacao DATETIME,
  detalhes_atualizacao NVARCHAR(MAX)
);



GO
CREATE TRIGGER Livro_RegistrarAtualizacao
ON Livro
AFTER UPDATE
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @LivroISBN VARCHAR(50);
  DECLARE @DataHoraAtualizacao DATETIME;
  DECLARE @DetalhesAtualizacao NVARCHAR(MAX);

  -- Obter informações sobre a atualização
  SELECT @LivroISBN = i.isbn, @DataHoraAtualizacao = GETDATE(), @DetalhesAtualizacao = 'Detalhes da atualização aqui.'
  FROM inserted i
  JOIN deleted d ON i.isbn = d.isbn;

  -- Registrar a atualização na tabela LogAtualizacaoLivros
  INSERT INTO LogAtualizacaoLivros (livro_isbn, data_hora_atualizacao, detalhes_atualizacao)
  VALUES (@LivroISBN, @DataHoraAtualizacao, @DetalhesAtualizacao);
END;
