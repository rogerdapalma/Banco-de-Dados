
-- Cria��o do Esquema
CREATE DATABASE EMPRESA;
GO

USE EMPRESA;
GO

-- Cria��o da tabela FUNCIONARIO
CREATE TABLE FUNCIONARIO (
    Pnome VARCHAR(15) NOT NULL,
    Minicial CHAR(1),
    Unome VARCHAR(15) NOT NULL,
    Cpf CHAR(11) PRIMARY KEY,
    Datanasc DATE,
    Endereco VARCHAR(255),
    Sexo CHAR(1),
    Salario DECIMAL(10,2),
    Cpf_supervisor CHAR(11),
    Dnr INT,
    FOREIGN KEY (Cpf_supervisor) REFERENCES FUNCIONARIO(Cpf)
);
GO

-- Tabela DEPARTAMENTO
CREATE TABLE DEPARTAMENTO (
    Dnome VARCHAR(15) NOT NULL,
    Dnumero INT PRIMARY KEY,
    Cpf_gerente CHAR(11),
    Data_inicio_gerente DATE,
    UNIQUE (Dnome),
    FOREIGN KEY (Cpf_gerente) REFERENCES FUNCIONARIO(Cpf)
);
GO

-- Adicionando restri��o referencial em FUNCIONARIO para DEPARTAMENTO
ALTER TABLE FUNCIONARIO
ADD CONSTRAINT FK_Dnr
FOREIGN KEY (Dnr) REFERENCES DEPARTAMENTO(Dnumero);
GO

-- Cria��o da tabela LOCALIZACAO_DEP
CREATE TABLE LOCALIZACAO_DEP (
    Dnumero INT NOT NULL,
    Dlocal VARCHAR(15) NOT NULL,
    PRIMARY KEY (Dnumero, Dlocal),
    FOREIGN KEY (Dnumero) REFERENCES DEPARTAMENTO(Dnumero)
);
GO

-- Cria��o da tabela PROJETO
CREATE TABLE PROJETO(
    Projnome VARCHAR(15) NOT NULL UNIQUE,
    Projnumero INT PRIMARY KEY,
    Projlocal VARCHAR(15),
    Dnum INT,
    FOREIGN KEY (Dnum) REFERENCES DEPARTAMENTO(Dnumero)
);
GO

-- Cria��o da tabela TRABALHA_EM
CREATE TABLE TRABALHA_EM(
    Fcpf CHAR(11) NOT NULL,
    Pnr INT NOT NULL,
    Horas DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (Fcpf, Pnr),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO(Cpf),
    FOREIGN KEY (Pnr) REFERENCES PROJETO(Projnumero)
);
GO

-- Cria��o da tabela DEPENDENTE sem sele��o do esquema
CREATE TABLE DEPENDENTE(
    Fcpf CHAR(11) NOT NULL,
    Nome_dependente VARCHAR(15) NOT NULL,
    Sexo CHAR(1),
    Datanasc DATE,
    Parentesco VARCHAR(8),
    PRIMARY KEY (Fcpf, Nome_dependente),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO(Cpf)
);
GO

--Inserindo valores no Departamento
INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('Pesquisa', 5);
INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('Administra��o', 4);
INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('Matriz', 1);
GO

--Inserindo funcionarios com cargo de gerencia DATE AAAA-MM-DD
INSERT INTO FUNCIONARIO VALUES ( 'Jorge', 'E', 'Brito', '88866555576', '1937-11-10', 'Rua do Horto, 35, S�o Paulo, SP', 'M', 55000, NULL , 1 );
INSERT INTO FUNCIONARIO VALUES ( 'Jennifer', 'S', 'Souza', '98765432168', '1941-06-20', 'Av Arthur de Lima, 54, Santo Andr�, SP', 'F', 43000, '88866555576' , 4 );
INSERT INTO FUNCIONARIO VALUES ( 'Fernando', 'T', 'Wong', '33344555587', '1955-12-08', 'Rua da Lapa, 34, S�o Paulo, SP', 'M', 40000, '88866555576' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'Jo�o', 'B', 'Silva', '12345678966', '1965-01-09', 'Rua das Flores, 751, S�o Paulo, SP', 'M', 30000, '33344555587' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'Alice', 'J', 'Zelaya', '99988777767', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000, '98765432168' , 4 );
INSERT INTO FUNCIONARIO VALUES ( 'Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15', 'Rua Rebou�as, 65, Piracicaba, SP', 'M', 38000, '33344555587' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'Joice', 'A', 'Leite', '45345345376', '1972-07-31', 'Av. Lucas Obes, 74, S�o Paulo, SP', 'F', 25000, '33344555587' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'Andr�', 'E', 'Brito', '98798798733', '1969-03-29', 'Rua Timbira, 35, S�o Paulo, SP', 'M', 25000, '98765432168' , 4 );
GO

--Finzalindo o preenchimento da tabela DEPTARTAMENTO
UPDATE DEPARTAMENTO
SET Cpf_gerente = '33344555587', Data_inicio_gerente = '1988-05-22'
WHERE Dnumero = 5;
UPDATE DEPARTAMENTO
SET Cpf_gerente = '98765432168', Data_inicio_gerente = '1995-01-01'
WHERE Dnumero = 4;
UPDATE DEPARTAMENTO
SET Cpf_gerente = '88866555576', Data_inicio_gerente = '1981-06-19'
WHERE Dnumero = 1;
GO

--Prrencher a tabela LOCALIZACAO_DEP
INSERT INTO LOCALIZACAO_DEP VALUES (1, 'S�o Paulo');
INSERT INTO LOCALIZACAO_DEP VALUES (4, 'Mau�');
INSERT INTO LOCALIZACAO_DEP VALUES (5, 'Santo Andr�');
INSERT INTO LOCALIZACAO_DEP VALUES (5, 'Itu');
INSERT INTO LOCALIZACAO_DEP VALUES (5, 'S�o Paulo');
GO

--Preenchendo a table PROJETO
INSERT INTO PROJETO VALUES ('ProdutoX', 1, 'Santo Andr�', 5);
INSERT INTO PROJETO VALUES ('ProdutoY', 2, 'Itu', 5);
INSERT INTO PROJETO VALUES ('ProdutoZ', 3, 'S�o Paulo', 5);
INSERT INTO PROJETO VALUES ('Informatiza��o', 10, 'Mau�', 4);
INSERT INTO PROJETO VALUES ('Reorganiza��o', 20, 'S�o Paulo', 1);
INSERT INTO PROJETO VALUES ('Novosbenef�cios', 30, 'Mau�', 4);
GO

--Preenchento TRABALHA_EM
INSERT INTO TRABALHA_EM VALUES ('12345678966',1,32.5);
INSERT INTO TRABALHA_EM VALUES ('12345678966',2,7.5);
INSERT INTO TRABALHA_EM VALUES ('66688444476',3,40);
INSERT INTO TRABALHA_EM VALUES ('45345345376',1,20);
INSERT INTO TRABALHA_EM VALUES ('45345345376',2,20);
INSERT INTO TRABALHA_EM VALUES ('33344555587',2,10);
INSERT INTO TRABALHA_EM VALUES ('33344555587',3,10);
INSERT INTO TRABALHA_EM VALUES ('33344555587',10,10);
INSERT INTO TRABALHA_EM VALUES ('33344555587',20,10);
INSERT INTO TRABALHA_EM VALUES ('99988777767',10,10);
INSERT INTO TRABALHA_EM VALUES ('99988777767',30,30);
INSERT INTO TRABALHA_EM VALUES ('98798798733',10,35);
INSERT INTO TRABALHA_EM VALUES ('98798798733',30,5);
INSERT INTO TRABALHA_EM VALUES ('98765432168',30,20);
INSERT INTO TRABALHA_EM VALUES ('98765432168',20,15);
GO

--Preenchendo a tabela de DEPENDENTES
INSERT INTO DEPENDENTE VALUES ('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha');
INSERT INTO DEPENDENTE VALUES ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filh0');
INSERT INTO DEPENDENTE VALUES ('33344555587', 'Janaina', 'F', '1958-05-03', 'Eposa');
INSERT INTO DEPENDENTE VALUES ('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido');
INSERT INTO DEPENDENTE VALUES ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho');
INSERT INTO DEPENDENTE VALUES ('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha');
INSERT INTO DEPENDENTE VALUES ('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');
GO

DROP TRIGGER tr_questao_11;
GO

ALTER TRIGGER tr_questao_11 
   ON  FUNCIONARIO 
   AFTER INSERT
AS 
BEGIN
	DECLARE @nome VARCHAR(15), @sobre_nome VARCHAR(15), @data_nasc DATE;
	SELECT @nome = Pnome, @sobre_nome = Unome, @data_nasc = Datanasc from inserted;
	IF EXISTS (SELECT * FROM FUNCIONARIO WHERE @nome=Pnome AND @sobre_nome=Unome AND @data_nasc=Datanasc GROUP BY Pnome HAVING COUNT(*)>1)
	BEGIN
		PRINT('funcionario j� cadastrado')
		ROLLBACK;
	END
	ELSE
		PRINT ('Funcionario cadastrado com sucesso')
END
GO


INSERT INTO FUNCIONARIO VALUES ( 'Andr�', 'E', 'Brito', '8809877', '1969-03-29', 'Rua Timbira, 35, S�o Paulo, SP', 'M', 25000, '98765432168' , 4 );
GO

SELECT * FROM FUNCIONARIO;

