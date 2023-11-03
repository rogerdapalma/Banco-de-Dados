USE Seguranca_1

SELECT * FROM Disciplina;

SELECT * FROM vw_Disciplina;

INSERT INTO Disciplina (nome)
VALUES ('Teste do Juca');

EXEC sp_Disciplina_01;

EXEC sp_Disciplina_02;

EXEC sp_Disciplina_03;

EXEC sp_Disciplina_04;

SELECT * FROM fncDisciplina(3);

USE Seguranca_2;

SELECT * FROM Instituicao;

INSERT INTO Instituicao(nome,cod)
VALUES('Instituição', 666);

UPDATE Instituicao SET nome = 'Juca lindo';

UPDATE Instituicao SET nome = 'Juca depois do deny update';

INSERT INTO Instituicao(nome,cod)
VALUES('Instituição', 321);
