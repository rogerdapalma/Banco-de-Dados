USE Biblioteca;

--1. Crie uma procedure que permita inserir uma nova categoria na tabela "Categoria".
GO
CREATE PROCEDURE InserirCategoria
  @tipo_categoria VARCHAR(50)
AS
BEGIN
  INSERT INTO Categoria (tipo_categoria)
  VALUES (@tipo_categoria);
END;

EXEC InserirCategoria @tipo_categoria = 'Nova Categoria';
--2. Crie uma procedure para atualizar os detalhes de um livro (por exemplo, título, ano)
--pelo ISBN.

GO
CREATE PROCEDURE AtualizarDetalhesLivro
  @isbn VARCHAR(50),
  @novo_titulo VARCHAR(100),
  @novo_ano INT
AS
BEGIN
  UPDATE Livro
  SET titulo = @novo_titulo,
      ano = @novo_ano
  WHERE isbn = @isbn;
END;

EXEC AtualizarDetalhesLivro @isbn = '8532511015', @novo_titulo = 'Novo Título', @novo_ano = 2023;
--3. Desenvolva uma procedure para adicionar um novo autor à tabela "Autor".

GO
CREATE PROCEDURE InserirNovoAutor
  @nome VARCHAR(100),
  @nacionalidade VARCHAR(50) = NULL -- Pode ser nulo
AS
BEGIN
  INSERT INTO Autor (nome, nacionalidade)
  VALUES (@nome, @nacionalidade);
END;

EXEC InserirNovoAutor @nome = 'Novo Autor', @nacionalidade = 'Brasil';

--4. Implemente uma procedure para excluir um autor e remover sua associação com os
--livros na tabela "LivroAutor".

GO
CREATE PROCEDURE ExcluirAutorEAssociacaoLivros
  @autor_id INT
AS
BEGIN
  -- Excluir a associação do autor com os livros na tabela LivroAutor
  DELETE FROM LivroAutor
  WHERE fk_autor = @autor_id;

  -- Excluir o autor da tabela Autor
  DELETE FROM Autor
  WHERE id = @autor_id;
END;

EXEC ExcluirAutorEAssociacaoLivros @autor_id = 1;

--5. Crie uma procedure que receba o nome de uma categoria e retorne todos os livros
--dentro dessa categoria.

GO
CREATE PROCEDURE RecuperarLivrosPorCategoria
  @nome_categoria VARCHAR(50)
AS
BEGIN
  SELECT Livro.isbn, Livro.titulo, Livro.ano, Editora.nome AS editora, Autor.nome AS autor
  FROM Livro
  JOIN Categoria ON Livro.fk_categoria = Categoria.id
  JOIN Editora ON Livro.fk_editora = Editora.id
  JOIN LivroAutor ON Livro.isbn = LivroAutor.fk_livro
  JOIN Autor ON LivroAutor.fk_autor = Autor.id
  WHERE Categoria.tipo_categoria = @nome_categoria;
END;

-- Exemplo de Uso da Procedure para Recuperar Livros por Categoria
EXEC RecuperarLivrosPorCategoria @nome_categoria = 'Literatura Juvenil';

--6. Desenvolva uma procedure que receba o nome de um autor e retorne todos os livros
--escritos por esse autor.

GO
CREATE PROCEDURE RecuperarLivrosPorAutor
  @nome_autor VARCHAR(100)
AS
BEGIN
  SELECT Livro.isbn, Livro.titulo, Livro.ano, Editora.nome AS editora, Categoria.tipo_categoria AS categoria
  FROM Livro
  JOIN LivroAutor ON Livro.isbn = LivroAutor.fk_livro
  JOIN Autor ON LivroAutor.fk_autor = Autor.id
  JOIN Editora ON Livro.fk_editora = Editora.id
  JOIN Categoria ON Livro.fk_categoria = Categoria.id
  WHERE Autor.nome LIKE '%' + @nome_autor + '%';
END;

EXEC RecuperarLivrosPorAutor @nome_autor = 'J.K. Rowling';


--7. Crie uma procedure que liste os livros publicados em um ano específico.


GO
CREATE PROCEDURE ListarLivrosPorAno
  @ano_publicacao INT
AS
BEGIN
  SELECT isbn, titulo, Editora.nome AS editora, Categoria.tipo_categoria AS categoria
  FROM Livro
  JOIN Editora ON Livro.fk_editora = Editora.id
  JOIN Categoria ON Livro.fk_categoria = Categoria.id
  WHERE ano = @ano_publicacao;
END;

EXEC ListarLivrosPorAno @ano_publicacao = 2000;

--8. Implemente uma procedure para listar os livros publicados por uma editora
--específica.

GO
CREATE PROCEDURE ListarLivrosPorEditora
  @nome_editora VARCHAR(100)
AS
BEGIN
  SELECT Livro.isbn, Livro.titulo, Livro.ano, Categoria.tipo_categoria AS categoria, Autor.nome AS autor
  FROM Livro
  JOIN Editora ON Livro.fk_editora = Editora.id
  JOIN Categoria ON Livro.fk_categoria = Categoria.id
  JOIN LivroAutor ON Livro.isbn = LivroAutor.fk_livro
  JOIN Autor ON LivroAutor.fk_autor = Autor.id
  WHERE Editora.nome = @nome_editora;
END;

EXEC ListarLivrosPorEditora @nome_editora = 'Rocco';


--9. Desenvolva uma procedure que retorne uma lista de livros com ISBNs dentro de
--uma faixa específica.

GO
CREATE PROCEDURE ListarLivrosPorFaixaISBN
  @isbn_inicio VARCHAR(50),
  @isbn_fim VARCHAR(50)
AS
BEGIN
  SELECT isbn, titulo, ano, Editora.nome AS editora, Categoria.tipo_categoria AS categoria, Autor.nome AS autor
  FROM Livro
  JOIN Editora ON Livro.fk_editora = Editora.id
  JOIN Categoria ON Livro.fk_categoria = Categoria.id
  JOIN LivroAutor ON Livro.isbn = LivroAutor.fk_livro
  JOIN Autor ON LivroAutor.fk_autor = Autor.id
  WHERE isbn BETWEEN @isbn_inicio AND @isbn_fim;
END;

EXEC ListarLivrosPorFaixaISBN @isbn_inicio = '8532511015', @isbn_fim = '9788578270698';


--10. Crie uma procedure para contar o número de livros em cada categoria.
GO
CREATE PROCEDURE ContarLivrosPorCategoria
AS
BEGIN
  SELECT Categoria.tipo_categoria, COUNT(Livro.isbn) AS total_de_livros
  FROM Categoria
  LEFT JOIN Livro ON Categoria.id = Livro.fk_categoria
  GROUP BY Categoria.tipo_categoria;
END;

EXEC ContarLivrosPorCategoria;


--11. Implemente uma procedure para listar os livros por autores de uma nacionalidade
--específica.

GO
CREATE PROCEDURE ListarLivrosPorNacionalidadeAutor
  @nacionalidade_autor VARCHAR(50)
AS
BEGIN
  SELECT Livro.isbn, Livro.titulo, Autor.nome AS autor, Categoria.tipo_categoria AS categoria
  FROM Livro
  JOIN LivroAutor ON Livro.isbn = LivroAutor.fk_livro
  JOIN Autor ON LivroAutor.fk_autor = Autor.id
  JOIN Categoria ON Livro.fk_categoria = Categoria.id
  WHERE Autor.nacionalidade = @nacionalidade_autor;
END;

EXEC ListarLivrosPorNacionalidadeAutor @nacionalidade_autor = 'Brasil';

--12. Desenvolva uma procedure para adicionar uma nova editora à tabela "Editora".

GO
CREATE PROCEDURE InserirNovaEditora
  @nome_editora VARCHAR(100)
AS
BEGIN
  INSERT INTO Editora (nome)
  VALUES (@nome_editora);
END;

EXEC InserirNovaEditora @nome_editora = 'Nova Editora';

--13. Crie uma procedure para excluir uma editora e atualizar os livros associados a essa
--editora.

GO
CREATE PROCEDURE ExcluirEditoraEAtualizarLivros
  @id_editora INT
AS
BEGIN
  -- Atualiza os livros associados à editora para uma editora padrão (ou NULL)
  UPDATE Livro
  SET fk_editora = NULL -- ou atribuir a outra editora padrão
  WHERE fk_editora = @id_editora;

  -- Exclui a editora da tabela Editora
  DELETE FROM Editora
  WHERE id = @id_editora;
END;

EXEC ExcluirEditoraEAtualizarLivros @id_editora = 3; 

--14. Implemente uma procedure para listar autores juntamente com os títulos dos livros
--que eles escreveram.

GO
CREATE PROCEDURE ListarAutoresComTitulosLivros
AS
BEGIN
  SELECT Autor.nome AS autor, Livro.titulo AS titulo
  FROM Autor
  JOIN LivroAutor ON Autor.id = LivroAutor.fk_autor
  JOIN Livro ON LivroAutor.fk_livro = Livro.isbn;
END;

EXEC ListarAutoresComTitulosLivros;

--15. Crie uma procedure para calcular o ano médio de publicação de livros em uma
--categoria específica.

GO
CREATE PROCEDURE CalcularAnoMedioPorCategoria
  @categoria_nome VARCHAR(50)
AS
BEGIN
  DECLARE @ano_medio INT;

  SELECT @ano_medio = AVG(Livro.ano)
  FROM Livro
  JOIN Categoria ON Livro.fk_categoria = Categoria.id
  WHERE Categoria.tipo_categoria = @categoria_nome;

  SELECT @ano_medio AS ano_medio_publicacao;
END;

EXEC CalcularAnoMedioPorCategoria @categoria_nome = 'Romance'; 

--16. Desenvolva uma procedure para associar um autor a um livro na tabela "LivroAutor".

GO
CREATE PROCEDURE AssociarAutorAoLivro
  @isbn_livro VARCHAR(50),
  @id_autor INT
AS
BEGIN
  INSERT INTO LivroAutor (fk_livro, fk_autor)
  VALUES (@isbn_livro, @id_autor);
END;

EXEC AssociarAutorAoLivro @isbn_livro = '9788578270698', @id_autor = 2; 


--17. Implemente uma procedure para remover um autor da lista de autores de um livro.

GO
CREATE PROCEDURE RemoverAutorDeLivro
  @isbn_livro VARCHAR(50),
  @id_autor INT
AS
BEGIN
  DELETE FROM LivroAutor
  WHERE fk_livro = @isbn_livro AND fk_autor = @id_autor;
END;

EXEC RemoverAutorDeLivro @isbn_livro = '9788578270698', @id_autor = 2;

--18. Crie uma procedure para listar livros que têm mais de um autor.
/*
GO
CREATE PROCEDURE ListarLivrosComMaisDeUmAutor
AS
BEGIN
  SELECT Livro.isbn AS ISBN, Livro.titulo AS Titulo
  FROM Livro
  JOIN (
    SELECT fk_livro
    FROM LivroAutor
    GROUP BY fk_livro
    HAVING COUNT(fk_autor) > 1
  ) AS LivrosComMaisDeUmAutor ON Livro.isbn = LivrosComMaisDeUmAutor.fk_livro;
END;

EXEC ListarLivrosComMaisDeUmAutor; */

--19. Desenvolva uma procedure para listar livros que não têm autores associados na
--tabela "LivroAutor".

GO
CREATE PROCEDURE ListarLivrosSemAutores
AS
BEGIN
  SELECT Livro.isbn AS ISBN, Livro.titulo AS Titulo
  FROM Livro
  WHERE Livro.isbn NOT IN (SELECT fk_livro FROM LivroAutor);
END;

EXEC ListarLivrosSemAutores;

--20. Implemente uma procedure para listar livros que não têm uma editora especificada./*GOCREATE PROCEDURE ListarLivrosSemEditora
AS
BEGIN
  SELECT isbn AS ISBN, titulo AS Titulo
  FROM Livro
  WHERE fk_editora IS NULL OR fk_editora = 0;
END;

EXEC ListarLivrosSemEditora; */