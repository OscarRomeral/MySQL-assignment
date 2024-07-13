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
-- -----------------------------------------------------
-- Schema P2-ex2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema P2-ex2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `P2-ex2` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Model` (
  `modelId` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `dataLlencament` DATE NULL,
  `dataDiscontinuacio` DATE NULL,
  PRIMARY KEY (`modelId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pantalo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pantalo` (
  `pantaloId` INT NOT NULL,
  `baixos` ENUM('Cenyits', 'Rectes', 'Campana') NULL,
  `cintura` ENUM('Alta', 'Mitja', 'Baixa') NULL,
  `cuixa` ENUM('Folgat', 'Normar', 'Cenyit') NULL,
  INDEX `pantaloId_idx` (`pantaloId` ASC) VISIBLE,
  PRIMARY KEY (`pantaloId`),
  CONSTRAINT `pantaloId`
    FOREIGN KEY (`pantaloId`)
    REFERENCES `mydb`.`Model` (`modelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Talla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Talla` (
  `tallaId` INT NOT NULL,
  `ample` VARCHAR(10) NULL,
  `llarg` VARCHAR(10) NULL,
  PRIMARY KEY (`tallaId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Referencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Referencia` (
  `referenciaId` INT NOT NULL,
  `tallaId` INT NOT NULL,
  `modelId` INT NULL,
  `color` VARCHAR(15) NULL,
  `patroId` VARCHAR(15) NULL,
  PRIMARY KEY (`referenciaId`),
  INDEX `IdModel_idx` (`modelId` ASC) VISIBLE,
  INDEX `tallaId_idx` (`tallaId` ASC) VISIBLE,
  CONSTRAINT `modelId`
    FOREIGN KEY (`modelId`)
    REFERENCES `mydb`.`Model` (`modelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `tallaId`
    FOREIGN KEY (`tallaId`)
    REFERENCES `mydb`.`Talla` (`tallaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Acabat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Acabat` (
  `acabatId` INT NOT NULL,
  `material` TEXT(25) NULL,
  `color` TEXT(25) NULL,
  PRIMARY KEY (`acabatId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Escandall`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Escandall` (
  `escandallId` INT NOT NULL,
  `acabatId` INT NULL,
  `quantitat` INT NULL,
  `Model_modelId` INT NOT NULL,
  PRIMARY KEY (`escandallId`, `Model_modelId`),
  INDEX `fk_Escandall_Model1_idx` (`Model_modelId` ASC) VISIBLE,
  INDEX `acabatId_idx` (`acabatId` ASC) VISIBLE,
  CONSTRAINT `fk_Escandall_Model1`
    FOREIGN KEY (`Model_modelId`)
    REFERENCES `mydb`.`Model` (`modelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `acabatId`
    FOREIGN KEY (`acabatId`)
    REFERENCES `mydb`.`Acabat` (`acabatId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Jacron`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jacron` (
  `jacronId` INT NOT NULL,
  `material` TEXT(25) NULL,
  `color` TEXT(25) NULL,
  `ample` INT NULL,
  `alt` INT NULL,
  `marcatge` VARCHAR(15) NULL,
  PRIMARY KEY (`jacronId`),
  CONSTRAINT `jacronId`
    FOREIGN KEY (`jacronId`)
    REFERENCES `mydb`.`Acabat` (`acabatId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reblo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reblo` (
  `rebloId` INT NOT NULL,
  `material` TEXT(25) NULL,
  `color` TEXT(25) NULL,
  `diametre` INT NULL,
  `llarg` INT NULL,
  INDEX `rebloId_idx` (`rebloId` ASC) VISIBLE,
  PRIMARY KEY (`rebloId`),
  CONSTRAINT `rebloId`
    FOREIGN KEY (`rebloId`)
    REFERENCES `mydb`.`Acabat` (`acabatId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Boto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Boto` (
  `botoId` INT NOT NULL,
  `material` TEXT(25) NULL,
  `color` TEXT(25) NULL,
  `diametre` INT NULL,
  `fixacio` ENUM('Cosit', 'Reblat') NULL,
  PRIMARY KEY (`botoId`),
  CONSTRAINT `botoId`
    FOREIGN KEY (`botoId`)
    REFERENCES `mydb`.`Acabat` (`acabatId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cremallera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cremallera` (
  `cremalleraId` INT NOT NULL,
  `material` TEXT(25) NULL,
  `color` TEXT(25) NULL,
  `longitud` INT NULL,
  `pas` INT NULL,
  `tirador` VARCHAR(25) NULL,
  PRIMARY KEY (`cremalleraId`),
  CONSTRAINT `cremalleraId`
    FOREIGN KEY (`cremalleraId`)
    REFERENCES `mydb`.`Acabat` (`acabatId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Jaqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Jaqueta` (
  `jaquetaId` INT NOT NULL,
  `entallat` ENUM('Cenyit', 'Recte', 'Folgat') NULL,
  `llargada` ENUM('Llarg', 'Normal', 'Curt') NULL,
  INDEX `jaquetaId_idx` (`jaquetaId` ASC) VISIBLE,
  PRIMARY KEY (`jaquetaId`),
  CONSTRAINT `jaquetaId`
    FOREIGN KEY (`jaquetaId`)
    REFERENCES `mydb`.`Model` (`modelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Peto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Peto` (
  `petoId` INT NOT NULL,
  `baixos` ENUM('Cenyits', 'Rectes', 'Campana') NULL,
  `cintura` ENUM('Alta', 'Mitja', 'Baixa') NULL,
  `cuixa` ENUM('Folgat', 'Normar', 'Cenyit') NULL,
  INDEX `petoId_idx` (`petoId` ASC) VISIBLE,
  PRIMARY KEY (`petoId`),
  CONSTRAINT `petoId`
    FOREIGN KEY (`petoId`)
    REFERENCES `mydb`.`Model` (`modelId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `P2-ex2` ;

-- -----------------------------------------------------
-- Table `P2-ex2`.`Rover`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P2-ex2`.`Rover` (
  `idRover` INT NOT NULL,
  `referenciaNASA` VARCHAR(45) NULL DEFAULT NULL,
  `nom` VARCHAR(15) NULL DEFAULT NULL,
  `dataServei` DATETIME NULL DEFAULT NULL,
  `dataAmartatge` DATETIME NULL DEFAULT NULL,
  `estat` ENUM('Inactiu', 'Actiu', 'Perdut') NULL DEFAULT 'Inactiu',
  `Rovercol` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idRover`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `P2-ex2`.`UbicacioET`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P2-ex2`.`UbicacioET` (
  `idUbicacio` INT NOT NULL,
  `idRover` INT NULL DEFAULT NULL,
  `alcadaRelativa` DECIMAL(7,4) NULL DEFAULT NULL,
  `longitudMarciana` VARCHAR(20) NULL DEFAULT NULL,
  `latitudMarciana` VARCHAR(20) NULL DEFAULT NULL,
  `dataHoraTerrestre` DATETIME NULL DEFAULT NULL,
  `dataHoraMarciana` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idUbicacio`),
  INDEX `idRover_idx` (`idRover` ASC) VISIBLE,
  CONSTRAINT `idRover`
    FOREIGN KEY (`idRover`)
    REFERENCES `P2-ex2`.`Rover` (`idRover`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `P2-ex2`.`grupSensor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P2-ex2`.`grupSensor` (
  `idgrupSensor` INT NOT NULL,
  `referenciaNASA` VARCHAR(45) NULL DEFAULT NULL,
  `tipus` ENUM('Càmera', 'Meteo', 'Sonda', 'Mixte', 'Altres') NULL DEFAULT 'Altres',
  `descripcio` MEDIUMTEXT NULL DEFAULT NULL,
  `estat` ENUM('Actiu', 'Inactiu', 'Perdut') NULL DEFAULT 'Inactiu',
  `idRover` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idgrupSensor`),
  INDEX `idRover_idx` (`idRover` ASC) VISIBLE,
  CONSTRAINT `idRover`
    FOREIGN KEY (`idRover`)
    REFERENCES `P2-ex2`.`Rover` (`idRover`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `P2-ex2`.`Registre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P2-ex2`.`Registre` (
  `idRegistre` INT NOT NULL,
  `idUbicacio` INT NULL DEFAULT NULL,
  `idGrupSensor` INT NULL DEFAULT NULL,
  `estatProces` ENUM('Presa', 'Processament', 'Desat', 'Enviant', 'Enviat', 'Error') NULL DEFAULT 'Presa',
  `dataHoraMarcianaFiEnviament` DATETIME NULL DEFAULT NULL,
  `arxiuBinari` MEDIUMBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`idRegistre`),
  INDEX `idUbicacio_idx` (`idUbicacio` ASC) VISIBLE,
  INDEX `idGrupSensor_idx` (`idGrupSensor` ASC) VISIBLE,
  CONSTRAINT `idUbicacio`
    FOREIGN KEY (`idUbicacio`)
    REFERENCES `P2-ex2`.`UbicacioET` (`idUbicacio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idGrupSensor`
    FOREIGN KEY (`idGrupSensor`)
    REFERENCES `P2-ex2`.`grupSensor` (`idgrupSensor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `P2-ex2`.`Sondeig`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P2-ex2`.`Sondeig` (
  `idSondeig` INT NOT NULL,
  `trepantId` INT NULL DEFAULT NULL,
  `profunditatTotal` INT NULL DEFAULT NULL,
  `tempsSondeig` INT NULL DEFAULT NULL,
  `idImatge` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idSondeig`),
  INDEX `idImatge_idx` (`idImatge` ASC) VISIBLE,
  CONSTRAINT `idSondeig`
    FOREIGN KEY (`idSondeig`)
    REFERENCES `P2-ex2`.`Registre` (`idRegistre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idImatge`
    FOREIGN KEY (`idImatge`)
    REFERENCES `P2-ex2`.`Imatge` (`idImatge`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `P2-ex2`.`Mostra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P2-ex2`.`Mostra` (
  `idMostra` INT NOT NULL,
  `profunditatEstrat` INT NULL DEFAULT NULL,
  `ph` DECIMAL(3,1) NULL DEFAULT NULL,
  `humitat` INT NULL DEFAULT NULL,
  `Sondeig_idSondeig` INT NOT NULL,
  PRIMARY KEY (`idMostra`, `Sondeig_idSondeig`),
  INDEX `fk_Mostra_Sondeig1_idx` (`Sondeig_idSondeig` ASC) VISIBLE,
  CONSTRAINT `fk_Mostra_Sondeig1`
    FOREIGN KEY (`Sondeig_idSondeig`)
    REFERENCES `P2-ex2`.`Sondeig` (`idSondeig`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `P2-ex2`.`Imatge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P2-ex2`.`Imatge` (
  `idImatge` INT NOT NULL,
  `nomArxiuOriginal` VARCHAR(100) NULL DEFAULT NULL,
  `arxiuImatgeOriginal` MEDIUMBLOB NULL DEFAULT NULL,
  `idMostra` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idImatge`),
  INDEX `idMostra_idx` (`idMostra` ASC) VISIBLE,
  CONSTRAINT `idImatge`
    FOREIGN KEY (`idImatge`)
    REFERENCES `P2-ex2`.`Registre` (`idRegistre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idMostra`
    FOREIGN KEY (`idMostra`)
    REFERENCES `P2-ex2`.`Mostra` (`idMostra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `P2-ex2`.`Meteo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `P2-ex2`.`Meteo` (
  `idMeteo` INT NOT NULL,
  `pressio` VARCHAR(10) NULL DEFAULT NULL,
  `temperatura` INT NULL DEFAULT NULL,
  `humitat` VARCHAR(10) NULL DEFAULT NULL,
  `visibilitat` VARCHAR(10) NULL DEFAULT NULL,
  `assolellament` VARCHAR(10) NULL DEFAULT NULL,
  `particules` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`idMeteo`),
  CONSTRAINT `idMeteo`
    FOREIGN KEY (`idMeteo`)
    REFERENCES `P2-ex2`.`Registre` (`idRegistre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
