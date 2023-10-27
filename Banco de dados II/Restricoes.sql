CREATE DATABASE AulaRestricoes;

USE AulaRestricoes;

-- Cadrastro de de um  pet shop

CREATE TABLE tbl_pessoa_pet
(
	id INTEGER PRIMARY KEY IDENTITY,
	nome_pessoa VARCHAR(50) NOT NULL,
	nome_pet VARCHAR(50) NOT NULL,
	num_pet INTEGER CHECK(num_pet>0)NOT NULL,
	idade INTEGER CHECK(idade BETWEEN 18 AND 85),
	sexo_pet CHAR CHECK(sexo_pet IN ('M','F','N'))
);
-- Testando restrições
INSERT INTO tbl_pessoa_pet VALUES('Roger', 'Costela',2,35,'M');
INSERT INTO tbl_pessoa_pet VALUES('Carlos', 'Chuleta',2,36,'F');

INSERT INTO tbl_pessoa_pet VALUES('Juca', 'Max',0,36,'F');

SELECT * FROM tbl_pessoa_pet;

--Exemplo para aplicar CASCADE
CREATE TABLE tbl_Pais
(
	id_pais INT PRIMARY KEY,
	nome_pais VARCHAR(50)UNIQUE NOT NULL,
	cod_pais VARCHAR(3)UNIQUE NOT NULL
);

CREATE TABLE tbl_Estados
(
	id_Estados INT PRIMARY KEY,
	nome_estado VARCHAR(50)NOT NULL,
	cod_Estado VARCHAR(3)NOT NULL,
	id_Pais INT
);
GO
-- Criando restrição check + CASCATE

ALTER TABLE tbl_Estados WITH CHECK
ADD CONSTRAINT [FK_estado_pais]FOREIGN KEY(id_Pais)
REFERENCES tbl_Pais(id_Pais)
ON DELETE CASCADE;

--Informações das tabelas
sp_help tbl_Estados;

GO
INSERT INTO tbl_Pais VALUES
(1, 'Brasil','BR'),
(2, 'Canada','CA'),
(3, 'Estado Unidos','EUA');

INSERT INTO tbl_Estados VALUES
(5,'cALIFORNIA','CA',3),
(6,'Alasca','AK',3),
(7,'Florida','FL',3),
(8,'Arizona','AZ',3);

INSERT INTO tbl_Estados VALUES
(9,'Ondario','ON',2),
(10,'Quebec','QC',2),
(11,'Toronto','TR',2),
(12,'Nova Escocia','NS',2);

SELECT * FROM tbl_Pais;

SELECT * FROM tbl_Estados;

DELETE FROM tbl_Pais WHERE id_pais = 1;

-- Outra forma de criação de restrição 

CREATE TABLE tbl_Produto
(
	id_produto INT PRIMARY KEY,
	nome_produto VARCHAR(50),
	categoria VARCHAR(25)
);

CREATE TABLE tbl_Inventario
(
	id_Inventario INT PRIMARY KEY,
	fk_id_Produto INT,
	quantidade INT,
	min_level INT,
	max_level INT,
	CONSTRAINT fk_inv_produto
		FOREIGN KEY (fk_id_Produto)
		REFERENCES tbl_Produto (id_produto)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

-- Inserindo alguns valores

INSERT INTO tbl_Produto VALUES
(1, 'Refrigerante','Bebidas'),
(2, 'Cerveja','Bebidas'),
(3, 'Tequla','Bebidas'),
(4, 'energetico','Bebidas');

INSERT INTO tbl_Inventario VALUES
(1,2,500,10,1000),
(2,4,50,5,50),
(3,2,1000,5,5000);

SELECT * FROM tbl_Produto;
SELECT * FROM tbl_Inventario;

UPDATE tbl_Produto SET id_produto = 550
WHERE id_produto = 1;

/*
ALTER TABLE tbl_Inventario WITH CHECK
ADD CONSTRAINT [FK_estado_Prod]FOREIGN KEY(fk_id_produto)
REFERENCES tbl_Produto(id_produto)
ON UPDATE CASCADE;
*/

DELETE FROM tbl_Produto WHERE id_produto = 550;

--Removendo restrição
ALTER TABLE tbl_Inventario DROP CONSTRAINT fk_inv_produto;
-- Alterando constraint
ALTER TABLE tbl_Inventario WITH CHECK
ADD CONSTRAINT [fk_inv_produto] 
FOREIGN KEY (fk_id_produto)
REFERENCES tbl_Produto (id_produto)
ON UPDATE CASCADE
ON DELETE SET NULL ;

-- Remover energetico
DELETE FROM tbl_Produto WHERE id_produto = 4;