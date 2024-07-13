-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema covid
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema covid
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `covid` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `covid` ;

-- -----------------------------------------------------
-- Table `covid`.`CENS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`CENS` (
  `dni` INT NOT NULL,
  `nomComplet` VARCHAR(50) NULL DEFAULT NULL,
  `adrecaCompleta` VARCHAR(50) NULL DEFAULT NULL,
  `telefon` INT NOT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `ciutat` VARCHAR(50) NULL DEFAULT NULL,
  `provincia` VARCHAR(50) NULL DEFAULT NULL,
  `dob` DATE NULL DEFAULT NULL,
  `sex` CHAR(1) NULL DEFAULT NULL,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `covid`.`VACUNES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`VACUNES` (
  `vacid` INT NOT NULL,
  `nom` VARCHAR(50) NULL DEFAULT NULL,
  `temp` INT NOT NULL,
  `preu` INT NOT NULL,
  PRIMARY KEY (`vacid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `covid`.`CENTRESVACUNACIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`CENTRESVACUNACIO` (
  `cvid` INT NOT NULL,
  `adrecaCompleta` VARCHAR(45) NULL,
  `ciutat` VARCHAR(45) NULL,
  `provincia` VARCHAR(45) NULL,
  `tempmin` INT NOT NULL,
  PRIMARY KEY (`cvid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`SANITARIS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`SANITARIS` (
  `trebid` INT NOT NULL,
  `dni` INT NOT NULL,
  `nomComplet` VARCHAR(45) NULL,
  `adrecaCompleta` VARCHAR(45) NULL,
  `telefon` INT NOT NULL,
  `ciutat` VARCHAR(45) NULL,
  `provincia` VARCHAR(45) NULL,
  `cvid` INT NOT NULL,
  PRIMARY KEY (`trebid`),
  INDEX `F. SAN - CENS` (`dni` ASC) VISIBLE,
  INDEX `F. SAN - CV` (`cvid` ASC) INVISIBLE,
  CONSTRAINT `F. SAN - CENS`
    FOREIGN KEY (`dni`)
    REFERENCES `covid`.`CENS` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `F. SAN - CV`
    FOREIGN KEY (`cvid`)
    REFERENCES `covid`.`CENTRESVACUNACIO` (`cvid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`LOGISTICA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`LOGISTICA` (
  `date` INT NOT NULL,
  `unitats` VARCHAR(45) NULL,
  `cvid` INT NULL,
  `vacid` INT NULL,
  INDEX `F. LOG - VAC` (`vacid` ASC) VISIBLE,
  INDEX `F. LOG - CV` (`cvid` ASC) VISIBLE,
  CONSTRAINT `F. LOG - VACUNES`
    FOREIGN KEY (`vacid`)
    REFERENCES `covid`.`VACUNES` (`vacid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `F. LOG - CV`
    FOREIGN KEY (`cvid`)
    REFERENCES `covid`.`CENTRESVACUNACIO` (`cvid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`EFECTESSECUNDARIS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`EFECTESSECUNDARIS` (
  `efsecid` INT NOT NULL,
  `descripcio` VARCHAR(45) NULL,
  `nivell` INT NULL,
  PRIMARY KEY (`efsecid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `covid`.`PLAVACUNACIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `covid`.`PLAVACUNACIO` (
  `dni` INT NOT NULL,
  `data` DATE NULL,
  `vacid` INT NOT NULL,
  `trebid` INT NOT NULL,
  `cvid` INT NOT NULL,
  `efsecid` INT NOT NULL,
  INDEX `F. PV - VAC` (`vacid` ASC) VISIBLE,
  INDEX `F. PV - CV` (`trebid` ASC) VISIBLE,
  INDEX `F. PV - CENS` (`dni` ASC) VISIBLE,
  INDEX `F. PV - EFSEC` (`efsecid` ASC) VISIBLE,
  INDEX `F. PV - SAN` (`cvid` ASC) VISIBLE,
  CONSTRAINT `F. PV - VACUNES`
    FOREIGN KEY (`vacid`)
    REFERENCES `covid`.`VACUNES` (`vacid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `F. PV - SANITARIS`
    FOREIGN KEY (`trebid`)
    REFERENCES `covid`.`SANITARIS` (`trebid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `F. PV - CENS`
    FOREIGN KEY (`dni`)
    REFERENCES `covid`.`CENS` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `F. PV - EFSEC`
    FOREIGN KEY (`efsecid`)
    REFERENCES `covid`.`EFECTESSECUNDARIS` (`efsecid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `F. PV - CV`
    FOREIGN KEY (`cvid`)
    REFERENCES `covid`.`CENTRESVACUNACIO` (`cvid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
