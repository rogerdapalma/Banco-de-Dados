-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema editora_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema editora_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `editora_db` DEFAULT CHARACTER SET utf8 ;
USE `editora_db` ;

-- -----------------------------------------------------
-- Table `editora_db`.`Autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_db`.`Autor` (
  `idAutor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAutor`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `editora_db`.`Editora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_db`.`Editora` (
  `idEditora` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEditora`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `editora_db`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_db`.`Genero` (
  `idGenero` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idGenero`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_db`.`Livro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_db`.`Livro` (
  `idLivro` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(3) NULL,
  `idEditora` INT NOT NULL,
  `idGenero` INT NOT NULL,
  PRIMARY KEY (`idLivro`),
  INDEX `fk_Livro_Editora_idx` (`idEditora` ASC),
  INDEX `fk_Livro_Genero1_idx` (`idGenero` ASC),
  CONSTRAINT `fk_Livro_Editora`
    FOREIGN KEY (`idEditora`)
    REFERENCES `editora_db`.`Editora` (`idEditora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Livro_Genero1`
    FOREIGN KEY (`idGenero`)
    REFERENCES `editora_db`.`Genero` (`idGenero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_db`.`Livro_Autor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_db`.`Livro_Autor` (
  `idAutor` INT NOT NULL,
  `idLivro` INT NOT NULL,
  PRIMARY KEY (`idAutor`, `idLivro`),
  INDEX `fk_Autor_has_Livro_Livro1_idx` (`idLivro` ASC),
  INDEX `fk_Autor_has_Livro_Autor1_idx` (`idAutor` ASC),
  CONSTRAINT `fk_Autor_has_Livro_Autor1`
    FOREIGN KEY (`idAutor`)
    REFERENCES `editora_db`.`Autor` (`idAutor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Autor_has_Livro_Livro1`
    FOREIGN KEY (`idLivro`)
    REFERENCES `editora_db`.`Livro` (`idLivro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_db`.`Ranking`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_db`.`Ranking` (
  `idRanking` INT NOT NULL AUTO_INCREMENT,
  `dataInicial` DATE NOT NULL,
  `dataFinal` DATE NOT NULL,
  PRIMARY KEY (`idRanking`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editora_db`.`Ranking_Semanal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `editora_db`.`Ranking_Semanal` (
  `idRanking` INT NOT NULL,
  `idLivro` INT NOT NULL,
  `posicao` DECIMAL(2) NULL,
  `quantidadeSemanas` DECIMAL(2) NULL,
  `semanasConsecutivas` DECIMAL(2) NULL,
  `posicaoSemanaAnterior` DECIMAL(2) NULL,
  PRIMARY KEY (`idRanking`, `idLivro`),
  INDEX `fk_Ranking_has_Livro_Livro1_idx` (`idLivro` ASC),
  INDEX `fk_Ranking_has_Livro_Ranking1_idx` (`idRanking` ASC),
  CONSTRAINT `fk_Ranking_has_Livro_Ranking1`
    FOREIGN KEY (`idRanking`)
    REFERENCES `editora_db`.`Ranking` (`idRanking`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ranking_has_Livro_Livro1`
    FOREIGN KEY (`idLivro`)
    REFERENCES `editora_db`.`Livro` (`idLivro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



SHOW TABLES;

use editora_db;
show tables;

insert into Genero values (1, 'Infantil');
insert into Genero values (2, 'Ficção');
insert into Genero values (3, 'Romance');
insert into Genero values (4, 'Auto-ajuda');
insert into Genero values (5, 'Negócios');
insert into Genero values (6, 'História');

select *
from Genero
ORDER BY descricao;

insert into Editora values (1, 'Ática');
insert into Editora values (2, 'Makron Books');
insert into Editora values (3, 'Rocco');
insert into Editora values (4, 'Scipione');
insert into Editora values (5, 'Sagra Luzato');

select *
from Editora
ORDER BY nome;

insert into Autor values (1, 'Pedro');
insert into Autor values (2, 'Marcos');
insert into Autor values (3, 'Felipe');
insert into Autor values (4, 'Ana');
insert into Autor values (5, 'Maria');
insert into Autor values (6, 'Francisco');
insert into Autor values (7, 'Lucas');

select *
from Autor;

insert into Livro values (1, 'A', 25.30, 1, 1);
insert into Livro values (2, 'B', 32.45, 1, 4);
insert into Livro values (3, 'C', 122.00, 4, 2);
insert into Livro values (4, 'D', 100.99, 4, 3);
insert into Livro values (5, 'E', 16.16, 1, 5);
insert into Livro values (6, 'F', 4.56, 3, 1);
insert into Livro values (7, 'G', 85.20, 2, 5);
insert into Livro values (8, 'H', 89.90, 5, 5);
insert into Livro values (9, 'I', 63.36, 2, 2);
insert into Livro values (10, 'J', 41.40, 3, 3);
insert into Livro values (11, 'K', 200.30, 4, 6);
insert into Livro values (12, 'L', 99.99, 2, 4);

select *
from Livro;

ALTER TABLE livro modify column preco float null;

TRUNCATE TABLE LIVRO;

DELETE
FROM livro
WHERE idEditora = 1;

insert into Livro_Autor values (1, 1);
insert into Livro_Autor values (6, 1);
insert into Livro_Autor values (6, 2);
insert into Livro_Autor values (5, 3);
insert into Livro_Autor values (1, 3);
insert into Livro_Autor values (4, 3);
insert into Livro_Autor values (4, 4);
insert into Livro_Autor values (1, 5);
insert into Livro_Autor values (5, 6);
insert into Livro_Autor values (3, 6);
insert into Livro_Autor values (3, 7);
insert into Livro_Autor values (2, 8);
insert into Livro_Autor values (6, 9);
insert into Livro_Autor values (6, 10);
insert into Livro_Autor values (1, 10);
insert into Livro_Autor values (2, 11);
insert into Livro_Autor values (2, 12);


select *
from Livro_Autor;

insert into Ranking values (1, '20250817', '20250823');
insert into Ranking values (2, '20250824', '20250830');
insert into Ranking values (3, '20250831', '20250906');
insert into Ranking values (4, '20250907', '20250913');

select * from Ranking;

insert into Ranking_Semanal values (1,1,4,6,3,3);
insert into Ranking_Semanal values (2,1,5,7,3,4);
insert into Ranking_Semanal values (3,2,1,1,1,null);
insert into Ranking_Semanal values (4,2,1,2,2,1);
insert into Ranking_Semanal values (1,3,2,2,2,null);
insert into Ranking_Semanal values (2,3,2,3,3,2);
insert into Ranking_Semanal values (3,3,8,4,4,2);
insert into Ranking_Semanal values (4,3,10,5,5,8);
insert into Ranking_Semanal values (1,4,1,50,43,1);
insert into Ranking_Semanal values (2,5,1,1,1,null);
insert into Ranking_Semanal values (3,5,2,2,2,1);
insert into Ranking_Semanal values (4,5,9,3,3,2);
insert into Ranking_Semanal values (4,6,8,1,1,null);
insert into Ranking_Semanal values (3,7,5,1,1,null);
insert into Ranking_Semanal values (4,7,5,2,2,5);
insert into Ranking_Semanal values (1,8, 3,13,12,6);
insert into Ranking_Semanal values (2,8, 3, 14,13,3);
insert into Ranking_Semanal values (3,8,3,15,14,3);
insert into Ranking_Semanal values (4,8,4,16,15,3);
insert into Ranking_Semanal values (2,9,7,1,1,null);
insert into Ranking_Semanal values (3,9,7,2,2,7);
insert into Ranking_Semanal values (1,10,8,4,4,10);
insert into Ranking_Semanal values (2,10,9,5,5,8);
insert into Ranking_Semanal values (3,11,9,1,1,null);
insert into Ranking_Semanal values (1,12,6,3,2,6);

select * from Ranking_Semanal;

-- Conta quantas tuplas/linhas há na tabela Ranking_Semanal
select count(*)
from Ranking_Semanal;

-- i.Mostre todos os autores cadastrados;
select * from Autor;

-- ii.Mostre apenas os nomes dos autores;
select nome
from Autor;

-- iii.Mostre o nome e a identificação do autor, nesta ordem;
select nome, idAutor
from Autor;

-- iv.Mostre o nome dos autores que aparecem na tabela Livro_Autor;
select Autor.nome
from Autor, Livro_Autor
where Autor.idAutor = Livro_Autor.idAutor;

SELECT distinct(Autor.nome)
FROM Autor
INNER JOIN Livro_Autor
ON Autor.idAutor = Livro_Autor.idAutor;

-- v.Mostre o nome dos autores, sem repetição, presentes na tabela Livro_Autor;
select distinct(Autor.nome)
from Autor, Livro_Autor
where Autor.idAutor = Livro_Autor.idAutor;

-- vi.Mostre os autores em ordem alfabética;
select distinct(Autor.nome)
from Autor, Livro_Autor
where Autor.idAutor = Livro_Autor.idAutor
order by Autor.nome;

-- vii.Mostre o título dos livros que são da editora Rocco ou da editora Scipione;
select Livro.titulo, Editora.nome
from Livro, Editora
where (Editora.nome = 'Rocco' or Editora.nome = 'Scipione') and Livro.idEditora = Editora.idEditora;

-- viii.Mostre, em ordem alfabética, os autores que começam com M;
select nome
from Autor
where nome like 'M%'
order by nome;

-- ix.Mostre, em ordem alfabética, os autores que começam com L;
select nome
from Autor
where nome like 'L%'
order by nome;

-- x.Mostre, em ordem alfabética, os autores que NÃO começam com L;
select nome
from Autor
where nome not like 'L%'
order by nome;

-- xi.Mostre, em qualquer ordem, os autores que não começam com M;
select nome
from Autor
where nome not like 'M%'
order by nome;

-- xii.Liste apenas os livros das editoras 1 OU 5;
select Livro.titulo, Editora.nome
from Livro, Editora
where (Editora.idEditora = 1 or Editora.idEditora = 5) and
      Livro.idEditora = Editora.idEditora;

-- xiii.Mostre os livros infantis das editoras 1 e 5;
select Livro.titulo, Genero.descricao, Livro.idEditora "Código Editora", Editora.nome
from Livro, Genero, Editora
where  Genero.descricao = 'Infantil' and
       Livro.idGenero = Genero.idGenero and
       (Livro.idEditora = 1 or Livro.idEditora = 5) and
       Livro.idEditora = Editora.idEditora;

-- xiv.Mostre os códigos e os títulos dos livros, com seus respectivos preços;
select idLivro, titulo, preco
from Livro;

-- xv.Mostre os autores em ordem contrária à alfabética;
select *
from autor
order by nome desc;

-- xvi.Liste os livros, na ordem de preços do mais caro ao mais barato;
select *
from Livro
order by preco desc;

-- xvii.Liste os livros, na ordem de preços do mais barato ao mais caro;
select *
from Livro
order by preco;

-- xviii.Mostre apenas os livros de auto-ajuda, na ordem crescente de preço;
select livro.titulo, livro.preco
from livro
where idGenero = '4'
order by preco;

SELECT *
FROM Livro, Genero
WHERE Livro.idGenero = Genero.idGenero AND
Genero.descricao = 'Auto-ajuda'
ORDER BY preco ASC;

select livro.*
from livro,genero
where descricao = 'Auto-Ajuda' and livro.idGenero = genero.idGenero
order by preco asc;

-- xix.Mostre quantos autores estão cadastros;
select count(*)
from autor;

-- xx.Mostre os preços dos livros mais baratos e mais caros da editora 1;
select max(preco) as livroMaisCaro, min(preco) as livroMaisBarato
from Livro
where Livro.idEditora = 1;

select max(preco), min(preco)
from livro
where idEditora = '1';

select titulo, preco
from livro
where preco = (select max(preco)
	       from livro
               where idEditora = 1) or preco = (select min(preco)
                                                from livro
                                                 where idEditora = 1);

-- xxi.Liste a média de preços dos livros da editora 2;
select avg(preco) as precoMedio
from Livro
where idEditora=2;

SELECT AVG(preco)
FROM Livro
WHERE idEditora=2;

select round(avg(preco),2)
from livro
where idEditora = 2;

create view MediaPreco as
select round(avg(preco),2)
from livro
where idEditora = 2;

-- xxii.Mostre os livros com seus respectivos nomes de editoras e gêneros;
select Livro.titulo, Editora.nome as editora, Genero.descricao as genero
from Livro, Editora, Genero
where Livro.idEditora=Editora.idEditora and
      Livro.idGenero=Genero.idGenero;

SELECT Livro.titulo, Editora.nome "Editora", Genero.descricao "Genero"
FROM Livro, Editora, Genero
WHERE Livro.idGenero = Genero.idGenero AND
Livro.idEditora = Editora.idEditora;

-- xxiii.Liste os livros, mostrando o titulo de cada um bem como o nome do autor;
SELECT Livro.titulo, Autor.nome
FROM Livro, Autor, Livro_Autor
WHERE Livro_Autor.idLivro = Livro.idLivro AND
Livro_Autor.idAutor = Autor.idAutor;

select Livro.titulo as livro, Autor.nome as autor
from Livro, Autor, Livro_Autor
where Livro_Autor.idAutor=Autor.idAutor and
Livro_Autor.idLivro=Livro.idLivro;

SELECT Livro.titulo, Autor.nome, Editora.nome
FROM Livro, Autor, Livro_Autor, Editora
WHERE Livro_Autor.idLivro = Livro.idLivro AND
Livro_Autor.idAutor = Autor.idAutor AND
Livro.idEditora = Editora.idEditora
ORDER BY Livro.titulo;

-- xxiv.Mostre o título do livro que ficou o maior número de semanas consecutivas em 1o lugar;
SELECT Livro.titulo, Ranking_semanal.posicao, Ranking_semanal.semanasConsecutivas
FROM Livro, Ranking_semanal
WHERE semanasConsecutivas = (SELECT max(semanasConsecutivas)
                             FROM Ranking_semanal
                             WHERE posicao = 1)
      AND Livro.idLivro = Ranking_semanal.idLivro;

select livro.titulo, ranking_semanal.idLivro, ranking_semanal.semanasConsecutivas
from ranking_semanal, livro
where Livro.idLivro = Ranking_semanal.idLivro
order by semanasConsecutivas desc limit 10;



-- xxv.Mostre o nome dos autores dos livros que estavam no ranking da semana de 24/08/2003 a 30/08/2003;
select distinct Autor.nome as autor
from Livro, Autor, Livro_Autor, Ranking, Ranking_Semanal
where Livro_Autor.idAutor=Autor.idAutor and
      Livro_Autor.idLivro=Livro.idLivro and
      Ranking_Semanal.idRanking = Ranking.idRanking and
      Ranking_Semanal.idLivro=Livro.idLivro and Ranking.idRanking=2;

select distinct Autor.nome as autor
from Livro, Autor, Livro_Autor, Ranking, Ranking_Semanal
where (Ranking.dataInicial='2025-08-24' and Ranking.dataFinal='2025-08-30') and
Livro_Autor.idAutor=Autor.idAutor and
Livro_Autor.idLivro=Livro.idLivro and
Ranking_Semanal.idRanking = Ranking.idRanking and
Ranking_Semanal.idLivro=Livro.idLivro;

select autor.nome
from autor,ranking, ranking_semanal, livro_autor
where ranking_semanal.idRanking = (select idRanking
				   from ranking
				   where dataInicial = '2025-08-24' and
				   dataFinal = '2025-08-30')
	and
	ranking.idRanking = ranking_semanal.idRanking and
	ranking_semanal.idLivro = livro_autor.idLivro and
	livro_autor.idAutor = autor.idAutor;


SELECT DISTINCT A.nome
FROM Autor A
INNER JOIN Livro_Autor LA ON A.idAutor = LA.idAutor
INNER JOIN Ranking_Semanal RS ON LA.idLivro = RS.idLivro
INNER JOIN Ranking R ON RS.idRanking = R.idRanking
WHERE R.dataInicial = '2025-08-24'
AND R.dataFinal = '2025-08-30';


SELECT L.titulo, R.semanasConsecutivas
FROM Ranking_Semanal R
INNER JOIN Livro L ON R.idLivro = L.idLivro
WHERE R.posicao = 1
AND R.semanasConsecutivas = (
  SELECT MAX(semanasConsecutivas)
  FROM Ranking_Semanal
  WHERE posicao = 1
);

SELECT nome, idAutor FROM Autor;

select Autor.nome as autor , Genero.descricao
from  Genero, autor
where  Genero.descricao = 'Ficção';


select Editora.nome, Genero.descricao
from  Editora, genero
where genero.descricao = 'Infantil';


SELECT Editora.nome , genero.descricao , autor.nome
from editora,genero,autor
where autor.nome = 'Francisco';

SELECT Autor.nome, COUNT(*) AS quantidade_livros
FROM Autor
INNER JOIN Livro_Autor ON Autor.idAutor = Livro_Autor.idAutor
GROUP BY Autor.nome
HAVING quantidade_livros = (
    SELECT MAX(qtd)
    FROM (
        SELECT COUNT(*) AS qtd
        FROM Livro_Autor
        GROUP BY idAutor
    ) AS subconsulta
);


SELECT Genero.descricao AS genero, COUNT(*) AS total_publicacoes
FROM Livro
INNER JOIN Genero ON Livro.idGenero = Genero.idGenero
GROUP BY Genero.descricao
ORDER BY total_publicacoes DESC
LIMIT 1;




