-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema localconference
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema localconference
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `localconference` DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci ;
USE `localconference` ;

-- -----------------------------------------------------
-- Table `localconference`.`conference`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `localconference`.`conference` (
  `idConference` INT(11) NOT NULL AUTO_INCREMENT,
  `acronimo` VARCHAR(45) NULL DEFAULT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `descricao` VARCHAR(200) NULL DEFAULT NULL,
  `local` VARCHAR(45) NULL DEFAULT NULL,
  `data` DATE NULL DEFAULT NULL,
  `dataRegisto` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`idConference`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;


-- -----------------------------------------------------
-- Table `localconference`.`conf_participant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `localconference`.`conf_participant` (
  `idConference` INT(11) NOT NULL DEFAULT 0,
  `idParticipant` VARCHAR(100) NOT NULL DEFAULT '0',
  `dataRegisto` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `nomeParticipante` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idConference`, `idParticipant`),
  CONSTRAINT `conf_fkk`
    FOREIGN KEY (`idConference`)
    REFERENCES `localconference`.`conference` (`idConference`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;


-- -----------------------------------------------------
-- Table `localconference`.`speaker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `localconference`.`speaker` (
  `idSpeaker` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `filiacao` VARCHAR(45) NULL DEFAULT NULL,
  `bio` VARCHAR(2000) NULL DEFAULT NULL,
  `foto` VARCHAR(500) NULL DEFAULT NULL,
  `link` VARCHAR(400) NULL DEFAULT NULL,
  `idSpeakerTipo` INT(11) NULL DEFAULT NULL,
  `active` INT(11) NULL DEFAULT NULL,
  `facebook` VARCHAR(450) NULL DEFAULT NULL,
  `linkedin` VARCHAR(450) NULL DEFAULT NULL,
  `twitter` VARCHAR(450) NULL DEFAULT NULL,
  `cargo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idSpeaker`))
ENGINE = InnoDB
AUTO_INCREMENT = 90
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;


-- -----------------------------------------------------
-- Table `localconference`.`conf_speaker`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `localconference`.`conf_speaker` (
  `idConference` INT(11) NOT NULL,
  `idSpeaker` INT(11) NOT NULL,
  PRIMARY KEY (`idConference`, `idSpeaker`),
  INDEX `speaker_fk_idx` (`idSpeaker` ASC) VISIBLE,
  CONSTRAINT `speaker_conf_fk`
    FOREIGN KEY (`idConference`)
    REFERENCES `localconference`.`conference` (`idConference`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `speaker_fk`
    FOREIGN KEY (`idSpeaker`)
    REFERENCES `localconference`.`speaker` (`idSpeaker`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;


-- -----------------------------------------------------
-- Table `localconference`.`sponsor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `localconference`.`sponsor` (
  `idSponsor` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `logo` VARCHAR(1000) NULL DEFAULT NULL,
  `categoria` VARCHAR(45) NULL DEFAULT NULL,
  `active` VARCHAR(45) NULL DEFAULT NULL,
  `link` VARCHAR(450) NULL DEFAULT NULL,
  PRIMARY KEY (`idSponsor`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;


-- -----------------------------------------------------
-- Table `localconference`.`conf_sponsor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `localconference`.`conf_sponsor` (
  `idConference` INT(11) NOT NULL,
  `idSponsor` INT(11) NOT NULL,
  PRIMARY KEY (`idConference`, `idSponsor`),
  INDEX `sponsors_fk` (`idSponsor` ASC) VISIBLE,
  CONSTRAINT `confs_fk`
    FOREIGN KEY (`idConference`)
    REFERENCES `localconference`.`conference` (`idConference`),
  CONSTRAINT `sponsors_fk`
    FOREIGN KEY (`idSponsor`)
    REFERENCES `localconference`.`sponsor` (`idSponsor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;


-- -----------------------------------------------------
-- Table `localconference`.`participant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `localconference`.`participant` (
  `idParticipant` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `dataRegisto` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`idParticipant`))
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;


-- -----------------------------------------------------
-- Table `localconference`.`speaker_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `localconference`.`speaker_type` (
  `idSpeakerType` INT(11) NOT NULL,
  `descricao` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idSpeakerType`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;


-- -----------------------------------------------------
-- Table `localconference`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `localconference`.`users` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NULL DEFAULT NULL,
  `apelido` VARCHAR(255) NULL DEFAULT NULL,
  `username` TEXT NULL DEFAULT NULL,
  `tipo` TEXT NULL DEFAULT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NOT NULL,
  `sobre` TEXT NULL DEFAULT NULL,
  `last_login` DATETIME NULL DEFAULT NULL,
  `status` ENUM('active', 'inactive') NULL DEFAULT 'active',
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = latin1
COLLATE = latin1_general_ci;


-- -----------------------------------------------------
-- Table `localconference`.`membroComissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `localconference`.`membroComissao` (
  `idMembro` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `instituto` VARCHAR(200) NOT NULL,
  `pais` VARCHAR(100) NOT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idMembro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `localconference`.`conf_membroComissao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `localconference`.`conf_membroComissao` (
  `idConference` INT NOT NULL,
  `idMembro` INT NOT NULL,
  `membroComissao_idMembro` INT NOT NULL,
  `conference_idConference` INT(11) NOT NULL,
  PRIMARY KEY (`idConference`, `idMembro`, `membroComissao_idMembro`, `conference_idConference`),
  INDEX `fk_conf_membroComissao_membroComissao1_idx` (`membroComissao_idMembro` ASC) ,
  INDEX `fk_conf_membroComissao_conference1_idx` (`conference_idConference` ASC) ,
  CONSTRAINT `fk_conf_membroComissao_membroComissao1`
    FOREIGN KEY (`membroComissao_idMembro`)
    REFERENCES `localconference`.`membroComissao` (`idMembro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_conf_membroComissao_conference1`
    FOREIGN KEY (`conference_idConference`)
    REFERENCES `localconference`.`conference` (`idConference`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
