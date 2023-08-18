DROP DATABASE EMPRESA;

#Criação do Esquema
CREATE DATABASE EMPRESA;

#Criação da tabela FUNCIONARIO
CREATE TABLE EMPRESA.FUNCIONARIO (
	Pnome VARCHAR(15) NOT NULL,
    Minicial CHAR,
    Unome VARCHAR(15) NOT NULL,
    Cpf CHAR(11),
    Datanasc DATE,
    Endereco VARCHAR(255),
    Sexo CHAR, 
    Salario DECIMAL(10,2),
    Cpf_supervisor CHAR(11),
    Dnr INT,
    PRIMARY KEY (Cpf),
    FOREIGN KEY (Cpf_supervisor) REFERENCES FUNCIONARIO(Cpf)
);

#Tablea de DEPARTAMENTO
CREATE TABLE EMPRESA.DEPARTAMENTO (
	Dnome VARCHAR(15) NOT NULL,
    Dnumero INT,
    Cpf_gerente CHAR(11),
    Data_inicio_gerente DATE,
    PRIMARY KEY (Dnumero),
    UNIQUE (Dnome),
    FOREIGN KEY (Cpf_gerente) REFERENCES FUNCIONARIO(CPF)
);

#Adiconando restição referencial em FUNCIONARO de DEPARTAMENTO
#Criando uma ALTERAÇÃO de Tabela
ALTER TABLE EMPRESA.FUNCIONARIO
ADD CONSTRAINT Dnr
FOREIGN KEY (Dnr) REFERENCES DEPARTAMENTO (Dnumero);

#Criação da tabela de LOCALIZACAO_DEP
CREATE TABLE EMPRESA.LOCALIZACAO_DEP (
	Dnumero INT NOT NULL,
	Dlocal VARCHAR (15) NOT NULL,
    PRIMARY KEY (Dnumero, Dlocal),
    FOREIGN KEY (Dnumero) REFERENCES DEPARTAMENTO (Dnumero)
);

#Criacao da tabela PROJETO
CREATE TABLE EMPRESA.PROJETO(
	Projnome VARCHAR (15) NOT NULL,
	Projnumero INT NOT NULL,
    Projlocal VARCHAR(15),
    Dnum INT,
    PRIMARY KEY (Projnumero),
    UNIQUE (Projnome),
    FOREIGN KEY (Dnum) REFERENCES DEPARTAMENTO (Dnumero)
);

#Criação da tabela TRABALHA_EM
CREATE TABLE EMPRESA.TRABALHA_EM(
	Fcpf CHAR(11) NOT NULL,
    Pnr INT NOT NULL,
    Horas DECIMAL (3,1) NOT NULL,
    PRIMARy KEY (Fcpf, Pnr),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO (Cpf),
    FOREIGN KEY (Pnr) REFERENCES PROJETO(Projnumero)
);

#Selecionando o esquema para criação da tabela
USE EMPRESA;
#Criação da tabela DEPENDENTE sem seleção do esquema
CREATE TABLE DEPENDENTE(
	Fcpf CHAR(11) NOT NULL,
    Nome_dependente VARCHAR(15) NOT NULL,
    Sexo CHAR,
    Datanasc DATE,
    Parentesco VARCHAR(8),
    PRIMARY KEY (Fcpf, Nome_dependente),
    FOREIGN KEY (Fcpf) REFERENCES FUNCIONARIO(Cpf)
);

#Inserindo valores no Departamento
INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('Pesquisa', 5);
INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('Administração', 4);
INSERT INTO DEPARTAMENTO (Dnome, Dnumero) VALUES('Matriz', 1);
SELECT * FROM DEPARTAMENTO;
#Inserindo funcionarios com cargo de gerencia DATE AAAA-MM-DD
INSERT INTO FUNCIONARIO VALUES ( 'Jorge', 'E', 'Brito', '88866555576', '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', 55000, NULL , 1 );
INSERT INTO FUNCIONARIO VALUES ( 'Jennifer', 'S', 'Souza', '98765432168', '1941-06-20', 'Av Arthur de Lima, 54, Santo André, SP', 'F', 43000, '88866555576' , 4 );
INSERT INTO FUNCIONARIO VALUES ( 'Fernando', 'T', 'Wong', '33344555587', '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000, '88866555576' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'João', 'B', 'Silva', '12345678966', '1965-01-09', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000, '33344555587' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'Alice', 'J', 'Zelaya', '99988777767', '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000, '98765432168' , 4 );
INSERT INTO FUNCIONARIO VALUES ( 'Ronaldo', 'K', 'Lima', '66688444476', '1962-09-15', 'Rua Rebouças, 65, Piracicaba, SP', 'M', 38000, '33344555587' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'Joice', 'A', 'Leite', '45345345376', '1972-07-31', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000, '33344555587' , 5 );
INSERT INTO FUNCIONARIO VALUES ( 'André', 'E', 'Brito', '98798798733', '1969-03-29', 'Rua Timbira, 35, São Paulo, SP', 'M', 25000, '98765432168' , 4 );

#Corrigindo erro de inserção
UPDATE FUNCIONARIO
SET Endereco = 'Rua Reboucas, 65, Piracicaba, SP'
WHERE Cpf = '66688444476';
#Recupera todas as informações de funcionários
SELECT * FROM FUNCIONARIO;

#Finzalindo o preenchimento da tabela DEPTARTAMENTO
UPDATE DEPARTAMENTO
SET Cpf_gerente = '33344555587', Data_inicio_gerente = '1988-05-22'
WHERE Dnumero = 5;
UPDATE DEPARTAMENTO
SET Cpf_gerente = '98765432168', Data_inicio_gerente = '1995-01-01'
WHERE Dnumero = 4;
UPDATE DEPARTAMENTO
SET Cpf_gerente = '88866555576', Data_inicio_gerente = '1981-06-19'
WHERE Dnumero = 1;
#Recuperar todas as informações de departamento
SELECT * FROM DEPARTAMENTO;

#Prrencher a tabela LOCALIZACAO_DEP
INSERT INTO LOCALIZACAO_DEP VALUES (1, 'São Paulo');
INSERT INTO LOCALIZACAO_DEP VALUES (4, 'Mauá');
INSERT INTO LOCALIZACAO_DEP VALUES (5, 'Santo André');
INSERT INTO LOCALIZACAO_DEP VALUES (5, 'Itu');
INSERT INTO LOCALIZACAO_DEP VALUES (5, 'São Paulo');
#Recuperando informações de LOCALIZACAO_DEP
SELECT * FROM LOCALIZACAO_DEP;

#Preenchendo a table PROJETO
INSERT INTO PROJETO VALUES ('ProdutoX', 1, 'Santo André', 5);
INSERT INTO PROJETO VALUES ('ProdutoY', 2, 'Itu', 5);
INSERT INTO PROJETO VALUES ('ProdutoZ', 3, 'São Paulo', 5);
INSERT INTO PROJETO VALUES ('Informatização', 10, 'Mauá', 4);
INSERT INTO PROJETO VALUES ('Reorganização', 20, 'São Paulo', 1);
INSERT INTO PROJETO VALUES ('Novosbenefícios', 30, 'Mauá', 4);

#Preenchento TRABALHA_EM
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

#Alternado a tabela TRABALHA_EM 
ALTER TABLE TRABALHA_EM
MODIFY COLUMN Horas Decimal(3,1);
#Agora conseguimos inseri null no horário
INSERT INTO TRABALHA_EM VALUES ('88866555576',20,NULL);

#Preenchendo a tabela de DEPENDENTES
INSERT INTO DEPENDENTE VALUES ('33344555587', 'Alicia', 'F', '1986-04-05', 'Filha');
INSERT INTO DEPENDENTE VALUES ('33344555587', 'Tiago', 'M', '1983-10-25', 'Filh0');
INSERT INTO DEPENDENTE VALUES ('33344555587', 'Janaina', 'F', '1958-05-03', 'Eposa');
INSERT INTO DEPENDENTE VALUES ('98765432168', 'Antonio', 'M', '1942-02-28', 'Marido');
INSERT INTO DEPENDENTE VALUES ('12345678966', 'Michael', 'M', '1988-01-04', 'Filho');
INSERT INTO DEPENDENTE VALUES ('12345678966', 'Alicia', 'F', '1988-12-30', 'Filha');
INSERT INTO DEPENDENTE VALUES ('12345678966', 'Elizabeth', 'F', '1967-05-05', 'Esposa');

select * from FUNCIONARIO;
select FUNCIONARIO.Pnome, FUNCIONARIO.Minicial, FUNCIONARIO.Unome from FUNCIONARIO where Pnome = 'João'; #PESQUISAR O NOME COMPLETO 
select CONCAT (FUNCIONARIO.Pnome, FUNCIONARIO.Minicial, FUNCIONARIO.Unome) from FUNCIONARIO where Pnome = 'João'; #PARA CONCATENAR 
select * from FUNCIONARIO where Pnome = 'João'; # PESQUISAR APENAS QUEM TEM O NOME JOÃO
select * from FUNCIONARIO where Sexo = 'M' and Salario = '30000';  # PESQUISAR MAIS DE UMA COISA
select * from FUNCIONARIO where Endereco LIKE '%São Paulo%' or  Endereco LIKE '%Curitiba%'; # PESQUISAR CERTA PARTE DE UM STRING 
select * from FUNCIONARIO where not Endereco like '%São Paulo%' ; 
select * from FUNCIONARIO order by Salario ASC;
select * from FUNCIONARIO order by Salario DESC;
select * from FUNCIONARIO where Cpf_supervisor is null ;  # PESQUISAR PARA QUEM NAO TEM SUPERVISOR
select * from FUNCIONARIO where Cpf_supervisor is not null ;  
select * from FUNCIONARIO order by Salario DESC limit 3;
select * from FUNCIONARIO where salario = (select min(Salario) from FUNCIONARIO);  # CONSULTA ALINHADA 
select * from FUNCIONARIO where salario = (select max(Salario) from FUNCIONARIO);  # CONSULTA ALINHADA 
select count(Pnome) from FUNCIONARIO;
select AVG(Salario) from FUNCIONARIO;
select SUM(Salario) from FUNCIONARIO;
select * from FUNCIONARIO where Datanasc like '__72%';
select * from FUNCONARIO where Pnome in (select STATEMNT) ;
#select pnr,horas from Trabalha_em where fcpf = '33344555587';
#select f.Pnome, f.Unome from trabalha_em t join FUNCIONARIO f ON f.cpf = t.fcpf
#where t.pnr  in (select pnr from Trabalha_em where fcpf = '33344555587');

select pnr, horas from trabalha_em where fcpf = (select cpf from funcionario where pnome like 'fernando');
select distinct  fcpf from trabalha_em where (pnr,horas)in (select pnr, horas from trabalha_em where fcpf = (select cpf from funcionario where pnome like 'fernando'));

SELECT F.CPF, CONCAT(F.PNOME, ' ', F.UNOME), T.PNR, T.HORAS FROM TRABALHA_EM T
JOIN FUNCIONARIO F ON F.CPF = T.FCPF
WHERE (T.PNR, T.HORAS) IN (SELECT PNR, HORAS FROM TRABALHA_EM WHERE FCPF = '33344555587') #AULA DEU AJUDA 
AND F.CPF <> '33344555587';

select * from FUNCIONARIO where Dnr = 5 and salario between 30000 and 40000 ; 
select Pnome as "NOME" 
from FUNCIONARIO as f ; # f.pnome , funcionario muda para f ; # tem que escrever sempre

select f.Pnome ,f.Unome,f.endereco from FUNCIONARIO as f Inner join DEPARTAMENTO as D on D.Dnumero = F.dnr where D.dnome = 'pesquisa' ;
select * from projeto;
select f.Pnome from FUNCIONARIO as f 
JOIN TRABALHA_EM T ON T.FCPF = F.CPF
JOIN PROJETO P ON P.PROJNUMERO = T.PNR
WHERE P.PROJNOME = "ProdutoX"  ; 

SELECT * FROM FUNCIONARIO F ,
TRABALHA_EM T ,
PROJETO P 
WHERE FCPF = T.FCPF
AND T.PNR = P.PROJNUMERO
AND P.Pnome = "ProdutoX" ;

SELECT * FROM FUNCIONARIO F
JOIN DEPENDENTE D ON D.FCPF = F.CPF; # MOSTRA SÓ OS QUE TEM DEPENDENTES

SELECT * FROM FUNCIONARIO F
LEFT JOIN DEPENDENTE D ON D.FCPF = F.CPF; #MOSTRA QUEM NAO TEM E QUEM TEM

SELECT * FROM FUNCIONARIO F
RIGHT JOIN DEPENDENTE D ON D.FCPF = F.CPF; #MOSTRA SO QUEM TEM DEPENDENTE

SELECT * FROM FUNCIONARIO F 
CROSS JOIN DEPENDENTE D;

SELECT  F.PNOME , F.UNOME , F.ENDERECO FROM FUNCIONARIO F
INNER JOIN DEPARTAMENTO D ON F.DNR = D.DNUMERO AND D.DNOME = "Pesquisa";

SELECT P.PROJNUMERO, P.PROJNOME FROM PROJETO  P 
INNER JOIN FUNCIONARIO F ON P.DNUM =  F.DNR
WHERE P.PROJLOCAL = 'Mauá';

SELECT
	P.PROJNOME,
	P.PROJNUMERO,
	D.DNUMERO AS DEPARTAMENTO,
	F.UNOME,
	F.ENDERECO,
	F.DATANASC
FROM 
	PROJETO P
JOIN 
	DEPARTAMENTO D ON D.DNUMERO = P.DNUM
JOIN 
	FUNCIONARIO F ON F.CPF = D.CPF_GERENTE
WHERE 
	P.PROJLOCAL = "Mauá";

SELECT * FROM FUNCIONARIO;
UPDATE FUNCIONARIO F SET UNOME = 'Pereira' WHERE F.CPF = '98798798733' ; 
    
SELECT F.UNOME AS FUNCIONARIO, 
 G.UNOME AS GERENTE  #MESMA TABELA EXPECIFICANDO O GERENTE
 FROM FUNCIONARIO F
 JOIN FUNCIONARIO G 
 ON G.CPF = F.CPF_SUPERVISOR; #MESMA TABELA APENAS CPF´S DIFERENTES 
