USE [Biblioteca]
GO
CREATE LOGIN [User1] WITH PASSWORD=N'user@123', DEFAULT_DATABASE=[Biblioteca], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
use [Biblioteca];
GO
USE [Biblioteca]
GO
CREATE USER [User1] FOR LOGIN [User1]
GO

GRANT SELECT ON [Categoria] TO User1;
GRANT SELECT ON [Autor] TO User1;
GRANT SELECT ON [Livro] TO User1;
GRANT SELECT ON [LivroAutor] TO User1;



USE [Biblioteca]
GO
CREATE LOGIN [User2] WITH PASSWORD=N'user@123', DEFAULT_DATABASE=[Biblioteca], CHECK_EXPIRATION=OFF, CHECK_POLICY=ON
GO
use [Biblioteca];
GO
USE [Biblioteca]
GO
CREATE USER [User2] FOR LOGIN [User2]
GO


-- Conceder permissões para o usuário criar, ler, atualizar e excluir na tabela "Livro"
GRANT INSERT, SELECT, UPDATE, DELETE ON [Livro] TO [User2];

-- Conceder permissões para o usuário criar, ler, atualizar e excluir na tabela "Autor"
GRANT INSERT, SELECT, UPDATE, DELETE ON [Autor] TO [User2];

-- Conceder permissões para o usuário criar, ler, atualizar e excluir na tabela "Categoria"
GRANT INSERT, SELECT, UPDATE, DELETE ON [Categoria] TO [User2];
