-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Jogadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jogadores` (
  `idJogadores` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `apelido` VARCHAR(45) NULL,
  `posicao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idJogadores`),
  INDEX `index` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Torneio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Torneio` (
  `idTorneio` INT NOT NULL AUTO_INCREMENT,
  `clube` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTorneio`),
  INDEX `index` (`clube` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`jogador_torneio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`jogador_torneio` (
  `idjogador_torneio` INT NOT NULL,
  `Jogadores.Jogador_1` INT NOT NULL,
  `Jogadores.Jogador_2` INT NOT NULL,
  `Torneio_idTorneio` INT NOT NULL,
  `Mes_ano` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idjogador_torneio`),
  INDEX `fk_jogador_torneio_Jogadores_idx` (`Jogadores.Jogador_1` ASC) VISIBLE,
  INDEX `fk_jogador_torneio_Jogadores1_idx` (`Jogadores.Jogador_2` ASC) VISIBLE,
  INDEX `fk_jogador_torneio_Torneio1_idx` (`Torneio_idTorneio` ASC) VISIBLE,
  CONSTRAINT `fk_jogador_torneio_Jogadores`
    FOREIGN KEY (`Jogadores.Jogador_1`)
    REFERENCES `mydb`.`Jogadores` (`idJogadores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_torneio_Jogadores1`
    FOREIGN KEY (`Jogadores.Jogador_2`)
    REFERENCES `mydb`.`Jogadores` (`idJogadores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogador_torneio_Torneio1`
    FOREIGN KEY (`Torneio_idTorneio`)
    REFERENCES `mydb`.`Torneio` (`idTorneio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
