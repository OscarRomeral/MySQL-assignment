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
-- Table `mydb`.`Suministre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Suministre` (
  `suministreId` INT NOT NULL,
  PRIMARY KEY (`suministreId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`acabat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`acabat` (
  `acabatId` INT NOT NULL,
  `material` TINYTEXT NULL DEFAULT NULL,
  `color` TINYTEXT NULL DEFAULT NULL,
  PRIMARY KEY (`acabatId`),
  CONSTRAINT `F. ACA - SUM`
    FOREIGN KEY (`acabatId`)
    REFERENCES `mydb`.`Suministre` (`suministreId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`boto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`boto` (
  `botoId` INT NOT NULL,
  `material` TINYTEXT NULL DEFAULT NULL,
  `color` TINYTEXT NULL DEFAULT NULL,
  `diametre` INT NULL DEFAULT NULL,
  `fixacio` ENUM('Cosit', 'Reblat') NULL DEFAULT NULL,
  PRIMARY KEY (`botoId`),
  CONSTRAINT `botoId`
    FOREIGN KEY (`botoId`)
    REFERENCES `mydb`.`acabat` (`acabatId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`cremallera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cremallera` (
  `cremalleraId` INT NOT NULL,
  `material` TINYTEXT NULL DEFAULT NULL,
  `color` TINYTEXT NULL DEFAULT NULL,
  `longitud` INT NULL DEFAULT NULL,
  `pas` INT NULL DEFAULT NULL,
  `tirador` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`cremalleraId`),
  CONSTRAINT `cremalleraId`
    FOREIGN KEY (`cremalleraId`)
    REFERENCES `mydb`.`acabat` (`acabatId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`model`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`model` (
  `modelId` INT NOT NULL,
  `nom` VARCHAR(45) NULL DEFAULT NULL,
  `dataLlencament` DATE NULL DEFAULT NULL,
  `dataDiscontinuacio` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`modelId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`escandall`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`escandall` (
  `escandallId` INT NOT NULL,
  `acabatId` INT NULL DEFAULT NULL,
  `quantitat` INT NULL DEFAULT NULL,
  `Model_modelId` INT NOT NULL,
  PRIMARY KEY (`escandallId`, `Model_modelId`),
  INDEX `fk_Escandall_Model1_idx` (`Model_modelId` ASC) VISIBLE,
  INDEX `acabatId_idx` (`acabatId` ASC) VISIBLE,
  CONSTRAINT `acabatId`
    FOREIGN KEY (`acabatId`)
    REFERENCES `mydb`.`acabat` (`acabatId`),
  CONSTRAINT `fk_Escandall_Model1`
    FOREIGN KEY (`Model_modelId`)
    REFERENCES `mydb`.`model` (`modelId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`jacron`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`jacron` (
  `jacronId` INT NOT NULL,
  `material` TINYTEXT NULL DEFAULT NULL,
  `color` TINYTEXT NULL DEFAULT NULL,
  `ample` INT NULL DEFAULT NULL,
  `alt` INT NULL DEFAULT NULL,
  `marcatge` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`jacronId`),
  CONSTRAINT `jacronId`
    FOREIGN KEY (`jacronId`)
    REFERENCES `mydb`.`acabat` (`acabatId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`jaqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`jaqueta` (
  `jaquetaId` INT NOT NULL,
  `entallat` ENUM('Cenyit', 'Recte', 'Folgat') NULL DEFAULT NULL,
  `llargada` ENUM('Llarg', 'Normal', 'Curt') NULL DEFAULT NULL,
  PRIMARY KEY (`jaquetaId`),
  INDEX `jaquetaId_idx` (`jaquetaId` ASC) VISIBLE,
  CONSTRAINT `jaquetaId`
    FOREIGN KEY (`jaquetaId`)
    REFERENCES `mydb`.`model` (`modelId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`pantalo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pantalo` (
  `pantaloId` INT NOT NULL,
  `baixos` ENUM('Cenyits', 'Rectes', 'Campana') NULL DEFAULT NULL,
  `cintura` ENUM('Alta', 'Mitja', 'Baixa') NULL DEFAULT NULL,
  `cuixa` ENUM('Folgat', 'Normar', 'Cenyit') NULL DEFAULT NULL,
  PRIMARY KEY (`pantaloId`),
  INDEX `pantaloId_idx` (`pantaloId` ASC) VISIBLE,
  CONSTRAINT `pantaloId`
    FOREIGN KEY (`pantaloId`)
    REFERENCES `mydb`.`model` (`modelId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`peto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`peto` (
  `petoId` INT NOT NULL,
  `baixos` ENUM('Cenyits', 'Rectes', 'Campana') NULL DEFAULT NULL,
  `cintura` ENUM('Alta', 'Mitja', 'Baixa') NULL DEFAULT NULL,
  `cuixa` ENUM('Folgat', 'Normar', 'Cenyit') NULL DEFAULT NULL,
  PRIMARY KEY (`petoId`),
  INDEX `petoId_idx` (`petoId` ASC) VISIBLE,
  CONSTRAINT `petoId`
    FOREIGN KEY (`petoId`)
    REFERENCES `mydb`.`model` (`modelId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`reblo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`reblo` (
  `rebloId` INT NOT NULL,
  `material` TINYTEXT NULL DEFAULT NULL,
  `color` TINYTEXT NULL DEFAULT NULL,
  `diametre` INT NULL DEFAULT NULL,
  `llarg` INT NULL DEFAULT NULL,
  PRIMARY KEY (`rebloId`),
  INDEX `rebloId_idx` (`rebloId` ASC) VISIBLE,
  CONSTRAINT `rebloId`
    FOREIGN KEY (`rebloId`)
    REFERENCES `mydb`.`acabat` (`acabatId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`talla`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`talla` (
  `tallaId` INT NOT NULL,
  `ample` VARCHAR(10) NULL DEFAULT NULL,
  `llarg` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`tallaId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`referencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`referencia` (
  `referenciaId` INT NOT NULL,
  `tallaId` INT NOT NULL,
  `modelId` INT NULL DEFAULT NULL,
  `color` VARCHAR(15) NULL DEFAULT NULL,
  `patroId` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`referenciaId`),
  INDEX `IdModel_idx` (`modelId` ASC) VISIBLE,
  INDEX `tallaId_idx` (`tallaId` ASC) VISIBLE,
  CONSTRAINT `modelId`
    FOREIGN KEY (`modelId`)
    REFERENCES `mydb`.`model` (`modelId`),
  CONSTRAINT `tallaId`
    FOREIGN KEY (`tallaId`)
    REFERENCES `mydb`.`talla` (`tallaId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`Textil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Textil` (
  `textilId` INT NOT NULL,
  `unitatMesura` ENUM('Unitats', 'Centimetres', 'Centimetres quadrats') NULL,
  PRIMARY KEY (`textilId`),
  CONSTRAINT `F. TEX - SUM`
    FOREIGN KEY (`textilId`)
    REFERENCES `mydb`.`Suministre` (`suministreId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sastreria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Sastreria` (
  `sastreiaId` INT NOT NULL,
  `textilId` INT NULL,
  `quantitat` INT NULL,
  `referencia_referenciaId` INT NOT NULL,
  PRIMARY KEY (`sastreiaId`),
  INDEX `F. SAS - TEX _idx` (`textilId` ASC) VISIBLE,
  INDEX `fk_Sastreria_referencia1_idx` (`referencia_referenciaId` ASC) VISIBLE,
  CONSTRAINT `F. SAS - TEX `
    FOREIGN KEY (`textilId`)
    REFERENCES `mydb`.`Textil` (`textilId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sastreria_referencia1`
    FOREIGN KEY (`referencia_referenciaId`)
    REFERENCES `mydb`.`referencia` (`referenciaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fil`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fil` (
  `gruix` INT NOT NULL,
  `color` VARCHAR(25) NULL,
  `composició` VARCHAR(50) NULL,
  `Textil_textilId` INT NOT NULL,
  INDEX `fk_Fil_Textil1_idx` (`Textil_textilId` ASC) VISIBLE,
  PRIMARY KEY (`Textil_textilId`),
  CONSTRAINT `fk_Fil_Textil1`
    FOREIGN KEY (`Textil_textilId`)
    REFERENCES `mydb`.`Textil` (`textilId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Etiqueta` (
  `ample` INT NOT NULL,
  `alt` INT NOT NULL,
  `marcatge` TINYTEXT NULL DEFAULT NULL,
  `Textil_textilId` INT NOT NULL,
  INDEX `fk_Etiqueta_Textil1_idx` (`Textil_textilId` ASC) VISIBLE,
  PRIMARY KEY (`Textil_textilId`),
  CONSTRAINT `fk_Etiqueta_Textil1`
    FOREIGN KEY (`Textil_textilId`)
    REFERENCES `mydb`.`Textil` (`textilId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Genere`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Genere` (
  `genereId` INT NOT NULL,
  `composició` VARCHAR(50) NULL,
  `trama` VARCHAR(50) NULL,
  PRIMARY KEY (`genereId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Color` (
  `colorId` INT NOT NULL,
  `colorPral` VARCHAR(25) NULL,
  `coloSec` VARCHAR(25) NULL,
  `tractament` VARCHAR(25) NULL,
  PRIMARY KEY (`colorId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Teixit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Teixit` (
  `denominació` VARCHAR(100) NOT NULL,
  `Textil_textilId` INT NOT NULL,
  `Genere_genereId` INT NOT NULL,
  `Color_colorId` INT NOT NULL,
  INDEX `fk_Teixit_Textil1_idx` (`Textil_textilId` ASC) VISIBLE,
  PRIMARY KEY (`Textil_textilId`),
  INDEX `fk_Teixit_Genere1_idx` (`Genere_genereId` ASC) VISIBLE,
  INDEX `fk_Teixit_Color1_idx` (`Color_colorId` ASC) VISIBLE,
  CONSTRAINT `fk_Teixit_Textil1`
    FOREIGN KEY (`Textil_textilId`)
    REFERENCES `mydb`.`Textil` (`textilId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Teixit_Genere1`
    FOREIGN KEY (`Genere_genereId`)
    REFERENCES `mydb`.`Genere` (`genereId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Teixit_Color1`
    FOREIGN KEY (`Color_colorId`)
    REFERENCES `mydb`.`Color` (`colorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`personaFiscal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`personaFiscal` (
  `personaFiscalId` INT NOT NULL,
  `nom` VARCHAR(45) NOT NULL,
  `raoSocial` VARCHAR(45) NULL,
  `seuSocial` VARCHAR(45) NULL,
  `CIF` INT NULL,
  PRIMARY KEY (`personaFiscalId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Proveidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Proveidor` (
  `proveidorId` INT NOT NULL,
  `pendentPagament` INT NOT NULL,
  INDEX `F. PROV - PF_idx` (`proveidorId` ASC) VISIBLE,
  CONSTRAINT `F. PROV - PF`
    FOREIGN KEY (`proveidorId`)
    REFERENCES `mydb`.`personaFiscal` (`personaFiscalId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entrega` (
  `entregaId` INT NOT NULL,
  `data` DATETIME NOT NULL,
  `import` INT NULL,
  `estatPagament` ENUM('Pagat', 'Pendent') NULL,
  `Proveidor_proveidorId` INT NULL,
  PRIMARY KEY (`entregaId`),
  INDEX `F. ENT - PROV_idx` (`Proveidor_proveidorId` ASC) VISIBLE,
  CONSTRAINT `F. ENT - PROV`
    FOREIGN KEY (`Proveidor_proveidorId`)
    REFERENCES `mydb`.`Proveidor` (`proveidorId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Albara`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Albara` (
  `albaraId` INT NOT NULL,
  `Entrega_entregaId` INT NOT NULL,
  PRIMARY KEY (`albaraId`),
  INDEX `fk_Albara_Entrega1_idx` (`Entrega_entregaId` ASC) VISIBLE,
  CONSTRAINT `fk_Albara_Entrega1`
    FOREIGN KEY (`Entrega_entregaId`)
    REFERENCES `mydb`.`Entrega` (`entregaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Lot`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Lot` (
  `suministreId` INT NOT NULL,
  `entregaId` INT NULL,
  `unitats` INT NULL,
  `unitatsMesura` VARCHAR(15) NULL,
  INDEX `F. LOT - SUM _idx` (`suministreId` ASC) VISIBLE,
  CONSTRAINT `F. LOT - SUM `
    FOREIGN KEY (`suministreId`)
    REFERENCES `mydb`.`Suministre` (`suministreId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `F. LOT - ALB`
    FOREIGN KEY (`entregaId`)
    REFERENCES `mydb`.`Albara` (`Entrega_entregaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `clientId` INT NOT NULL,
  `pendentCobrament` INT NULL,
  INDEX `F. CLI - PF_idx` (`clientId` ASC) VISIBLE,
  CONSTRAINT `F. CLI - PF`
    FOREIGN KEY (`clientId`)
    REFERENCES `mydb`.`personaFiscal` (`personaFiscalId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Encarrec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Encarrec` (
  `comandaId` INT NOT NULL,
  `data` DATETIME NULL,
  `import` INT NULL,
  `estatCobrament` ENUM('Cobrat', 'Pendent', 'En producció') NULL,
  `Client_clientId` INT NOT NULL,
  PRIMARY KEY (`comandaId`),
  INDEX `fk_Encarrec_Client1_idx` (`Client_clientId` ASC) VISIBLE,
  CONSTRAINT `fk_Encarrec_Client1`
    FOREIGN KEY (`Client_clientId`)
    REFERENCES `mydb`.`Client` (`clientId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Detall`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Detall` (
  `comandaId` INT NOT NULL,
  `referenciaId` INT NOT NULL,
  `unitats` INT NOT NULL,
  INDEX `F. DET - REF_idx` (`referenciaId` ASC) VISIBLE,
  INDEX `F. DET - ENC_idx` (`comandaId` ASC) VISIBLE,
  CONSTRAINT `F. DET - REF`
    FOREIGN KEY (`referenciaId`)
    REFERENCES `mydb`.`referencia` (`referenciaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `F. DET - ENC`
    FOREIGN KEY (`comandaId`)
    REFERENCES `mydb`.`Encarrec` (`comandaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
