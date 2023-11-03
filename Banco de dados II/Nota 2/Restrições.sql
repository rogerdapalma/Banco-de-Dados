--BDescola

CREATE DATABASE UFNrogers

USE UFNrogers;

DROP DATABASE UFNrogers;

/*
a. Para professor:
i. o nome é um campo obrigatório;
ii. o RG é um atributo que tem valor único para cada professor
iii. o sexo pode ser: 'M' ou 'F'
iv. o idade deve estar entre 21 e 70 anos
v. o titulação deve ser: 'especialista', 'mestre', 'doutor' pu 'pós-doutor'
vi. o categoria deve ser: 'auxiliar', 'assistente', 'adjunto' ou 'titular'
vii. para a titulação doutor ou superior, a categoria só pode ser adjunto ou
titular
viii. para a titulação mestre, a categoria só pode ser assistente
ix. para a titulação especialista, a categoria só pode ser auxiliar
x. um campo NumeroTurmas deve existir, e toda vez que uma turma for
excluída ou inserida, esse valor deve ser decrementado ou
incrementado
xi. todo dia 31 do mês de dezembro incrementar 1 à idade do professor
*/
CREATE TABLE Professor (
    ProfessorID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    RG VARCHAR(20) UNIQUE,
    Sexo CHAR(1) CHECK (Sexo IN ('M', 'F')),
    Idade INT CHECK (Idade BETWEEN 21 AND 70),
    Titulacao VARCHAR(20) CHECK (Titulacao IN ('especialista', 'mestre', 'doutor', 'pós-doutor')),
    Categoria VARCHAR(20),
    NumeroTurmas INT,
    CONSTRAINT CHK_NumeroTurmas CHECK (NumeroTurmas >= 0)
);

/*
 Para disciplinas
i. o nome é um atributo obrigatório
ii. o número de créditos deve estar entre 2 e 12
iii. o semestre da disciplina deve ser compativel com o numero de
semestres do curso que esta vinculada
*/
CREATE TABLE Disciplina (
    DisciplinaID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Creditos INT CHECK (Creditos BETWEEN 2 AND 12),
    Semestre INT,
    CursoID INT
);

/*
Para curso
i. o nome é um atributo obrigatório;
ii. o duração deve estar entre 6 e 12 semestres
iii. o coordenador é uma chave estrangeira para Professores
*/
CREATE TABLE Cursos (
    CursoID INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Duracao INT CHECK (Duracao BETWEEN 6 AND 12),
    Coordenador INT
);

/*
Para turma
i. vagas deve ser maior que zero;
*/
CREATE TABLE Turmas (
    TurmaID INT PRIMARY KEY,
    Vagas INT CHECK (Vagas > 0),
    ProfessorID INT,
    DisciplinaID INT
);

/*
 Para currículos
i. O semestre deve estar entre 1 e 12
*/
CREATE TABLE Curriculos (
    CurriculoID INT PRIMARY KEY,
    Semestre INT CHECK (Semestre BETWEEN 1 AND 12),
    CursoID INT,
    DisciplinaID INT,
    CONSTRAINT FK_CursoCurriculo FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID),
    CONSTRAINT FK_DisciplinaCurriculo FOREIGN KEY (DisciplinaID) REFERENCES Disciplina(DisciplinaID)
);

ALTER TABLE Professor
ADD CONSTRAINT FK_Coordenador FOREIGN KEY (Coordenador) REFERENCES Cursos(CursoID);

ALTER TABLE Disciplina
ADD CONSTRAINT FK_CursoDisciplina FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID);

ALTER TABLE Cursos
ADD CONSTRAINT FK_CoordenadorCurso FOREIGN KEY (Coordenador) REFERENCES Professor(ProfessorID);

ALTER TABLE Turmas
ADD CONSTRAINT FK_ProfessorTurma FOREIGN KEY (ProfessorID) REFERENCES Professor(ProfessorID);

ALTER TABLE Turmas
ADD CONSTRAINT FK_DisciplinaTurma FOREIGN KEY (DisciplinaID) REFERENCES Disciplina(DisciplinaID);


-----------------------------------------------------------------------------------------------------
INSERT INTO Professor (ProfessorID, Nome, RG, Sexo, Idade, Titulacao, Categoria, NumeroTurmas)
VALUES (1, 'Nome Professor', '12345678', 'M', 30, 'mestre', 'assistente', 3);

INSERT INTO Professor (ProfessorID, Nome, RG, Sexo, Idade, Titulacao, Categoria, NumeroTurmas)
VALUES (2, 'Outro Professor', '87654321', 'F', 19, 'doutor', 'adjunto', 2);

INSERT INTO Disciplina (DisciplinaID, Nome, Creditos, Semestre, CursoID)
VALUES (1, 'Disciplina 1', 4, 2, 1);

INSERT INTO Disciplina (DisciplinaID, Nome, Creditos, Semestre, CursoID)
VALUES (2, 'Disciplina 2', 5, 3, 3);

UPDATE Cursos SET Coordenador = 1 WHERE CursoID = 1;

UPDATE Cursos SET Coordenador = 5 WHERE CursoID = 2;

INSERT INTO Turmas (TurmaID, Vagas, ProfessorID, DisciplinaID)
VALUES (1, -5, 1, 1);


