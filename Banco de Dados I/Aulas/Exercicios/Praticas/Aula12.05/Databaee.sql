-- 1. Criar banco de dados
CREATE DATABASE IF NOT EXISTS universidade;
USE universidade;

-- 2. Criar tabela de cursos
CREATE TABLE curso (
    cursoId INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- 3. Criar tabela de alunos
CREATE TABLE aluno (
    alunoId INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    curso INT,
    FOREIGN KEY (curso) REFERENCES curso(cursoId)
);

-- 4. Inserir cursos
INSERT INTO curso (nome) VALUES
('Ciência da Computação'),
('Engenharia'),
('Administração');

-- 5. Inserir alunos
INSERT INTO aluno (nome, curso) VALUES
('Ana', 1),
('Bruno', 1),
('Carlos', 2),
('Daniela', 3),
('Eduardo', NULL); -- Aluno sem curso

-- 6. Consultas baseadas na imagem

-- Projeção (seleção de colunas)
SELECT alunoId FROM aluno;
SELECT nome, curso FROM aluno;

-- Seleção com condição
SELECT nome FROM aluno WHERE curso = 1;
SELECT nome, alunoId FROM aluno WHERE curso IS NULL;
SELECT nome, alunoId FROM aluno WHERE curso = 1 AND curso = 3;

-- Junção (JOIN): listar todos os alunos e os nomes de seus cursos
SELECT aluno.nome, curso.nome
FROM aluno
JOIN curso ON curso.cursoId = aluno.curso;

-- Alunos do curso Ciência da Computação
SELECT aluno.nome
FROM aluno
JOIN curso ON curso.cursoId = aluno.curso
WHERE curso.nome = 'Ciência da Computação' and curso.cursoId = aluno.curso ;

-- quanto alunos sao do curso de ciencia da computação
SELECT COUNT(*)
FROM aluno , curso
WHERE curso.nome = 'Ciência da Computação' and curso.cursoId = aluno.curso;

SELECT aluno.nome
FROM aluno
JOIN curso ON curso.cursoId = aluno.curso
WHERE curso.nome = 'Ciência da Computação';


-- Criação do banco de dados
-- CREATE DATABASE IF NOT EXISTS exemplo_relacional;
-- USE exemplo_relacional;

-- Tabela de usuários
CREATE TABLE Usuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    sexto VARCHAR(10),
    dataNascimento DATE
);

-- Tabela de cidades
CREATE TABLE Cidade (
    idCidade INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Tabela de aeroportos
CREATE TABLE Aeroporto (
    idAeroporto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    idCidade INT,
    FOREIGN KEY (idCidade) REFERENCES Cidade(idCidade)
);

-- Inserindo dados em Usuario
INSERT INTO Usuario (nome, email, sexto, dataNascimento) VALUES
('João', 'joao@email.com', 'Masculino', '1970-01-10'),
('Maria', 'maria@email.com', 'Feminino', '1980-05-20'),
('Carlos', 'carlos@email.com', 'Masculino', '1990-08-15'),
('Ana', 'ana@email.com', 'Feminino', '1973-03-09');

-- Inserindo dados em Cidade
INSERT INTO Cidade (nome) VALUES
('São Paulo'),
('Rio de Janeiro');

-- Inserindo dados em Aeroporto
INSERT INTO Aeroporto (nome, tipo, idCidade) VALUES
('Guarulhos', 'Internacional', 1),
('Congonhas', 'Nacional', 1),
('Galeão', 'Internacional', 2);

-- PROJEÇÃO (projetar apenas algumas colunas)
SELECT Usuario.nome, Usuario.email
FROM Usuario;

-- SELEÇÃO (com filtro)
SELECT Usuario.nome, Usuario.email
FROM Usuario
WHERE Usuario.sexto = 'Masculino';

-- UNIÃO (OR)
SELECT Usuario.nome, Usuario.email
FROM Usuario
WHERE Usuario.sexto = 'Masculino' OR Usuario.dataNascimento < '1974-03-10';

-- INTERSEÇÃO (AND)
SELECT Usuario.nome, Usuario.email
FROM Usuario
WHERE Usuario.sexto = 'Masculino' AND Usuario.dataNascimento < '1974-03-10';

-- PRODUTO CARTESIANO com condição
SELECT Aeroporto.nome, Aeroporto.tipo
FROM Cidade, Aeroporto
WHERE Cidade.nome = 'São Paulo'
  AND Cidade.idCidade = Aeroporto.idCidade
  AND Aeroporto.tipo = 'Internacional';

-- JUNÇÃO usando INNER JOIN
SELECT Aeroporto.nome, Aeroporto.tipo
FROM Aeroporto
INNER JOIN Cidade ON Cidade.idCidade = Aeroporto.idCidade
WHERE Cidade.nome = 'São Paulo'
  AND Aeroporto.tipo = 'Internacional';


-- 3 exercicios

-- listar todos os cursos cadastrados e sua relação com istituição(id)
SELECT curso.nome, curso.Instituicao_idInstituicao
FROM curso;

-- listar todos os cursos e os nomes respectivios de suas instituições
SELECT curso.nome, instituicao.nome
FROM curso, instituicao
where curso.Instituicao_idInstituicao = Instituicao.idInstituicao

-- mostrar todos os usuarios de cursos que tenha bio no nome e seus respectivos cursos
SELECT Usuario.nome, curso.nome
FROM Usuario,curso,Usuario_has_curso
WHERE curso.nome like 'bio' and
      curso.idCurso = Usuario_has_curso.curso_idCurso and
      usuario.idUsuario = Usuario_has_curso.usuario_idUsuarios;

-- Listar os avaliadores

SELECT Usuario.*
FROM Usuario, avaliacao
WHERE Usuario.idUsuario = avaliacao.usuario_idUsuario_avaliadorResponsavel or
      Usuario.idUsuario = avaliacao.usuario_idUsuario_suplente;

-- listar quem nao fez parecer
SELECT Usuario.nome
FROM Usuario, avaliacao
Where (avaliacao.parecerAvalaiadorResponsavel = NULL or avaliacao.parecerAvalaiadorResponsavel = NULL)
       and
      (Usuario.idUsuario = avaliacao.usuario_idUsuario_avaliadorResponsavel or
      Usuario.idUsuario = avaliacao.usuario_idUsuario_suplente);